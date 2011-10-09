/*
 * Dot product function which uses Intel SIMD extensions.
 * 
 * author: Emin Senay
 */
#include <fvec.h>
#include <iostream>
#include <sys/time.h>
#include <stdlib.h>

using namespace std;

long int paralleldotproduct(int VECTORSIZE, double &dotproduct, long int &inittime)
{
	struct timeval tv;
	time_t t1sec,t1usec,t2sec,t2usec;
	time_t t0sec,t0usec;
	
	gettimeofday(&tv,NULL);
	t0sec = tv.tv_sec;
	t0usec = tv.tv_usec;
	F32vec4 val, tmp;
	F32vec4 v1[VECTORSIZE/4];	
	F32vec4 v2[VECTORSIZE/4];
	
	for (int i = 0; i < VECTORSIZE/4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			v1[i][j] = (float)rand()/RAND_MAX;
			v2[i][j] = (float)rand()/RAND_MAX;
		}
	}
	gettimeofday(&tv,NULL);
	t1sec = tv.tv_sec;
	t1usec = tv.tv_usec;
	inittime += (t1sec * 1000000 + t1usec) - (t0sec * 1000000 + t0usec);
	//double dotproduct = 0;
	for (int i = 0; i < VECTORSIZE/4; i++)
	{
		tmp = v1[i][0] * v2[i][0];
		val = val + tmp;
		//dotproduct = dotproduct + val[0] + val[1] + val[2] + val[3];	
	}
	dotproduct += add_horizontal(val);
	gettimeofday(&tv,NULL);
	t2sec = tv.tv_sec;
	t2usec = tv.tv_usec;
	
	long int timepassed = (t2sec * 1000000 + t2usec) - (t1sec * 1000000 + t1usec);
	//cout << "Dotproduct1: " << dotproduct << endl;
	//cout << "Dotproduct2: " << dotproduct2 << endl;
	//cout << timepassed << " microseconds passed." << endl;
	return timepassed;
}
