/* Emin ޞenay
	Student id:2002103907

	Second Project=High School Gamble

	Description:I wrote a program which plays a number guessing game against human.
	There is a pool of numbers and each hint reduces the number of the
	pool members. Each time, the program controls all the pool members whether
	they fit the given clues or not. Numbers which do not fit the clues
	eliminated.Later, program chooses a random number from the remaining
	numbers.This process finish when the number is found. Lastly,
	the program asks if the player wants to play again or not.  */

/* Note:There are some digit controlling mechanisms I made.

	The first:
		If player enters the number of digits wrong, program warns
	the player and restarts.

	The second:
		Nowhere in the program can number of pluses and minuses more than
	digit number. After the program gets the plus and minus number from
	the player, it checks this first, and then starts to eliminate numbers.
	If player enters that values wrong, the program warns the player and
	shuts down.

	The third:
		If there is no	remaining number in the number array, the player must
	have entered one or more of hints incorrectly. In this situation,
	program again warns the	player and terminates. */

/* P.S: I made the indentation with TAB, and chose tab size 3 characters.*/
/* So,if your tab size is different, you may see the indentation spaces very big.*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define N 9877

int number[N];

int divide(int num_d,int whichdigit);						/* Prototypes of other functions */
void eliminate (int num_e, int plus_e, int minus_e);

main()
{
	int digit,minusno=0,plusno=0,counter=0;
	int i,j;												/*Temporary variables*/
	char again;

	srand (time(NULL));

	for (i=0;i<N;i++)			 /*  Initalization of array elements */
		number[i]=-1;			 /*  If number[i]==-1, the number is eliminated.
										  Firstly, -1 is initialized to all numbers,
										  later the program initializes the numbers
										  it will use in this array. i.e:If digit is
										  2, program will only initialize 10 to 99 to
										  their real values */

	printf ("Enter number of digits in the game: ");
	scanf ("%d",&digit);

	switch (digit)

	/* In all of these cases firstly array elements are initialized. In this
		process, array element is divided to its digits. If there is any
		repeating number in the array element, it is not initialized to its
		value. (The value of it remains the same,-1,which was initialized	before.
		After that, random number for guess is chosen. The random number must be
		between the digit boundaries and must be different than -1 (-1 shows
		that the number is eliminated. */
	{
		case 2:

			for (i=10;i<99;i++)
				if (divide(i,3)!=divide(i,4))	/* i.e. If our number is 15 divide(i,3)=1,divide(i,4)=5*/
					number[i]=i;

			do
				i=rand();
			while (i<10 || i>98 || number[i]==-1);
				printf ("Your number is %d.\n",number[i]);

			break;

		case 3:

			for (i=102;i<988;i++)
			  if (divide(i,2)!=divide(i,3) &&	/*i.e Our number=123; divide(i,2)=1,divide(i,3)=2,divide(i,4)=3*/
					divide(i,2)!=divide(i,4) &&
					divide(i,3)!=divide(i,4))

				  number[i]=i;

			do
				i=rand();
			while (i<102 || i>987 || number[i]==-1);
				printf ("Your number is %d.\n",number[i]);

			break;

		case 4:

			for (i=1023;i<9877;i++)
				if (divide(i,1)!=divide(i,2)&&
					 divide(i,1)!=divide(i,3)&&
					 divide(i,1)!=divide(i,4)&&
					 divide(i,2)!=divide(i,3)&&
					 divide(i,2)!=divide(i,4)&&
					 divide(i,3)!=divide(i,4))

					number[i]=i;

			do
				i=rand();
			while (i<1023 || i>9876 || number[i]==-1);

				printf ("Your number is %d.\n",number[i]);

			break;

		default:					/*If digit is entered wrong, the program starts again*/

			printf ("Invalid digit number!\n");

			return main();

	}	/*End of switch*/		/*first guess is over*/

	counter++;					/*now counter is 1*/

	printf ("What is number of +'s? ");
	scanf ("%d",&plusno);
	printf ("What is number of -'s? ");
	scanf ("%d",&minusno);

	while (plusno!=digit && plusno+minusno<=digit) /* If plusno is equal to digit number
																	  or plusno+minusno is more or equal to
																	  digit number, either the guessed number
																	  is correct or player entered the plus and
																	  minus numbers incorrectly */
	{
		eliminate (number[i],plusno,minusno);	/*Elimination from the number array*/
		counter++;

		for (i=0;i<N;i++)       /* digit control no:3 (explained in the beginning) */
		{
			if (number[i]!=-1)   /* If there is any number which is not equal to
											-1, the elements of the array is not over */
				break;

			if (i==N-1)       /* This shows us all elements in the array are eliminated */
			{
				printf ("No number for given hints is found.\nMost probably you entered wrong hint somewhere.\nThe program is shutting down.\n");
				return 0;
			}
		}                       /* end of digit control no:3 */

		switch (digit)
		{						/*Random number choosing*/
			case 2:        /* Again, number must obey rules given between while
									paranthesis */
								/* If it does not obey the rule, it is	chosen again */
				do
					i=rand();
				while (i<10 || i>98 || number[i]==-1);

					break;

			case 3:

				do
					i=rand();
				while (i<102 || i>987 || number[i]==-1);

					break;

			case 4:

				do
					i=rand();
				while (i<1023 || i>9876 || number[i]==-1);

					break;
		}						/*Random number is chosen*/

		printf ("Your number is %d.\n",number[i]);

		printf ("What is number of +'s? ");
		scanf ("%d",&plusno);
		printf ("What is number of -'s? ");
		scanf ("%d",&minusno);

	}/* end of while */

	if (plusno+minusno>digit)	/*The sum of +'s and -'s can not be bigger than the digit number*/
	{
		printf ("You did not enter the number of +'s and -'s correct.\nThe program is shutting down.\n");

		return 0;
	}

	printf ("I found the number in %d tries.\n",counter);

	fflush (stdin);

	printf ("Do you want to continue (Y,N)? ");
	scanf ("%c",&again);

	if (again=='y' || again=='Y')	/* Other than 'Y' or 'y' ends the program.*/
		return main();

	return 0;
}                /* end of main function */

