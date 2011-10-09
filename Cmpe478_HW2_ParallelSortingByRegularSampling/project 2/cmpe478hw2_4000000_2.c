/**
Emin Senay - 2002103907
Cmpe 478 HW2 - Parallel Sorting by Regular Sampling	

Creates a random integer array and sorts this array using parallel sorting by regular sampling algorithm written in C and MPI.

Compilation: mpicc -o cmpe78hw2.o cmpe78hw2.c
Running: mpirun -np number_of_processors ./cmpe478hw2.o [size_of_array] [step_7_version] [program_running_type]
number_of_processors: The number of processors of the algorithm running onto
size_of_array: Number of elements in the initial array to be sorted. Default value is 1000. If program_running_type is 0, each processor creates an array of size_of_array 
step_7_version: There are different versions of step 7 (explanation can be found in comments). This value specifies the version. It can be 1,2,3 or 4. Default is 1.
program_running_type: If set to 0, processors create the random numbers themselves instead of root processor creating and sending to the other processors.
If the option on the right would like to be given, options right of it sholud also be given. For example, if you want to specify program_running_type, you should also specify the size_of_array and step_7_version.
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>

int N = 4000000;
int step7Version = 2;

void createRandomArray(int *theList, int listSize, int numberOfDummyElems, int maxRand,int mypid);
void distributeList(int mypid, int numprocs, int w, int *theList, int *subList);
int compare (const void * a, const void * b);
int myBinarySearch(int *subList, int value, int sizeOfList);
void divideList_old(int w, int numprocs, int *subList, int *splitterList, int *sendCountList);
void divideList(int w, int numprocs, int *subList, int *splitterList, int *sendCountList);
void fillDisplacementArray(int numprocs, int *countArray, int *dispArray);
int runVersion1_1(int numprocs, int *sendCountList, int *receiveCountList);
void runVersion1_2(int numprocs, int *subList, int *sendCountList, int *receiveCountList, int *receiveDisplacementList, int *subList2);
int runVersion2_1(int numprocs, int mypid, int *sendCountList, int *receiveCountList);
//void runVersion3_2(int mypid, int numprocs, int *subList, int *sendCountList, int *receiveCountList, int *receiveDisplacementList, int *subList2, FILE *fp);
void runVersion3_2(int mypid, int numprocs, int *subList, int *sendCountList, int *receiveCountList, int *receiveDisplacementList, int *subList2);
void merge(int *a,int *b, int *c, int sizeOfA, int sizeOfB);
void mergesubLists(int *receiveCountList, int *receiveDisplacementList, int numprocs, int *subList2);
int getNumberOfReceives(int numprocs, int *receiveCountList);
void printArray(int *arr, int size, char* name);
void printArray1(int *arr, int size, int mypid, char* name);
void checkSorted(int *theList, int listSize);
void isEqual(int *list1, int *list2, int size);
void printArraytoFile(int *arr, int size, char* name, FILE *fp);

/**Main function*/
int main(int argc, char** argv)
{
	int mypid, numprocs;
	int *theList, *subList, *subList2;
	int i;
	int w; //length of subList
	int numberOfDummyElems;
	int *sampleList, *gatheredList, *splitterList;
	int *sendCountList, *receiveCountList, *receiveDisplacementList;
	int subList2Size, *subList2SizeList, *subList2DisplacementList;
	int maxRand = 10 * N;
	//FILE *fp;
	char outputfile[15];
	double startTime, endTime;
	int progRunningType = 0;
	double maxTime, *elapsedTimeList;	
/*	
	if (argc > 1)
		N = atoi(argv[1]);
	if (argc > 2)
		step7Version = atoi(argv[2]);
	if (step7Version < 1 || step7Version > 4)
		step7Version = 1;
	if (argc > 3)
		progRunningType = atoi(argv[3]);
	if (progRunningType != 0)
		progRunningType = 1;
*/
	// MPI Initializations
	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD,&mypid);
	MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
	
	elapsedTimeList = (double *) malloc(numprocs * sizeof(double)); 
	
	// Create a different file for each processor. Used for debugging reasons
	//strcpy (outputfile,"output");
	//outputfile[6] = mypid + ('0' - 0);
	//outputfile[7] = '\0';
	
	//printf("outputfile : %s\n",outputfile);
	//fp=fopen(outputfile, "w");
	
	if (progRunningType == 0) // Each processor creates its own random array
	{
		w = N;
		N = numprocs * w;
		maxRand = 10 * N;
		numberOfDummyElems = 0;
	}
	else
	{
		numberOfDummyElems = (numprocs - (N % numprocs)) % numprocs;
		w = (N + numberOfDummyElems) / numprocs;
	}
	theList = (int *) malloc((N + numberOfDummyElems) * sizeof(int));
	subList = (int *) malloc(w * sizeof(int));

	// Step 0: Randomization and distribution of the list
	if (progRunningType == 0) // Each processor creates its own random array
	{
		if (mypid == 0)
		{
			printf("Creating random integers\n");
		}	
		createRandomArray(subList, w, numberOfDummyElems, maxRand, mypid);
	}
	else
	{
		if (mypid == 0)
		{
			printf("Creating random integers\n");
			createRandomArray(theList, N, numberOfDummyElems, maxRand,mypid);
		}
		distributeList(mypid, numprocs, w, theList, subList);
	}
	// End of step 0
	
	// Start time
	startTime = MPI_Wtime();
	// Step 1: Each processor will sort their sublists with sequential quicksort algorithm
	qsort (subList, w, sizeof(int), compare);
	//if (mypid == 0) printf("w: %d\n",w);
	//printArraytoFile(subList, w, "subList",fp);
	//checkSorted(subList,w);
	// End of step 1
	// Step 2: Each processor selects a "regular sample" of size numprocs-1 from the locally sorted list.
	if (numprocs > 1)
	{
		sampleList = (int *) malloc((numprocs - 1) * sizeof(int));
		for (i = 0; i < numprocs - 1; i++)
		{
			sampleList[i] = subList[((i+1)*w)/numprocs];
		}
		// End of step 2
		
		// Step 3: Regular samples are gathered onto a single processor. This list of p(p-1) samples are then sorted
		if (mypid == 0)
		{
			gatheredList = (int *) malloc((numprocs * (numprocs - 1)) * sizeof(int));
		}
		MPI_Gather(sampleList, (numprocs - 1), MPI_INT, gatheredList, (numprocs - 1), MPI_INT, 0, MPI_COMM_WORLD);
		free(sampleList);
		if (mypid == 0)
		{
			qsort(gatheredList, numprocs * (numprocs - 1), sizeof(int), compare);
		}
		// End of step 3
		
		// Step 4: Pick p-1 splitters (again regularly)
		splitterList = (int *) malloc((numprocs - 1) * sizeof(int));
		if (mypid == 0)
		{	
			for (i = 0; i < numprocs - 1; i++)
			{
				splitterList[i] = gatheredList[(i * numprocs) + numprocs / 2];
			}
			free(gatheredList);
		}
		// End of step 4
		
		// Step 5: Broadcast these splitters to the rest of the processors
		MPI_Bcast(splitterList, numprocs -1, MPI_INT, 0, MPI_COMM_WORLD);
		// End of step 5
	}
	// Step 6: Each processor divides its sorted list based on splitters
	sendCountList = (int *)calloc(numprocs, sizeof(int));
	if (numprocs == 1)
	{
		sendCountList[0] = N;
	}
	else
	{
		divideList(w, numprocs, subList, splitterList, sendCountList);
		free(splitterList);
	}
	// End of step 6

	// Step 7: The p sorted sublists are then sent to the responsible processors
	switch (step7Version)
	{
		case 1: // Step 7 Version 1
			receiveDisplacementList = (int *) malloc(numprocs * sizeof(int));
			receiveCountList = (int *) malloc(numprocs * sizeof(int));
			i = runVersion1_1(numprocs, sendCountList, receiveCountList);
			subList2 = (int *) malloc(i * sizeof(int));
			runVersion1_2(numprocs, subList, sendCountList, receiveCountList, receiveDisplacementList, subList2);
			free(subList);
			free(sendCountList);
			break; // End of Step 7 Version 1
		case 2: //Step 7 Version 2
			receiveDisplacementList = (int *) malloc(numprocs * sizeof(int));
			receiveCountList = (int *) malloc(numprocs * sizeof(int));
			i = runVersion2_1(numprocs, mypid, sendCountList, receiveCountList);
			subList2 = (int *) malloc(i * sizeof(int));
			// Second part of the version 2 is the same as second part of the version 1
			runVersion1_2(numprocs, subList, sendCountList, receiveCountList, receiveDisplacementList, subList2);
			free(subList);
			free(sendCountList);
			break; // End of Step 7 Version 2
		case 3: //Step 7 Version 3
			receiveDisplacementList = (int *) malloc(numprocs * sizeof(int));
			receiveCountList = (int *) malloc(numprocs * sizeof(int));
			// First part of the version 3 is the same as first part of the version 2
			i = runVersion2_1(numprocs, mypid, sendCountList, receiveCountList);
			subList2 = (int *) malloc(i * sizeof(int));
			runVersion3_2(mypid, numprocs, subList, sendCountList, receiveCountList, receiveDisplacementList, subList2);
			//printArraytoFile(subList2,i,"subList2",fp);
			free(subList);
			free(sendCountList);
			break; // End of Step 7 Version 3
		case 4: //Step 7 Version 4
			break; // End of Step 7 Version 4
	}
	// End of Step 7	
	
	// Step 8: Sorted sublists are then merged into a sorted list
	subList2Size = getNumberOfReceives(numprocs, receiveCountList);
	mergesubLists(receiveCountList, receiveDisplacementList, numprocs, subList2);
	free(receiveCountList);
	free(receiveDisplacementList);
	// End of step 8

	// Get time again
	endTime = MPI_Wtime();
	// Step 9: Each sorted list are sent to the root processor
	//if (mypid == 0) printArraytoFile(theList,N,"initial List",fp);
	subList2SizeList = (int *) malloc(numprocs * sizeof(int));
	MPI_Gather(&subList2Size, 1, MPI_INT, subList2SizeList, 1, MPI_INT, 0, MPI_COMM_WORLD);
	subList2DisplacementList = (int *) malloc(numprocs * sizeof(int));
	fillDisplacementArray(numprocs, subList2SizeList, subList2DisplacementList);
	MPI_Gatherv(subList2, subList2Size, MPI_INT, theList, subList2SizeList, subList2DisplacementList, MPI_INT, 0, MPI_COMM_WORLD);	
	// End of step 9	

	//if(mypid == 0) printArraytoFile(theList2,N,"sorted List",fp);
	//printArraytoFile(subList2, subList2Size, "SubList2",fp);
	//if(mypid == 0) checkSorted(theList, N);
	//if(mypid == 0) isEqual(theList, theList2,N);
	//fclose(fp);
	elapsedTimeList[0] = endTime - startTime;
	MPI_Gather(elapsedTimeList, 1, MPI_DOUBLE, elapsedTimeList, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
	for (i = 0; i < numprocs; i++)
	{
		if (maxTime < elapsedTimeList[i])
			maxTime = elapsedTimeList[i];
	}
	if (mypid == 0)
		printf("Elapsed time: %f seconds\n",maxTime);
	MPI_Finalize();
	return 0;
} 

