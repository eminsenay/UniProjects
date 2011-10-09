//Student id: 2002103907
//Name : Emin Senay

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <conio.h>
#include <ctype.h>

typedef struct 
{
	char typeID[20];
	int numRowsInEco;
	int numRowsInFirst;
}planeType;

typedef struct
{
	int flightID;
	char typeID[20];
	int hour;
	int *ecoSeatPlan[6];
	int *firstSeatPlan[4];
}flight;

int insert_plane(char plane_id[20]);
void display_planes();
int insert_flight(int flight_id);
void display_help();
int make_reservation(int flight_id);
void display_flight();
void correct_word (char *lowercase);
int is_digit(char *a);
int open_once(char *filename);

int main()
{
	char select[2], id[20];
	int i=0,j=0;

	if(open_once("seatPlan.dat")==0) //Open all of the files once to ensure that all of the files exist
	{
		printf("There is an error opening the 'seatPlan.dat' file. \n Program is terminating...\n");
		return 0;
	}
	if(open_once("planeType.dat")==0)
	{
		printf("There is an error opening the 'planeType.dat' file. \n Program is terminating...\n");
		return 0;
	}
	if(open_once("flight.dat")==0)
	{
		printf("There is an error opening the 'flight.dat' file. \n Program is terminating...\n");
		return 0;
	}

	while(1)
	{
		printf(">>");
		scanf("%s",select);
		correct_word(select);
		if (strcmp(select,"H")==0)			//help
		{	
			display_help();
			continue;
		}
		else if (strcmp(select,"Ip")==0)	//insert plane
		{
			scanf("%c",&id[0]);				//checks if the other command is entered or not
			while(id[0]=='\n' || id[0]==' ' || id[0]=='\t')
			{
				if (id[0]=='\n')
					printf("Waiting for a command.\n");
				scanf("%c",&id[0]);
			}
			i=1;
			while(id[i-1]!='\n' && id[i-1]!=' ' && id[i-1]!='\t')
			{
				scanf("%c",&id[i]);
				i++;
			}
			id[i-1]='\0';
			correct_word(id);
			insert_plane(id);
		}
		else if (strcmp(select,"Dp")==0)	//display planes
			display_planes();
		else if (strcmp(select,"If")==0)	//insert flight
		{
			scanf("%c",&id[0]);				//checks if the other command is entered or not
			while(id[0]=='\n' || id[0]==' ' || id[0]=='\t')
			{
				if (id[0]=='\n')
					printf("Waiting for a command.\n");
				scanf("%c",&id[0]);
			}
			i=1;
			while(id[i-1]!='\n' && id[i-1]!=' ' && id[i-1]!='\t')
			{
				scanf("%c",&id[i]);
				i++;
			}
			id[i-1]='\0';

			while(!(i=is_digit(id)))		//integer check
			{
				printf("The input is not valid. Please enter again: ");
				fflush(stdin);
				scanf("%s",id);
			}
			insert_flight(i);
		}
		else if (strcmp(select,"Df")==0)	//display flight
			display_flight();
		else if (strcmp(select,"R")==0)		//reservation
		{
			scanf("%c",&id[0]);				//checks if the other command is entered or not
			while(id[0]=='\n' || id[0]==' ' || id[0]=='\t')
			{
				if (id[0]=='\n')
					printf("Waiting for a command.\n");
				scanf("%c",&id[0]);
			}
			i=1;
			while(id[i-1]!='\n' && id[i-1]!=' ' && id[i-1]!='\t')
			{
				scanf("%c",&id[i]);
				i++;
			}
			id[i-1]='\0';
			while(!(i=is_digit(id)))		//integer check
			{
				printf("The input is not valid. Please enter again: ");
				fflush(stdin);
				scanf("%s",id);
			}
			make_reservation(i);
		}
		else if (strcmp(select,"Q")==0)		//quit
		{
			printf("Bye...\n");
			break;
		}
		else								//if the command is invalid
			printf("Please enter a valid command. For help, enter 'H'.\n");
	}
	return 0;
}

