//main.cpp

#include <fstream>
#include <iostream>
#include "sparsematrix.h"
using namespace std;

int main()
{
	SparseMatrix A,B,C,D,E;
	ifstream input1,input2;
	ofstream output;

	input1.open("input1.txt");
	input2.open("input2.txt");
	output.open("output.txt");

	if(!input1.is_open() || !input2.is_open() || !output.is_open())
	{
		cout << "One of the files can not be opened." << endl << "Terminating...";
		cout <<  endl << "Press any key to continue";
		getchar();
		return 0;
	}

	input1 >> A;
	input2 >> B;
	C=A+B;
	D=A-B;
	E=C*D;
	output << E;
	input1.close();
	input2.close();
	output.close();
	cout << "Press any key to continue";
	getchar();
	return 0;
}
