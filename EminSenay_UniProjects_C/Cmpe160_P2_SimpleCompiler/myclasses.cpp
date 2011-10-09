//myclasses.cpp

#include <iostream>
#include <string.h>
#include "myclasses.h"

UsersProgram::UsersProgram()
{
	for(int i=0; i<27 ; i++)
		IsFull[i]=0;
}

UsersProgram::~UsersProgram()
{
	for (int i=0; i<100 ; i++)
		delete [] lines[i];
}

double UsersProgram::getv(char &varletter)
{
	int integerValue=varletter-('A'-1);  //variable's integer equivalent in the array
	if (checkFull(varletter)==0)  //if the variable is not initialized before
		varletter='!';
	return variablename[integerValue];
}
void UsersProgram::setv(char varletter, double number)
{
	int integerValue=varletter-('A'-1);  //variable's integer equivalent in the array
	variablename[integerValue]=number;
	IsFull[integerValue]=1;   //IsFull flag of the variable set to 1
}
void UsersProgram::setl(int linenum, const char* line)
{
	int length=strlen(line);
	lines[linenum]=new char[length+1];
	for (int i=0; i<=length ; i++)
		lines[linenum][i]=line[i];
}
int UsersProgram::checkFull (const char varletter)
{
	int integerValue=varletter-('A'-1);
	if (IsFull[integerValue]==1)  //if the variable is initialized before
		return 1;
	return 0;
}