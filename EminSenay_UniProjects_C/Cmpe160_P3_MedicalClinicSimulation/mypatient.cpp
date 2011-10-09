//ID:2002103907
//Emin Þenay
//CMPE 160 Project 3: "Medical Clinic Simulation"
//mypatient.cpp:Patient class functions

#include <string>
#include <stdlib.h>
#include <time.h>
#include "myclasses.h"

Patient::Patient()
{
	DeptName=new char[4];
}

Patient::Patient(long int EnterTime)
{
	DeptName=new char[3];
	for (int i=0; i<3; i++)
	{
		ExTime[i]=0;
		QueTime[i]=0;
	}
	EnteringTime=EnterTime;
	LastProcessTime=EnterTime;
	ToRad=0;
	int rnd=Random(0,100);
	if (rnd>0 && rnd<=15)
		DeptName="INT";
	else if (rnd>15 && rnd<=25)
		DeptName="CAR";
	else if (rnd>25 && rnd<=35)
		DeptName="SUR";
	else if (rnd>35 && rnd<=50)
		DeptName="PSY";
	else if (rnd>50 && rnd<=65)
		DeptName="ORT";
	else if (rnd>65 && rnd<=80)
		DeptName="DER";
	else if (rnd>80 && rnd<=95)
		DeptName="ENT";
	else
		DeptName="RAD";
}

void Patient::GoTo(Unit &Dept,char* UName, long int Time)
{
	if (ToRad==2) //This shows that patient is returning from RAD
	{
		ExTime[2]=Random(5*60,10*60);
		Dept.RadQue.Enqueue(*this);
	}
	else //this shows that patient must go to normal queue of the unit
	{
		if (ExTime[0]==0) //this means patient is going to his first unit.  
		{
			if (strcmp(UName,"INT")==0) 
			{
				ExTime[0]=Random(5*60,15*60);
				int RadPercentage=Random(0,100);
				if(RadPercentage<=25)
					ToRad=1;
			}
			else if(strcmp(UName,"ORT")==0)
			{
				ExTime[0]=Random(5*60,15*60);
				int RadPercentage=Random(0,100);
				if(RadPercentage<=50)
					ToRad=1;
			}
			else if (strcmp(UName,"CAR")==0 || strcmp(UName,"SUR")==0)
			{
				ExTime[0]=Random(10*60,30*60);
				int RadPercentage=Random(0,100);
				if (RadPercentage<=25)
					ToRad=1;
			}
			else if (strcmp(UName,"PSY")==0 || strcmp(UName,"DER")==0)
				ExTime[0]=Random(5*60,20*60);
			else if (strcmp(UName,"ENT")==0)
				ExTime[0]=Random(10*60,20*60);
			else if (strcmp(UName,"RAD")==0)
				ExTime[0]=Random(10*60,15*60);

			if(ExTime[0]+Time>34200) //We are assuming that these patients won't go to RAD. 
				ToRad=0;
		}
		else if (ExTime[0]!=0) //can only be if the patient is going to RAD from the first unit
		{
			ToRad=2;
			ExTime[1]=Random(10*60,15*60);
		}
		Dept.NormQue.Enqueue(*this);
	}//end of else
}

char* Patient::GetDept()
{
	return DeptName;
}

void Patient::SetQueTime(long int Time,char*UName)
{
	int NewQueTime=Time-LastProcessTime;
	if(strcmp(UName,"RAD")==0) 
	{
		if(ToRad==0) //This means RAD is the patient's first Unit
			QueTime[0]+=NewQueTime;
		else if(ToRad==2) //This means the patient is coming from another Unit
			QueTime[1]+=NewQueTime;
	}
	else if (ToRad==0 || ToRad==1) 	//if the Unit is different than RAD
		QueTime[0]+=NewQueTime;	   	//and the patient is not coming from RAD
	else 
		QueTime[2]+=NewQueTime;		//the patient is coming from RAD
}

void Patient::GetQueTime(int *QT)
{
	for (int i=0;i<3;i++)
		QT[i]=QueTime[i];
}

int Patient::Random(int min,int max)
{
	int sub=max-min+1;
	return rand()%sub+min-1;
}

void Patient::GetExTime(int *ET)
{
	for (int i=0;i<3;i++)
		ET[i]=ExTime[i];
}
