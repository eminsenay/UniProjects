//ID:2002103907
//Emin Þenay
//CMPE 160 Project 3: "Medical Clinic Simulation"
//main.cpp:main program

#include <iostream>
#include <string>
#include <time.h>
#include <stdlib.h>
#include "myclasses.h"

void endofday(Unit &Unt, Unit &RAD, char* Uname, Statistics &ClinicStat);
void NewPatient (long int time,Unit &INT,Unit &CAR,Unit &SUR,Unit &PSY,Unit &ORT,Unit &DER,Unit &ENT,Unit &RAD,Statistics &ClinicStat);
void checkUnit (Unit &Unt,Unit &RAD,Unit &ORT,Unit &INT,Unit &CAR,Unit &SUR,char* Uname,long int Time, Statistics &ClinicStat);
int Random(int min,int max);

using namespace std;

int main()
{
	srand(time(NULL));
	Unit INT,CAR,SUR,PSY,ORT,DER,ENT,RAD;
	Statistics ClinicStat;
	int A;
	int day;
	
	cout << "Please Enter the Patent Arrival Time: ";
	cin >> A;
	ClinicStat.SetArrPar(A);
	cout << "How many days does the simulation continue? ";
 	cin >> day;
	ClinicStat.SetSimTime(day);
	
	NewPatient(1,INT,CAR,SUR,PSY,ORT,DER,ENT,RAD,ClinicStat);
	
	int rndtime=Random(1,A);
	
	for(int i=0; i<day; i++)
	{
 		for(long int time=1; time<34200; time++) //time<1 day=60*60*9.5 sec=34200 sec
		{
			rndtime--;
			if (rndtime<=0) //time has come for taking a new patient.
			{
				rndtime=Random(1,A);
				NewPatient(time,INT,CAR,SUR,PSY,ORT,DER,ENT,RAD,ClinicStat);
			}

			/*We must check the RAD Unit twice. The explanation is quite messy, but I will try:
			If we do not check the RAD unit first, the patient sent back after RAD may 
			not be taken first in other units. Units can take the normal patient instead of
			taking the RAD patient, which we do not want to be like that.
			RAD unit may be empty at some time when first checked, but the other units may
			send patient to RAD unit after checking at that moment. If we do not check
			the RAD unit again, RAD unit can not take the patient sent from the other 
			units at that moment. So we must check RAD unit twice. */

  			checkUnit(RAD,RAD,ORT,INT,CAR,SUR,"RAD",time,ClinicStat);
  			checkUnit(INT,RAD,ORT,INT,CAR,SUR,"INT",time,ClinicStat);
  			checkUnit(CAR,RAD,ORT,INT,CAR,SUR,"CAR",time,ClinicStat);
  			checkUnit(SUR,RAD,ORT,INT,CAR,SUR,"SUR",time,ClinicStat);
  			checkUnit(PSY,RAD,ORT,INT,CAR,SUR,"PSY",time,ClinicStat);
  			checkUnit(ORT,RAD,ORT,INT,CAR,SUR,"ORT",time,ClinicStat);
  			checkUnit(DER,RAD,ORT,INT,CAR,SUR,"DER",time,ClinicStat);
  			checkUnit(ENT,RAD,ORT,INT,CAR,SUR,"ENT",time,ClinicStat);
  			checkUnit(RAD,RAD,ORT,INT,CAR,SUR,"RAD",time,ClinicStat);	

	 		//Setting queue lengths must be done in every second for statistics. 
			ClinicStat.SetQueLength(RAD,"RAD");
			ClinicStat.SetQueLength(INT,"INT");
			ClinicStat.SetQueLength(CAR,"CAR");
			ClinicStat.SetQueLength(SUR,"SUR");
			ClinicStat.SetQueLength(PSY,"PSY");
			ClinicStat.SetQueLength(ORT,"ORT");
			ClinicStat.SetQueLength(DER,"DER");
			ClinicStat.SetQueLength(ENT,"ENT");

		} 
		//end of the day
		endofday(INT,RAD,"INT",ClinicStat);
		endofday(CAR,RAD,"CAR",ClinicStat);
		endofday(SUR,RAD,"SUR",ClinicStat);
		endofday(PSY,RAD,"PSY",ClinicStat);
		endofday(ORT,RAD,"ORT",ClinicStat);
		endofday(DER,RAD,"DER",ClinicStat);
		endofday(ENT,RAD,"ENT",ClinicStat);
		endofday(RAD,RAD,"RAD",ClinicStat);

	}
	//end of the given day
	ClinicStat.DisplayStat();
	return 0;
}

