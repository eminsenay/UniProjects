//sparsematrix.cpp

#include <iostream>
#include <fstream>
#include "sparsematrix.h"

//Mnode functions

Mnode::Mnode(bool h,triple& tr)
{
	head=h;
	right=this;
	down=this;
	if(head==true)
		next=this; //for head nodes
	else 
		tri=tr;		//for MainHead or the other nodes
}

//Global functions

istream& operator>> (istream& file,SparseMatrix& Matrix)
{
	triple hd; //mainhead
	triple empty;
	empty.column=0;
	empty.row=0;
	empty.value=0;
	file >> hd.row >> hd.column >> hd.value;
	Matrix.MainHead= new Mnode(false,hd);
	if(hd.value==0)
	{
		Matrix.MainHead -> right=Matrix.MainHead;
		return file;
	}
	Mnode* last= new Mnode(true,empty);
	Matrix.MainHead -> right= last;
	Mnode* newnode=NULL;

	for (int i=1;i<hd.row;i++)
	{
		newnode= new Mnode(true,empty);
		last -> next= newnode;
		last= newnode;
	}
	last -> next =Matrix.MainHead; //heads are connected with each other and MainHead
	for (int j=0;j<hd.value;j++)
	{
		triple mx; //for element's values
		file >> mx.row >> mx.column >> mx.value;
		Mnode* tmp= Matrix.MainHead -> right; //first head
		for (int k=0;k<mx.column;k++)
			tmp=tmp -> next;
		//tmp is pointing the given column's headnode
		while ((tmp->down)->head==0)
		{
			int r=(tmp->down)->tri.row;
			if(r>mx.row)
				break;
			else
				tmp=tmp->down;
		}
		//tmp is pointig one node upper than the place which we are adding the new node
		newnode=new Mnode(false,mx);
		newnode->down=tmp->down;
		tmp->down=newnode;
		//new Mnode linked in column, now me must link in row
		tmp=Matrix.MainHead->right;
		for(int l=0;l<mx.row;l++)
			tmp=tmp->next;
		//tmp is pointing the given unit's headnode
		while ((tmp->right)->head==0)
		{
			int c=(tmp->right)->tri.column;
			if (c>mx.column)
				break;
			else
				tmp=tmp->right;
		}
		//tmp is pointing the node left to the newnode
		newnode->right=tmp->right;
		tmp->right=newnode;
		//newnode is linked in row
	}//end of for
	return file;
}//end of fnc

ostream& operator << (ostream& file, SparseMatrix& Matrix)
{
	file << Matrix.MainHead->tri.row << " ";
	file << Matrix.MainHead->tri.column << " ";
	file << Matrix.MainHead->tri.value << endl;

	Mnode* headnode= Matrix.MainHead->right; //first head node
	Mnode* last=NULL;

	while (headnode->head==1)
	{
		last= headnode->right;
		while (last->head==0)
		{
			file << last->tri.row << " " << last->tri.column << " " << last->tri.value << endl;
			last=last->right;
		}
		headnode=headnode->next;
	}
	return file;
}

//SparseMatrix functions

SparseMatrix::SparseMatrix(SparseMatrix& rhs)
{
	*this=rhs;
}

SparseMatrix::~SparseMatrix()
{
	if(MainHead!=NULL)
	{
		Mnode* headnode=MainHead->right;
		//Mnode* last=headnode;
		Mnode* lasthead=MainHead;
		Mnode* tmp;
		while (headnode->head==1)
		{
			while(headnode->right->head==0)
			{
				tmp=headnode->right;
				headnode->right=tmp->right;
				delete tmp;
			}
			tmp=MainHead->right;
			MainHead->right=tmp->next;
			headnode=headnode->next;
			delete tmp;
		}
		delete MainHead;
	}
}


