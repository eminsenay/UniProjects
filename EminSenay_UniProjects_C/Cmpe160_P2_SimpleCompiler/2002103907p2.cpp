//ID:2002103907
//NAME:Emin Senay
//SOME NOTES: There are many controlling mechanisms I made before expression evaluation. These are:
//While executing data:
//If user enters something other than commands, program gives error and terminates.
//Uninitialized variable can not be printed.
//Code can not exceed the line limit
//Before the expression evaluation:
//a) First element of the expression can only be a variable or '~' operator.
//b) Last element of the expression can only be a variable.
//c) Two variables can not be next to each other.
//d) Two operators, except '~' can not be next to each other.
//e) All the variables in the expression must be initialized before. (except the one before the operator'=')
//f) Expression can not contain any character except the capital letters of the English alphabet and valid operators.
//g) After '~' operator, there can not be any operator. Also, there can only be '|' or '&' operators before '~' operator.
//h) Since '~' operator is a logical operator, it can only change 0 to 1 or 1 to 0. In the other numbers, program gives
//an error message. 


#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
#include "myclasses.h"

using namespace std;

int readdata(UsersProgram &code);
void executedata(int ln,UsersProgram &code);
void scanvar(const char, UsersProgram &code);
void rangecheck(char ,int ln);
int toline(char *line, int linenumber, UsersProgram &code);
void assignment(char *line, int linenumber,UsersProgram &code);
double evaluate (char* expression, char* op, int* preced, UsersProgram &code);
double result(double FirstValue,char op, double SecondValue);

void main()
{
	UsersProgram code;
	int linenumber;
	linenumber=readdata(code);
	executedata(linenumber,code);
}

int readdata(UsersProgram &code)
{
	char choice; //From file or from screen reading
	int ln; //linenumber
	string temps; //temporary string for taking the data
	
	cout << "Where do I read the code from?" << endl;
	cout << "If from the file 'input.txt', press F" << endl;
	cout << "If from screen, press S" << endl;
	cin >> choice;
	
	if (choice=='F' || choice=='f')
	{
		fflush(stdin);
		ifstream inFile;
		inFile.open("input.txt");
		for(ln=0; ln<100; ln++)
		{
			getline(inFile,temps);
			code.setl(ln,temps.c_str());
			if (temps=="RUN")
				break;
		}
		if(temps!="RUN") //This means the code exceeds the line limit
		{
			cout << "Your code can not be longer than 100 lines." << endl;
			cout << "Terminating..." << endl;
			exit(0);
		}
		inFile.close();
	}
	else
	{
		fflush(stdin);
		for(ln=0; ln<100; ln++)
		{
			if (ln<10)
				cout << "0";
			cout << ln << " ";
			getline(cin,temps);
			code.setl(ln,temps.c_str());
			if (temps=="RUN")
				break;
		}
		if(temps!="RUN") //This means the code exceeds the line limit
		{
			cout << "Your code can not be longer than 100 lines." << endl;
			cout << "Terminating..." << endl;
			exit(0);
		}
	}
	return ln;
}