/**Fills the given array of size N with random integers smaller than maxRand.*/
void createRandomArray(int *theList, int listSize, int numberOfDummyElems, int maxRand, int mypid)
{
	int i;
	srand(time(NULL));
	//srand(mypid);
	for (i = 0; i < listSize; i++)
	{
		theList[i] = rand() % maxRand;
	}
	for (i = 0; i < numberOfDummyElems; i++)
	{
		theList[listSize + i] = maxRand + 1;
	}
}

/**Copies the main list to each processor's sublist.*/
void distributeList(int mypid, int numprocs, int w, int *theList, int *subList)
{
	int i;
	MPI_Request *request, request2;
	MPI_Status status;
	
	request = (MPI_Request*) malloc(numprocs * sizeof(MPI_Request));
	if (mypid == 0) // copy the first w elements to the subList, send the other elements to other processors
	{
		printf("Sending sublists to processors\n");
		for (i = 1; i < numprocs; i++)
		{
			MPI_Isend(&(theList[i*w]), w, MPI_INT, i, 1, MPI_COMM_WORLD, &(request[i]));
		}
		for (i = 0; i < w; i++)
		{
			subList[i] = theList[i];
		}
		for (i = 1; i < numprocs; i++)
		{
			MPI_Wait(&(request[i]),&status);
		}
	}
	else
	{
		MPI_Irecv(subList, w, MPI_INT, 0, MPI_ANY_TAG, MPI_COMM_WORLD, &request2);
		MPI_Wait(&request2,&status);
	}
	free (request);
}

