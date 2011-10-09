//ID:2002103907
//Emin Þenay
//CMPE 160 Project 3: "Medical Clinic Simulation"
//myclasses.h:class definition file

#ifndef MYCLASSES_H
#define MYCLASSES_H
class Unit;
class Statistics;
class QueType;
struct NodeType;

class Patient
{
	friend class QueType;
public:
	Patient(); //Default Constructor
	Patient(long int EnterTime); //Constructor
	void GoTo(Unit &Dept,char* UName, long int Time);
	char* GetDept();
	void SetQueTime (long int Time,char* UName);
	void GetQueTime (int* QT);
	int Random(int min, int max);
	void GetExTime(int* ET);
	int ToRad;
	int LastProcessTime;
private:
	int ExTime[3];
	int QueTime[3];
	char* DeptName;
	int EnteringTime;
};

class FullQueue
{};

class EmptyQueue
{};

class QueType
{
public:
	QueType(); //constructor
	~QueType(); //destructor
	void MakeEmpty();
	void Enqueue (Patient);
	void Dequeue (Patient&);
	bool IsEmpty() const;
	bool IsFull() const;
	int LengthIs() const;
private:
	NodeType* front;
	NodeType* rear;
	int Length;
};

class Unit
{
public:
	Unit();
	bool IsEmpty();
	void MakeEmpty();
	void GetPatient();
	QueType NormQue;
	QueType RadQue;
	Patient ExaminedPat;
private:
	bool empty;
};

class Statistics
{
public:
	Statistics();
	int RadPat;
	void SetArrPar(int A);
	void SetSimTime(int ST);
	void SetPatientTime(char* Unitname, int ExTime, int QTime);
	void IncrementUnitPat(char* Unitname);
	void IncrementExaminedPat(char* Unitname);
	void SetQueLength(Unit &Temp, char* Unitname);
	void SetNotBeingEx(Unit &Temp, char* Unitname);
	void DisplayStat();
	void SetQueTime(char* UnitName, int QTime);
	void SetTotalClinicTime(int CT);
	void IncrementTotalPat();
private:
	int ArrPar; //Arrival Parameter
	int SimTime; //Simulation Duration (Day)
	int ExaminedUnitPat[8]; //Examined patient numbers 
	int UnitPat[8]; //Patient numbers arrived to each unit
	int UnitTime[8];
	double QueLength[8]; //Sum of the queue lengths of each second
	int NotBeingEx;
	int QueTime[8]; //Sum of the waiting time in each queue
	int TotalClinicTime; //Sum of total time spent in clinic of each patient
	int TotalPat; //Total number of patients came to the clinic
	int MaxWaitingTime; //Will store the maximum waiting time
	int FindDeptNumber(char* Unitname); //Client will give the 3 letter code of unit, 
										//this will convert it to number that class uses
};

#endif
