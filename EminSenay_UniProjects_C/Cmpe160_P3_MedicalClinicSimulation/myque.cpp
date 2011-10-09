//ID:2002103907
//Emin Þenay
//CMPE 160 Project 3: "Medical Clinic Simulation"
//myque.cpp:QueType class functions

#include <string>
#include <iostream>
#include <cstddef> //for NULL
#include <new> //for bad_alloc
#include "myclasses.h"

struct NodeType
{
	Patient pat;
	NodeType* next;
};

QueType::QueType()
{
	front=NULL;
	rear=NULL;
	Length=0;
}

void QueType::MakeEmpty()
{
	NodeType* tempPtr;
    
	while (front != NULL)
	{
		tempPtr=front;
		front=front->next;
		delete tempPtr;
	}
	rear=NULL;
	Length=0;
}

QueType::~QueType()
{
	MakeEmpty();
}

bool QueType::IsFull() const
{
	NodeType* location;
	try
	{
		location= new NodeType;
		delete location;
		return false;
	}
	catch(std::bad_alloc exception)
	{
		return true;
	}
}

bool QueType::IsEmpty() const
{
	return (front==NULL);
}

void QueType::Enqueue(Patient newPatient)
{
	if(IsFull())
		throw FullQueue();
	else
	{
		NodeType* newNode;
		newNode=new NodeType;

		//setting newNode->pat's all parameters, equalizing newNode->pat to the newPatient
		(newNode->pat).EnteringTime=newPatient.EnteringTime;
		strcpy((newNode->pat).DeptName,newPatient.DeptName);
		for(int i=0;i<3;i++)
		{
			(newNode->pat).ExTime[i]=newPatient.ExTime[i];
			(newNode->pat).QueTime[i]=newPatient.QueTime[i];
		}
		(newNode->pat).LastProcessTime=newPatient.LastProcessTime;
		(newNode->pat).ToRad=newPatient.ToRad;

		newNode->next=NULL;
		if (rear==NULL)
			front=newNode;
		else
			rear->next=newNode;
		rear=newNode;
		Length++;
	}
}
        
void QueType::Dequeue(Patient& Pat)
{
	if(IsEmpty())
		throw EmptyQueue();
	else
	{
		NodeType* tempPtr;
        
		tempPtr=front;

		//setting Pat's all parameters, equalizing Pat to the patient in the queue
		Pat.EnteringTime=(front->pat).EnteringTime;
		strcpy(Pat.DeptName,(front->pat).DeptName);
		for(int i=0;i<3;i++)
		{
			Pat.ExTime[i]=(front->pat).ExTime[i];
			Pat.QueTime[i]=(front->pat).QueTime[i];
		}
		Pat.LastProcessTime=(front->pat).LastProcessTime;
		Pat.ToRad=(front->pat).ToRad;

		front=front->next;
		if(front==NULL)
			rear=NULL;
		delete tempPtr;
		Length--;
	}
}
int QueType::LengthIs() const
{
	return Length;
}