void rangecheck(char letter,int ln)
{
	if (letter<'A' || letter>'Z')
	{
		cout << "Error in line "<< ln <<"."<< endl;
		cout << "The variable name must be between 'A' and 'Z'." << endl;
		cout << "Terminating..." << endl;
		
		exit(0);
	}
}
void executedata(int ln,UsersProgram &code) //Reads the code lines and passes them to the appropriate functions.
{
	double tmp;
	int k;
	char* temp= code.getl(0);
	char* firstWord;
	int line;
	int linelength=strlen(temp);
	for (int i=0; i<100 ; i++)
	{
		temp=code.getl(i);//temp contains the i th line now
		firstWord=new char[strlen(temp)];
		for(k=0; k<256; k++)
		{
			if(temp[k]==' ' || temp[k]=='\n' || temp[k]=='\t' || temp[k]=='\0')
				break;
			firstWord[k]=temp[k];
		}
		firstWord[k]='\0';

		if (strcmp(firstWord,"INPUT")==0)
		{
			rangecheck(temp[6],i);
			if (linelength>6) //then variable name is not the last element of the array
				for(int j=7; j<linelength ;j++) // But the user can enter blanks; if so, compiler must work properly
					if(temp[j]!=' ' || temp[j]!='\t')
					{
						cout << "Error in line" << i << endl;
						cout << "Your variables must be between 'A' and 'Z'." << endl;
						cout << "Terminating..." << endl;
						exit(0);
					}
			scanvar(temp[6],code);
		}
		else if (strcmp(firstWord,"PRINT")==0)
		{
			rangecheck(temp[6],i);
			tmp=code.getv(temp[6]);
			if (temp[6]!='!')
				cout << temp[6] << "=" << code.getv(temp[6]) << endl;
			else
			{
				cout << "Error in line" << i << endl;
				cout << "Uninitialized variable can not be printed." << endl;
				cout << "Terminating..." << endl;
				exit(0);
			}
		}
		else if (strcmp(firstWord,"GOTO")==0)
		{
			line=toline(temp,i,code);
			if (line>ln)
			{
				cout << "Error in line number " << i << endl;
				cout << "The line number " << line << " does not exist!" << endl;
				cout << "Terminating..." << endl;
				exit(0);
			}
			if(line!=-1)
				i=line-1; //line number changed
		}
		else if (strcmp(firstWord,"STOP")==0 || strcmp(firstWord,"RUN")==0) 
			exit(0);

		else if (temp[1]=='=') //assignment i.e A(=)B+C
				assignment(temp,i,code);

		else
		{  //if none of the above, the code has an error
			cout << "Error in line ";
			if (i<10)
				cout << "0";
			cout << i <<endl;
			cout << "Code does not contain an available command." << endl;
			cout << "Terminating..." << endl;
			exit(0);
		}
		
	}//end of for
}
void scanvar(const char input,UsersProgram &code)
{
	double value; //value of the input
	cout << "> Enter " << input << ":" << endl;
	cout << "? ";
	cin >> value;
	code.setv (input,value);
}

