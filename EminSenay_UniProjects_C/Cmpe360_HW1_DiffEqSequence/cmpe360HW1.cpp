/**
  * Write a program to generate the first n terms in the sequence 
  * given by the difference equation:
  * X(k+1) = 111 - (1130-3000/X(k-1))/X(k)
  * with starting values X(1) = 11/2 and X(2) = 61/11
  * chapter 1: Scientific computingpage 48 pr 1.18
  */

#include <iostream>

using namespace std;

int main()
{
	float x1 = 11.0/2;
	float x2 = 61.0/11;
	int n = 100;

	float seq[100];
	seq[0] = x1;
	seq[1] = x2;
	cout << seq [0] << " " << seq[1] << " ";
	
	for (int i = 1; i < n; i++)
	{
		seq[i+1] = 111.0 - (1130.0-3000.0/seq[i-1])/seq[i];
		cout << seq[i+1] << " ";
	}
	cout << endl;
	system("PAUSE");
	return 0;
}
