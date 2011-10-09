/*CHESSMASTER PROGRAM*/
/*by Emin Senay*/
/*2002103907*/
#include <stdio.h>
main()
{

   char piece=' ',row=' ',column=' '; /*Main values*/
   char i,j;                          /*Temporary values*/
   printf("\nPlease enter your piece,column and row:\n");
   scanf(" %c %c %c%c",&piece,&column,&row,&i);
   if (column<'a')        /*Uppercase to lowercase converter for column*/
      column=column+32;   /*32 is ASCII code of 'a'(97) - ASCII code of 'A'(65)*/
   if (piece<'a')         /*Uppercase to lowercase converter for piece*/
      piece=piece+32;
			  /*Beginning of input control*/
   if (piece!='b'&& piece!='n'&& piece!='q'&& piece!='p'&& piece!='r'&& piece!='k')
   {
      printf("Wrong piece\n");
      return 0;                        /*Program ends here*/
   }
   if (column<'a' || column>'h')
   {
      printf("column outside range\n");
      return 0;                        /*Program end*/
   }
   if (row<'0' || row>'8' || i!=' ' && i!='\n')
   {
      printf("Row outside range\n");
      return 0;                        /*Program end*/
   }
				    /*End of input control*/
				    /*Beginning of the main program*/
   switch (piece)
   {
      case 'n':                     /*Beginning of knight */
      /*Code starts for column -+2 row -+1 moves*/
	 i=column-2;
	 j=row-1;
	 while (i<=column+2)
	 {
	    if (i>='a' && i<='h')        /*Controls the range of column*/
	    {
	       while (j<=row+1)
	       {
		  if (j>='1' && j<='8')      /*Controls the range of row*/
		     printf("%c%c ",i,j);
		  j=j+2;                     /*j becomes row+1*/

	       }
	    }
	    i=i+4;   /*i becomes column+2*/
	    j=row-1; /*Reset to the beginning value of j*/

	 }
     /*End of code for column -+2 row -+1 moves*/
     /*Code starts for column -+1 row -+2 moves*/
	 i=column-1;
	 j=row-2;
	 while (i<=column+1)
	 {
	    if (i>='a' && i<='h')     /*Controls the range of column*/
	    {
	       while (j<=row+2)
	       {
		  if (j>='1' && j<='8')     /*Controls the range of row*/
		     printf("%c%c ",i,j);
		  j=j+4;                    /*j becomes row+2*/

	       }
	    }
	    i=i+2;          /*i becomes column+1*/
	    j=row-2;        /*Reset to the second value of j*/

	 }
		       /*End of code for column -+1 row -+2 moves*/
	 break;            /*End of knight*/

      case 'q':       /*Beginning of queen and rook */
      case 'r':       /*Nested cases*/
	 i='a';           /*Program starts from the begining of column*/
	 while(i<='h')
	 {
	    if(i==column)   /*The main place of the queen or rook*/
	       i++;         /*Program passes the main place*/
	    printf("%c%c ",i,row);
	      i++;
	 }
	 i='1';             /*Program starts from the begining of row*/
	 while(i<='8')
	 {
	    if(i==row)      /*The main place of the queen or rook*/
	       i++;         /*Program passes the main place*/
	    printf("%c%c ",column,i);
	    i++;
	 }
	 if(piece=='r')     /*If piece is queen, program continues with bishop moves*/
	    break;          /*End of rook*/

      case 'b':         /*Beginning of bishop*/
	 i=column;
	 j=row;
	 while (i>'a'&& j>'1')  /*Program goes to the first column or row*/
	 {
	    i--;
	    j--;
	 }
	 while (i>='a' && i<='h' && j>='1'&& j<='8') /*For column+n row+n moves of bishop*/
	 {
	    if(i==column && j==row) /*The main place of the queen or bishop*/
	    {
	       i++;                 /*Program passes the main place*/
	       j++;
	       continue;
	    }
	    printf("%c%c ",i,j);
	    i++;
	    j++;
	 }
	 i=column;
	 j=row;
	 while (i<'h' && j>'1')    /*Program goes to the first row or last column*/
	 {
	    i++;
	    j--;
	 }
	 while (i>='a' && i<='h' && j>='1'&& j<='8') /*For column-n row+n moves of bishop*/
	 {
	    if(i==column && j==row)  /*The main place of queen or bishop*/
	    {
	       i--;                  /*Program passes the main place*/
	       j++;
	       continue;
	    }
	    printf("%c%c ",i,j);
	    i--;
	    j++;
	 }
	    break;                    /*End of queen and bishop */
   case 'p':                      /*Begining of pawn*/
      if(row+1<='8')
      {
	 printf("%c%c ",column,row+1);
	 if (row=='2')
	    printf("%c%c ",column,row+2);
      }
      else
      printf("Pawn can not move further");
      break;                                  /*End of pawn*/
   case 'k':                                  /*Begining of king*/
      for(i=column-1; i<=column+1; i++)
      {
	 if(i<='h' && i>='a')                     /*Column range control*/
	 {
	    for(j=row-1; j<=row+1; j++)
	    {
	       if(j<='8' && j>='1')              /*Row range control*/
	       {
		  if(i==column && j==row)            /*The main place of the king*/
		     continue;                       /*Loop starts again so row changes*/
		  printf("%c%c ",i,j);
	       }
	    }
	 }
      }
      break;
   }                        /*End of switch*/
   return 0;
}                          /*End of the program*/
