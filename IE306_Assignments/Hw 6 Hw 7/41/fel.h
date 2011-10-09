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
#ifndef FEL_H
#define FEL_H
#include <queue>
#include "event.h"
#include "myclasses.h"
using namespace std;
class FELType
{
public:
	priority_queue<Event> Elist;
	FELType();
	~FELType();
	void print_FEL();
	void initialize(linklist* PatientList); //insert a new event with t = 0 and eventtype = arrival
	Event GetNextEvent();
	void AddEvent(Event ev);
};
#endif