int insert_plane(char plane_id[20])
{
	FILE *fp;
	planeType newPlane;
	planeType temp;
	char control[3];
	int i=0;

	if((fp=fopen("planeType.dat","r+b"))==NULL) //needed file opening
		{
			printf("There's an error opening the file planeType.dat .\n");
			return 0;
		}
	while(!feof(fp))//input control
	{
		fread(&temp,sizeof(planeType),1,fp); 
		if(!strcmp(plane_id,temp.typeID))
		{
			printf("This plane is inserted before.\n");
			return 0;
		}
	}
	strcpy(newPlane.typeID,plane_id);

	printf("Enter the number of rows in First Class: "); //getting the # of rows in economy and first class and controlling
	fflush(stdin);										 // whether they are integers or not.
	scanf("%s",control);
	while(!(newPlane.numRowsInFirst=is_digit(control)))
	{
		printf("The input is not valid. Please enter again: ");
		fflush(stdin);
		scanf("%s",control);
	}

	printf("Enter the number of rows in Economy Class: ");
	fflush(stdin);
	scanf("%s",control);
	while(!(newPlane.numRowsInEco=is_digit(control)))
	{
		printf("The input is not valid. Please enter again: ");
		fflush(stdin);
		scanf("%s",control);
	}

	fwrite(&newPlane,sizeof(planeType),1,fp);			//writing to the file
	printf("New plane type is recorded...\n");
	fclose(fp);
	return 0;											//end of function
}

void display_planes()
{
	planeType *sort;
	planeType temp;
	int i=0,j=0,pass=1;
	FILE *fp;
	
	if((fp=fopen("planeType.dat","r+b"))==NULL)			//needed file opening
		printf("planeType.dat can not be opened.\n");
	else
	{
		while(!feof(fp))								//finds how many types of planes there were in the database
		{
			if((fread(&temp,sizeof(planeType),1,fp))==0)
				break;
			i++;
		}

		sort=(planeType*)malloc(i*sizeof(planeType));

		rewind(fp);
		
		printf("There are %d types of planes: \n",i);
		i--;
		j=i;
		while(i>=0)											//preparing sort array for the sorting operation
		{
			if((fread(&sort[i],sizeof(planeType),1,fp)==0))
				break;
			i--;
		}

		i=j+1;
		for(pass=1;pass<=i-1;pass++)						//Bubble sort
			for(j=0;j<=i-2;j++)
				if((strcmp(sort[j].typeID,sort[j+1].typeID)==-1))
				{
					strcpy(temp.typeID,sort[j].typeID);
					temp.numRowsInEco=sort[j].numRowsInEco;
					temp.numRowsInFirst=sort[j].numRowsInFirst;
					strcpy(sort[j].typeID,sort[j+1].typeID);
					sort[j].numRowsInEco=sort[j+1].numRowsInEco;
					sort[j].numRowsInFirst=sort[j+1].numRowsInFirst;
					strcpy(sort[j+1].typeID,temp.typeID);
					sort[j+1].numRowsInEco=temp.numRowsInEco;
					sort[j+1].numRowsInFirst=temp.numRowsInFirst;
				}
		i--;
		fclose(fp);
		if((fp=fopen("planeType.dat","wb"))==NULL)			//The database is recreated and written with sorted data for	
			printf("planeType.dat can not be opened.\n");	//efficiency.
		else
		{	while(i>=0)
			{
				fwrite(&sort[i],sizeof(planeType),1,fp);
				printf("TypeID: %-9s, # of Rows In First Class:%2d, # of Rows In Economic Class:%2d\n",
						sort[i].typeID, sort[i].numRowsInFirst, sort[i].numRowsInEco);
				i--;
			}

			fclose(fp);
			free(sort);
		}
	}
	
}					//end of display_planes function

