/** Contains implementations of the functions of the sac class. */

#include <iostream>
#include "sac.h"
#include <fstream>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <iomanip>
#include "stringop.h"
#include "window.h"
using namespace std;

extern "C"
{
	extern void hyp02d_();
	extern void apick_(const float* arry,float& nlen,float& delta,float& ndxst,const float* cAry,long int& ndxpk,float& nlncda,long int& itype,long int& iqual,float& updwn);
}
//Input parameters
float* data;
float nlen, delta, ndxst;
// cAry of Kandilli
//float cAry[] = {0.985,3.0,0.6,0.03,5.0,0.0039,100.0,-0.1,2.0,3.0,1.0,3,40,3,0,0,0};//standart olan
float cAry[] = {0.95,1.0,0.15,0.005,11.0,0.0039,1000000.0,-0.1,2.0,3.0,1.0,3,40,3,0,0,0};
// Output parameters
long int ndxpk,itype,iqual,nzyear,nzhour,nzmin,nzsec,nzmsec,nzjday;
float nlncda,updwn;
char kstnm[8];
int windowNum;
int windowSlideNum;

/** Reads the SAC file and initializes necessary parameters which will be used in other functions.
 *  Parameters that are being initialized:
 *  float* data: The SAC data array
 *  float nlen: Length of the SAC data array
 *  float delta: Time interval in seconds between two SAC data elements.
 *  float ndxst: Used for defining the beginning of the pick search. Used internally by aPicker function. 
 *
 *  fileName: Name of the SAC file
 */
void sac::readFile(string fileName)
{
	sac_header mysac;
	fstream f2;	
	f2.open(fileName.c_str(), ios::binary | ios::in);
	if (!f2)
	{
		cout << "cannot open the file" << endl;
		return;
	}

	// Header
	f2.read((char*)&mysac,sizeof(sac_header));	
	
	delta = mysac.delta;
	ndxst = 1;
	// Take number of samples variable from the header
	nlen = mysac.npts;	
	data = new float[(long)nlen];

	// Read data accoring to the number of samples
	f2.read((char*)data, (long)nlen * sizeof(float));
	
	/*for (int i = 0; i < 30; i++)
	{
		cout << "Data: " << data[i] << endl;
	}*/
		
	f2.close();
	
	cAry[14] = nlen;
	cAry[15] = delta;
	cAry[16] =  ndxst;
	nzyear = mysac.nzyear;
	nzjday = mysac.nzjday;
	nzhour = mysac.nzhour;
	nzmin = mysac.nzmin;
	nzsec = mysac.nzsec;
	nzmsec = mysac.nzmsec;
	
	for(int i=0; i<8; i++)
		kstnm[i] = mysac.kstnm[i];
}

/** Calls HYP02d fortran function. This function is used for locating the earthquake. */
void sac::callHYP02d()
{
	hyp02d_();
}

/** Calls aPicker fortran function. This function is used for finding the pick, i.e. starting point of the earthquake in the SAC data. 
 * 
 *  Input parameters: 
 *
 *  float* data: The SAC data array
 *  float nlen: Length of the SAC data array
 *  float delta: Time interval in seconds between two SAC data elements.
 *  float ndxst: Used for defining the beginning of the pick search.
 *  float cAry[]: Holds some parameters required for the function.
 * 
 *  Output parameters:
 *
 *  float ndxpk: Start index of the pick in the data array.
 *  float nlncda: Length of event in samples (duration) (=0 if not found)
 *  long int itype: Type of arrival (0:impulsive,  1:emergent)
 *  float updwn: Direction of first motion (0: none, 1 UP, 0.5 UP critical, -1: Down, -0.5 Down critical
 *  long int iqual: Quality of pick (1,2,3,4 for best to worst)
 * 
 *  Precondition: Input parameters are need to be initialized before this function is called.
 */
void sac::callAPicker(float *tempData, float windowSize)
{
	cAry[14] = windowSize;
	apick_(tempData,windowSize,delta,ndxst,cAry,ndxpk,nlncda,itype,iqual,updwn);
}

/** Reads the input parameters from the given input file and calculates the pick time */
void sac::calculatePickValue(string fileName, window windowList[],int windowSec,
		int windowSlideSec)
{
	readFile(fileName);
	setWindow(windowSec, windowSlideSec);
	// Burada tempdata array i oluştur (2 dk lık)
	// callAPicker fonk.u tempdata alacak şekilde değiştir.
	// Pencereyi 1 dk kaydır, baştan başla.
//	int numOfIndexesInOneSecond = (int)(1 / delta); 
//	int window = 2 * 60 * numOfIndexesInOneSecond;
	float *tempData;
	tempData = new float[windowNum];
	// window boyutlu arrayi tempData ya kopyala
	for (int startIndex = 0; startIndex < (long)nlen - windowNum; startIndex += windowSlideNum)
	{
		for (int i = 0; i < windowNum; i++)
		{
			tempData[i] = data[startIndex + i];
		}
		callAPicker(tempData,windowNum);
		//ndxpk 0 olduğu zaman gereksiz pick veriyor.
		if(ndxpk != 0 ) 
		{
			calculatePickTime(nzyear, nzjday, nzhour, nzmin, nzsec, 
				nzmsec, ndxpk, delta, startIndex/(windowSlideNum), windowNum, windowList);
		}
	}
}

/** Given the window size (in seconds) and the amount of time between two successive windows (in seconds), this function sets the appropriate index values of both. */
void sac::setWindow(int windowSec, int windowSlideSec)
{
	int numOfIndexesInOneSecond = (int)(1 / delta);
	windowNum = windowSec * numOfIndexesInOneSecond;
	windowSlideNum = windowSlideSec * numOfIndexesInOneSecond;
}

