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
#ifndef MYCLASSES_H
#define MYCLASSES_H
#include <iostream>
#include "patient.h"
class random_var
{
private:

	unsigned long seed;

public:

	random_var();
	double uniform();
	double uniform(double a, double b);
	double rand_exp(double mu);
	double rand_gamma2(double lambda);
	void SetSeed(long NewSeed);
	long GetSeed();

};
class node
{
public:
	patient *Patient;
	node *link;
	node();
};
 
class linklist
{
private:
 
	node *p;
	int numElems;
 
public:
 
	linklist();
	void append(patient *Pat);
	void display(int number);
	int count();
	bool find(int PatientNumber,patient **pat);
	~linklist();
	void MoreThanTwoHours(int &TotalPeople, int &MoreThanTwoCounter);
};

#endif
