/* Student id:2002103907
	Name: Emin Senay
   Notes:

        1)First, I allocated Cell structures in other functions, but then I
   understood that it causes memory to get full easily, so I changed the
   program in a way such that it is now allocating Cell structures in main
   function.Because of this, some parts of the code is repeating.

        2)In Turbo C, sometimes en error message "Floating point error: Domain.
   Abnormal program termination" occurs. I looked for it in the internet.
   It is because of allocations. In Borland 5.02, this error never occurred
   in my tries.

        3) Some of my friends get all of the random values as float and it is
   automatically converted to integer because they assign this value to an integer.
   As a consequence, the value "2" chance decreases and random rightrange and
   downrange values do not increase easily. Therefore, table of cell structure
   do not increase easily and became smaller than my tables. This is because why
   my table became easily very large and why there are much more yecucs in my
   environment in large number of turns than some of my friends' programs.

        4) I wrote a code that shows  the table of yecucs in each turn for
   debugging purposes. It works quite well in small tables of environment. I did
   not delete it, it is now in my main function, but in commentation. It is in
   commentation because it is not good to stop the program in all turns and the
   output of code becomes not understandable in big tables.

        5)(EXTRA) I wrote a function that creates a html file. In this file,
   there is a environment table.If cells are empty,nothing displayed in
   corresponding row and column, and is cells are full, ages of yecucs
   displayed in that row and column. */


#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<conio.h>

/* Structure definition */
typedef struct
{
	int empty;
	int age;
	float weight;
	float weightIncreaseConstant;
	float reproductionThreshold;
	int rightRange;
	int downRange;
}
Cell;

/* function prototypes */
void Force2LinkFloat();
int askToUser(Cell **mycell);
void increase(Cell **mycell, int row, int column);
float randomFloat();
int randomInt();
void newValues(Cell mycell, float *wit, float *repro, int *right, int *down); /*wit=weightIncreaseConstant*/
Cell** checkReproduction(Cell **mycell,int *oldrow, int *oldcolumn);
void printProperties(Cell** mycell, int row, int column);
void writetohtml(Cell **mycell, int row, int column);