void checkUnit (Unit &Unt,Unit &RAD,Unit &ORT,Unit &INT,Unit &CAR,Unit &SUR,char* Uname,long int Time, Statistics &ClinicStat)
{	
	while(1)
	{
		if(Unt.IsEmpty())//We must take a new patient
		{
			//GetPatient takes the patient first from the radque; if it is empty, then normque
 			Unt.GetPatient();

			//if unit is again empty, it means there is no patient waiting in queues
 			if (Unt.IsEmpty()) 
 				break;

			//We must increment number of patients that examined in the unit.But we do
			//not want to increase the number of patients when a patient returns to his
			//main unit from RAD.So,if ToRad=2 and Uname!=RAD, we do no increment ExaminedPat 
			
			if(Uname=="RAD" && Unt.ExaminedPat.ToRad==0)
				ClinicStat.RadPat++;
			if (Unt.ExaminedPat.ToRad!=2)
				ClinicStat.IncrementExaminedPat(Uname);
			else if(Unt.ExaminedPat.ToRad==2 && strcmp(Uname,"RAD")==0)
				ClinicStat.IncrementExaminedPat("RAD");
			
			//Setting queue and LastProcess times
 			Unt.ExaminedPat.SetQueTime(Time,Uname);
 			Unt.ExaminedPat.LastProcessTime=Time;
		}

		int tmp[3]; //Will take examination durations of patient
		int QT[3]; //Will take waiting times in queues 
		Unt.ExaminedPat.GetExTime(tmp); 
		Unt.ExaminedPat.GetQueTime(QT);
		int Exam; //Will be the appropriate member of tmp

		if (strcmp(Uname,"RAD")==0)
		{
			if (Unt.ExaminedPat.ToRad==0) //This means RAD is patient's first Unit
				Exam=tmp[0];
			else //This means patient is coming from another Unit
  				Exam=tmp[1];
		}
		else //if Unit is not RAD
		{
			if (Unt.ExaminedPat.ToRad==2) //This means patient is coming from RAD
  				Exam=tmp[2];
 			else //This means Unit is patient's first Unit
   				Exam=tmp[0];
		}  

		//If patient has finished his examination duration
   		if (Time-Unt.ExaminedPat.LastProcessTime==Exam)
		{
			Unt.ExaminedPat.LastProcessTime=Time;
 			if (Unt.ExaminedPat.ToRad==1) //Patient must go to RAD
			{
   				Unt.ExaminedPat.GoTo(RAD,"RAD",Time);
				ClinicStat.IncrementUnitPat("RAD");
   				Unt.MakeEmpty();
				continue; //All of the unit operations must start again
			}

			//Patient has either finished his job with clinic or he has finished his
  			//job with RAD after coming from some unit.								 
			else if(Unt.ExaminedPat.ToRad==2) 
			{ 							     
				//ToRad is 2 both in RAD Unit and returning unit. We must not
				//increment patient time if patient is in RAD unit
				if(strcmp(Uname,"RAD")!=0)//This means patient has finished all of his exams. 
				{
					//Statistical operations
					ClinicStat.SetQueTime(Uname,QT[0]+QT[2]);
					ClinicStat.SetQueTime("RAD",QT[1]);
			   		ClinicStat.SetPatientTime(Uname,tmp[0]+tmp[1]+tmp[2],QT[0]+QT[1]+QT[2]);
		   			ClinicStat.SetTotalClinicTime(tmp[0]+tmp[1]+tmp[2]+QT[0]+QT[1]+QT[2]);
				}
				else //Patient must go to his main unit after RAD
				{
					char* Dpt=Unt.ExaminedPat.GetDept(); //Unit is taken
					//Sending patient to his unit
					if (strcmp(Dpt,"ORT")==0)			
						Unt.ExaminedPat.GoTo(ORT,Dpt,Time);
   	 				else if (strcmp(Dpt,"INT")==0)
						Unt.ExaminedPat.GoTo(INT,Dpt,Time);
					else if (strcmp(Dpt,"CAR")==0)
						Unt.ExaminedPat.GoTo(CAR,Dpt,Time);
					else if (strcmp(Dpt,"SUR")==0)
						Unt.ExaminedPat.GoTo(SUR,Dpt,Time);
				}
				Unt.MakeEmpty();
				continue; //This unit's all operations must start again.
			}

			//Patient has finished his job with clinic
			else if(Unt.ExaminedPat.ToRad==0)  
 			{
 				ClinicStat.SetQueTime(Uname,QT[0]);
 				ClinicStat.SetPatientTime(Uname,tmp[0]+tmp[1]+tmp[2],QT[0]+QT[1]+QT[2]);
 				ClinicStat.SetTotalClinicTime(tmp[0]+tmp[1]+tmp[2]+QT[0]+QT[1]+QT[2]);
				Unt.MakeEmpty();
 				continue; //All of the unit operations must start again.
			}
		}//end of if (Time-Unt.ExaminedPat.LastProcessTime==Exam)
		else //if patient does not finish his examination time
  			break;
	}//end of while		
}//end of the function.

