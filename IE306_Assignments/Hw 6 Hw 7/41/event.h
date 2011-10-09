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
#ifndef EVENT_H_
#define EVENT_H_
class Event
{
public:
	Event()
	{
	};
	double clock;
	int eventtype;
	int cust_no;
	// To use priority queue, < operator must be overloaded
	// It is implemented to return the minimum clock value of the list 
	friend bool operator<(const Event& x, const Event& y)
	{
		if(x.clock > y.clock) 
			return true;
		return false;
	}
};

#endif /*EVENT_H_*/
