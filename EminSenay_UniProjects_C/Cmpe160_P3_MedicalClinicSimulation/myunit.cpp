//ID:2002103907
//Emin Þenay
//CMPE 160 Project 3: "Medical Clinic Simulation"
//myunit.cpp: Unit class functions

#include "myclasses.h"

Unit::Unit()
{
	empty=true;
}
bool Unit::IsEmpty()
{
	if (empty==false)
		return false;
	return true;
}
void Unit::GetPatient()
{
	if(!RadQue.IsEmpty())
	{
		RadQue.Dequeue(ExaminedPat);
		empty=false;
	}
	else if(!NormQue.IsEmpty())
	{
 		NormQue.Dequeue(ExaminedPat);
		empty=false;
	}
}

void Unit::MakeEmpty()
{
	empty=true;
}