main()
{
	int i,j,k,turnno,row=5,column=5,rrange,drange;
	int a,b,c,d;
   char htmltable;
	Cell **mycell; /*my environment structure */

   /*first allocation of pointer*/
	mycell=(Cell**)malloc(5*sizeof(Cell*));
	if (mycell == NULL)
	{
		printf("\nMemory can not be allocated.(firstcell)\n");
		getch();
		exit(0);
	}
	for(i=0 ; i<5 ; i++)
	{
		mycell[i]=(Cell*)malloc(5*sizeof(Cell));
		if (mycell[i] == NULL)
		{
			printf("\nMemory can not be allocated.(firstcell[%d])\n",i);
			getch();
			exit(0);
		}
	}
	for (i=0 ; i<5 ; i++)
		for(j=0 ; j<5 ; j++)
			(mycell[i][j]).empty=1; /*If empty=1, the cell is free */

   /* asking the initial values */
	turnno=askToUser(mycell);
	srand(time(NULL));

	for(i=0;i<turnno;i++)
	{
      /* First, weight and age values are increased. */
	   increase(mycell,row,column);

      /*  Code controls whether the environment is big enough for new yecucs or
          not. If it is not, environment is reallocated. */
		for (a=(row-1);a>=0;a--)
		{
	   	for (b=(column-1);b>=0;b--)
		   {
         /* If cell is empty, or threshold is bigger or equal to weight,
            program continues, If cell is full and threshold exceeded, program
            checks right range and down range of the cell */

		 	   if ( (mycell[a][b].empty) == 1 || (mycell[a][b].reproductionThreshold) >= (mycell[a][b].weight) )
					continue;

            /* First, rightrange check */
            rrange=mycell[a][b].rightRange;
				if ( (rrange+b) > (column-1))
				{
				   for(c=0;c<row;c++)
               {
				      mycell[c]=(Cell*)realloc(mycell[c],(b+rrange+1)*sizeof(Cell));
				      if (mycell[c]==NULL)
					   {
					      printf("\nMemory can not be allocated.(reallocatecolumn)\n");
					      getch();
					      exit(0);
					   }
               }
					for(c=0;c<row;c++)
					   for(d=column;d<(b+rrange+1);d++)
					      mycell[c][d].empty=1;

					column=b+rrange+1;
				}

            /* Now, downrange check */
           	drange=mycell[a][b].downRange;
			   if ( (drange+a) > (row-1))
			   {
			      mycell=(Cell**)realloc(mycell,(a+drange+1)*sizeof(Cell*));
			      if(mycell==NULL)
				   {
				      printf("\nMemory can not be allocated.(reallocaterow)\n");
				      getch();
				      exit(0);
				   }
				   for (c=row;c<=(drange+a);c++)
				   {
				      mycell[c]=(Cell*)malloc(column*sizeof(Cell));
				      if (mycell[c]==NULL)
				      {
				         printf("\nMemory can not be allocated.(reallocaterow[])\n");
					      getch();
					      exit(0);
				      }
               }
			  	   for(c=row;c<=(drange+a);c++)
				      for(d=0;d<column;d++)
				         mycell[c][d].empty=1;
				   row=a+drange+1;
            }
         } /* End of column for */
      }    /* End of row for */

      /* Values of new yecucs are initialized in this function */
      /* Although I made call by reference, I returned the array because
         sometimes the program was working as if it is call by value */
		mycell=checkReproduction(mycell,&row,&column);

      /* My extra table printing code (about which I wrote above) is here. */
      /* printf("%d. turn:\n",i+1);
		getch();

		for(k=0;k<row;k++)
		{
			for(j=0;j<column;j++)
			{
				if(mycell[k][j].empty==0)
					printf(" %d ",mycell[k][j].age);
				else
					printf (" . ");
			}
			printf("\n");
		}
		printf("\n");  */

	} /* End of turnno for */

   fflush(stdin);
   /* Asking whether the program gives html output or not */
   printf("\nDo you want a html output table(Y/N)?");
   scanf("%c",&htmltable);
   if (htmltable=='y' || htmltable=='Y')
   {
      writetohtml(mycell,row,column);
      printf("The html file 2002103907.htm created. You can look at it.\n\n");
   }
   /* At the end of the loop, program is printing the properties of the cell */
	printProperties(mycell,row,column);
   for (i=0;i<row;i++)
		free (mycell[i]);
	free (mycell);

   return 0;
}  /* End of the main function */


/*in this function, program asks user to enter the properties of yecuc*/
int askToUser(Cell **mycell)
{
	int row,column,turnno;

   /*input check for row & column*/
	do
	{
		printf ("Please enter the position of the yecuc.\nRow: ");
		scanf ("%d",&row);
		printf ("Column: ");
		scanf ("%d",&column);

		if ( column<0 || column>4 || row<0 || row>4 )
			printf("Row or column can not be bigger than 4 or smaller than 0.\n\n");

	} while ( column<0 || column>4 || row<0 || row>4 );
	mycell[row][column].empty=0;

	printf ("Please enter properties of the yecuc.\n");
	printf ("Age: ");
	scanf ("%d", &mycell[row][column].age);

   /*input check for weight & reproduction threshold. User can not enter the
     reproduction threshold smaller than weight */
	do
	{
		printf ("Weight: ");
		scanf ("%f", &mycell[row][column].weight);

		printf ("Weight increase constant: ");
		scanf ("%f", &mycell[row][column].weightIncreaseConstant);

		printf ("Reproduction threshold: ");
		scanf ("%f", &mycell[row][column].reproductionThreshold);

		if ( (mycell[row][column].reproductionThreshold) < (mycell[row][column].weight) )
			printf("Reproduction threshold can not be smaller than weight.\nPlease enter them correctly.\n");

	} while( (mycell[row][column].reproductionThreshold) < (mycell[row][column].weight) );

	printf ("Right range: ");
	scanf ("%d", &mycell[row][column].rightRange);

	printf ("Down range: ");
	scanf ("%d", &mycell[row][column].downRange);

	printf ("How many turns? ");
	scanf ("%d",&turnno);

	return turnno;
} /*end of askToUser */


/* in this function, the program increases the weight and age */
/* The program first increases all of the ages and weights. It checks
   reproduction in another function */