SparseMatrix SparseMatrix::operator +(SparseMatrix &rhs)
{
	int nodecount=0;
	triple empty;
	SparseMatrix sum;
	sum.MainHead=new Mnode(false,rhs.MainHead->tri);

	Mnode* last= new Mnode(true,empty); //first headnode
	sum.MainHead->right=last;
	Mnode* newnode=NULL;

	//headnodes are being created and linked now
	for (int i=1; i<rhs.MainHead->tri.row; i++) 
	{
		newnode= new Mnode(true, empty);
		last->next=newnode;
		last=newnode;
	}
	last->next=sum.MainHead;
	//all head nodes are linked

	Mnode* tmpthis=MainHead->right->right;	//First elements of matrices
	Mnode* tmprhs=(rhs.MainHead)->right->right;
	last=sum.MainHead->right; //first headnode of sum
	
	Mnode* rows= rhs.MainHead->right; //first headnode of rhs

	while (rows->head==true) //goes up to the MainHead (its head is false)
	{
		Mnode* collink=NULL;
		int rhscol,thiscol;
		while(tmprhs->head==false && tmpthis->head==false)
		{
			thiscol=tmpthis->tri.column;
			rhscol=tmprhs->tri.column;
			triple trisum;
			if(thiscol>rhscol)
			{
				newnode= new Mnode(false,tmprhs->tri);
				tmprhs=tmprhs->right;
			}
			else if(thiscol<rhscol)
			{
				newnode=new Mnode(false,tmpthis->tri);
				tmpthis=tmpthis->right;
			}
			else
			{
				trisum.column=tmpthis->tri.column;
				trisum.row=tmpthis->tri.row;
				trisum.value=tmpthis->tri.value+tmprhs->tri.value;
				if(trisum.value!=0)
					newnode=new Mnode(false,trisum);
				tmprhs=tmprhs->right;
				tmpthis=tmpthis->right;
			}
			if(trisum.value!=0)
			{
				nodecount++;
				newnode->right=last->right;
				last->right=newnode;
				last=newnode;
				//row linking is OK, now we must link columns
				collink=sum.MainHead->right;//first headnode

				int smaller=rhscol;
				if(thiscol<rhscol)
					smaller=thiscol;	

				for(int j=0;j<smaller;j++)
					collink=collink->next;
				//collink is pointing added node's column

				while(collink->down->head==false)
					collink=collink->down;
				//collink is pointing the place to link the newnode	

				newnode->down=collink->down; //pointing to the headnode
				collink->down=newnode;
			}
		}//end of second while
		//now, at least one of the matrix lists is pointing to NULL
		//and maybe the other has nodes to be added

		while(tmpthis->head==false)
		{
			newnode= new Mnode(false,tmpthis->tri);
			nodecount++;
			newnode->right=last->right;
			last->right=newnode;
			last=newnode;
			tmpthis=tmpthis->right;
			//Row is OK, now column
			collink=sum.MainHead->right;//first headnode of sum

			for (int c=0;c<thiscol;c++)
				collink=collink->next;
			//collink is now pointing added node's column
			
			while (collink->down->head==false)
				collink=collink->down;
			//collink is now pointing the place to link the new node

			newnode->down=collink->down; //pointing to the headnode
			collink->down=newnode;
		}

		while(tmprhs->head==false)
		{
			newnode= new Mnode(false,tmprhs->tri);
			nodecount++;
			newnode->right=last->right;
			last->right=newnode;
			last=newnode;
			tmprhs=tmprhs->right;
			//Row is OK, now column
			collink=sum.MainHead->right;//first headnode of sum

			for (int c=0;c<rhscol;c++)
				collink=collink->next;
			//collink is now pointing added node's column
			
			while (collink->down->head==false)
				collink=collink->down;
			//collink is now pointing the place to link the new node

			newnode->down=collink->down; //pointing to the headnode
			collink->down=newnode;
		}
		//now, both tmpthis and tmprhs are pointing to the headnode
		//we finished one row, now, we must start the other row
		tmpthis=tmpthis->next->right;	//first elements of the other row
		tmprhs=tmprhs->next->right;
		last=last->right->next;
		rows=rows->next;
	}//end of first while
	sum.MainHead->tri.value=nodecount;
	return sum;
}

