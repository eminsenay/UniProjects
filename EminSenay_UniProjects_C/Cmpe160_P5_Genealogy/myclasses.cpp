#include <string>
#include <iostream>
#include <fstream>
#include "myclasses.h"

using namespace std;

TreeList::TreeList()//constructor
{
	headoflist=new ListNode;
	headoflist->ancestor=NULL;
	headoflist->next=NULL;
	numofpeople=0;
}

bool TreeList::InsertNode(string newname,bool gender)
{
	//check memory
	if(IsFull())
		return false;
	Person* tmp=NULL;
	if(tmp->IsFull())
		return false;
	//create new node
	ListNode* newnode=new ListNode;
	ListNode* last=headoflist;
	//find the place to add the new node
	while(last->next!=NULL)
		last=last->next;
	newnode->next=last->next;
	last->next=newnode;
	//create the person with specified information
	newnode->ancestor=new Person(gender,newname);
	if(last->ancestor!=NULL)
	{
		newnode->ancestor->next=last->ancestor->next;
		last->ancestor->next=newnode->ancestor;
	}
	//Increment numberofpeople
	IncrementPeople();
	return true;
}

Person::Person(bool gender,string n)//create new person
{
	prop.male=gender;
	prop.name=n;
	child=NULL;
	parent=NULL;
	married=NULL;
	sibling=NULL;
	next=NULL;
}

void Person::MarriedTo(Person *with)//marriage
{
	married=with;
	with->married=this;
}

bool Person::NewChild(Person *&newchild)//add new child
{
	//check memory
	if(IsFull())
		return false;
	//firstchild
	if (child==NULL)
	{
		child=newchild;
		newchild->next=next;
		next=newchild;
	}
	//not firstchild
	else
	{
		Person* last=child;
		while (last->sibling!=NULL)
			last=last->sibling;
		last->sibling=newchild;
		newchild->next=last->next;
		last->next=newchild;
	}
	newchild->parent=this;
	return true;
}

void Person::NameSearch(string &n, Person *&place)//search the name
{
	place=NULL;
	if (prop.name==n)
		place=this;
	else
	{
		//search in the child and sibling
		if(child!=NULL)
			child->NameSearch(n,place);
		if(place==NULL)
			if(sibling!=NULL)
				sibling->NameSearch(n,place);
	}
}

void TreeList::Search(string &n, Person *&place) //search the name
{
	place=NULL;
	ListNode* last=headoflist->next; //first node is dummy
	while(last!=NULL)
	{
		last->ancestor->NameSearch(n,place);
		if(place!=NULL)
			break;
		last=last->next;
	}
}

void Operations::savetofile(ostream &output, TreeList &families)
{
	struct tmppro
	{
		bool male;
		char name[10];
	};
	tmppro temp;
	//write the number of people in the family
	output.write((char*)&(families.numofpeople),sizeof(int));
	if(families.headoflist->next!=NULL)
	{
		Person* last=families.headoflist->next->ancestor;
		//write the properties
		while(last!=NULL)
		{
			temp.male=last->prop.male;
			strcpy(temp.name,last->prop.name.c_str());
			output.write((char*)&temp,sizeof(tmppro));
			last= last->next;
		}
		last=families.headoflist->next->ancestor;
		family savefam;
		//write relatives
		while (last!=NULL)
		{
			strcpy(savefam.who,last->prop.name.c_str());
			if(last->child!=NULL)
				strcpy(savefam.firstchild,last->child->prop.name.c_str());
			else
				strcpy(savefam.firstchild,"None");
			if(last->parent!=NULL)
				strcpy(savefam.father,last->parent->prop.name.c_str());
			else
				strcpy(savefam.father,"None");
			if(last->married!=NULL)
				strcpy(savefam.marry,last->married->prop.name.c_str());
			else
				strcpy(savefam.marry,"None");
			if(last->sibling!=NULL)
				strcpy(savefam.nextsibling,last->sibling->prop.name.c_str());
			else
				strcpy(savefam.nextsibling,"None");
			
			output.write((char*)&savefam,sizeof(family));
			last=last->next;
		}
	}
}