/**Comparator function to be used by qsort*/
int compare (const void * a, const void * b)
{
  return ( *(int*)a - *(int*)b );
}

/**Divides given sorted list (subList) based on the integers in the splitterList array. 
  *Number of elements between two splitters are then written to sendCountList array. 
  *The first element of the sendCountList array is the number of elements smaller than or equal to the first splitter.
  *There are numprocs - 1 elements in splitterList, and w elements in subList
  */
void divideList_old(int w, int numprocs, int *subList, int *splitterList, int *sendCountList)
{
	int i;
	int j = 0;
	for (i = 0; i < w; i++)
	{
		if (subList[i] <= splitterList[j])
		{
			sendCountList[j]++;
		}
		else
		{
			j++;
			i--;
			if (j > numprocs - 2) // for the elements larger than the largest splitter
			{
				sendCountList[j] = w - 1 - i;
				break;
			}
		}
	}
}

/** Modified version of the binary search. Finds the number of elements smaller than or equal to the value in the list. */
int myBinarySearch(int *subList, int value, int sizeOfList)
{
	int lower, upper, middle, result;
	if (value < subList[0])
	{
		result = 0;
	}
	else if (value > subList[sizeOfList-1])
	{
		result = sizeOfList;
	}
	else
	{
		lower = 0;
		upper = sizeOfList - 1;
		while (upper > lower)
		{
			middle = (upper + lower) / 2;
			if (value >= subList[middle] && value < subList[middle + 1])
			{
				result = middle + 1;
				break;
			}
			else if (value < subList[middle])
			{
				upper = middle;
			}
			else if (value >= subList[middle])
			{
				lower = middle + 1;
			}
		}
	}
	return result;
}

