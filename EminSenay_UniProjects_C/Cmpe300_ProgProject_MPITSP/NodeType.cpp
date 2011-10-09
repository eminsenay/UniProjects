#include "NodeType.h"

mypath::mypath(int N)
{
	indice = new int[N];
	count = 0;
	size = N;
}
void mypath::add_item(int num)
{
	indice[count++]=num;
}
mypath::mypath(mypath &rhs)
{
	count = rhs.count;
	size = rhs.size;
	indice = new int[size];
	for (int i = 0; i < size; i++)
	{
		indice[i] = rhs.indice[i];
	}
}
bool mypath::copy(mypath &rhs)
{
	if (size != rhs.size)
		return false;
	count = rhs.count;
	for (int i = 0; i < size; i++)
	{
		indice[i] = rhs.indice[i];
	}
	return true;
}
mypath::mypath()
{
	indice = 0;
	count = 0;
	size = 0;
}
mypath::~mypath()
{
	delete[] indice;
}