/** Calculates and returns the length of the window array. 
 *  windowSlideSec: the amount of time between two successive windows (in seconds).
 *  In an hourly data, normally there will be 3600/windowSlideSec different elements of the array.
 *  However, sometimes the data from the last minutes of the last hour and the first minutes of the next hour are received.
 *  Thus, the required array length is doubled.
 *
 *  This function is required to be called before calculatePickValue function.
 */
int sac::getWindowListSize(int windowSlideSec)
{
	// Normalde 1 saatlik veri var ama oncesi ve sonrasi olabilecegi icin 2 kati kadar array size yapalim
	return 2 * (3600 / windowSlideSec);
}

/** Takes the year and the day of the year (for example 101), and returns the month which contains this day of the year.
 *  It also sets the day number of the given day in the month to the day parameter. 
 *  For example if it takes 2006 and 32, it returns 2 and sets the day to 1. 
 */
int sac::calculateMonth(int year, int &day)
{
	int months[] = {31,28,31,30,31,30,31,31,30,31,30,31};
	if (year % 4 == 0)
		months[1]++;
	for (int i = 0; i < 11; i++)
	{
		if (day < months[i])
			return i+1;
		else
			day -= months[i];
	}
	return 12;	
}

/** This function calculates the time (year, day of year, hour, minutes, seconds and milliseconds) of the pick.
 *  It takes the time variables which are read from the SAC file and sets the start time to these variables.
 *  After that, it adds the number of seconds which is passed from the beginning of the data to the pick start to the start time. 
 *  The number of seconds since the pick start can be found by multiplying ndxpk and delta values of the class.
 *  Lastly, the function converts the calculated time to year, month, day of month, hour, minutes, seconds and milliseconds format 
 *  and adds this pick to the current window.
 *  All time values are two digit integers except the second, which is a three digit integer.
 *  For example 0705231341042.18 stand for 23 May 2007 13:41:42:18.
 */
void sac::calculatePickTime(long nzyear, long nzjday, long nzhour,long nzmin, long nzsec, 
							long nzmsec, long ndxpk,float delta,
							int windowNumber, int windowSize, window windowList[])
{
	// Saniyeye çevir
	double tempTime = (( (nzjday*24 + nzhour)*60 + nzmin)*60 + nzsec) + nzmsec/1000.0;
	// Ekle
	tempTime += windowNumber * (windowSize/2) * delta;
	tempTime += ndxpk*delta;	
	
	// Geri çevir
	nzmsec = (long)(1000 * (tempTime - (int)tempTime));
	tempTime -= (nzmsec/1000);
	nzsec = (int)tempTime % 60;
	tempTime = (int) (tempTime/60);
	nzmin = (int) tempTime % 60;
	tempTime = (int) (tempTime/60);
	nzhour = (int)tempTime % 24;
	tempTime = (int) (tempTime/24);
	nzjday = (long)tempTime;
	if (nzyear % 4 == 0)
	{
		if (nzjday > 366)
		{
			nzyear ++;
			nzjday -= 366;
		}
	}
	else
	{
		if (nzjday > 365)
		{
			nzyear ++;
			nzjday -= 365;
		}
	}
	string newPick = "";
	string newPickTime = "";
	stringop myStr;
	//out << "Window number: " << windowNumber << endl;
	//istasyon adı 4 karakter
	for(int i=0; i<4; i++)
		newPick += kstnm[i];
		
	newPick = newPick + "EP " + myStr.ltoa(iqual,10) + " ";
	
	int newday = (int)nzjday;
	newPickTime += formattedString(nzyear%100,2);
	newPickTime += formattedString(calculateMonth(nzyear,newday),2);
	newPickTime += formattedString(newday,2);
	newPickTime += formattedString(nzhour,2); 
	newPickTime += formattedString(nzmin,2); 
	newPickTime = newPickTime + formattedString(nzsec,3) + ".";
	newPick += newPickTime;
	if (nzmsec > 100)
	{
		newPick = newPick + myStr.ltoa(nzmsec/10,10);
	}
	else
	{
		if (nzmsec > 10)
			newPick = newPick + myStr.ltoa(nzmsec,10);
		else
			newPick = newPick + "0" + myStr.ltoa(nzmsec,10);
	}
	
	//cout << "newPickTime: " << setprecision(15) << atof(newPickTime.c_str()) << " window: " << windowNumber << endl;
	windowList[windowNumber].addPick(newPick, atof(newPickTime.c_str()), ndxpk);
}

/** Takes the number and number of digits as input. 
 *  If it is necessary, it adds some zeros to the left side of the number to make the number appear as the desired number of digits and returns the formatted output as string.
 */
string sac::formattedString(int number, int digits)
{
	stringop mystring;
	string str_num = mystring.itoa(number,10);
	for (int i = str_num.length(); i < digits; i++)
	{
		str_num = "0" + str_num; 
	} 
	return str_num;
}

/** Creates the header for input file of the earthquake location algorithm. 
 *  Reads the template.txt file and copies it to a given output stream. 
 */
void sac::createHypoHeader(std::ofstream& out)
{
	string line;
	ifstream myfile ("template.txt");
	if (myfile.is_open())
	{
		while (! myfile.eof() )
    	{
			getline (myfile,line);
			out << line << endl;
		}
		myfile.close();
	}					
}

/** Creates the footer for input file of the earthquake location algorithm. */
void sac::createHypoFooter(std::ofstream& out)
{
	out << endl << "                 10"<<endl;
}