/**Divides given sorted list (subList) based on the integers in the splitterList array. 
  *Number of elements between two splitters are then written to sendCountList array. 
  *The first element of the sendCountList array is the number of elements smaller than or equal to the first splitter.
  *There are numprocs - 1 elements in splitterList, and w elements in subList
  */
void divideList(int w, int numprocs, int *subList, int *splitterList, int *sendCountList)
{
	int i;
	int sum = 0;
	sendCountList[0] = myBinarySearch(subList, splitterList[0], w);
	sum += sendCountList[0];
	for (i = 1; i < numprocs - 1; i++)
	{
		sendCountList[i] = myBinarySearch(subList, splitterList[i], w) - sum;
		sum += sendCountList[i];
	}
	sendCountList[numprocs - 1] = w - sum;
}


/**Calculates the displacements and fills these to the displacement arrays needed in step 7 version 1*/
void fillDisplacementArray(int numprocs, int *countArray, int *dispArray)
{
	int i;
	int dispSum = 0;
	dispArray[0] = 0;
	for (i = 0; i < numprocs - 1; i++)
	{
		dispSum += countArray[i];
		dispArray[i+1] = dispSum;
	}
}

/** Parallel Sorting by Regular Sampling Algorithm - Step 7 - Version 1 Part 1: 
    Uses MPIAlltoall to communicate the sizes and senders of the sublists,
    fills the array of elements to be received and  
    returns the number of elements for the subList which will be used to store the received elements
*/
int runVersion1_1(int numprocs, int *sendCountList, int *receiveCountList)
{
	int i;
	int numRecvElems;
	MPI_Alltoall(sendCountList, 1, MPI_INT, receiveCountList, 1, MPI_INT, MPI_COMM_WORLD);	
	// Find the total number of elements which will be received
	numRecvElems = 0;
	for (i = 0; i < numprocs; i++)
	{
		numRecvElems += receiveCountList[i];
	}
	return numRecvElems;
}

/** Parallel Sorting by Regular Sampling Algorithm - Step 7 - Version 1 Part 2: 
    Uses MPIAlltoallv to communicate the sublists 
    fills the displacement array of received elements and the subList of received elements
*/
void runVersion1_2(int numprocs, int *subList, int *sendCountList, int *receiveCountList, int *receiveDisplacementList, int *subList2)
{
	int i;
	int *sendDisplacementList = (int *) malloc(numprocs * sizeof(int));
	fillDisplacementArray(numprocs, sendCountList, sendDisplacementList);
	fillDisplacementArray(numprocs, receiveCountList, receiveDisplacementList);
	MPI_Alltoallv(subList, sendCountList, sendDisplacementList, MPI_INT, subList2, receiveCountList, receiveDisplacementList, MPI_INT, MPI_COMM_WORLD);
	free (sendDisplacementList);
}

