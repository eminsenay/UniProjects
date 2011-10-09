//ID:2002103907
//Emin Senay
//main.cpp:main program

#include "mpi.h"
#include <iostream>
#include <fstream>
#include <queue>
#include "NodeType.h"
#include <time.h>

using namespace std;

bool FindBestPath(CostStruct **costMatrix, mypath* Path, int root_index, int *currentcost, int *upperbound, int *timelimit, time_t *starttime, int *rank)
{
	time_t endtime;
	priority_queue<CostStruct> myHeap;
	for (int i = 0; i < Path->size; i++)
	{
		myHeap.push(costMatrix[root_index][i]);
	}
	// created the heap
	int initialcost = *currentcost;
	//int *best_cost_so_far = new int;
	int *temp_cost = new int;
	//*best_cost_so_far = initialcost;
	mypath best_path_so_far;
	bool success = false;
	bool success_once = false;
	mypath initialpath = *Path;

	while(!myHeap.empty())
	{
		endtime = time(NULL);
		if ((int)(endtime-*starttime) >= *timelimit)
		{
			break;
		}
		*temp_cost = initialcost;
		mypath temp_path = initialpath;
		// taking and deleting the minimum cost element from the heap
		CostStruct min_Elem = myHeap.top();
		myHeap.pop();

		//fathoming
		if (min_Elem.cost + initialcost >= *upperbound)
		{
			break;
		}
		// searching the min_Elem element in the path
		bool found = false;
		for (int i = 1; i<(initialpath.count); i++)//Path->count stores the number of elements in the path
		{
			if (initialpath.indice[i] == min_Elem.node)
			{
				found = true;
				break;
			}
		}
		if (initialpath.count < Path->size)
		{
			if (initialpath.indice[0] == min_Elem.node)
				found = true;
		}
		// if minimum element is found in the list, to prevent subtours
		// it shouldn't be put in the path, pass to the next element
		if (found)
		{
			continue;
		}
		// check if root node is a leaf node
		else if(initialpath.count == Path->size)
		{
			// if so add the cost of the city, update the upperbound
			*currentcost += min_Elem.cost;
			if (*upperbound > *currentcost)
			{
				// found a better cost path
				*upperbound = *currentcost;
				MPI_Bcast(upperbound, 1, MPI_INT, *rank, MPI_COMM_WORLD);
				return true;
			}
			//found a worse cost path
			return false;
		}
		// if root node is not a leaf node
		else
		{
			*temp_cost += min_Elem.cost;
			temp_path.add_item(min_Elem.node);
			// now, calling the function recursively
			success = FindBestPath(costMatrix, &temp_path, min_Elem.node, temp_cost, upperbound, timelimit, starttime, rank);
			if (success)
			{
				success_once = true;
				Path->copy(temp_path);
				//best_path_so_far.copy(temp_path);
				//*best_cost_so_far = *temp_cost;
				*currentcost = *temp_cost;
			}
			else
				continue;
		}
    }
	if (success_once)
	{
		delete temp_cost;

		//Path->copy(best_path_so_far);
		//*currentcost = *best_cost_so_far;
		return true;
	}
	else
		return false;
}
int main(int argc, char** argv)
{
	// Initializing MPI   
	int rank, size;
    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
	MPI_Comm_size( MPI_COMM_WORLD, &size );

	// Reading from input.txt
	int num_cities,timelimit;
	ifstream in("input.txt"); // input
	if(!in)
	{
		if (rank == 0)
		{
			cout << "Cannot open input file.\n";
			system("PAUSE");
		}
		MPI_Finalize();
		return 1;
	}
	// Take the number of cities and timelimit
	in >> num_cities;
	in >> timelimit;
	// Create a new matrix for storing cost values of edges
	// Initialize all edges to 30000 for a large value
	CostStruct **CostMatrix = new CostStruct*[num_cities];
	for (int i = 0; i < num_cities ; i++)
	{
		CostMatrix[i] = new CostStruct[num_cities];
		for (int j = 0; j < num_cities; j++)
		{
			CostMatrix[i][j].cost = 30000;
			CostMatrix[i][j].node = j;
		}
	}
	// Read costs
	while(!in.eof())
	{
		int city_index_a, city_index_b, dist;
		in >> city_index_a >> city_index_b >> dist;
		CostMatrix[city_index_a-1][city_index_b-1].cost = dist;
		CostMatrix[city_index_a-1][city_index_b-1].node = city_index_b-1;
		CostMatrix[city_index_b-1][city_index_a-1].cost = dist;
		CostMatrix[city_index_b-1][city_index_a-1].node = city_index_a-1;
	}
	in.close();
	// Created the cost Matrix.

	// Create a new path and add the first city
	mypath optimalpath(num_cities);
	optimalpath.add_item(rank);

	int optimalcost = 0;
	int upperbound = 60000;
	time_t starttime = time(NULL);
	
	// Find the best path in timelimit seconds starting from city no: rank 
	bool success = FindBestPath(CostMatrix, &optimalpath, rank, &optimalcost, &upperbound, &timelimit, &starttime, &rank);
	
	MPI_Barrier (MPI_COMM_WORLD );
	//Create data for sending to processor no: 0
	int foundedcost = optimalcost;
	int *foundedpath = new int[num_cities];
	for (int i = 0; i < num_cities; i++)
		foundedpath[i]=optimalpath.indice[i];

	if (!success)
	{
		foundedcost = 50000;
	}
	// data created
	if (rank == 0) //if rank = 0 receive all foundedpaths and fondedcosts
	{
		MPI_Status status;
		// Create arrays for taking all solutions starting from all nodes
		int *costarray = new int[num_cities];
		int **patharray = new int*[num_cities];
		for (int i = 0 ; i < num_cities; i++)
			patharray[i] = new int[num_cities];
		int minindex=0;
		// Copy the path found by processor 0
		for (int i = 0; i < num_cities; i++)
			patharray[0][i] = foundedpath[i];
		for (int i = 0; i < num_cities; i++)
			costarray[i] = 50000;
		costarray[0] = foundedcost;

		// Receive data (cost and path)
		for (int i = 1; i < size; i++)
		{
			MPI_Recv( &costarray[i], 1, MPI_INT, i, 0, MPI_COMM_WORLD, &status );
			MPI_Recv( patharray[i], num_cities, MPI_INT, i, 0, MPI_COMM_WORLD, &status);
		}
		// Find the minimum of them
		int minelem = foundedcost;
		for (int i = 0; i < size; i++)
		{
			if (minelem > costarray[i])
			{
				minindex = i;
				minelem = costarray[i];
			}
		}

		// Find the place of the first node in the path
		int firstNodeIndex = 0;
		for(firstNodeIndex = 0; firstNodeIndex < num_cities; firstNodeIndex++)
			if(patharray[minindex][firstNodeIndex] == 0)
				break;
		// Print the cost and the path to file output.txt
		ofstream output;
		output.open("Output.txt");
		output << "Founded cost is: " << costarray[minindex] << endl;
		output << "The path is: ";
		// Write the path starting from the first node
		for (int i = 0; i < num_cities; i++)
		{
			output << patharray[minindex][(firstNodeIndex+i)%(num_cities)]+1 << " - ";
		}
		output << 1 << endl;
		cout << "Solution is found and written to Output.txt." << endl;

	//	system("PAUSE");


	}
	else 	//Send data if rank != 0
	{
		MPI_Send( &foundedcost, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
		MPI_Send( foundedpath, num_cities, MPI_INT, 0, 0, MPI_COMM_WORLD);
	}

	MPI_Finalize( );
	return 0;
}