SparseMatrix SparseMatrix::operator -(SparseMatrix &rhs)
{
	int nodecount=0;
	triple empty;
	SparseMatrix diff;
	diff.MainHead=new Mnode(false,rhs.MainHead->tri);

	Mnode* last= new Mnode(true,empty); //first headnode
	diff.MainHead->right=last;
	Mnode* newnode=NULL;

	//headnodes are being created and linked now
	for (int i=1; i<rhs.MainHead->tri.row; i++) 
	{
		newnode= new Mnode(true, empty);
		last->next=newnode;
		last=newnode;
	}
	last->next=diff.MainHead;
	//all head nodes are linked

	Mnode* tmpthis=MainHead->right->right;	//First elements of matrises
	Mnode* tmprhs=(rhs.MainHead)->right->right;
	last=diff.MainHead->right; //first headnode of diff
	
	Mnode* rows= rhs.MainHead->right; //first headnode of rhs

	while (rows->head==true) //goes up to the MainHead (its head is false)
	{
		Mnode* collink=NULL;
		int rhscol,thiscol;
		while(tmprhs->head==false && tmpthis->head==false)
		{
			thiscol=tmpthis->tri.column;
			rhscol=tmprhs->tri.column;
			triple minus;
			if(thiscol>rhscol)
			{
				minus.column=tmprhs->tri.column;
				minus.row=tmprhs->tri.row;
				minus.value=-(tmprhs->tri.value);
				newnode= new Mnode(false,minus);
				tmprhs=tmprhs->right;
			}
			else if(thiscol<rhscol)
			{
				newnode=new Mnode(false,tmpthis->tri);
				tmpthis=tmpthis->right;
			}
			else
			{
				minus.column=tmpthis->tri.column;
				minus.row=tmpthis->tri.row;
				minus.value=tmpthis->tri.value-tmprhs->tri.value;
				if(minus.value!=0)
					newnode=new Mnode(false,minus);
				tmprhs=tmprhs->right;
				tmpthis=tmpthis->right;
			}
			if(minus.value!=0)
			{
				nodecount++;
				newnode->right=last->right;
				last->right=newnode;
				last=newnode;
				//row linking is OK, now we must link columns
				collink=diff.MainHead->right;//first headnode		

				int smaller=rhscol;
				if(thiscol<rhscol)
					smaller=thiscol;	

				for(int j=0;j<smaller;j++)
					collink=collink->next;
				//collink is pointing added node's column

				while(collink->down->head==false)
					collink=collink->down;
				//collink is pointing the place to link the newnode

				newnode->down=collink->down; //pointing to the headnode
				collink->down=newnode;
			}
		}//end of second while
		//now, at least one of the matrix lists is pointing to NULL
		//and maybe the other has nodes to be added

		while(tmpthis->head==false)
		{
			newnode= new Mnode(false,tmpthis->tri);
			nodecount++;
			newnode->right=last->right;
			last->right=newnode;
			last=newnode;
			tmpthis=tmpthis->right;
			//Row is OK, now column
			collink=diff.MainHead->right;//first headnode of diff

			for (int c=0;c<thiscol;c++)
				collink=collink->next;
			//collink is now pointing added node's column
			
			while (collink->down->head==false)
				collink=collink->down;
			//collink is now pointing the place to link the new node

			newnode->down=collink->down; //pointing to the headnode
			collink->down=newnode;
		}

		while(tmprhs->head==false)
		{
			triple neg;
			neg.column=tmprhs->tri.column;
			neg.row=tmprhs->tri.row;
			neg.value=-(tmprhs->tri.value);
			newnode= new Mnode(false,neg);
			nodecount++;
			newnode->right=last->right;
			last->right=newnode;
			last=newnode;
			tmprhs=tmprhs->right;
			//Row is OK, now column
			collink=diff.MainHead->right;//first headnode of diff

			for (int c=0;c<rhscol;c++)
				collink=collink->next;
			//collink is now pointing added node's column
			
			while (collink->down->head==false)
				collink=collink->down;
			//collink is now pointing the place to link the new node

			newnode->down=collink->down; //pointing to the headnode
			collink->down=newnode;
		}
		//now, both tmpthis and tmprhs are pointing to the headnode
		//we finished one row, now, we must start the other row
		tmpthis=tmpthis->next->right;	//first elements of the other row
		tmprhs=tmprhs->next->right;
		last=last->right->next;
		rows=rows->next;
	}//end of first while
	diff.MainHead->tri.value=nodecount;
	return diff;
}