void Operations::readfromfile(istream& input,TreeList &families)
{
	struct tmppro
	{
		bool male;
		char name[10];
	};
	tmppro temp;
	Properties loadpro;
	int num;
	//read the number of people in the family
	input.read((char*)&num,sizeof(int));
	families.numofpeople=num;
	Person *first,*last=NULL;

	//read the properties
	input.read((char*)&temp,sizeof(tmppro));
	loadpro.male=temp.male;
	loadpro.name=temp.name;
	Person* newperson=new Person(loadpro.male,loadpro.name);
	first=newperson;
	newperson->next=last;
	last=newperson;
	num--;

	while(num>0)
	{
		input.read((char*)&temp,sizeof(tmppro));
		loadpro.male=temp.male;
		loadpro.name=temp.name;
		newperson=new Person(loadpro.male,loadpro.name);
		newperson->next=last->next;
		last->next=newperson;
		last=newperson;
		num--;
	}
	
	family loadfam;
	last=first;
	newperson=first;
	num=families.numofpeople;
	
	//read relatives
	while(num>0)
	{
		input.read((char*)&loadfam,sizeof(family));
		if(strcmp(loadfam.who,last->prop.name.c_str())!=0)
		{
			cout << "Error while reading the file." << endl << "Terminating...";
			exit(0);
		}
		if(strcmp(loadfam.firstchild,"None")!=0)
		{
			while(strcmp(loadfam.firstchild,newperson->prop.name.c_str())!=0)
				newperson=newperson->next;
			last->child=newperson;
			newperson=first;
		}
		if(strcmp(loadfam.father,"None")==0)
		{
			last->parent=NULL;
			ListNode* newtree= new ListNode;
			newtree->ancestor=last;
			ListNode* lasttree;
			if(families.headoflist->next==NULL)
			{
				newtree->next=families.headoflist->next;
				families.headoflist->next=newtree;
				lasttree=newtree;
			}
			else
			{
				newtree->next=lasttree->next;
				lasttree->next=newtree;
				lasttree=newtree;
			}
		}
		else
		{
			while(strcmp(loadfam.father,newperson->prop.name.c_str())!=0)
				newperson=newperson->next;
			last->parent=newperson;
			newperson=first;
		}
		if(last->married==NULL)
		{
			if(strcmp(loadfam.marry,"None")!=0)
			{
				while(strcmp(loadfam.marry,newperson->prop.name.c_str())!=0)
					newperson=newperson->next;
				last->married=newperson;
				newperson->married=last;
				newperson=first;
			}
		}
		if(strcmp(loadfam.nextsibling,"None")!=0)
		{
			while(strcmp(loadfam.nextsibling,newperson->prop.name.c_str())!=0)
				newperson=newperson->next;
			last->sibling=newperson;
			newperson=first;
		}
		last=last->next;
		num--;
	}
}

bool Person::IsFull()//check memory
{
	Person* newperson;
	try
	{
		newperson=new Person(0," ");
		delete newperson;
		return false;
	}
	catch(std::bad_alloc exception)
	{
		return true;
	}
}

bool TreeList::IsFull()//check memory
{
	ListNode* newnode;
	try
	{
		newnode=new ListNode;
		delete newnode;
		return false;
	}
	catch(std::bad_alloc exception)
	{
		return true;
	}
}