/** Parallel Sorting by Regular Sampling Algorithm - Step 7 - Version 2 Part 1: 
    Uses MPIAllreduce to communicate the sizes and senders of the sublists,
    fills the array of elements to be received and  
    returns the number of elements for the subList which will be used to store the received elements
*/
int runVersion2_1(int numprocs, int mypid, int *sendCountList, int *receiveCountList)
{
	int i,numRecvElems;
	int *sendReceiveCountList_s = (int *) calloc((numprocs * numprocs), sizeof(int));
	int *sendReceiveCountList_r = (int *) malloc((numprocs * numprocs) * sizeof(int));
	for (i = 0; i < numprocs; i++)
	{
		sendReceiveCountList_s[(numprocs * i) + mypid] = sendCountList[i]; 
	}
	MPI_Allreduce(sendReceiveCountList_s,sendReceiveCountList_r,(numprocs * numprocs),MPI_INT,MPI_SUM,MPI_COMM_WORLD);
	for (i = 0; i < numprocs; i++)
	{
		receiveCountList[i] = sendReceiveCountList_r[(mypid * numprocs) + i];
	}
	numRecvElems = 0;
	for (i = 0; i < numprocs; i++)
	{
		numRecvElems += receiveCountList[i];
	}
	free(sendReceiveCountList_s);
	free(sendReceiveCountList_r);
	return numRecvElems;
}

/** Parallel Sorting by Regular Sampling Algorithm - Step 7 - Version 3 Part 2: 
    Uses non-blocking send/receive calls to communicate the sublists 
    fills the displacement array of received elements and the subList of received elements
*/
//void runVersion3_2(int mypid, int numprocs, int *subList, int *sendCountList, int *receiveCountList, int *receiveDisplacementList, int *subList2, FILE *fp)
void runVersion3_2(int mypid, int numprocs, int *subList, int *sendCountList, int *receiveCountList, int *receiveDisplacementList, int *subList2)
{
	int i;
	MPI_Request *request, *request2;
	MPI_Status status;
	int *sendDisplacementList = (int *) malloc(numprocs * sizeof(int));
	fillDisplacementArray(numprocs, sendCountList, sendDisplacementList);
	fillDisplacementArray(numprocs, receiveCountList, receiveDisplacementList);
	request = (MPI_Request*) malloc(numprocs * sizeof(MPI_Request));
	request2 = (MPI_Request*) malloc(numprocs * sizeof(MPI_Request));
	
	/*
	// Some printing stuff for debugging reasons
	printArraytoFile(sendCountList,numprocs,"Send Count List",fp);
	printArraytoFile(sendDisplacementList,numprocs,"Send Displacement List",fp);
	printArraytoFile(receiveCountList,numprocs,"Receive count List",fp);
	printArraytoFile(subList,N/numprocs,"SubList",fp);
	*/

	for (i = 0; i < numprocs; i++)
	{
		if (i == mypid)
			continue;
		MPI_Isend(&(subList[sendDisplacementList[i]]), sendCountList[i], MPI_INT, i, 1, MPI_COMM_WORLD, &(request[i]));
		//printArraytoFile(&(subList[sendDisplacementList[i]]),sendCountList[i],"sending",fp);
	}
	for (i = 0; i < numprocs; i++)
	{
		if (i == mypid)
			continue;
		MPI_Irecv(&(subList2[receiveDisplacementList[i]]), receiveCountList[i], MPI_INT, i, MPI_ANY_TAG, MPI_COMM_WORLD, &(request2[i]));
	}
	for (i = 0; i < sendCountList[mypid]; i++)
	{
		subList2[receiveDisplacementList[mypid] + i] = subList[sendDisplacementList[mypid] + i];
	}
	//printArraytoFile(&(subList[sendDisplacementList[mypid]]),sendCountList[mypid],"sending to myself",fp);
	free (sendDisplacementList);
	MPI_Barrier(MPI_COMM_WORLD);
	
	for (i = 0; i < numprocs; i++)
	{
		if (i == mypid)
			continue;
		MPI_Wait(&(request[i]), &status);
		MPI_Wait(&(request2[i]), &status);
	}
	/*
	// Again some printing for debugging
	for (i = 0; i < numprocs; i++)
	{
		if (i == mypid)
			continue;
		printArraytoFile(&(subList2[receiveDisplacementList[i]]),receiveCountList[i],"received",fp);
	}
	printArraytoFile(&(subList2[receiveDisplacementList[mypid]]),receiveCountList[mypid],"received from myself",fp);
	*/
}