SparseMatrix SparseMatrix::operator *(SparseMatrix& rhs)
{
	SparseMatrix product;
	product.MainHead=new Mnode(false,rhs.MainHead->tri);
	int nodecount=0; //for changing the MainHead->tri.value

	triple empty;
	empty.column=0;
	empty.row=0;
	empty.value=0;

	//creating and linking Head nodes 
	Mnode* last= new Mnode(true,empty);
	product.MainHead->right=last;
	
	Mnode* newnode=NULL;
	for(int i=1;i<MainHead->tri.row;i++)
	{
		newnode= new Mnode(true,empty);
		last->next=newnode;
		last=newnode;
	}
	last->next=product.MainHead;

	Mnode* tmpthis=MainHead->right; //first head nodes
	Mnode* tmprhs =rhs.MainHead->right;

	last=product.MainHead->right; //First headnode of product

	int rows=MainHead->tri.row;
	int columns=MainHead->tri.column;

	for(int r=0; r<rows; r++)
	{
		triple prod;
		prod.row=r;
		for (int c=0;c<columns;c++)
		{
			tmpthis=tmpthis->right; //first element in row
			tmprhs=tmprhs->down; //first element in column
			prod.column=c;
			prod.value=0;
			
			while(tmpthis->head==false && tmprhs->head==false)
			{
				int columnofthis=tmpthis->tri.column;
				int rowofrhs=tmprhs->tri.row;
				if(rowofrhs!=columnofthis)
				{
					if (rowofrhs>columnofthis)
						tmpthis=tmpthis->right;
					else 
						tmprhs=tmprhs->down;
				}
				else
				{
					prod.value+=tmpthis->tri.value*tmprhs->tri.value;

					tmpthis=tmpthis->right;
					tmprhs=tmprhs->down;
				}
			}
			while(tmpthis->head==false)
				tmpthis=tmpthis->right;
			while(tmprhs->head==false)
				tmprhs=tmprhs->down;

			//Adding the new element and row linking
			if(prod.value!=0)
			{
				newnode=new Mnode(false,prod);
				nodecount++;
				newnode->right=last->right; //to header node
				last->right=newnode;
				last=newnode;
				//Row linking is OK, now column linking

				Mnode* collink=(product.MainHead)->right; //first HeadNode
				for(int a=0; a<newnode->tri.column; a++)
					collink=collink->next;
				//collink is pointing newnode's column
				while(collink->down->head==0)
					collink=collink->down;
				//collink is pointing the place to link the newnode
				newnode->down=collink->down; //to the headnode
				collink->down=newnode;
			}
			tmprhs=tmprhs->next;
		}
		tmprhs=tmprhs->right;
		tmpthis=tmpthis->next;
	}
	product.MainHead->tri.value=nodecount;
	return product;
}

void SparseMatrix::operator =(SparseMatrix& rhs)
{
	triple empty;
	empty.column=0;
	empty.row=0;
	empty.value=0;

	//Setting the MainHead values
	MainHead=new Mnode(false,rhs.MainHead->tri);

	//setting head nodes and connecting
	Mnode* newnode=new Mnode(true,empty);
	Mnode* last=newnode;
	MainHead->right=newnode;

	for (int i=1; i<MainHead->tri.row; i++)
	{
		newnode=new Mnode(true,empty);
		last->next=newnode;
		last=newnode;
	}
	last->next=MainHead; //heads are connected with each other and MainHead

	Mnode* headnodes=rhs.MainHead->right;//first headnode of matrix to copy
	last=MainHead->right;//first element of the first row (of matrix to be copied)

	while(headnodes->head==1)
	{
		Mnode* read=headnodes->right;
		while(read->head==0)
		{
			newnode=new Mnode(false,read->tri);
			newnode->right=last->right;
			last->right=newnode;
			last=newnode;
			//Row linking is OK, now column linking						

			Mnode* tmp=MainHead->right;
			for (int j=0; j<newnode->tri.column; j++)
				tmp=tmp->next;
			//tmp is now pointing the headnode of the newnode	

			while(tmp->down->head==0)
				tmp=tmp->down;
			//tmp is pointing the place to link the newnode	

			newnode->down=tmp->down;
			tmp->down=newnode;
			read=read->right;
		}
		headnodes=headnodes->next;
		last=last->right->next; //the next headnode
	}
}