int divide (int num_d,int whichdigit)
{
  switch (whichdigit)     /* The program looks the digit requested */
	{                      /* and returns that digit */
		case 1:
			return num_d/1000;      /* Finding digits using / and % operators */
		case 2:
			return (num_d%1000)/100;
		case 3:
			return (num_d%100)/10;
		case 4:
			return num_d%10;
	}
}						/*end of the function*/

void eliminate (int num_e, int plus_e, int minus_e)
{
	int no1=divide(num_e,1), no2=divide(num_e,2);	/*digits of the parameter number*/
	int no3=divide(num_e,3), no4=divide(num_e,4);
	int a,b,c,d;											/*digits of the temporary number*/
	int i,counterplus=0,counterminus=0;				/*temporary values*/

	if (num_e<100)	/*if this initialization does not made, the intial values*/
	{					/*of no1 and no2,which were both 0, occur problems in*/
		no1=-1;		/*the controlling process.So,I initialized them to -1*/
		no2=-1;		/*in order not to be a problem for the process.*/
	}

	else if (num_e<1000)	/*again,for same reasons no1 is initialized to -1*/
		no1=-1;

	/*the beginning of the number control*/
	for (i=0;i<N;i++)
	{
		counterplus=0;
		counterminus=0;

		if (number[i]!=-1)	/*if number is already eliminated,there is no need to control it again*/
									/*"If" here is not necessary but it is good for performance reasons*/
		{
			a=divide (number[i],1);
			b=divide (number[i],2);
			c=divide (number[i],3);
			d=divide (number[i],4);

			if (number[i]<100)		/* Again,the initialization is made to prevent*/
			{								/* the initial values of a and b (0) to be a  */
				a=-2;						/* a problem.*/
				b=-2;						/* This time -2 is used for initialization,because*/
			}								/* -1 was used before*/

			else if (number[i]<1000)
				a=-2;

			if (a==no2 || a==no3 || a==no4) /*minus control*/
				counterminus++;

			if (b==no1 || b==no3 || b==no4)
				counterminus++;

			if (c==no1 || c==no2 || c==no4)
				counterminus++;

			if (d==no1 || d==no2 || d==no3)
				counterminus++;

			if (counterminus!=minus_e)   /* if counterminus is not equal to
													  minus_e, the number does not match
													  the given minus number, so it is
													  eliminated. */

				number[i]=-1;							/*end of minus control*/

			else	/* if the number is not eliminated from minus control, */
			{		/* plus control starts for that number, again it is for performance*/

				if (a==no1)						/*plus control*/
					counterplus++;

				if (b==no2)
					counterplus++;

				if (c==no3)
					counterplus++;

				if (d==no4)
					counterplus++;

				if (counterplus!=plus_e)
					number[i]=-1;
			}										/*end of plus control*/
		}
		/* end of the number control and eliminaton*/
	}  /* end of for */
}     /* end of the function */