int insert_flight(int flight_id)
{
	FILE *plane,*fly;
	planeType temp1;
	flight newPlane,temp2;
	int hourControl=100, minuteControl=100;

	newPlane.flightID=flight_id;

	if((plane=fopen("planeType.dat","rb"))==NULL)  //opening needed files
		{
			printf("There's an error opening the file planeType.dat.\n");
			return 0;
		}
	if((fly=fopen("flight.dat","r+b"))==NULL)
		{
			printf("There's an error opening the file flight.dat .\n");
			return 0;
		}

	while(!feof(fly))							//flightID control
	{
		fread(&temp2,sizeof(flight),1,fly); 
		if(newPlane.flightID==temp2.flightID)
		{
			printf("This ID is used in another flight.\n");
			return 0;
		}
	}


	printf("Enter the ID of the type of the plane: ");
	scanf("%s",newPlane.typeID);
	correct_word(newPlane.typeID);

	while(!feof(plane))							//plane TypeID control
	{
		fread(&temp1,sizeof(planeType),1,plane); 
		if(!strcmp(newPlane.typeID,temp1.typeID))
			break;
		else
			continue;
	}
	
	if (strcmp(newPlane.typeID,temp1.typeID))
	{
		printf("This plane type does not exists!\n");
		return 0;
	}
	fflush(stdin);
	while(hourControl<0 || hourControl>23 || minuteControl<0 || minuteControl>59) //hour control
	{
		printf("Enter the hour of the flight: ");
		scanf("%d:%d",&hourControl,&minuteControl);
		if(hourControl<0 || hourControl>23 || minuteControl<0 || minuteControl>59)
			printf("Time you entered is not valid.It must be between 0:00 and 23:59 and\nyou must enter the time as 'hh:mm'.\n",hourControl,minuteControl);
	}
	newPlane.hour=hourControl*100+minuteControl;
	fwrite(&newPlane,sizeof(flight),1,fly);
	printf("New flight is recorded...\n");
	fclose(fly);
	fclose(plane);
	return 0;
}
	
void display_help()
{
	printf("Available commands:\n\nH              :Displays this help menu.\n\nIP <type ID>   :It is used to insert planes."); 
	printf("You must write a type identifier of \t\tthe plane after IP.\n\nDP             :It is used for displaying inserted ");
	printf("planes.\n\nIF <flight ID> :It is used to insert flights. You must write a flight identifier\t\tof the flight after");
	printf("IF.\n\nDF             :It is used for displaying flights and available seats.\n\nR <flight ID>  :It is used to"); 
	printf("make a reservation. You must use the flight\t\t\tidentifier of the flight in which you want to reserve seat.\n\n");
	printf("Q              :It is used to quit the program.\n\n");
}

