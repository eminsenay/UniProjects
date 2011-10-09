package com.eminsenay.cmpe597;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Stack;

public class Graph {

	/** List of vertices */
	public Vertex vertexList[]; 

	/** Adjacency matrix to store edge information. */
	public int adjMat[][]; 

	/** Current number of vertices */
	private int nVerts; 
	
	private Stack<Integer> stack;

	/** Constructor of the graph. */
	private Graph(int maxVertice) 
	{
		vertexList = new Vertex[maxVertice];
		// adjacency matrix
		adjMat = new int[maxVertice][maxVertice];
		nVerts = 0;
		for (int y = 0; y < maxVertice; y++)
			// set adjacency
			for (int x = 0; x < maxVertice; x++)
				//    matrix to 0
				adjMat[x][y] = 0;
		stack = new Stack<Integer>();
	} // end constructor

	/** Addds a vertex to the graph. */
	private void addVertex() {
		vertexList[nVerts++] = new Vertex();
	}

	/** Adds a new directed edge to the graph. If undirected edge is required,
	 *  rerun with start and end conversed. */
	private void addEdge(int start, int end) {
		adjMat[start][end] = 1;		
	}
	

	/** Gives the index of an unvisited vertex. 
	 * @param mode: same as dfs method
	 */
	private int getUnvisitedVertex(int mode)
	{
		int returnIndex = -1;
		if (mode == 0)
		{
			for (int i = 0; i < nVerts; i++)
			{
				if (!vertexList[i].visitedBefore)
				{
					returnIndex = i;
					break;
				}
			}
		}
		else 
		{
			int maxFinishTime = -1;
			for (int i = 0; i < nVerts; i++)
			{
				if (!vertexList[i].visitedBefore && vertexList[i].finishTime > maxFinishTime)
				{
					maxFinishTime = vertexList[i].finishTime;
					returnIndex = i;
				}
			}
		
		}
		return returnIndex;
	}
	
	public void printCycles(ArrayList cycleList)
	{
		System.out.println("Elementary cycles:");
		for (int i = 0; i < cycleList.size(); i++)
		{
			ArrayList nextCycle = (ArrayList)cycleList.get(i);
			for (int j = 0; j < nextCycle.size(); j++)
			{
				Integer nextElem = (Integer)nextCycle.get(j);
				System.out.print((nextElem.intValue()+1) + " ");
			}
			System.out.println();
		}
	}
	
	/** depth-first search
	 * @param mode:
	 *  0 = vertices are selected arbitrarily when stack is empty
	 *  1 = vertices are selected in the order of decreasing finish time when stack is empty
	 */
	public ArrayList dfs(int mode) 
	{
		// mark start and finish times of vertices with turnTime
		int turnTime = 1;
		
		ArrayList<ArrayList> cycleList = new ArrayList<ArrayList>();
		
		while(true)
		{
			ArrayList<Integer> nextCycle = new ArrayList<Integer>();
			
			int nextVertex = getUnvisitedVertex(mode);
			
			if (nextVertex == -1)
				break;
			
			// Mark, display and push to stack
			vertexList[nextVertex].visitedBefore = true;
			vertexList[nextVertex].firstVisitTime = turnTime++;			
			if (mode == 1)
			{
				nextCycle.add(new Integer(nextVertex));
			}
			stack.add(new Integer(nextVertex));
	
			while (!stack.isEmpty()) // until stack empty,
			{
				// get an unvisited vertex adjacent to stack top
				int v = getAdjUnvisitedVertex((stack.peek()).intValue());
				if (v == -1) { // if no such vertex,
					int vertexIndex = (stack.peek()).intValue();
					vertexList[vertexIndex].finishTime = turnTime++;
					stack.pop();
				}
				else // if it exists,
				{
					vertexList[v].visitedBefore = true; // mark it
					vertexList[v].firstVisitTime = turnTime++;
					if (mode == 1)
					{
						nextCycle.add(new Integer(v));
					}
					stack.push(new Integer(v));
				}
			} // end while
			cycleList.add(nextCycle);
		} // end of while
		return cycleList;
	} // end dfs

	/** returns an unvisited vertex adj to v */
	private int getAdjUnvisitedVertex(int v) {
		for (int j = 0; j < nVerts; j++)
			if (adjMat[v][j] == 1 && vertexList[j].visitedBefore == false)
				return j;
		return -1;
	}
	