int Person::CheckRelation(Person *partner)
{
	int relation;
	if(married!=NULL) //already married
		return relation=1;
	if(partner->married!=NULL)
		return relation=8; //partner is already married
	if(parent!=NULL)
	{
		if(parent==partner) //parents
			return relation=2;
		if(parent->married==partner) //parents
			return relation=2;

		if(parent->parent!=NULL)//grandparents now
		{
			if(parent->parent==partner)
				return relation=6;
			if(parent->parent->married==partner)
				return relation=6;
		}
		if (parent->married->parent!=NULL)
		{
			if(parent->married->parent==partner)
				return relation=6;
			if(parent->married->parent->married==partner)
				return relation=6;
		}
	
		//siblings now
		Person* temp=parent->child;
		while(temp!=this)
		{
			if(temp==partner)
				return relation=3;
			temp=temp->sibling;
		}
		//temp=this now
		temp=temp->sibling;
		while(temp!=NULL)
		{
			if(temp==partner)
				return relation=3;
			temp=temp->sibling;
		}

		//uncles and aunts now
	
		temp=parent->sibling;
		while(temp!=NULL)
		{
			if(temp==partner)
			{
				if(temp->prop.male)
					return relation=4; //uncle
				else
					return relation=5; //aunt
			}
			temp=temp->sibling;
		}
		temp=parent->married->sibling;
		while(temp!=NULL)
		{
			if(temp==partner)
			{
				if(temp->prop.male)
					return relation=4; //uncle
				else
					return relation=5; //aunt
			}
			temp=temp->sibling;
		}
	}
	return relation=7; //nothing
}
bool Operations::getwords(string *&words, string &input)
{
	//clearing the contents of the string
	for (int a=0;a<6;a++)
		words[a]="";

	char* line=new char[256];
	int wordindex=0,i,j;
	char *tmp=new char[30];
	//space control before first word
	do
	{
		cin.getline(line,256);
		input=line;
		while(input=="")
		{
			cout << "Waiting for command." << endl << ">>";
			cin.getline(line,256);
			input=line;
		}
		i=0;
		while(input[i]==' ' || input[i]=='\t')
			i++;
		if(input[i]=='\0')
			cout << "You must enter a command." << endl << ">>";
	}while(input[i]=='\0');
	
	//We now know that at least one word is entered
	//Now, getting words
	i=0;
	
	do
	{
		while(input[i]==' ' || input[i]=='\t')
			i++;
		j=0;
		while(input[i]!=' ' && input[i]!='\t' && input[i]!='\n' && input[i]!='\0')
		{
			tmp[j]=input[i];
			i++;
			j++;
			if(j>30)
				return false;
		}
		tmp[j]='\0';
		words[wordindex]=tmp;
		wordindex++;
		if (wordindex>6)
			return false;
	}while(input[i]!='\0');

	return true;
}