int toline(char *line,int linenumber,UsersProgram &code)
{
	char* tokenPtr;

	tokenPtr=new char[7];
	for(int i=5; i<7; i++)
		tokenPtr[i-5]=line[i]; //the number
	
	if(tokenPtr[0]<'0' || tokenPtr[0]>'9' || tokenPtr[1]<'0' || tokenPtr[1]>'9') // line number must contain 2 digits i.e. 05,95...	
	{
		cout << "Error in line " << linenumber << "." << endl;
		cout << "The line number must contain 2 digits" << endl;
		cout << "Terminating..." << endl;
		exit(0);
	}

	int d1,d2; //digit1 and digit 2 of line
	d1=tokenPtr[0]-'0';
	d2=tokenPtr[1]-'0';

	for(int j=8; j<14; j++)//detecting ALWAYS OR IF
	{
		tokenPtr[j-8]=line[j];
		if(tokenPtr[1]=='F')
		{
			tokenPtr[2]='\0';
			break;
		}
	}
	tokenPtr[6]='\0';

	if (strcmp(tokenPtr,"ALWAYS")==0)
		return d1=d1*10+d2;  //d1 is the linenumber to go to now.
	
	else if (strcmp(tokenPtr,"IF")==0)
	{
		int k;
		int linelength=strlen(line);
		char* exp; //will point the expression
		char op[11]={'|','&','~','<','>','=','+','-','*','/','^'}; //Operators and their precedences are initialized
		int preced[11]={0,1,2,3,3,3,4,4,5,5,6};
		
		exp=new char[linelength-10];//length of the expression +1 (for '\0')
		for(k=0; k<linelength-11; k++)
			exp[k]=line[k+11];
		exp[k]='\0'; //The expression is copied to the exp
		
		//The validity of the expression is being examined
		try
		{
			if (exp[0]>='A' && exp[0]<='Z' || exp[0]=='~') //The first character must be a variable or ~
			{
				int length=strlen(exp); //length of the expression
				if (exp[length-1]>='A' && exp[length-1]<='Z') //last character must be a variable
				{
					int i; // Original code is modified here so that it can be built in VS2010.
					for(i=0;i<length-1;i++)
					{
						if(exp[i]>='A' && exp[i]<='Z' && exp[i+1]>='A' && exp[i+1]<='Z') //two variables can not be next to each other
						{
							cout << "Error in line " << linenumber << "." << endl;
							cout << "Two variables can not be next to each other" << endl;
							cout << "Terminating..." << endl;
							exit(0);
						}
						//Most of the operators can not be next to each other. The exception is ~
						if (
							(exp[i]=='|' || exp[i]=='&' || exp[i]=='~' || exp[i]=='<'|| exp[i]=='>' || exp[i]=='='
						  || exp[i]=='+' || exp[i]=='-' || exp[i]=='*' || exp[i]=='/'|| exp[i]=='^')
						                               && 
						    (exp[i+1]=='|' || exp[i+1]=='&' || exp[i+1]=='<' || exp[i+1]=='>' || exp[i+1]=='='
						  || exp[i+1]=='+' || exp[i+1]=='-' || exp[i+1]=='*' || exp[i+1]=='/' || exp[i+1]=='^') )
						{
							cout << "Error in line " << linenumber << "." << endl;
							cout << "Two operators (except ~) can not be next to each other" << endl;
							cout << "Terminating..." << endl;
							exit(0);
						}
						if (exp[i+1]=='~' && (exp[i]!='|' && exp[i]!='&')) //~ can be after | or &
						{
							cout << "Error in line " << linenumber << "." << endl;
							cout << "The usage of ~ is false." << endl;
							cout << "Terminating..." << endl;
							exit(0);
						}
						if(exp[i]>='A' && exp[i]<='Z') //all variables must be initialized before
						{
							if(code.checkFull(exp[i])==0)
							{
								cout << "Error in line " << linenumber << "." << endl;
								cout << "The variable " << exp[i] << " is not initialized before." << endl;
								cout << "Terminating..." << endl;
								exit(0);
							}
						}
					}//end of for
					
					//all variables must be initialized before 
					//(last element is not checked in the for loop, now it will be checked)
					if(code.checkFull(exp[i])==0)
					{
						cout << "Error in line " << linenumber << "." << endl;
						cout << "The variable " << exp[i] << " is not initialized before." << endl;
						cout << "Terminating..." << endl;
						exit(0);
					}		

					//if the expression has all of these requirements, it is being evaluated
					if(evaluate(exp,op,preced,code)==1)
						return d1=d1*10+d2;
					else //if the evaluation result is 0
						return -1;	

				}//end of second if
				else
				{
					cout << "Error in line " << linenumber << "." << endl;
					cout << "Last character of the expression must be a variable." << endl;
					cout << "Terminating..." << endl;
					exit(0);
				}
			}//end of first if
			else 
			{
				cout << "Error in line " << linenumber << "." << endl;
				cout << "First character of the expression can only be a variable or ~." <<endl;
				cout << "Terminating..." << endl;
				exit(0);
			}	
		}//end of try
		catch (char* error)
		{
			cout << "Error in line " << linenumber << "." << endl;
			cout << error <<endl;
			cout << "Terminating..." << endl;
			exit(0);
		}
	}//end of else if
		cout << "Error in line " << linenumber << "." << endl;
		cout << "The usage of GOTO command is wrong." << endl;
		cout << "Terminating..." << endl;
		exit(0);
}//end of function

