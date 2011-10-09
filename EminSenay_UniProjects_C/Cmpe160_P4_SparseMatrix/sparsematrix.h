//sparsematrix.h

#ifndef SPARSEMATRIX_H
#define SPARSEMATRIX_H

#include <iostream>
#include <fstream>

using namespace std;

class SparseMatrix;

struct triple
{
    int row, column, value;
};

class Mnode
{
public:
	Mnode(bool,triple&); //constructor
	friend class SparseMatrix;
	friend istream& operator >> (istream&, SparseMatrix&);
	friend ostream& operator << (ostream&, SparseMatrix&);
private:
	Mnode *down, *right;
	bool head;
	union
	{
		Mnode* next; //for head nodes;
		triple tri; //for MainHead and normal nodes
	};
};

class SparseMatrix
{
	friend istream& operator >> (istream&, SparseMatrix&);
	friend ostream& operator << (ostream&, SparseMatrix&);
	public:
		SparseMatrix::SparseMatrix()
		{MainHead=NULL;}; //constructor
		SparseMatrix(SparseMatrix&); //copy constructor
		~SparseMatrix(); //destructor
		SparseMatrix operator + (SparseMatrix&);
		SparseMatrix operator - (SparseMatrix&);
		SparseMatrix operator * (SparseMatrix&);
		void operator = (SparseMatrix&);
	private:
		Mnode *MainHead;
};
#endif