int make_reservation(int flight_id)
{
	FILE *plane,*fly,*plan;
	flight reservation,tempf;
	planeType selectedp,tempp;
	int i=-1,j,k,l=0,ticket,countfirst=0,counteco=0,choice;
	char answer,seatLetter='A';
	char *seat, control[5];
	int *num;
	
	if((plan=fopen("seatPlan.dat","r+b"))==NULL)    //opening the needed databases
	{
		printf("There is an error opening the seatPlan.dat file.\n");
		return 0;
	}


	if((fly=fopen("flight.dat","rb"))==NULL)
	{
		printf("There is an error opening the flight.dat file.\n");
		return 0;
	}


	if((plane=fopen("planeType.dat","rb"))==NULL)
	{
		printf("There is an error opening the planeType.dat file.\n");
		return 0;
	}

	while(!feof(fly))							//searching the entered flightID in the database
	{
		fread(&reservation,sizeof(flight),1,fly);
		if(reservation.flightID==flight_id)
			break;
	}
	if(reservation.flightID!=flight_id)
	{
		printf("Wrong flightID!\n");
		return 0;
	}
	while(!feof(plane))							//Searching the plane in planeType database to get #of rows in the classes
	{
		fread(&selectedp,sizeof(planeType),1,plane);
		if(strcmp(selectedp.typeID,reservation.typeID)==0)
			break;
	}

	for(i=0;i<6;i++)							//preparing seatplan arrays for storing seat plans
		reservation.ecoSeatPlan[i]=(int*)malloc((selectedp.numRowsInEco)*sizeof(int));
	for(i=0;i<4;i++)
		reservation.firstSeatPlan[i]=(int*)malloc((selectedp.numRowsInFirst)*sizeof(int));


	rewind(plan);
	while(!feof(plan))							//Searching the reservation information in the seatPlan database.
	{
		if((fread(&i,sizeof(int),1,plan))==0)
			break;
		if (i==reservation.flightID)
		{
			for(j=0;j<selectedp.numRowsInFirst;j++)
				for(k=0;k<4;k++)
				{
					if((fread(&l,sizeof(int),1,plan))==0)
						printf("Error!");
					reservation.firstSeatPlan[k][j]=l;
				}
			for(j=0;j<selectedp.numRowsInEco;j++)
				for(k=0;k<6;k++)
					fread((&(reservation.ecoSeatPlan)[k][j]),sizeof(int),1,plan);
			break;
		}
		rewind(fly);
		while(!feof(fly))
		{
			fread(&tempf,sizeof(flight),1,fly);
			if (tempf.flightID==i)
			{
				rewind(plane);
				while(!feof(plane))
				{
					fread(&tempp,sizeof(planeType),1,plane);
					if (tempf.typeID==tempp.typeID)
						fseek(plan,(tempp.numRowsInEco+tempp.numRowsInFirst)*sizeof(int),SEEK_CUR);
				}
			}
		}
	}//reservation information is now found

	if(i!=reservation.flightID)						//If function can not find the reservation information, it creates one
	{
		fseek(plan,0,SEEK_END);						//on the seatPlan.dat flie
		fwrite(&reservation.flightID,sizeof(int),1,plan);

		for(j=0;j<selectedp.numRowsInFirst;j++)
			for(k=0;k<4;k++)
				fwrite(&l,sizeof(int),1,plan);
		for(j=0;j<selectedp.numRowsInEco;j++)
			for(k=0;k<6;k++)
				fwrite(&l,sizeof(int),1,plan);
		for(j=0;j<selectedp.numRowsInFirst;j++)
			for(k=0;k<4;k++)
				reservation.firstSeatPlan[k][j]=0;
		for(j=0;j<selectedp.numRowsInEco;j++)
			for(k=0;k<6;k++)
				reservation.ecoSeatPlan[k][j]=0;
	}
	
	printf("How many tickets do you want? ");		
	fflush(stdin);
	scanf("%s",control);							//Integer control
	while(!(ticket=is_digit(control)))
	{
		printf("The input is not valid. Please enter again: ");
		fflush(stdin);
		scanf("%s",control);
	}

	for(i=0;i<4;i++)								//counting the # of available seats
		for(j=0;j<selectedp.numRowsInFirst;j++)
			if((reservation.firstSeatPlan)[i][j]==0)
				countfirst++;
	counteco=0;
	for(i=0;i<6;i++)
		for(j=0;j<selectedp.numRowsInEco;j++)
			if((reservation.ecoSeatPlan)[i][j]==0)
				counteco++;

	if(countfirst<ticket && counteco<ticket)
	{
		printf("Not enough seats in Economic Class and First Class!\n");
		return 0;
	}
	else if(countfirst<ticket)
	{
		printf("Not enough seats in First Class!\nDo you want a seat from Economic Class? (Y/N) ");
		fflush(stdin);
		scanf("%c",&answer);
		if (answer!='Y' && answer!='y')
			return 0;
		else
			choice=1;
	}
	else if(counteco<ticket)
	{
		printf("Not enough seats in Economic Class!\nDo you want a seat from First Class?(Y/N) ");
		fflush(stdin);
		scanf("%c",&answer);
		if (answer!='Y' && answer!='y')
			return 0;
		else
			choice=2;
	}
	else
		while(1)
		{
			printf("Select your class:\n1) Economic Class\n2) First Class\nChoice>> ");
			scanf("%d",&choice);
			if(choice!=1 && choice!=2)
				printf("Please select 1 or 2.\n");
			else 
				break;
		}

	seat=(char*)malloc(ticket*sizeof(char));
	num=(int*)malloc(ticket*sizeof(int));

	printf("Please select your seats by giving the seat letter and seat number\nA * show that the seat is full:\n\n");

	if(choice==2) //First class
	{
		for(i=0;i<selectedp.numRowsInFirst;i++) //drawing the first class seat plan
		{
			for(j=0;j<4;j++)
			{
				if(j==2)
					printf("-  ");
				printf("%c%d",seatLetter,j+1);
				if ((reservation.firstSeatPlan)[j][i]==1) //if the seat is reserved before
					printf("*  ");
				else
					printf("   ");
			}
			seatLetter++;
			printf("\n");
		}
		printf("\n\n");
		for(k=0;k<ticket;k++)						//asking seats
		{
			while(1)
			{
				printf("Seat%d>> ",k+1);
				fflush(stdin);
				scanf("%c %d",&seat[k],&num[k]);
				if(seat[k]>='a' && seat[k]<='z')
					seat[k]=seat[k]-('a'-'A');
				i=seat[k]-'A'+0;
				if(seat[k]>=seatLetter || num[k]>4 || num[k]<1)	//input check
				{
					printf("Wrong input!\n");
					continue;
				}
				else if (reservation.firstSeatPlan[num[k]-1][i]==1)	//checking the reserved seats
				{
					printf("%c%d is full, please select another seat!\n",seat[k],num[k]);
					continue;
				}
				else											//again input check
				{
					for(l=0;l<k;l++)
						if(seat[l]==seat[k] && num[k]==num[l])
							printf("You selected %c%d before, please select another seat!\n",seat[k],num[k]);						
					if(seat[l-1]==seat[k] && num[k]==num[l-1])
						continue;
				}
				break;
			}
		}
	}
	else if(choice==1)		//Economic class
	{	
		seatLetter+=selectedp.numRowsInFirst;	//drawing the economic class seat plan
		for(i=0;i<selectedp.numRowsInEco;i++)
		{
			for(j=0;j<6;j++)
			{
				if(j==3)
					printf("-  ");
				printf("%c%d",seatLetter,j+1);
				if ((reservation.ecoSeatPlan)[j][i]==1)	//if the seat is reserved before
					printf("*  ");
				else
					printf("   ");
			}
			seatLetter++;
			printf("\n");
		}
		printf("\n\n");
		for(k=0;k<ticket;k++)							//asking seats
			while(1)
			{
				printf("Seat%d>> ",k+1);
				fflush(stdin);
				scanf("%c%d",&seat[k],&num[k]);
				if(seat[k]>='a' && seat[k]<='z')
					seat[k]=seat[k]-('a'-'A');
				i=seat[k]-'A'+0-selectedp.numRowsInFirst;
				if(seat[k]>=seatLetter || seat[k]<seatLetter-(selectedp.numRowsInEco) || num[k]>6 || num[k]<1) //input check
				{
					printf("Wrong input!\n");
					continue;
				}
				else if (reservation.ecoSeatPlan[num[k]-1][i]==1)  //checking the reserved seats
				{
					printf("%c%d is full, please select another seat!\n",seat[k],num[k]);
					continue;
				}
				else
				{
					for(l=0;l<k;l++)
						if(seat[l]==seat[k] && num[k]==num[l])		//again input check
							printf("You selected %c%d before, please select another seat!\n",seat[k],num[k]);
					if(seat[l-1]==seat[k] && num[k]==num[l-1])
						continue;
				}
				break;
			}
	}
	for(k=0;k<ticket;k++)		//writing the reserved seats to the reservation array
	{
		if (choice==2)
		{
			i=seat[k]-'A'+0;
			reservation.firstSeatPlan[num[k]-1][i]=1;	
		}
		else if (choice==1)
		{
			i=seat[k]-'A'+0-selectedp.numRowsInFirst;
			reservation.ecoSeatPlan[num[k]-1][i]=1;	
		}
	}

	rewind(plan);
	rewind(fly);
	rewind(plane);

	while(!feof(plan))					//writing reserved seats to the reservation database
	{
		fread(&i,sizeof(int),1,plan);
		if (i==reservation.flightID)
		{
			fseek(plan,0,SEEK_CUR);
			for(j=0;j<selectedp.numRowsInFirst;j++)
				for(k=0;k<4;k++)
				{
					l=reservation.firstSeatPlan[k][j];
					if((fwrite(&l,sizeof(int),1,plan))==0)
						printf("!\n");
				}
			for(j=0;j<selectedp.numRowsInEco;j++)
				for(k=0;k<6;k++)
					fwrite((&(reservation.ecoSeatPlan)[k][j]),sizeof(int),1,plan);
			break;
		}
		else
		{
			rewind(fly);
			while(!feof(fly))
			{
				fread(&tempf,sizeof(flight),1,fly);
				if (tempf.flightID==i)
				{
					rewind(plane);
					while(!feof(plane))
					{
						fread(&tempp,sizeof(planeType),1,plane);
						if (tempf.typeID==tempp.typeID)
							fseek(plan,(tempp.numRowsInEco+tempp.numRowsInFirst)*sizeof(int),SEEK_CUR);
					}
				}
			}
		}
	}

	printf("Your reservation is completed.\nFlight information:\nFlight ID: %d Plane type: %s Time: %d:%d Seats: ",
		    reservation.flightID,selectedp.typeID,(reservation.hour)/100,(reservation.hour)%100);
	for(k=0;k<ticket;k++)
		printf("%c%d ",seat[k],num[k]);
	printf("\n");

	for(i=0;i<6;i++)
		free(reservation.ecoSeatPlan[i]);
	for(i=0;i<4;i++)
		free(reservation.firstSeatPlan[i]);

	fclose(plane);
	fclose(plan);
	fclose(fly);
	free(num);
	return 0;
}
	