bool Operations::readandwrite(TreeList &families)
{
	bool done=0;
	ofstream outfile;
	outfile.open("Family.trn",ios::app);
	if(!outfile.is_open())
	{
		cout << "Family.trn could not be opened." << endl;
		return done;
	}
	string input;
	string* words=new string[6]; //largest command can be at most 6 words

	while(1)
	{
		cout << ">>";
		if(!getwords(words,input))
		{
			outfile << input.c_str() << endl;
			outfile << "Invalid command!" << endl;
			cout << "Invalid command!" << endl;
			continue;
		}
		//command is taken now

		convert(words[0]); 
		//Uppercase to lowercase change is done now

		outfile << input.c_str() << endl;
		//Now checking command possibilities

		if(words[0]=="Male" || words[0]=="Female")
		{
			convert(words[1]); //words[1] is the name
			convert(words[2]); //words[2] is "Exists"

			if(words[2]!="Exists" || words[3]!="")
			{
				outfile << "Invalid command!" << endl;
				cout << "Invalid command!" << endl;
				continue;
			}
			Person *place=NULL;

			families.Search(words[1],place);
			if(place!=NULL)
			{
				outfile << "Invalid command!" << endl;
				cout << "Invalid command!" << endl;
				continue;
			}

			bool male=0;
			if(words[0]=="Male")
				male=1;
			
			if(!families.InsertNode(words[1],male))
			{
				outfile << words[1].c_str() << " cannot be created." << endl;
				outfile << "Memory is full." << endl;
				cout << words[1].c_str() << " cannot be created." << endl;
				cout << "Memory is full." << endl;
			}

			continue;
		}//Male/Female option is over

		else if(words[0]=="Print")
		{
			//now we must eliminate the 's after the name
			string realname;
			char *temp=new char[40];
			int a=0;
			
			while(words[1][a]!='\'')
			{
				temp[a]=words[1][a];
				a++;
			}
			temp[a]='\0';
			realname=temp;
			//'s is eliminated now.

			convert(realname);
			//searching the name in the tree
			Person *place=NULL;
			families.Search(realname,place);
			if(place==NULL)
			{
				outfile << realname.c_str() << " does not exist!" << endl;
				cout << realname.c_str() << " does not exist!" << endl;
				continue;
			}

			convert(words[2]);
			enum relation {Siblings,Sisters,Brothers,Children,Daughters,Sons,Parents,
						   Grandparents,Aunts,Uncles};

			if(words[2]=="Siblings")
				place->Print(Siblings,outfile);
			else if(words[2]=="Sisters")
				place->Print(Sisters,outfile);
			else if(words[2]=="Brothers")
				place->Print(Brothers,outfile);
			else if(words[2]=="Children")
				place->Print(Children,outfile);
			else if(words[2]=="Daughters")
				place->Print(Daughters,outfile);
			else if(words[2]=="Sons")
				place->Print(Sons,outfile);
			else if(words[2]=="Parents")
				place->Print(Parents,outfile);
			else if(words[2]=="Grandparents")
				place->Print(Grandparents,outfile);
			else if(words[2]=="Aunts")
				place->Print(Aunts,outfile);
			else if(words[2]=="Uncles")
				place->Print(Uncles,outfile);
			else
			{
				outfile << "No such relationship exists!" << endl;
				cout << "No such relationship exists!" << endl;
			}
			continue;
		}//Print command is over

		else if(words[0]=="Quit")
		{
			done=true;
			break;
		}

		else //first word is noun
		{
			Person *place=NULL;
			//searching the first name
			families.Search(words[0],place);
			if(place==NULL)
			{
				outfile << words[0].c_str() << " does not exist!" << endl;
				cout << words[0].c_str() << " does not exist!" << endl;
				continue;
			}
			convert(words[1]);
			convert(words[2]);
			
			Person* PartnerPlace=NULL;
			//searching the second name
			families.Search(words[2],PartnerPlace);
			if(PartnerPlace==NULL)
			{
				outfile << words[2].c_str() << " does not exist!" << endl;
				cout << words[2].c_str() << " does not exist!" << endl;
				continue;
			}

			if(words[1]=="Marries")//marriage
			{
				//check relationship
				if(place->prop.male)
				{
					if(PartnerPlace->prop.male)
					{
						outfile << "Marriage is only with different genders." << endl;
						cout << "Marriage is only with different genders." << endl;
						continue;
					}
				}
				else if(!place->prop.male)
				{
					if(!PartnerPlace->prop.male)
					{
						outfile << "Marriage is only with different genders." << endl;
						cout << "Marriage is only with different genders." << endl;
						continue;
					}
				}
				int relation;
				relation=place->CheckRelation(PartnerPlace);

				switch(relation)
				{
				case 1: //married to another person
					outfile << words[0].c_str() << " is already married to " 
							<< place->married->prop.name.c_str() << endl;
					cout	<< words[0].c_str() << " is already married to " 
							<< place->married->prop.name.c_str() << endl;
					continue;
				case 2: //marriage to parent
					outfile << "Marriage to parent is not permitted." << endl;
					cout << "Marriage to parent is not permitted." << endl;
					continue;
				case 3: //marriage to sibling
					outfile << "Marriage to sibling is not permitted." << endl;
					cout << "Marriage to sibling is not permitted." << endl;
					continue;
				case 4: //marriage to uncle
					outfile << "Marriage to uncle is not permitted." << endl;
					cout << "Marriage to uncle is not permitted." << endl;
					continue;
				case 5: //marriage to aunt
					outfile << "Marriage to aunt is not permitted." << endl;
					cout << "Marriage to aunt is not permitted." << endl;
					continue;
				case 6: //marriage to grandparent
					outfile << "Marriage to grandparent is not permitted." << endl;
					cout << "Marriage to grandparent is not permitted." << endl;
					continue;
				case 8: //partner is married to another person
					outfile << words[2].c_str() << " is already married to " 
							<< PartnerPlace->married->prop.name.c_str() << endl;
					cout	<< words[2].c_str() << " is already married to " 
							<< PartnerPlace->married->prop.name.c_str() << endl;
					continue;
				case 7: //marriage is available
					break;
				}
				place->MarriedTo(PartnerPlace);
			}//Marries command is over

			else if(words[1]=="And") //Beget command
			{
				convert(words[3]);
				convert(words[4]);
				convert(words[5]);
				if(words[3]!="Beget")
				{
					outfile << "Invalid command!" << endl;
					cout << "Invalid command!" << endl;
					continue;
				}
				//check marriage
				if (place->married!=PartnerPlace)
				{
					outfile << words[0].c_str() << " is not married to "
							<< words[2] .c_str()<<"." << endl;
					cout << words[0].c_str() << " is not married to " 
						 << words[2].c_str() <<"." << endl;
					continue;
				}
				Person *childplace=NULL;
				families.Search(words[5],childplace);
				if(childplace!=NULL)
				{
					outfile << words[5].c_str() << " already exists!" << endl;
					cout << words[5].c_str() << " already exists!" << endl;
					continue;
				}
				//check memory
				if(childplace->IsFull())
				{
					outfile << "Cannot add child, memory is full!" << endl;
					cout << "Cannot add child, memory is full!" << endl;
					continue;
				}
				bool Male;
				if(words[4]=="Son")
					Male=1;
				else if(words[4]=="Daughter")
					Male=0;
				else
				{
					outfile << "Invalid command!" << endl;
					cout << "Invalid command!" << endl;
					continue;
				}
				//add new child
				childplace=new Person(Male,words[5]);
				if(place->prop.male)
					place->NewChild(childplace);
				else
					PartnerPlace->NewChild(childplace);
				families.IncrementPeople();
				continue;
			}//Beget command is over
			
			else  //words[1] is neither of the above 
			{
				outfile << "Invalid command!" << endl;
				cout << "Invalid command!" << endl;
				continue;
			}
		}//first word is noun is over
	}//end of while
	return done;
}//end of the function
		