void increase(Cell **mycell, int row, int column)
{
	int i,j;
	for (i=0;i<row;i++)
		for (j=0;j<column;j++)
		{
			if(mycell[i][j].empty==0)
			{
				mycell[i][j].age++;
				mycell[i][j].weight+=mycell[i][j].weightIncreaseConstant;
			}
		}
}


/* This function checks whether weight of the yecuc exceeds its reproduction
   threshold, if it exceeds, values of the new yecuc are initialized. */
Cell** checkReproduction(Cell **mycell,int *oldrow, int *oldcolumn)
{
	int i,j;
	float tempweight,tempwit,temprep;
	int tempright,tempdown,rrange,drange;
	for (i=(*oldrow-1);i>=0;i--)
	{
		for (j=(*oldcolumn-1);j>=0;j--)
		{
			if ( (mycell[i][j].empty) == 1 || (mycell[i][j].reproductionThreshold) >= (mycell[i][j].weight) )
				continue;

			mycell[i][j].weight /= 3;
			tempweight=(mycell[i][j].weight);
			newValues(mycell[i][j],&tempwit,&temprep,&tempright,&tempdown);

			rrange=mycell[i][j].rightRange;

			if ( (mycell[i][j+rrange].empty)==0)
			{
				mycell[i][j+rrange].age/=2;
				mycell[i][j+rrange].weight=((mycell[i][j+rrange].weight)+tempweight)/2;
				mycell[i][j+rrange].weightIncreaseConstant=((mycell[i][j+rrange].weightIncreaseConstant)+tempwit)/2;
				mycell[i][j+rrange].reproductionThreshold=((mycell[i][j+rrange].reproductionThreshold)+temprep)/2;
				mycell[i][j+rrange].rightRange=((mycell[i][j+rrange].rightRange)+tempright)/2;
				mycell[i][j+rrange].downRange=((mycell[i][j+rrange].downRange)+tempdown)/2;
			}
			else
			{
				mycell[i][j+rrange].empty=0;
				mycell[i][j+rrange].age=0;
				mycell[i][j+rrange].weight=tempweight;
				mycell[i][j+rrange].weightIncreaseConstant=tempwit;
				mycell[i][j+rrange].reproductionThreshold=temprep;
				mycell[i][j+rrange].rightRange=tempright;
				mycell[i][j+rrange].downRange=tempdown;
			}

			newValues(mycell[i][j],&tempwit,&temprep,&tempright,&tempdown);

			drange=mycell[i][j].downRange;


			if ( (mycell[i+drange][j].empty)==0)
			{
				mycell[i+drange][j].age/=2;
				mycell[i+drange][j].weight=((mycell[i+drange][j].weight)+tempweight)/2;
				mycell[i+drange][j].weightIncreaseConstant=((mycell[i+drange][j].weightIncreaseConstant)+tempwit)/2;
				mycell[i+drange][j].reproductionThreshold=((mycell[i+drange][j].reproductionThreshold)+temprep)/2;
				mycell[i+drange][j].rightRange=((mycell[i+drange][j].rightRange)+tempright)/2;
				mycell[i+drange][j].downRange=((mycell[i+drange][j].downRange)+tempdown)/2;
			}
			else
			{
				mycell[i+drange][j].empty=0;
				mycell[i+drange][j].age=0;
				mycell[i+drange][j].weight=tempweight;
				mycell[i+drange][j].weightIncreaseConstant=tempwit;
				mycell[i+drange][j].reproductionThreshold=temprep;
				mycell[i+drange][j].rightRange=tempright;
				mycell[i+drange][j].downRange=tempdown;
			}
		}
	}
	return mycell;
}


/* This function generates random values for the new yecuc. It also checks
   whether the random values is above 0 or not. */
void newValues(Cell mycell, float *wit, float *repro, int *right, int *down) /*wit=weightIncreaseConstant*/
{
	float random_d=randomFloat();
	int random_i=randomInt();

/* All if s check the random values. If random values are above 0, new values
   are initialized. If randoms are equal to or below 0, values of parent yecuc
   are inititialized. */
	if ( ((mycell.weightIncreaseConstant)+random_d) <=0 )
		*wit=mycell.weightIncreaseConstant;
	else
		*wit=(mycell.weightIncreaseConstant)+random_d;

	random_d=randomFloat();
	if ( ((mycell.reproductionThreshold)+random_d) <=0 )
		*repro=mycell.reproductionThreshold;
	else
		*repro=(mycell.reproductionThreshold)+random_d;

	if ( ((mycell.rightRange)+random_i) <=0 )
		*right=mycell.rightRange;
	else
		*right=(mycell.rightRange)+random_i;

	random_i=randomInt();
	if ( ((mycell.downRange)+random_i) <=0 )
		*down=mycell.downRange;
	else
		*down=(mycell.downRange)+random_i;


}     /* end of new values function. */

