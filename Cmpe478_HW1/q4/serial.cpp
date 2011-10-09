/*
 * Serial dot product function.
 * 
 * author: Emin Senay
 */
#include <iostream>
#include <sys/time.h>
#include <stdlib.h>

using namespace std;
long int serialdotproduct(int VECTORSIZE, double &dotproduct, long int &inittime)
{
	struct timeval tv;
	time_t t1sec,t2sec,t1usec,t2usec;
	time_t t0sec,t0usec;
	
	gettimeofday(&tv,NULL);
	t0sec = tv.tv_sec;
	t0usec = tv.tv_usec;
	float v1[VECTORSIZE];
	float v2[VECTORSIZE];
	//double dotproduct = 0;
	int i;
	for (i = 0; i < VECTORSIZE; i++)
	{
		v1[i] = (float)rand()/RAND_MAX;
		v2[i] = (float)rand()/RAND_MAX;
	}
	gettimeofday(&tv,NULL);
	t1sec = tv.tv_sec;
	t1usec = tv.tv_usec;
	inittime += (t1sec * 1000000 + t1usec) - (t0sec * 1000000 + t0usec);
	
	for (i = 0; i < VECTORSIZE; i++)
	{
		dotproduct += (v1[i] * v2[i]);
		//printf("\n",t1);
	}
	gettimeofday(&tv,NULL);
	t2sec = tv.tv_sec;
	t2usec = tv.tv_usec;

	long int timepassed = (t2sec * 1000000 + t2usec) - (t1sec * 1000000 + t1usec);
	//cout << "Dotproduct: " << dotproduct << endl;
	//cout << timepassed << " microseconds passed." << endl;
	return timepassed;
}