void Operations::convert(string &newcommand)
{
	int i=0;
	if(newcommand[i]>='a' && newcommand[i]<='z')
			newcommand[i]=newcommand[i]-('a'-'A');
	i++;

	while (newcommand[i]!='\0')
	{
		if(newcommand[i]>='A' && newcommand[i]<='Z')
			newcommand[i]=newcommand[i]+('a'-'A');
		i++;
	}
}
				
void Person::Print(int relation,ofstream &output)
{

//enum relation={Siblings,Sisters,Brothers,Children,Daughters,Sons,Parents,
//						   Grandparents,Aunts,Uncles};
	Person* temp;
	switch (relation)
	{
	case 0: //Siblings
		if (parent==NULL)
			break;
		temp=parent->child;
		while(temp!=this)
		{
			output << temp->prop.name.c_str() << endl;
			cout << temp->prop.name.c_str() << endl;
			temp=temp->sibling;
		}
		temp=temp->sibling;
		while(temp!=NULL)
		{
			output << temp->prop.name.c_str() << endl;
			cout << temp->prop.name.c_str() << endl;
			temp=temp->sibling;
		}
		break;
	case 1: //Sisters
		if (parent==NULL)
			break;
		temp=parent->child;
		while(temp!=this)
		{
			if(!temp->prop.male)
			{
				output << temp->prop.name.c_str() << endl;
				cout << temp->prop.name.c_str() << endl;
			}
			temp=temp->sibling;
		}
		temp=temp->sibling;
		while(temp!=NULL)
		{
			if(!temp->prop.male)
			{
				output << temp->prop.name.c_str() << endl;
				cout << temp->prop.name.c_str() << endl;
			}
			temp=temp->sibling;
		}
		break;
	case 2: //Brothers
		if (parent==NULL)
			break;
		temp=parent->child;
		while(temp!=this)
		{
			if(temp->prop.male)
			{
				output << temp->prop.name.c_str() << endl;
				cout << temp->prop.name.c_str() << endl;
			}
			temp=temp->sibling;
		}
		temp=temp->sibling;
		while(temp!=NULL)
		{
			if(temp->prop.male)
			{
				output << temp->prop.name.c_str() << endl;
				cout << temp->prop.name.c_str() << endl;
			}
			temp=temp->sibling;
		}
		break;
	case 3: //Children
		if(prop.male)
			temp=child;
		else
			temp=married->child;
		while(temp!=NULL)
		{
			output << temp->prop.name.c_str() << endl;
			cout << temp->prop.name.c_str() << endl;
			temp=temp->sibling;
		}
		break;
	case 4: //Daughters
		if(prop.male)
			temp=child;
		else
			temp=married->child;
		while(temp!=NULL)
		{
			if(!temp->prop.male)
			{
				output << temp->prop.name.c_str() << endl;
				cout << temp->prop.name.c_str() << endl;
			}
			temp=temp->sibling;
		}
		break;
	case 5: //Sons
		if(prop.male)
			temp=child;
		else
			temp=married->child;
		while(temp!=NULL)
		{
			if(temp->prop.male)
			{
				output << temp->prop.name.c_str() << endl;
				cout << temp->prop.name.c_str() << endl;
			}
			temp=temp->sibling;
		}
		break;
	case 6: //Parents
		if(parent!=NULL)
		{
			output << parent->prop.name.c_str() << endl;
			cout << parent->prop.name.c_str() << endl;
			output << parent->married->prop.name.c_str() << endl;
			cout << parent->married->prop.name.c_str() << endl;
		}
		else
		{
			output << "Unknown" << endl;
			cout << "Unknown" << endl;
		}
		break;
	case 7: //Grandparents
		//first,father's parents
		if(parent!=NULL)
		{
			if(parent->parent!=NULL)
			{
				output << parent->parent->prop.name.c_str() << endl;
				cout << parent->parent->prop.name.c_str() << endl;
				output << parent->parent->married->prop.name.c_str() << endl;
				cout << parent->parent->married->prop.name.c_str() << endl;
			}
			else
			{
				output << "Unknown" << endl;
				cout << "Unknown" << endl;
			}
			//now,mother's parents
			if (parent->married->parent!=NULL)
			{
				output << parent->married->parent->prop.name.c_str() << endl;
				cout << parent->married->parent->prop.name.c_str() << endl;
				output << parent->married->parent->married->prop.name.c_str() << endl;
				cout << parent->married->parent->married->prop.name.c_str() << endl;
			}
			else
			{
				output << "Unknown" << endl;
				cout << "Unknown" << endl;
			}
		}
		else
		{
			output << "Unknown" << endl;
			cout << "Unknown" << endl;
		}
		break;
	case 8: //Aunts

		if(parent!=NULL)
		{
			//first, father's sisters
			if(parent->parent!=NULL)
			{
				temp=parent->parent->child;
				while(temp!=parent)
				{
					if(!temp->prop.male)
					{
						output << temp->prop.name.c_str() << endl;
						cout << temp->prop.name.c_str() << endl;
					}
					temp=temp->sibling;
				}
				temp=temp->sibling;
	
				while(temp!=NULL)
				{
					if(!temp->prop.male)
					{
						output << temp->prop.name.c_str() << endl;
						cout << temp->prop.name.c_str() << endl;
					}
					temp=temp->sibling;
				}
			}
			//now, mother's sisters
			if(parent->married->parent!=NULL)
			{
				temp=parent->married->parent->child;
				while(temp!=parent->married)
				{
					if(!temp->prop.male)
					{
						output << temp->prop.name.c_str() << endl;
						cout << temp->prop.name.c_str() << endl;
					}
					temp=temp->sibling;
				}
				temp=temp->sibling;	
	
				while(temp!=NULL)
				{
					if(!temp->prop.male)
					{
						output << temp->prop.name.c_str() << endl;
						cout << temp->prop.name.c_str() << endl;
					}
					temp=temp->sibling;
				}
			}
		}
		break;
	case 9://Uncles
		if(parent!=NULL)
		{
			//first, father's brothers
			if(parent->parent!=NULL)
			{
				temp=parent->parent->child;
				while(temp!=parent)
				{
					if(temp->prop.male)
					{
						output << temp->prop.name.c_str() << endl;
						cout << temp->prop.name.c_str() << endl;
					}
					temp=temp->sibling;
				}
				temp=temp->sibling;
	
				while(temp!=NULL)
				{
					if(temp->prop.male)
					{
						output << temp->prop.name.c_str() << endl;
						cout << temp->prop.name.c_str() << endl;
					}
					temp=temp->sibling;
				}
			}
			//now, mother's brothers
			if(parent->married->parent!=NULL)
			{
				temp=parent->married->parent->child;
				while(temp!=parent->married)
				{
					if(temp->prop.male)
					{
						output << temp->prop.name.c_str() << endl;
						cout << temp->prop.name.c_str() << endl;
					}
					temp=temp->sibling;
				}
				temp=temp->sibling;	
	
				while(temp!=NULL)
				{
					if(temp->prop.male)
					{
						output << temp->prop.name.c_str() << endl;
						cout << temp->prop.name.c_str() << endl;
					}
					temp=temp->sibling;
				}
			}
		}
		break;
	}//end of switch
}//end of function

TreeList::~TreeList()
{
	if(headoflist->next!=NULL)
	{
		Person *temp=headoflist->next->ancestor;
		while(temp->next!=NULL)
		{
			Person *del=temp->next;
			temp->next=del->next;
			delete del;
		}
		delete temp;
		ListNode *tmp;
		while(headoflist->next!=NULL)
		{
			tmp=headoflist->next;
			headoflist->next=tmp->next;
			delete tmp;
		}
	}
	delete headoflist;
}
