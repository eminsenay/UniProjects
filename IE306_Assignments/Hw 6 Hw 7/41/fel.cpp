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
#include <queue>
#include "fel.h"
#include "myclasses.h"
#include "patient.h"
#define ARRIVAL 1
using namespace std;
void FELType::print_FEL()
{
//TODO needs to be implemented

}
void FELType::initialize(linklist *PatientList)
{
     Event temp;
     temp.clock = 0;
     temp.eventtype = ARRIVAL;
     temp.cust_no = 1;
     Elist.push(temp);
     
     patient *pt = new patient(1);
     pt -> ArrivalTime = 0;
     PatientList -> append(pt);
}
FELType::FELType()
{}
FELType::~FELType()
{}
Event FELType::GetNextEvent()
{
	Event ev = Elist.top();
	Elist.pop();
	return ev;
}
void FELType::AddEvent(Event ev)
{
	Elist.push(ev);
}
