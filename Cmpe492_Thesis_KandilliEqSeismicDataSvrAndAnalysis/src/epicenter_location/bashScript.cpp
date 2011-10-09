/** Contains functions of bashScript class. */

#include <iostream>
#include <time.h>
#include "bashScript.h"
#include "stringop.h"
#include <string>

using namespace std;
/** Returns the current year, month, day and the hour before the current hour. 
 *  It sets the given array's appropriate elements to return these information. 
 *  dateList : Array to be set
 *  dateList[0]: Year
 *  dateList[1]: Month
 *  dateList[2]: Day
 *  dateList[3]: Hour
 */
void bashScript::getTime(string *dateList)
{
	int Day,Month,Year,Hour;
	struct tm *Sys_T = NULL;
	time_t Tval = 0;
	Tval = time(NULL);
	Tval -= 3600; //1 saat çıkar
	Sys_T = localtime(&Tval);
	//cout << "bok" << Tval << endl;
	Day=Sys_T->tm_mday;
	Month=Sys_T->tm_mon+1;
	Year=1900 + Sys_T->tm_year;
	Hour = Sys_T -> tm_hour;
	
	stringop strop;
	dateList[0] = strop.itoa(Year,10);
	if (Month < 10)
		dateList[1] = "0" + strop.itoa(Month,10);
	else
		dateList[1] = strop.itoa(Month,10);
	if (Day < 10)
		dateList[2] = "0" + strop.itoa(Day,10);
	else
		dateList[2] = strop.itoa(Day,10);
	if (Hour < 10)
		dateList[3] = "0" + strop.itoa(Hour,10);
	else
		dateList[3] = strop.itoa(Hour,10);
}

/** Returns the bash command which can be used to copy the seismic data from the grid to a given directory name. 
 *  The seismic data to be copied is the hourly data which belongs to the hour before the algorithm is run. 
 */
string bashScript::getDataFiles(string destDir)
{
	
	string *dateList = new string[4];
	getTime(dateList);
	
	string lfc_ls_command = "lfc-ls /grid/trgridd/kandilli/barbar.koeri.boun.edu.tr/wData/";

	for (int i = 0; i < 4; i++)
	{
		lfc_ls_command = lfc_ls_command + dateList[i] + "/";
	}
	//cout << lfc_ls_command << endl;
	//for i in `ls -b $FILEPATH`; do     echo $i ; done 
	//lfc-ls /grid/trgridd/kandilli/barbar.koeri.boun.edu.tr/wData/
	string lcg_cp_command = "for i in ";
	//lcg_cp_command = lcg_cp_command + "`" + lfc_ls_command + "`; do echo $i ; done";
	lcg_cp_command = lcg_cp_command + "`" + lfc_ls_command + "`; do "; 
	lcg_cp_command = lcg_cp_command + "lcg-cp --vo trgridd lfn:/grid/trgridd/kandilli/barbar.koeri.boun.edu.tr/wData/" ;
	lcg_cp_command = lcg_cp_command + dateList[0] + "/" + dateList[1] + "/" + dateList[2] + "/" + dateList[3] + "/" + "$i ";
	lcg_cp_command = lcg_cp_command + "file:" + destDir + "/$i ; done";
	
	return lcg_cp_command;	
	
}

/** Returns the bash command which can be used to copy the seismic data from the grid to a given directory name. 
 *  The seismic data to be copied is the hourly data which is given by dateList array. 
 *  The elements of the dateList array must be as follows: 
 *  dateList[0]: Year
 *  dateList[1]: Month
 *  dateList[2]: Day
 *  dateList[3]: Hour
 */
string bashScript::getDataFiles(string destDir, string *dateList)
{

	string lfc_ls_command = "lfc-ls /grid/trgridd/kandilli/barbar.koeri.boun.edu.tr/wData/";

	for (int i = 0; i < 4; i++)
	{
		lfc_ls_command = lfc_ls_command + dateList[i] + "/";
	}
	//cout << lfc_ls_command << endl;
	//for i in `ls -b $FILEPATH`; do     echo $i ; done 
	//lfc-ls /grid/trgridd/kandilli/barbar.koeri.boun.edu.tr/wData/
	string lcg_cp_command = "for i in ";
	//lcg_cp_command = lcg_cp_command + "`" + lfc_ls_command + "`; do echo $i ; done";
	lcg_cp_command = lcg_cp_command + "`" + lfc_ls_command + "`; do "; 
	lcg_cp_command = lcg_cp_command + "lcg-cp --vo trgridd lfn:/grid/trgridd/kandilli/barbar.koeri.boun.edu.tr/wData/" ;
	lcg_cp_command = lcg_cp_command + dateList[0] + "/" + dateList[1] + "/" + dateList[2] + "/" + dateList[3] + "/" + "$i ";
	lcg_cp_command = lcg_cp_command + "file:" + destDir + "/$i ; done";
	
	return lcg_cp_command;	
	
}
