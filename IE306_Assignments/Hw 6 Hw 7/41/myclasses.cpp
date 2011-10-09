/***************************************************************************
 *   Copyright (C) 2005 by Emin Senay                                      *
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
#include <fstream>
#include <string>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include "myclasses.h"

using namespace std;
/** Creates a new random value instance. Sets the seed*/
random_var::random_var()
{
	seed = time(NULL);
}
/** generates a U(0,1) random variate using the recursion:
 *    X(i+1) = 69069*X(i) + 1 mod 2^32  
 */
double random_var::uniform()
{
	seed = 69069 * seed + 1;
	return seed * 2.3283064365386962891e-10 + 1.1641532182693481445e-10;
}
/** Changes the seed to the NewSeed value */
void random_var::SetSeed(long NewSeed)
{
	seed = NewSeed;
}
/** returns the seed */
long random_var::GetSeed()
{
	return seed;
}
/** generates random variates of the exponential distr. with E(X)=mu */ 
double random_var::rand_exp(double mu)
{ 
  return -log(uniform())*mu;
}
/** generates random variates of the uniform distr. between a and b */ 
double random_var::uniform(double a, double b)
{
	return uniform() * (b-a) + a;
}
/** generates random variates of the gamma2 distr. with a composition method */ 
double random_var::rand_gamma2(double lambda)
{
	double u, hx, x;
	double A1 = 2*log(2)*exp(-1);
	double A2 = 2*exp(-1);

	while (1)
	{
		u = uniform();
		if (u * (A1+A2) < A1)
		{
			x = uniform()*2*log(2);
			hx = exp(-1);
		}
		else
		{
			x = -log(1-uniform())*2+2*log(2);
			hx = 2 * exp(-0.5*x -1);
		}
		u = uniform();
		if (u * hx <= x * exp(-x))
			return (1/lambda) * x;
	}
}

/** Initializes a new node */
node::node()
{
	link = NULL;
}
/** Initializes a new linked list */ 
linklist::linklist()
{
	p=NULL;
	numElems = 0;
}
/** Appends a new element into the list */ 
void linklist::append(patient *Pat)
{
	node *q,*t;
 
	if( p == NULL )
	{
		p = new node;
		p->Patient = Pat;
		p->link = NULL;
	}
	else
	{
		q = p;
		while( q->link != NULL )
			q = q->link;
 
		t = new node;
		t->Patient = Pat;
		t->link = NULL;
		q->link = t;
	}
	numElems++;
}
/** Finds the patient with a given patient number */
bool linklist::find(int PatientNumber,patient **pat)
{
	if (p == NULL)
		return false;

	node *q;
	q = p;
	while (q != NULL)
	{
		if ((q -> Patient) -> PatientNumber == PatientNumber)
		{
			*pat = q -> Patient;
			return true;
		}
		else 
			q = q -> link;
	}
	return false;
}
void linklist::MoreThanTwoHours(int &TotalPeople, int &MoreThanTwoCounter)
{
	TotalPeople = numElems;
	node *q;
	q = p;
	int TwoHourCounter = 0;	
	
	while (q != NULL)
	{
		double TimeInSimulation = (q -> Patient) -> EndOfService - (q -> Patient) -> ArrivalTime;
		// if patient have a total time in system more than two hours
		if (TimeInSimulation > 120)
			TwoHourCounter++;
		q = q -> link; 
	}
	MoreThanTwoCounter = TwoHourCounter;
	int a;
	a = 5;
//	double percentage = (100.0 * TwoHourCounter) / numElems;
//	cout << "The percentage of patients who have a total time in system more than two hours: ";
//	cout << percentage << endl; 
	
}

/** Prints patients with their stats in the list */
void linklist::display(int number)
{
	node *q;
	cout << endl;
	int i = 0;
	
	ofstream output;
	output.open("Output.txt");
	if (!output.is_open())
	{
		cout << "Output.txt can not be created." << endl << "Cannot write the trace" << endl;
		return;
	}
	
	for( q = p ; q != NULL ; q = q->link )
	{
		if(i >= number)
			break;
		output << "For patient number " << (q -> Patient) -> PatientNumber << ": " << endl;
		output << "Arrival Time : " << (q-> Patient) -> ArrivalTime << endl;
		output << "Start treatment from DoctorA : " << (q -> Patient) -> DoctorATime << endl;
		output << "Start treatment from DoctorB : " << (q -> Patient) -> DoctorBTime << endl;
		output << "Start treatment from DoctorA again : " << (q -> Patient) -> DoctorAAgainTime << endl;
		output << "End of service Time : " << (q -> Patient) -> EndOfService << endl << endl;
		i++;
	}
	output.close();
}
/** Returns the number of elements in the list */ 
int linklist::count()
{
	return numElems;
}
/** Destructor */ 
linklist::~linklist()
{
	node *q;
	if( p == NULL )
		return;
 
	while( p != NULL )
	{
		q = p->link;
		delete p;
		p = q;
	}
}
