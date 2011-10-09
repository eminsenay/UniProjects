#include <string>
#include <iostream>
#include <fstream>
#include "myclasses.h"

using namespace std;

int main()
{
	Operations program;
	TreeList families;
	ifstream infile;
	infile.open("Family.dat",ios::binary);
	if(!infile)
	{
		cout << "Family.dat could not be opened." << endl << "Terminating..." << endl;
		return 0;
	}
	infile.seekg(0,ios::end);
	if(infile.tellg())
	{
		infile.seekg(0,ios::beg);
		program.readfromfile(infile,families);
	}
	infile.close();
	if(!program.readandwrite(families))
	{
		cout << "Family.trn could not be opened." << endl << "Terminating..." << endl;
		return 0;
	}
	ofstream outfile("Family.dat",ios::binary);
	program.savetofile(outfile,families);
	outfile.close();
	return 0;
}
