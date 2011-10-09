/*
 * Program which makes a dot product operation both using 
 * serial operations and Intel SIMD extensions to give the execution time.
 * 
 * author: Emin Senay
 */

#include <iostream>
#include <stdlib.h>
#include "cmpe478dotproduct.h"
 
using namespace std;

/*argv[0] = vector size*/
int main(int argc, char *argv[])
{
	srand(time(NULL));
	unsigned long int vectorsize = 100000;
	if (argc > 1)
	{
		vectorsize =  atol(argv[1]);
	}
	// Serial dot product starts
	unsigned long int proctime = 0;
	long int inittime=0;
	double dotproduct = 0;
	int initvectorsize = vectorsize;
	while (1)
	{
		unsigned int tempvectorsize = 100000;
		if (vectorsize < tempvectorsize)
			tempvectorsize = vectorsize;
		if (tempvectorsize <= 0)
			break;
		proctime += serialdotproduct(tempvectorsize, dotproduct, inittime);
		vectorsize -= tempvectorsize;
	}
	cout << "Serial time for vector size " << initvectorsize << ": " << endl;
	cout << "Initialization: " << inittime << " microseconds" << endl; 
	cout << "Processing:" << proctime << " microseconds" << endl; 
	cout << "Dotproduct: " << dotproduct << endl << endl;
	
	// Parallel dot product starts here
	proctime = 0;
	vectorsize = initvectorsize;
	dotproduct = 0;
	inittime = 0;
	while (1)
	{
		unsigned int tempvectorsize = 100000;
		if (vectorsize < tempvectorsize)
			tempvectorsize = vectorsize;
		if (tempvectorsize <= 0)
			break;
		proctime += paralleldotproduct(tempvectorsize, dotproduct, inittime);
		vectorsize -= tempvectorsize;
	}
	cout << "Parallel time for vector size " << initvectorsize << ": " << endl;
	cout << "Initialization: " << inittime << " microseconds" << endl; 
	cout << "Processing:" << proctime << " microseconds" << endl; 
	cout << "Dotproduct: " << dotproduct << endl << endl;
	
}