/**Merges the lists a and b onto the list c*/
void merge(int *a,int *b, int *c, int sizeOfA, int sizeOfB)
{
	int indexA,indexB,indexC;
	indexA = 0;
	indexB = 0;
	indexC = 0;

	while(indexA < sizeOfA && indexB < sizeOfB)
	{
		if(a[indexA] < b[indexB])
		{
			c[indexC]=a[indexA];
			indexA++;
		}
		else 
		{
			c[indexC]=b[indexB];
			indexB++;
		}
		indexC++;
	}
	while(indexA < sizeOfA)
	{
		c[indexC]=a[indexA];
		indexA++;
		indexC++;
	}
	while(indexB < sizeOfB)
	{
		c[indexC]=b[indexB];
		indexB++;
		indexC++;
	}
}

/**Merges the sorted sublists placed in subList2. Number of elements of sorted sublists are in receiveCountList array. 
  Placements of these sublists are in receiveDisplacementList array.*/
void mergesubLists(int *receiveCountList, int *receiveDisplacementList, int numprocs, int *subList2)
{
	int i, j;
	int *firstArr, *secondArr, *thirdArr;
	int sizeOfFirstArr = receiveCountList[0];
	firstArr = (int*) malloc(receiveCountList[0] * sizeof(int));
	for (i = 0; i < receiveCountList[0]; i++)
	{
		firstArr[i] = subList2[i];
	}
	for (i = 1; i < numprocs; i++)
	{
		secondArr = (int *) malloc(receiveCountList[i] * sizeof(int));
		thirdArr = (int *) malloc((sizeOfFirstArr + receiveCountList[i]) * sizeof(int));
		for (j = 0; j < receiveCountList[i]; j++)
		{
			secondArr[j] = subList2[receiveDisplacementList[i] + j]; 
		}
		merge(firstArr, secondArr, thirdArr, sizeOfFirstArr, receiveCountList[i]);
		free(firstArr);
		free(secondArr);
		firstArr = thirdArr;
		sizeOfFirstArr += receiveCountList[i];
	}
	// Copy the resulting sorted and merged list into the subList2
	for (i = 0; i < sizeOfFirstArr; i++)
	{
		subList2[i] = firstArr[i];
	}
}

/**Gets the total number of elements in the list of receive counts*/
int getNumberOfReceives(int numprocs, int *receiveCountList)
{
	int i = 0;
	int numberOfReceives = 0;
	for (i = 0; i < numprocs; i++)
	{
		numberOfReceives += receiveCountList[i];
	}
	return numberOfReceives;
}

/**Prints the first "size" elements of the given array with a header of "name".*/
void printArray(int *arr, int size, char* name)
{
	int i;
	printf("%s :\n",name);
	for (i = 0; i < size; i++)
	{
		printf("%d ",arr[i]);
	}
	printf("\n");
}

/**Prints the first "size" elements of the given array with a header of "name". Printing is done to a file*/
void printArraytoFile(int *arr, int size, char* name, FILE *fp)
{
	int i;
	fprintf(fp,"%s :\n",name);
	for (i = 0; i < size; i++)
	{
		fprintf(fp,"%d ",arr[i]);
	}
	fprintf(fp,"\n");
}

/**Prints the given pid number and first "size" elements of the given array with a header of "name".*/
void printArray1(int *arr, int size, int mypid, char* name)
{
	int i;
	printf("mypid = %d\n%s :\n",mypid,name);
	for (i = 0; i < size; i++)
	{
		printf("%d ",arr[i]);
	}
	printf("\n");
}

/**Checks if the given list of size "listSize" is sorted*/
void checkSorted(int *theList, int listSize)
{
	int i;
	for (i = 1; i < listSize; i++)
	{
		if (theList[i] < theList[i-1])
		{
			printf("Found an inconsistency in the sorted list between index %d and %d.\n Elements are %d and %d\n",i,i-1,theList[i],theList[i-1]);
			break;
		}
	}
}

/**Checks the equality condition of two lists of size "size"*/
void isEqual(int *list1, int *list2, int size)
{
	int i, j;
	int found = 0;
	for (i = 0; i < size; i++)
	{
		found = 0;
		for (j = 0; j < size; j++)
		{
			if (list1[i] == list2[j])
			{
				found = 1;
				break;
			}
		}
		if (found == 1)
			continue;
		else
			break;
	}
	if (found == 0)
		printf("Lists are not the same\n");	
}