/* random float function */
float randomFloat()
{
	float i;
	i=((rand()%401)/100.0)-2;
	return i; /*The program returns values between -2.00 to 2.00 */
}

/* random integer function */
int randomInt()
{
	int i;
	i=(rand()%5)-2;
	return i;  /*The program returns -2,-1,0,1 or 2 */
}

/* Properties of the environment is printed in this function */
void printProperties(Cell** mycell, int row, int column)
{
	int i,j,countyecuc=0,k=0,*yecucages,ischanged;
	printf("\nThe environment has %d rows and %d columns.\n",row,column);


	for(i=0;i<row;i++)
		for(j=0;j<column;j++)
			if (mycell[i][j].empty == 0)
				countyecuc++;

	yecucages=(int*)malloc(countyecuc*sizeof(int));
	if(yecucages==NULL)
	{
		printf("\nMemory can not be allocated.(printproperties)\n");
		getch();
		exit(0);
	}

	for(i=0;i<row;i++)
		for(j=0;j<column;j++)
			if (mycell[i][j].empty == 0)
				yecucages[k++]=mycell[i][j].age;

	printf("There are %d yecucs living in the environment.\n\n",countyecuc);

  /* Here I used bubble sorting to find how much yecucs are in a constant age.
     After that, I found another solution of finding the yecuc number of spesific
     age, but this code is working (but it is only slow in very high numbers of
     yecucs (such as 100000), and I don't have much time, so I did not
     changed the code. */

	for(j=1;j<countyecuc;j++)
	{
		ischanged=0;
		for(i=0;i<(countyecuc-1);i++)
			if (yecucages[i] > yecucages[i+1])
			{
			 k=yecucages[i];
			 yecucages[i]=yecucages[i+1];
			 yecucages[i+1]=k;
			 ischanged=1;
			}
			if (ischanged==0)
				break;
	}

   /*I made a table here to show the ages and how much yecuc are in that age*/
	printf("     Ages          Howmuch     \n");
	printf("-------------------------------\n");
	printf("|%7d",yecucages[0]);
	j=1;
	for(i=0;i<countyecuc;i++)
	{
		if (yecucages[i+1] == yecucages[i])
			j++;
		else
		{
			printf("%16d      |\n",j);
			if((i+1)<countyecuc)
				printf("|%7d",yecucages[i+1]);
			j=1;
		}
	}
	printf("-------------------------------\n");
   free (yecucages);
   getch();
}

void writetohtml(Cell **mycell, int row, int column)
{
   FILE *fp;
   int i,j;
   fp=fopen ("2002103907.htm","w");     /*Opened the file in write mode*/
   fprintf (fp,"<html><head></head><body>"); /*Beginning of html code*/
   fprintf (fp,"<font color=red,size=3><center><b>2002103907 Environment properties<br></b></font>");
   fprintf (fp,"<table border=1>");  /* Beginning of table */
   for(i=0;i<row;i++)
   {
      fprintf(fp,"<tr>");        /* Beginning of row */
      for(j=0;j<column;j++)
      {
         fprintf(fp,"<td>");     /* Beginning of column */
         if ((mycell[i][j].empty)==1)
            fprintf(fp,"&nbsp;");
         else
            fprintf(fp,"%d",mycell[i][j].age);
         fprintf(fp,"</td>");    /* End of column */
      }
      fprintf (fp,"</tr>");      /* End of row */
   }
   fprintf(fp,"</table></center></body></html>"); /* End of html code */
   fclose(fp);                                    /* closed the file */
}    /* End of the function */


/* This function is to force the compiler to link floats in structs */
void Force2LinkFloat()
{
   float a, *f=&a;
   *f=0000;
}