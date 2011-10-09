/***************************************************************************
 *   Copyright (C) 2006 by Emin Senay                                      *
 *   esenay@boun.edu.tr                                                    *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#include <iostream>
#include <cstdlib>
#include <queue>
#include "doctor.h"
#include "event.h"
#include "fel.h"
#include "myclasses.h"
#include "patient.h"

using namespace std;

#define ARRIVAL 1
#define ARRIVALEND 2
#define DOCTORBEND 3

// Function prototypes
void arrival(random_var *rnd, double tnow, int* cust_id, doctor *DocA, queue<patient> *QuA,
			 FELType *FEL, linklist *PatientList, int PatientNo, unsigned int *maxQuA);
void arrivalend(random_var *rnd, double tnow, doctor *DocA, queue<patient> *QuA,
				doctor *DocB, queue<patient> *QuB, linklist *PatientList, FELType *FEL,
				unsigned int *maxQuB);
void doctorbend(random_var *rnd, double tnow, doctor *DocA, queue<patient> *QuA,
				doctor *DocB, queue<patient> *QuB, linklist *PatientList, FELType *FEL,
				unsigned int *maxQuA);

int main()
{
	// number of the days that simulation will be run
	// it can be used if independent runs needed
	int day_count = 1;
	
	// initialize the random variable
	random_var rnd;
	rnd.SetSeed(5);
	
	// initialize the variables needed by the output
	unsigned int maxQuA = 0;
	unsigned int maxQuB = 0;
	int MoreThanTwoHours;
	int DayPeopleCount;
	int TotalPatients = 0;
	int MoreThanTwoPatients = 0;
	
	char trace;
	cout << "Do you want a trace of the first 30 patients? (y/n)" << endl;
	cin >> trace;
	
	for (int i = 0; i < day_count; i++)
	{
		// initialize the list of the patients
		linklist PatientList;	
		// initialize the future event list
		FELType FEL;
		// initialization puts the first event in the FEL and the first 
		// patient in the linklist
		FEL.initialize(&PatientList);
		 
		// initalize the Doctor A and Doctor B
		doctor DocA;
		doctor DocB;
		// initialize queues of the doctor A and B
		queue<patient> QuA;
		queue<patient> QuB;
		
		// initialize tnow
		double tnow = 0;
		
		// to identify the customers, customer ids will be used
		int cust_id = 2; // id = 1 had already been put to the FEL
		
		while (tnow < 24*60*20) // in minutes (last 20 is because of 1 long simulation of 20 days)
		//	if independent simulations is needed, delete the last 20
		{
			// Get the new event and set tnw to the clock of the clock of the event
			Event new_event = FEL.GetNextEvent();
			tnow = new_event.clock;
			//cout << tnow << " ";
			
			if (new_event.eventtype == ARRIVAL)
				arrival(&rnd, tnow, &cust_id, &DocA, &QuA, &FEL,
				 &PatientList, new_event.cust_no, &maxQuA);
			else if (new_event.eventtype == ARRIVALEND)
				arrivalend(&rnd, tnow, &DocA, &QuA, &DocB, &QuB, &PatientList, &FEL,
				&maxQuB);
			else //if (new_event.eventtype == DOCTORBEND)
				doctorbend(&rnd, tnow, &DocA, &QuA, &DocB, &QuB, &PatientList, &FEL,
				&maxQuA);
		}
		if ((trace == 'y' || trace == 'Y') && i == 0)
			PatientList.display(30);
		PatientList.MoreThanTwoHours(DayPeopleCount,MoreThanTwoHours);
		TotalPatients += DayPeopleCount;
		MoreThanTwoPatients += MoreThanTwoHours;
	}
	cout << "Maximum queue length in doctor A: " << maxQuA << endl;
	cout << "Maximum queue length in doctor B: " << maxQuB << endl; 
	
	double percentage = (100.0 * MoreThanTwoPatients) / TotalPatients;
	cout << "The percentage of patients who have a total time in system more than two hours: ";
	cout << percentage << endl; 
	cout << "Press a key and ENTER to continue" << endl;
	fflush(stdin);
	cin >> percentage;
	return 0;	
}
void arrival(random_var *rnd, double tnow, int* cust_id, doctor *DocA, queue<patient> *QuA,
			 FELType *FEL, linklist *PatientList, int PatientNo, unsigned int *maxQuA)
{
	// Generating the next arrival
	double interarr = rnd -> rand_exp(20); //TODO buraya bir bak, 20 den emin ol
	Event *evn = new Event();
	evn -> eventtype = ARRIVAL;
	evn -> clock = interarr + tnow;
	evn -> cust_no = (*cust_id);
	// Adding the event to FEL
	FEL -> AddEvent(*evn);
	
	// Creating a patient for this event
	patient *pt = new patient(*cust_id);
	pt -> ArrivalTime = tnow + interarr;
	(*cust_id)++;

	patient *current_pat = NULL;
	if (PatientList ->  find(PatientNo, &current_pat) == 0)
	{
		cout << "error" << endl;
		exit(-1);
	}
	
	// if doctor A is not busy, send the patient to him,
	// else, add the patient to the queue A
	if (!(DocA -> busy))
	{
		// generate a treatment time
		double svc_time = rnd -> rand_gamma2(0.2);
		
		// create an event which is for the end of treatment for doctor A
		Event tmp;
		tmp.clock = svc_time + tnow;
		tmp.eventtype = ARRIVALEND;
		tmp.cust_no = PatientNo;
		// add this event to FEL
		FEL -> AddEvent(tmp);
		
		// set doctor a to busy and assign the patient_id
		DocA -> busy = true;
		DocA -> patient_id = PatientNo;

		current_pat -> DoctorATime = tnow;
	}
	else
	{
		QuA -> push(*current_pat);
		if (QuA -> size() > *maxQuA)
			*maxQuA = QuA -> size();
	}
	// add the patient to the list of patients
	PatientList -> append(pt);
}
void arrivalend(random_var *rnd, double tnow, doctor *DocA, queue<patient> *QuA,
				doctor *DocB, queue<patient> *QuB, linklist *PatientList, FELType *FEL,
			 	unsigned int* maxQuB)
{
	// First, send the patient whose treatment is finished now
	patient *pt;
	// if system couldn't find the patient in the list of all patients,
	// then there's a problem.
	if (PatientList -> find(DocA -> patient_id, &pt) == 0)
	{
		cout << "System couldn't find the patient in the list off all patients." << endl;
		cout << "This is not supposed to happen." << endl << "Exiting..." << endl;
		exit(-1);
	}
	
	// if found, pt is pointing to that patient
	// check if it is first time of  coming to doctor A of the patient
	if (pt -> DoctorAEndTime == -1) // it is first time
	{
		pt -> DoctorAEndTime = tnow;
		
		// if doctor B is not busy, send the patient to him,
		// else, add the patient to the queue B
		if (!DocB -> busy)
		{
			// generate a treatment time
			double svc_time = rnd -> uniform(10.0,20.0);
			
			// create an event which is for the end of treatment for doctor B
			Event tmp;
			tmp.clock = svc_time + tnow;
			tmp.eventtype = DOCTORBEND;
			tmp.cust_no = pt -> PatientNumber;
			// add this event to FEL
			FEL -> AddEvent(tmp);
			
			// set doctor B to busy and assign the patient_id
			DocB -> busy = true;
			DocB -> patient_id = pt -> PatientNumber;
			
			pt -> DoctorBTime = tnow;
		}
		else
		{
			QuB -> push(*pt);
			if (QuB -> size() > *maxQuB)
				*maxQuB = QuB -> size();
		}
	}
	else // it is the second time
	{
		pt -> EndOfService = tnow;
	}
	
	// Now, get a new patient from the QuA for doctor A (if queue is not empty)
	if (!(QuA ->empty()))
	{
		// take a patient from the queue
		patient Pat = QuA -> front();
		QuA -> pop();
		
		// generate a treatment time
		double trt_time = rnd -> rand_gamma2(0.2);
		
		// create an event which is for the end of treatment for doctor A
		Event temp;
		temp.clock = trt_time + tnow;
		temp.eventtype = ARRIVALEND;
		temp.cust_no = Pat.PatientNumber;
		// add this event to FEL
		FEL -> AddEvent(temp);
		DocA -> patient_id = Pat.PatientNumber;
		
		patient *pt;
		// if system couldn't find the patient in the list of all patients,
		// then there's a problem.
		if (PatientList -> find(DocA -> patient_id, &pt) == 0)
		{
			cout << "System couldn't find the patient in the list off all patients." << endl;
			cout << "This is not supposed to happen." << endl << "Exiting..." << endl;
			exit(-1);
		}
		// if found, pt is pointing to that patient
		pt -> DoctorATime = tnow;	
	}
	else // if queue is empty, set the status of the Doctor A to idle
	{
		DocA -> busy = false;
	}
}
void doctorbend(random_var *rnd, double tnow, doctor *DocA, queue<patient> *QuA,
				doctor *DocB, queue<patient> *QuB, linklist *PatientList, FELType *FEL,
				unsigned int *maxQuA)
{
	// First, send the patient whose treatment is finished now.
	// With 70%, send him to home, with 30% send him to Doctor A
	
	double againA = rnd -> uniform();
	
	patient *pt;
	// if system couldn't find the patient in the list of all patients,
	// then there's a problem.
	if (PatientList -> find(DocB -> patient_id, &pt) == 0)
	{
		cout << "System couldn't find the patient in the list off all patients." << endl;
		cout << "This is not supposed to happen." << endl << "Exiting..." << endl;
		exit(-1);
	}
	// if found, pt is pointing to that patient
	pt -> DoctorBEndTime = tnow;	
	
	if (againA > 0.3) //Patient will be sent to home
	{
		pt -> EndOfService = tnow;	
	}
	else // patient will be sent to Doctor A
	{
		if (!(DocA -> busy)) // if Doctor A is not busy, treatment begins
		{
			// generate a treatment time
			double svc_time = rnd -> rand_gamma2(0.2);
			
			// create an event which is for the end of treatment for doctor A
			Event tmp;
			tmp.clock = svc_time + tnow;
			tmp.eventtype = ARRIVALEND;
			tmp.cust_no = pt -> PatientNumber;
			// add this event to FEL
			FEL -> AddEvent(tmp);
		
			// set doctor a to busy and assign the patient_id
			DocA -> busy = true;
			DocA -> patient_id = pt -> PatientNumber;
			pt -> DoctorAAgainTime = tnow;
		}
		else //Doctor A is busy
		{
			QuA -> push(*pt);
			if (QuA -> size() > *maxQuA)
				*maxQuA = QuA -> size();
		}
	}
	// Now, get a new patient from the QuB for doctor B (if queue is not empty)
	if (!(QuB -> empty()))
	{
		double trt_time = rnd -> uniform(10.0, 20.0);
		
		patient pat = QuB -> front();
		QuB -> pop();
		
		Event ev;
		ev.clock = trt_time + tnow;
		ev.eventtype = DOCTORBEND;
		ev.cust_no = pat.PatientNumber;
		
		FEL -> AddEvent(ev);
		DocB -> patient_id = pat.PatientNumber;
		
		patient *pt;
		if (PatientList -> find(pat.PatientNumber, &pt) == 0)
		{
			cout << "error" << endl;
			exit(-1);
		}
		pt -> DoctorBTime = tnow;
	}
	else // if queue is empty, set the status of Doctor B to idle
	{
		DocB -> busy = false;
	}
}
