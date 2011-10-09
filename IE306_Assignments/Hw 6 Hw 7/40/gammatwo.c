#include <stdio.h>
#include <time.h>
#include <math.h>
#include <stdlib.h>

static unsigned long urn = 0;

/** generates a U(0,1) random variate using the recursion:
 *    X(i+1) = 69069*X(i) + 1 mod 2^32  
 */
double uniform()
{
	urn = 69069*urn+1;
	return urn*2.3283064365386962891e-10 + 1.1641532182693481445e-10;
}

/** changes the seed of the uniform generator */
void setseed(long seed)
{	
	urn = seed;
	//printf("%ld\n",urn);
}

/* return the curent seed of the uniform generator */
long getseed()
{	
	return urn;
}

double rand_gamma2()
{
	double u, hx, x;
	double A1 = 2*log(2)*exp(-1);
	double A2 = 2*exp(-1);
	int i;
	
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
			return x;
	}
}

int main()
{
	double gamma2,cdf,expected,chi2=0;
	int i;
	int NumOfClasses = 1000, SampleSize = 1000000; 
	int* observed,temp;
	
	//setseed(time(NULL));
	setseed(5);
	
	expected = (double)SampleSize / NumOfClasses;
	observed = malloc(NumOfClasses * sizeof(int));
	
	for (i = 0; i < SampleSize ; i++)
	{
		gamma2 = rand_gamma2();
		cdf = 1-(gamma2+1) * exp(-gamma2);
		temp = (int)(cdf*NumOfClasses);
		observed[temp]++;
	}
	for (i = 0; i < NumOfClasses; i++)
	{
		chi2 += ((expected - observed[i]) * (expected - observed[i])) / expected;
	}
	printf ("Chi2 value is %lf\n",chi2);
}
