/**
 *			Earthquake Epicenter Location on Grid
 *			Atilla Soner Balkır - Emin Şenay 
 *		
 *			        Boğaziçi University 
 *			Department of Computer Engineering
 *
 *		sonerbalkir@gmail.com - eminsenay@gmail.com
 *				Feel free to contact us
 */

#include <iostream>
#include <fstream>
#include <iomanip>
#include "sac.h"
#include "eqFileOp.h"
#include "bashScript.h"
#include "eqDb.h"
#include "pickFilter.h"
#include "window.h"

using namespace std;

#define WINDOWSLIDESEC 60
#define WINDOWSEC 120 
#define SUBWINDOWSEC 15
#define PICKTHRESHOLD 4

/** Main method of the program. 
 *  It takes the date and the hour from the arguments (default 2007 05 19 20), 
 *  takes the seismic data of that hour from the grid, 
 *  extracts the necessary data files to be used for finding the epicenter of the earthquake,
 *  calculates the picks in the data files,
 *  filters noisy data,
 *  executes the earthquake epicenter location subroutines and
 *  inserts the earthquakes that are found by the previous subroutines.
 *  By default, the data is first copied from the grid and after the data is read, they are deleted from the system. 
 *  However, this behavior can be changed for testing purposes. 
 *  After specifiying the date and hour information in the terminal, one can specify a number (running mode).
 *  The running modes are as follows:
 *
 *  0- First copy the data and delete (default)
 *  1- Copy the data but not delete at the end of the program.
 *  2- Do not copy the data, but delete them at the end of the program.
 *  3- Neither copy nor delete the data.
 *
 *  The program uses four important variables in execution. These are WINDOWSLIDESEC, WINDOWSEC\ SUBWINDOWSEC
 *
 *  WINDOWSLIDESEC: The time between two windows used by the picker function (in seconds).
 *  WINDOWSEC: The length of the window used by the picker (in seconds).
 *  SUBWINDOWSEC: The maximum allowed delay in the start time of the pick for the same earthquake. 
 *  If a pick is found at time t by one station, pick time of the other stations must be at most t+SUBWINDOWSEC for the pick
 *  to be considered as the same pick.
 *  PICKTHRESHOLD: Minimum number of picks which must exist in the same subwindow for those picks to be considered as an earthquake.
 */
