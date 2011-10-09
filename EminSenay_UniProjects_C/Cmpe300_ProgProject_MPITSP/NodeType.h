#ifndef NODETYPE_H_
#define NODETYPE_H_

class CostStruct
{
public:
	int cost;
	int node;

	friend bool operator<(const CostStruct& x, const CostStruct& y)
	{
		if(x.cost > y.cost) 
			return true;
		return false;
	}
};
class mypath
{
public:
	int* indice;
	int count;
	int size;
	mypath();
	mypath(int N);
	mypath(mypath &rhs);
	~mypath();
	void add_item(int num);
	bool copy(mypath &rhs);
};
#endif