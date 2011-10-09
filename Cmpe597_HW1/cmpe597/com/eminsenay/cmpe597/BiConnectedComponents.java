package com.eminsenay.cmpe597;

public class BiConnectedComponents {

	public static void main(String[] args)
	{
		String fileName = "exGraphBiconn.txt"; 
		if (args.length != 0)
			fileName = args[0];
		if (fileName.equals("-h"))
		{
			System.out.println("Usage:");
			System.out.println("BiConnectedComponents [inputFile]");
			System.out.println("inputFile: Text file of a graph. Default: exGraphBiconn.txt");
			System.exit(0);
		}
		Graph theGraph = Graph.readFromFile(fileName,false);
		if (theGraph == null)
			System.exit(-1);
		
		theGraph.bidfs(); // bi-connected depth-first search
	}
}