void correct_word (char *word)
{
	int i=0;

	if(word[i]>='a' && word[i]<='z')
			word[i]=word[i]-('a'-'A');
		i++;

	while (word[i]!='\0')
	{
		if(word[i]>='A' && word[i]<='Z')
			word[i]=word[i]+('a'-'A');
		i++;
	}
}

void display_flight()
{
	FILE *fly;
	flight temp, *display;
	int i=0,j=0;
	int count=0;

	if((fly=fopen("flight.dat","r"))==NULL)			//needed file opening
		printf("There is an error opening the flight.dat file.\n");
	else
	{
		while(!feof(fly))							//counting the # of flights
		{
			if((fread(&temp,sizeof(flight),1,fly))==0)
				break;
			count++;
		}
		printf("There are %d scheduled flights\n",count);

		display=malloc(count*sizeof(flight));

		rewind(fly);								//prepairing the display array for sorting
		while(!feof(fly))
		{
			if((fread(&display[i],sizeof(flight),1,fly))==0)
				break;
			i++;
		}

		for(j=0;j<=count-1;j++)
			for(i=0;i<=count-2;i++)
				if(display[i].hour>display[i+1].hour)
				{
					temp.flightID=display[i].flightID;
					display[i].flightID=display[i+1].flightID;
					display[i+1].flightID=temp.flightID;
					temp.hour=display[i].hour;
					display[i].hour=display[i+1].hour;
					display[i+1].hour=temp.hour;
					strcpy(temp.typeID,display[i].typeID);
					strcpy(display[i].typeID,display[i+1].typeID);
					strcpy(display[i+1].typeID,temp.typeID);
				}

		fclose(fly);
		if((fly=fopen("flight.dat","wb"))==NULL)	    //The database is recreated and written with sorted data for	
			printf("flight.dat can not be opened.\n");	//efficiency.
		else
		{	
		    for(i=0;i<count;i++)
			{
				fwrite(&display[i],sizeof(flight),1,fly);
				printf("FlightID: %-4d Type ID: %-9s Time: %d:%d\n",display[i].flightID,display[i].typeID,(display[i].hour)/100,(display[i].hour)%100);
			}

			fclose(fly);
		}

		free(display);
	}
}

int is_digit(char *a)
{
	int i=0,j=0;

	while(a[i]!='\0')
	{
		if(!isdigit(a[i]))
			return 0;
		else
		{
			j=10*j+(a[i]-48);
			i++;
		}
	}
	return j;
}

int open_once(char *filename)
{
	FILE *fp;
	int i=1;
	if((fp=fopen(filename,"r+b"))==NULL)
		if((fp=fopen(filename,"w+b"))==NULL)
			i=0;
	fclose(fp);
	return i;
}


		