int main(int argc, char** argv)
{
	// Oluşturduğu path i lcg-cp komutu ile lokal dizine kopyalayacak. lcg-cp kullanımı aşağıda
	// lcg-cp --vo trgridd lfn:/grid/trgridd/soner-emin/helloworld.jdl file:/home_levrek/bouncmpe/esenay/helloworld1.jdl
	// lokal dizin "localSourceDir" olacak.
	
	sac mysac;
	eqFileOp op;
	bashScript myScript;
	string *dateList = new string[4];
	int windowListSize = mysac.getWindowListSize(WINDOWSLIDESEC);
	window *windowList = new window[windowListSize];
	int copyAndDelete = 0; // 0 = copy and delete, 1 = copy but not delete, 2 = not copy but delete, 3 = not copy not delete
	
	eqDb dbOp;
	
	if (argc >= 5)
	{
		dateList[0] = argv[1];
		dateList[1] = argv[2];
		dateList[2] = argv[3];
		dateList[3] = argv[4];
	}
	else
	{
		dateList[0] = "2007";
		dateList[1] = "05";
		dateList[2] = "19";
		dateList[3] = "20";
	}
	if (argc == 6)
	{
		copyAndDelete = atoi(argv[5]);
	}
	
	string localDestDir = "`pwd`/kandilliDataFiles/zipped";
	string localSourceDir = "./kandilliDataFiles/zipped";
	
	for ( int i = 0; i < 4; i++ )
	{
		localSourceDir += "/" + dateList[i];
		localDestDir += "/" + dateList[i];
	}
		
	//sourceDir = ´pwd´/kandilliDataFiles/zipped/yıl/ay/gün/saat;
	
	string destDir = "./kandilliDataFiles/unzipped";
	
	for ( int i = 0; i < 4; i++ )
		destDir = destDir +  "/" + dateList[i];

	if (copyAndDelete == 0 || copyAndDelete == 1)
	{	
		cout << "Copying SAC files from TR_GRID to local machine" << endl;
		cout << "This may take a few minutes..." << endl;
		
		//destDir = ´pwd´/kandilliDataFiles/unzipped/yıl/ay/gün/saat;	
		
		string command = "mkdir -p " + localSourceDir + " > /dev/null"; 
		system(command.c_str());	
		
		command = "mkdir -p " + destDir + " > /dev/null"; 
		system(command.c_str());
		
		//sourceDir'e grid'deki lfn'den alınan dosyaları kopyala.
		string scriptCommand = myScript.getDataFiles(localDestDir,dateList);
		system(scriptCommand.c_str());
		
		cout << "Extracting the necessary SAC files" << endl;
		cout << "This may take a few minutes..." << endl;
			
		op.extract(localSourceDir.c_str(),destDir.c_str(),"BHZ",NULL);
	
//		cout << destDir << endl;
	}

	cout << "Reading SAC files" << endl;
	
	int numberOfFiles = 0;
	string* fileList = op.listFiles(destDir.c_str(),"BHZ",NULL,numberOfFiles);
	// Filelist in her elemanı için Apicker metodunu çağır
	
	int j=0;
	while ( j < numberOfFiles ) {

		mysac.calculatePickValue(destDir + "/" + fileList[j], windowList, WINDOWSEC, 
				WINDOWSLIDESEC);
		j++;
	}
	if (numberOfFiles < 1)
	{
		cout << "The data is not available yet" << endl;
		return 1;
	}
	// Aldığın pick verilerini işle
	
	cout << "Filtering noisy data" << endl;
	
	pickFilter myFilter;
	myFilter.filterData(windowList, windowListSize);
	
	
	// windowList i yaz
//	for (int i = 0; i < 64; i++)
//	{
//		list<double>::iterator theIterator1;
//		cout << "window number: " << i << endl;
//		for( theIterator1 = windowList[i].timeList.begin(); theIterator1 != windowList[i].timeList.end(); theIterator1++ ) 
//		{
//			cout << setprecision(15) << *theIterator1 << " ";
//			//arr[*theIterator]++;
//		}
//		
//		cout << endl;
//		list<string>::iterator theIterator2;
//		for( theIterator2 = windowList[i].pickList.begin(); theIterator2 != windowList[i].pickList.end(); theIterator2++ ) 
//		{
//			cout << *theIterator2 << endl;
//			//arr[*theIterator]++;
//		}
//	}	
	
	myFilter.filterWindow(windowList, windowListSize, SUBWINDOWSEC);
	
//	cout << " *********************** filterWindow çalıştı bitti ******************************" << endl;
	
	
//	for (int i = 0; i < 64; i++)
//	{
//		list<double>::iterator theIterator1;
//		cout << "window number: " << i << endl;
//		for( theIterator1 = windowList[i].timeList.begin(); theIterator1 != windowList[i].timeList.end(); theIterator1++ ) 
//		{
//			cout << setprecision(15) << *theIterator1 << " ";
//			//arr[*theIterator]++;
//		}
//		
//		cout << endl;
//		list<string>::iterator theIterator2;
//		for( theIterator2 = windowList[i].pickList.begin(); theIterator2 != windowList[i].pickList.end(); theIterator2++ ) 
//		{
//			cout << *theIterator2 << endl;
//			//arr[*theIterator]++;
//		}
//	}	
	//Gereksiz pickler filtrelendikten sonra kalanların içinden
	//PICKTHRESHOLD istasyon ve üzerinde pick olanları yazdır.
	
	cout << "Executing earthquake location subroutines" << endl;
	
	for( int i=0; i < windowListSize; i++ )
	{
		if( windowList[i].pickList.size() >= PICKTHRESHOLD ) 
		{
			ofstream out ("1");
			
			//Hypo girdi dosyası (1) için gerekli baş kısmı oluştur.
			mysac.createHypoHeader(out);
			cout << endl << "window no: " << i << endl;
			unsigned int pickCount = 0;
			list<string>::iterator pickIterator;
			for( pickIterator = windowList[i].pickList.begin(); 
				 pickIterator != windowList[i].pickList.end(); 
				 pickIterator++ ) 
			{
				pickCount++;
				if (pickCount == windowList[i].pickList.size())
				{
					out << *pickIterator;
					cout << *pickIterator;
				}
				else
				{
					out << *pickIterator << endl;
					cout << *pickIterator << endl;
				}
			}
			
			//Hypo girdi dosyası (1) için gerekli son kısmı oluştur. 
			mysac.createHypoFooter(out);	
			
			out.close();
			mysac.callHYP02d();
			//Buraya java ile insert
						
			//1 ve 2 dosyalarını okuyup sonuçları database'e yaz.
			dbOp.insertLocation();				
		}	
	}
	// Set the successful flag to 1
	dbOp.updateHour(dateList[0],dateList[1],dateList[2],dateList[3]);
	
	if (copyAndDelete == 0 || copyAndDelete == 2)
	{
		// Gridden alınan ve oluşturulan dosyaları sil
		string command = "rm -rf " + localSourceDir;
		system(command.c_str());		
		command = "rm -rf " + destDir;
		system(command.c_str());
	}
	
	return 0;
}
 
