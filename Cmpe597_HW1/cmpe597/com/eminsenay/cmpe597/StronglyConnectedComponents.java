package com.eminsenay.cmpe597;

import java.util.ArrayList;

public class StronglyConnectedComponents {
	
	public static void main(String[] args) {
		String inputFileName = "exGraph.txt";
		String outputFileName = "uDrawExampleOutput.udg";
		if (args.length != 0)
			inputFileName = args[0];
		if (args.length >= 2)
			outputFileName = args[1];
		if (inputFileName.equals("-h"))
		{
			System.out.println("Usage:");
			System.out.println("StronglyConnectedComponents [inputFile] [outputFile]");
			System.out.println("inputFile: Text file of a graph. Default: exGraph.txt");
			System.out.println("outputFile: A file name to save the representation of the graph.");
			System.out.println("File is prepared in uDraw(graph) .udg format.");
			System.out.println("Default output file name: uDrawExampleOutput.udg");
			System.exit(0);
		}
		
		Graph theGraph = Graph.readFromFile(inputFileName,true);
		if (theGraph == null)
			System.exit(-1);

		theGraph.dfs(0); // depth-first search
		theGraph.transpose();
		theGraph.clearVisits();
		ArrayList cycles = theGraph.dfs(1); //dfs according to the finish times of each vertex
		
		theGraph.printCycles(cycles); // Print cycles
		
		// Prepare the graph for udraw
		uDrawWriter uDW = new uDrawWriter();
		uDW.write(cycles,inputFileName,outputFileName);
	} // end main()

}
