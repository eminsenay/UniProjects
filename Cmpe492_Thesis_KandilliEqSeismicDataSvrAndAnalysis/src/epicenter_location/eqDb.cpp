/** Contains functions of the eqDb class. */

#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <fstream>

#include "eqDb.h"
#include "stringop.h"

#define HOST "zumrut.grid.boun.edu.tr"
#define USER "cmpe"
#define PASS "aliveli492mysql"
#define DB "491earthquake" 

using namespace std;

/** Inserts the earthquakes found by earthquake location algorithm to a database. 
 *  When the earthquake location algorithm finds an earthquake, it generates a file called "2" and 
 *  writes the necessary information except the earthquake time to this file. 
 *  The time information can be found in another file called "1", the input file of the earthquake location algorithm,
 *  which is created by the program.
 *  Once all information is taken from those files, a Java executable, which inserts the data to the database, is called with the insert command. 
 */
void eqDb::insertLocation()
{
	
	string line;
	
	float latitude = 0;
	float longtitude = 0;
	ifstream myfile ("2");	
	if (myfile.is_open())
	{
		getline (myfile,line);
		getline (myfile,line);

		for(unsigned int i = 0; i < line.length(); i++ )
		{
			char c = line[i];
			if ( c =='-' ) {
				char coordinate[5];
				strncpy(coordinate, &(line[i-2]), 5);

				float lat = 10*(coordinate[0] - '0');
				lat += coordinate[1] - '0';
				
				int minute=0;
				if( coordinate[3] != ' ')
					minute = 10*(coordinate[3] - '0');
				minute+=coordinate[4]-'0';
				
				lat += minute/60.0;
				
				if (latitude == 0)
					latitude = lat;
				else 
					longtitude = lat;
			}
		}
//		cout << latitude << " " << longtitude << endl;
		myfile.close();		
	}
	else 
	{
		cout << "Unable to open file" << endl;
		return;
	}
	
	string date = "20";
	string mytime = "";
	ifstream yourfile ("1");	
	if (yourfile.is_open())
	{
		for( int j = 0; j < 193; j++)
			getline (yourfile,line);


		char date_time[10];
		strncpy(date_time, &(line[9]), 10);
		


		date =  date + date_time[0] + date_time[1] + "-" 
				+ date_time[2] + date_time[3] + "-"
				+ date_time[4] + date_time[5];	
		
		mytime = mytime + date_time[6] + date_time[7] + ":" + date_time[8] + date_time[9] + ":00";
		
//		cout << date_time << endl;
//		cout << date << endl << mytime << endl;
				
		myfile.close();		
	}
	else 
	{
		cout << "Unable to open file" << endl;
		return;
	}
	stringop str;
	string query = "insert into eqdata\\(eqdate,eqtime,eqlatitude,eqlongtitude,eqdepth,eqmagnitude\\)" ;
	query = query + " values\\(\\'"+ date.c_str() +"\\',\\'" + mytime.c_str() + "\\'," + str.ftoa(latitude,4) + "," + str.ftoa(longtitude,4) + ",0,-1\\)";
	//cout << query << endl;
		
	string command = "java insertQuery ";
	command = command + query;
	system(command.c_str());
}
/** Updates the database table startdates. Sets the successful value to 1 for a given hour. 
 *  This function is used when the epicenter function executes for the given hour. 
 */
void eqDb::updateHour(string year, string month, string day, string hour)
{
	string query = "update startdates set successful=1 where startdate=\\'" ;
	string concat_dateTime = year + "-" + month + "-" + day + " " + hour + ":00:00";
	query = query + concat_dateTime + "\\'";
		
	string command = "java updateStartDates ";
	command = command + query;
	system(command.c_str());
}
