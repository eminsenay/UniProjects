//ID:2002103907
//Emin Þenay
//CMPE 160 Project 3: "Medical Clinic Simulation"
//mystat.cpp: Statistics class functions

#include <iostream>
#include <fstream>
#include <string>
#include "myclasses.h"

using namespace std;

//Constructor
Statistics::Statistics()
{
	RadPat=0;
	TotalPat=0;
	NotBeingEx=0;
	TotalClinicTime=0;
	MaxWaitingTime=0;
	for(int i=0; i<8; i++)
	{
		ExaminedUnitPat[i]=0;
		UnitPat[i]=0;
		UnitTime[i]=0;
		QueLength[i]=0;
		QueTime[i]=0;
	}
}
//Settng simulation time
void Statistics::SetSimTime(int ST)
{
	SimTime=ST;
}
//Setting arrival parameter
void Statistics::SetArrPar(int A)
{
	ArrPar=A;
}
//Setting waiting time of the patient.
void Statistics::SetPatientTime(char* Unitname,int ExTime,int QTime)
{
	int choice=FindDeptNumber(Unitname);	
	UnitTime[choice]+=ExTime+QTime;
	if (MaxWaitingTime<ExTime+QTime)
		MaxWaitingTime=ExTime+QTime;
}
//Finding the number which will be used in the arrays of the class.
int Statistics::FindDeptNumber(char* Unitname)
{
	int choice;
	if (strcmp(Unitname,"INT")==0)
		choice=0;
	else if (strcmp(Unitname,"CAR")==0)
		choice=1;
	else if (strcmp(Unitname,"SUR")==0)
		choice=2;
	else if (strcmp(Unitname,"PSY")==0)
		choice=3;
	else if (strcmp(Unitname,"ORT")==0)
		choice=4;
	else if (strcmp(Unitname,"DER")==0)
		choice=5;
	else if (strcmp(Unitname,"ENT")==0)
		choice=6;
	else if (strcmp(Unitname,"RAD")==0)
		choice=7;
	return choice;
}

//Increments given unit's patient number by 1.
void Statistics::IncrementUnitPat(char* Unitname)
{
	int choice=FindDeptNumber(Unitname);
	UnitPat[choice]++;
}

//Incrementing given unit's queue lengths
void Statistics::SetQueLength(Unit &Temp,char* Unitname)
{
	int choice=FindDeptNumber(Unitname);
	int NormQueLength=Temp.NormQue.LengthIs();
	int RadQueLength=Temp.RadQue.LengthIs();
	QueLength[choice]+=(NormQueLength+RadQueLength);
}

//Counting the queues at the end of the day and adding them to NotBeingEx
void Statistics::SetNotBeingEx(Unit &Temp,char* Unitname)
{
	int choice=FindDeptNumber(Unitname);
	int QueLength=Temp.NormQue.LengthIs()+Temp.RadQue.LengthIs();
	NotBeingEx+=QueLength;
}

//Setting queue times of units
void Statistics::SetQueTime(char* UnitName, int QTime)
{
	int choice=FindDeptNumber(UnitName);
	QueTime[choice]+=QTime;
}

//Setting total clinic time
void Statistics::SetTotalClinicTime(int CT)
{
	TotalClinicTime+=CT;
}

//writing statistics to Medsim.out
void Statistics::DisplayStat()
{
	char *units[8]={"INT","CAR","SUR","PSY","ORT","DER","ENT","RAD"};
	ofstream output;
	output.open("Medsim.out");
	if (!output.is_open())
	{
		cout << "Medsim.out can not be created." << endl << "Terminating..." << endl;
		exit(0);
	}
	output << "ID:2002103907 " << endl << "Name: Emin Þenay";
	output << endl << "Clinic Statistics: " << endl << endl;
	output << "1. Arrival Parameter(A): " << ArrPar << " seconds" << endl << endl;
	output << "2. Simulation Time: " << SimTime;
	if (SimTime==1)
		output << " day" << endl << endl;
	else
		output << " days" << endl << endl;

	output << "3. Total number of patients arrived to the clinic: " << TotalPat << endl << endl;

	output << "4. Total number of patients arrived to units:" << endl << endl;
	int sum=0;
	for (int i=0;i<8;i++)
	{
		output << "   To " << units[i] << ": ";
		output << UnitPat[i] << endl;
		sum+=ExaminedUnitPat[i];
	}

	output << endl << "5. Average time that patients spend in the clinic.(for the whole clinic): ";
	output << TotalClinicTime/sum << " seconds(" << (TotalClinicTime/sum)/60 << " minutes)." << endl << endl;

	output << "6. Average time that patients spend in the clinic: " << endl << endl;
	int j; // Original code is modified here so that it can be built in VS2010.
	for (j=0;j<7;j++)
	{
		if(ExaminedUnitPat[j]==0)
			output << "   No patients examined in " << units[j] << endl;
		else
		{
			output << "   For " << units[j] << ": " << UnitTime[j]/ExaminedUnitPat[j];
			output << '\t' <<"seconds(" << (UnitTime[j]/ExaminedUnitPat[j])/60 << '\t' << "minutes)" << endl;
		}
	}
	if(ExaminedUnitPat[7]==0)
			output << "   No patients examined in " << units[7] << endl;
	else
		{
			output << "   For " << units[7] << ": " << UnitTime[j]/RadPat;
			output << '\t' <<"seconds(" << (UnitTime[7]/RadPat)/60 << '\t' << "minutes)" << endl;
		}
	
	output << endl;
	output << "7. Average waiting time in queues of units:" << endl << endl;
	for (int k=0;k<8;k++)
	{
		if(ExaminedUnitPat[k]==0)
			output << "   No patients examined in " << units[k] << endl;
		else
		{
			output << "   For " << units[k] << ": ";
			output << QueTime[k]/ExaminedUnitPat[k] << '\t' << "seconds(" << QueTime[k]/ExaminedUnitPat[k]/60 << '\t' << "minutes)" << endl;
		}
	}
	
	output << endl << "8. Average length of unit queues:" << endl << endl;
	for (int l=0; l<8; l++)
	{
 		output << "   " << units[l] << ": ";
  		output << QueLength[l]/(34200*SimTime) << endl;
	}
	
	output << endl << "9. Maximum waiting time of a patient: ";
 	output << MaxWaitingTime << " seconds(" << MaxWaitingTime/60 << " minutes)" << endl << endl;
 	
	output << "10. Average number of patients that leave the clinic without being examined at the end of the day: ";
 	output << NotBeingEx/SimTime << endl << endl;
 	output.close();
}
	
void Statistics::IncrementTotalPat()
{
	TotalPat++;
}

void Statistics::IncrementExaminedPat(char *Unitname)
{
	int Dept=FindDeptNumber(Unitname);
	ExaminedUnitPat[Dept]++;
}
