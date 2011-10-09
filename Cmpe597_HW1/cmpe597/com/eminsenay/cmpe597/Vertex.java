package com.eminsenay.cmpe597;

public class Vertex {

	public boolean visitedBefore;
	
	public int firstVisitTime;
	public int finishTime;
	
	/** firstVisitTime of the furthest ancestor of v to which
	there is back edge from a descendant w of v */
	public int b;
	
	/** parent index of vertice in the DFS tree vertex list */
	public int parent; 
	
	/** Color index of the vertex (used for udraw)*/
	public int color;
	
	public Vertex() // constructor
	{
		visitedBefore = false;
		firstVisitTime = -1;
		finishTime = -1;
		b = 60000; //a large number
		parent = 0;
	}
}