//Basic random function, gives a random number between min and max
int Random(int min,int max)
{
	int sub=max-min+1;
	return (rand()%sub)+min-1;
}

//New patient come and go a random unit. Patient's unit is set when a new patient
//class is constructed, so this fnc only takes the unit of patient and enqueues him to 
//the queue of the unit.
void NewPatient (long int time,Unit &INT,Unit &CAR,Unit &SUR,Unit &PSY,Unit &ORT,Unit &DER,Unit &ENT,Unit &RAD,Statistics &ClinicStat)
{
	Patient NewPat(time);
	ClinicStat.IncrementTotalPat();
    char* U= NewPat.GetDept();
	ClinicStat.IncrementUnitPat(U);
	if (strcmp(U,"INT")==0)
		NewPat.GoTo(INT,U,time);
	else if (strcmp(U,"CAR")==0)
		NewPat.GoTo(CAR,U,time);
	else if (strcmp(U,"SUR")==0)
		NewPat.GoTo(SUR,U,time);
	else if (strcmp(U,"PSY")==0)
		NewPat.GoTo(PSY,U,time);
	else if (strcmp(U,"ORT")==0)
		NewPat.GoTo(ORT,U,time);
	else if (strcmp(U,"DER")==0)
		NewPat.GoTo(DER,U,time);
	else if (strcmp(U,"ENT")==0)
		NewPat.GoTo(ENT,U,time);
	else if (strcmp(U,"RAD")==0)
		NewPat.GoTo(RAD,U,time);
}

//Operations that must be done at the end of the day is done in this function
void endofday(Unit &Unt, Unit &RAD, char* Uname, Statistics &ClinicStat)
{
	//first, counting the number of patients who can not be examined
	ClinicStat.SetNotBeingEx(Unt,Uname); 
	
	//Then, emptying queues of units.
	Unt.RadQue.MakeEmpty();
	Unt.NormQue.MakeEmpty();  	
	
	//If there are patients who enter the unit before end of the day but can not
	//finish their examinations till the end of the day, we must wait until they finish
	//their examinations.
	if (!Unt.IsEmpty())
	{
		int tmp[3]; //Will take examination durations of patient
		int QT[3]; //Will take waiting times in queues 
		Unt.ExaminedPat.GetExTime(tmp); 
		Unt.ExaminedPat.GetQueTime(QT);
		if(Unt.ExaminedPat.ToRad==0) //we know that ToRad can not be 1
		{
			ClinicStat.SetQueTime(Uname,QT[0]);
 			ClinicStat.SetPatientTime(Uname,tmp[0],QT[0]);
 			ClinicStat.SetTotalClinicTime(tmp[0]+QT[0]);
		}
		else if (Unt.ExaminedPat.ToRad==2)
			//we have to forget the patient who is in RAD after some unit
			if(strcmp(Uname,"RAD")!=0) 
			{
				ClinicStat.SetQueTime(Uname,QT[0]+QT[2]);
				ClinicStat.SetQueTime("RAD",QT[1]);
				ClinicStat.SetPatientTime(Uname,tmp[0]+tmp[2],QT[0]+QT[2]);
				ClinicStat.SetPatientTime("RAD",tmp[1],QT[1]);
				ClinicStat.SetTotalClinicTime(tmp[0]+tmp[1]+tmp[2]+QT[0]+QT[1]+QT[2]);
			}
		//Emptying the unit
		Unt.MakeEmpty();
	}
}
