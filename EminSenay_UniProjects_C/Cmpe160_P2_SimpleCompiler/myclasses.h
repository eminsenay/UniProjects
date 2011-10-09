//myclasses.h

#ifndef MYCLASSES_H
#define MYCLASSES_H

class UsersProgram {
public:
	UsersProgram(); //Constructor
	~UsersProgram(); //Destructor
	double getv (char &varletter);    //get variable from the variablename array
	void setv (char varletter, double number);  //set value to a variable
	char* getl (int linenum) { return lines[linenum]; }//get line from the lines array
	void setl (int linenum, const char* line);        //save the readed line to the array
	int linesize (int linenum) { return strlen(lines[linenum]); } //returns the linesize
	int checkFull (const char varletter); //returns 1 if the variable is initialized before
private:
	double variablename[27];
	bool IsFull[27];
	char* lines[100];
};

template <class T>
class Stack {
public:
	Stack(int s); //Constructor
	~Stack() { delete [] stackPtr; } //destructor
	void push (const T& item); //Push an element onto the stack
	void pop (T& item); //delete and return the last element
	void top (T& item); //only return the last element
	int isEmpty(); //returns 1 if the stack is empty.
private:
	int size; //#of elements in the stack
	int t;  //location of the top element
	T *stackPtr; //pointer to the stack
};

template <class T>
Stack<T>::Stack(int s)
{
	size=s;
	t=-1;
	stackPtr=new T[size];
}

template <class T>
void Stack<T>::push(const T& item)
{
	stackPtr[++t]=item;
}
template <class T>
void Stack<T>::pop(T& item)
{
	item=stackPtr[t--];
}
template <class T>
void Stack<T>::top(T& item)
{
	item=stackPtr[t];
}
template <class T>
int Stack<T>::isEmpty()
{
	if (t==-1)
		return 1;
	return 0;
}

#endif

