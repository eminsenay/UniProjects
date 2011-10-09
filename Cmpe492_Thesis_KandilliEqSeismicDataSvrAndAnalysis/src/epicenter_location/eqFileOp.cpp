/** Contains implementations of the functions of the eqFileOp class. */
 
#include <stddef.h>
#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <string>
#include <iostream>
#include <cstdlib>
#include <ostream>
#include "eqFileOp.h"

using namespace std;

/** Extracts the compressed seismic files located in a given source directory. The destination directory is also given.
 *
 *  The file name format of the compressed files is as follows:
 *  date.station_name.type1.type2.zip
 *  date: The hour which the data belongs to. Given as yyyymmddhh format.
 *  station_name: The name of the station which sends the data.
 *  type1: Specific information of the type of the station. It can be one of these values: BHE,BNH,BHZ,SHE,SHN,SHZ
 *  type2: Specific information of the data. It can be one of these values: IU, KO, GE, TK
 *
 *  By specifying the type1 and type2 parameters, one can extract only the necessary data for usage. 
 *  If a parameter is specified as NULL, all types of files are extracted. 
 *  For example, if type1 is equal to NULL and type2 is equal to KO, the files which suits date.station_name.*.KO.zip are extracted.
 */
void eqFileOp::extract (const char* sourceDir, const char* destinationDir, const char* type1, const char* type2)
{
	DIR *dp;
	
	string destDir = destinationDir;
	//dirPath deki bosluklari temizle
	string dirPath = sourceDir;
	string newPath = "";
	for (unsigned int i = 0; i < dirPath.length(); i++)
	{
		if (sourceDir[i] == ' ')
		{
			 newPath += "\\ ";
		}
		else
		{
			newPath += sourceDir[i];
		}
	}
	//cout << newPath << endl;
	
	dp = opendir (sourceDir); 
	if (dp != NULL)
	{
		string searchPattern = "*";
		if (type1 != NULL)
		{
			searchPattern += ".";
			searchPattern.append(type1);
		}
		if (type2 != NULL)
		{
			searchPattern += ".";
			searchPattern.append(type2);
		}
		searchPattern += "*.zip";
		
		string unzipCommand = "find " + newPath + "/ -name '" + searchPattern + "' -exec unzip -o -d " + destDir +" {} \\; >/dev/null";
		//cout << unzipCommand << endl;
		system(unzipCommand.c_str()); //c_str() string i char* a cevirir.
		
		(void) closedir (dp);
	}
	else
		perror ("Couldn't open the directory");
}

/** Returns an array of file names which are located in the given source directory. The number of elements in the array is also returned.
 *  Instead of returning a list of all files, one can use the type1 and type2 parameters to return a specific set of elements.
 *  More information about these parameters is given in extract method.
 */
string* eqFileOp::listFiles (const char* sourceDir, const char* type1, const char* type2, int& numberOfElements)
{
	string* fileList;
	string dirPath = sourceDir;
	string newPath = "";
	string type1Str, type2Str;
	
	if (type1 != NULL)
		type1Str = type1;
	if (type2 != NULL)
		type2Str = type2;
	int fileCount = 0;

	//path'te ' ' varsa onu '\ ' ile değiştirir.  
	for (unsigned int i = 0; i < dirPath.length(); i++)
	{
		if (sourceDir[i] == ' ')
		{
			 newPath += "\\ ";
		}
		else
		{
			newPath += sourceDir[i];
		}
	}
	
	DIR *dp = opendir (sourceDir); 
	struct dirent *ep;
	if (dp != NULL)
	{		
		/* Klasorde kac dosya var */
		while (ep = readdir (dp))
		{
			fileCount++;
		}
		
		(void)closedir(dp);
		dp = opendir(sourceDir);
		fileList = new string[fileCount];
		fileCount = 0;
		
		while (ep = readdir (dp))
		{
			//puts (ep->d_name);
			
			// Take the next file 
			string name = ep->d_name;
			//cout << name << endl;
			
			if (name == "." || name == "..")
				continue;
			
			if (type1 == NULL && type2 == NULL)
			{
				fileList[fileCount++] = name;
				continue;
			}
			if (name.size() > 6) //*.type1.type2 (en az uzunluk toplami 6)
			{
				//cout << extension << endl;
				
				// type 1 ve 2 yi belirleme
				string foundType2Str = name.substr(name.size()-2);
				string foundType1Str = name.substr(name.size()-6,3);
				string remaining = name.substr(0,name.size()-6); //*. kismi
				//cout << remaining << " " << type1Str << " " << type2Str << endl;
				if (type1 == NULL && type2Str == foundType2Str.c_str())
				{
					fileList[fileCount++] = name;
				}
				else if (type2 == NULL && type1 == foundType1Str)
				{
					fileList[fileCount++] = name;
				}
				else if (type1Str == foundType1Str && type2Str == foundType2Str)
				{
					fileList[fileCount++] = name;
				}				
			}
		}		
		(void) closedir (dp);
		
		numberOfElements = fileCount-1;
	}
	else
		perror ("Couldn't open the directory");
	
	return fileList;

}
