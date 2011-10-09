//myclasses.h
#ifndef MYCLASSES_H
#define MYCLASSES_H
#include <string>
#include <fstream>

using namespace std;

struct Properties
{
	bool male;
	string name;
};

class Person
{
public:
	friend class Operations;
	friend class TreeList;
	Person(bool gender,string n);
	~Person(){};
	bool NewChild(Person *&newchild);
	void MarriedTo (Person* with);
	void NameSearch (string& n, Person *&place);
	void Print (int relation, ofstream& output);
	int CheckRelation(Person* partner);
private:
	Person* child;
	Person* parent;
	Person* married;
	Person* sibling;
	Properties prop;
	Person* next;
	bool IsFull();
};

struct family
{
	char who[10];
	char firstchild[10];
	char father[10];
	char marry[10];
	char nextsibling[10];
};

struct ListNode
{
	Person* ancestor;
	ListNode* next;
};

class TreeList
{
public:
	friend class Person;
	friend class Operations;
	TreeList();
	~TreeList();
	bool IsFull();
	bool InsertNode(string newname, bool gender);
	void Search(string& n,Person *&place);
	void IncrementPeople() {numofpeople++;};
private:
	ListNode* headoflist;
	int numofpeople;
};

class Operations
{
public:
	void readfromfile(istream& input,TreeList& families);
	bool readandwrite(TreeList& families);
	void savetofile(ostream& output,TreeList& families);
private:
	void convert(string& newcommand);
	bool getwords(string *&words,string& input);
};

#endif