	/** Reads a graph from a text file. */
	public static Graph readFromFile(String fileName, boolean isDirected)
	{
		Graph g = null;
		try {
			FileReader f = new FileReader(fileName);
			BufferedReader r = new BufferedReader(f);
			
			// first read number of vertices and number of edges
			String firstLine = r.readLine();
			String[] verticeEdge = firstLine.split(" ");
			int numVertice = Integer.parseInt(verticeEdge[0]);
			int numEdge = Integer.parseInt(verticeEdge[1]);	
				
			g = new Graph(numVertice);
			
			// Add vertices
			for (int i = 0; i < numVertice; i++)
			{
				g.addVertex();
			}
			
			// Add edges
			for (int i = 0; i < numEdge; i++)
			{
				String newEdge = r.readLine();
				String[] edgeIndices = newEdge.split(" ");
				int firstVertex = Integer.parseInt(edgeIndices[0]);
				int secondVertex = Integer.parseInt(edgeIndices[1]);
				
				// Vertex numbers read from file are starting from 1, so decrement 1
				g.addEdge(firstVertex-1, secondVertex-1);
				if (!isDirected)
					g.addEdge(secondVertex-1, firstVertex-1);
			}
			
			
		} catch (Exception e) {
			System.err.println("Graph read error. Possibly the input file you specified does not exist in the system.");
			System.err.println("For help, use the -h flag.");
			//e.printStackTrace();
		}
		return g;
	}

	/** Transposes a directed graph. */
	public void transpose()
	{
		int[][] newAdjMat = new int[vertexList.length][vertexList.length];
		for (int i = 0; i < vertexList.length; i++)
		{
			for (int j = 0; j < vertexList.length; j++)
			{
				newAdjMat[j][i] = adjMat[i][j];
			}
		}
		adjMat = newAdjMat;
	}
	
	/** Clears all nodes like they were unvisited before. */
	public void clearVisits()
	{
		for (int i = 0; i < nVerts; i++)
		{
			vertexList[i].visitedBefore = false;	
		}
	}

	/** Finds bi-connected components of the graph. */
	public void bidfs()
	{
		System.out.println("Elementary cycles:");
		Stack<String> edgeStack = new Stack<String>();
		
		int turnTime = 1;
		
		while(true)
		{
			int nextVertex = getUnvisitedVertex(0);
			if (nextVertex == -1)
				break;			
					
			bidfs(new Integer(nextVertex),new Integer(turnTime),edgeStack);
		}
	}
	
	/** Recursive method for finding bi-connected components of the graph */
	private void bidfs(Integer vertexIndex,Integer turnTime,Stack<String> edgeStack)
	{
		vertexList[vertexIndex].visitedBefore = true;
		vertexList[vertexIndex].firstVisitTime = turnTime++;
		vertexList[vertexIndex].b = vertexList[vertexIndex].firstVisitTime;
		
		ArrayList<Integer> neighbors = getNeighbors(vertexIndex);
		
		for (int i = 0; i < neighbors.size(); i++)
		{
			int neighborIndex = (neighbors.get(i)).intValue();
			
			if (vertexList[neighborIndex].firstVisitTime == -1)
			{
				edgeStack.push("(" + (vertexIndex+1) + "," + (neighborIndex+1) + ")");
				vertexList[neighborIndex].parent = vertexIndex;
				bidfs(new Integer(neighborIndex),turnTime,edgeStack);
				
				if (vertexList[neighborIndex].b >= vertexList[vertexIndex].firstVisitTime)
				{
					//System.out.println("New biconnected component");
					while (true)
					{
						String newEdge = edgeStack.pop();
						System.out.print(newEdge + " ");
						if (newEdge.equals("(" + (vertexIndex+1) + "," + (neighborIndex+1) + ")"))
						{
							System.out.println();
							break;							
						}
					}
				}
				else
				{
					if (vertexList[neighborIndex].b < vertexList[vertexIndex].b)
						vertexList[vertexIndex].b = vertexList[neighborIndex].b;
				}
			}
			else if (vertexList[neighborIndex].firstVisitTime < vertexList[vertexIndex].firstVisitTime &&
					neighborIndex != vertexList[vertexIndex].parent)
			{
				edgeStack.push("(" + (vertexIndex+1) + "," + (neighborIndex+1) + ")");
				if (vertexList[neighborIndex].firstVisitTime < vertexList[vertexIndex].b)
					vertexList[vertexIndex].b = vertexList[neighborIndex].b;
			}
		}
	}
	
	/** Returns the neighbors of a given node */
	private ArrayList<Integer> getNeighbors(int vertexIndex)
	{
		ArrayList<Integer> neighbors = new ArrayList<Integer>();
		
		for (int i = 0; i < adjMat[vertexIndex].length; i++)
		{
			if (adjMat[vertexIndex][i] == 1)
			{
				neighbors.add(new Integer(i));
			}
		}
		return neighbors;
	}
}