void assignment(char* line, int linenumber,UsersProgram &code)
{
	char op[5]={'+','-','*','/','^'};	//operators and their precedences are initialized
	int preced[5]={0,0,1,1,2};
	int length=strlen(line); //length of the expression

	try
	{
		if(line[0]>='A' && line[0]<='Z')//first character must be a variable
		{
			if (line[length-1]>='A' && line[length-1]<='Z')//last character must be a variable
			{
				for(int i=2; i<length; i++)
				{
					if (line[i]>='A' && line[i]<='Z')//only for variables
					{
						if(code.checkFull(line[i])==0) //All variables must be initialized before
						{
							cout << "Error in line " << linenumber << "." << endl;
							cout << "The variable " << line[i] << " is not initialized before." << endl;
							cout << "Terminating..." << endl;
							exit(0);
						}
					}
					if(line[i]>='A' && line[i]<='Z' || line[i]=='+' || line[i]=='-' || line[i]=='*' || line[i]=='/'
						|| line[i]=='^') //a line can only contain these characters
					{
						if(line[i]>='A' && line[i]<='Z' && line[i-1]>='A' && line[i-1]<='Z')//Two variables can not be next to each other.								
							throw ("Two variables can not be next to each other.");
						else if ((line[i]=='+' || line[i]=='-' || line[i]=='*' || line[i]=='/' || line[i]=='^') &&
						     (line[i-1]=='+' || line[i-1]=='-' || line[i-1]=='*' || line[i-1]=='/' || line[i-1]=='^'))//Two operators can not be next to each other.
							throw("Two operators can not be next to each other.");
					}											
					else
						throw("Line contains a character that is not allowed.");
				}							
				char* evaluatePtr=&(line[2]);
				double sum=evaluate(evaluatePtr,op,preced,code);//evaluating the result if an expression has passed
				code.setv(line[0],sum);					   //all of these controls
			}
			else
				throw("Last element of the expression must be a variable.");
		}//end of if after try
		else
			throw("First element of the expression must be a variable.");
	}//end of try
	catch(char* error)
	{
		cout << "Error in line " << linenumber << "." << endl;
		cout << error << endl;
		cout << "Terminating..." << endl;
		exit(0);
	}
	
}	
double evaluate (char* expression, char* op, int* preced, UsersProgram &code)
{
	int size=(strlen(expression)+1)/2; //size of stacks
	//double var;
	Stack<char> operators(size);
	Stack<double> values(size);

	for(int i=0; i<strlen(expression); i++)
	{
		if(expression[i]>='A' && expression[i]<='Z') //if it is a variable
			values.push(code.getv(expression[i]));
		else //if it is operator
			while(1)
			{
				int EmptyFlag=(operators.isEmpty());
				if (EmptyFlag==1) //If there is no element in the operators stack
				{
					operators.push(expression[i]);
					break;
				}
				int j,k; //The place of operators in the op array

				//finding the place of the current operator in the op array
				for(j=0; j<strlen(op); j++)
					if(expression[i]==op[j])
						break;

				//finding the place of the last operator on the stack
				for(k=0; k<strlen(op); k++)
				{
					char temp;
					operators.top(temp);
					if(temp==op[k])
						break;
				}

				//if the operator in the stack has a lower precedence or both of the operators are '^'
				if((preced[j]>preced[k]) || (preced[j]==preced[k] && expression[i]=='^')) 
				{
					operators.push(expression[i]);
					break; //break of while
				}
				else // if((preced[j]<preced[k]) || preced[j]==preced[k] && expression[i]!='^')) 
				{
					double FirstValue=0;
					double SecondValue;
					double res; //result
					char lastOp; // last operator in the stack
					values.pop(SecondValue);
					operators.pop(lastOp);
					if(lastOp!='~')// ~ takes one variable, so FirstValue must stay in the Stack
						values.pop(FirstValue);
					res=result(FirstValue,lastOp,SecondValue);
					values.push(res);
				}
			}
	}//end of for

	//All of the elements(or results of some elements) are in stacks but some elements are not evaluated
	//Now, the function evaluates them
	int EmptyFlag=operators.isEmpty();
	while(EmptyFlag==0)
	{
		double FirstValue=0;
		double SecondValue;
		double res; //result
		char lastOp; //last operator in the stack
		values.pop(SecondValue);
		operators.pop(lastOp);
		if(lastOp!='~')// ~ takes one variable, so FirstValue must stay in the Stack
			values.pop(FirstValue);
		res=result(FirstValue,lastOp,SecondValue);
		values.push(res);
		EmptyFlag=operators.isEmpty();
	}

	double temp;
	values.pop(temp);
	return (temp);
}
double result(double FirstValue,char op, double SecondValue)
{
	switch (op)
	{
	case '|':
		if(FirstValue==1 || SecondValue==1)
			return 1;
		return 0;
		break;
	case '&':
		if(FirstValue==0 || SecondValue==0)
			return 0;
		return 1;
		break;
	case '~':
		if(SecondValue==0) //SecondValue must be a boolean
			return 1;
		if(SecondValue==1)
			return 0;
		else //to prevent a GOTO statement like A~A
		{
			cout << "Usage of ~ is wrong in the GOTO statement." << endl;
			cout << "Terminating..." << endl;
			exit(0);
		}
		break;
	case '<':
		if(FirstValue<SecondValue)
			return 1;
		return 0;
		break;
	case '>':
		if (FirstValue>SecondValue)
			return 1;
		return 0;
		break;
	case '=':
		if (FirstValue==SecondValue)
			return 1;
		return 0;
		break;
	case '+':
		return FirstValue+SecondValue;
		break;
	case '-':
		return FirstValue-SecondValue;
		break;
	case '*':
		return FirstValue*SecondValue;
		break;
	case '/':
		return FirstValue/SecondValue;
		break;
	case '^':
		return pow(FirstValue,SecondValue);
		break;
	default:
		cout << "There's an error in the result function." << endl;
		cout << "Check the input." << endl;
		cout << "Terminating..." << endl;
		exit(0);
	}
}
