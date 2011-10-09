package com.eminsenay.cmpe597;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;

public class uDrawWriter {
	
	private String[] getRandomColors(int numberOfRandom)
	{
		char[] colorSet = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'}; 
		String[] colors = new String[numberOfRandom];
		Random r = new Random();
		for (int i = 0; i < numberOfRandom; i++)
		{
			colors[i] = "#";
			for (int j = 0; j < 6; j++)
			{
				colors[i] += colorSet[r.nextInt(colorSet.length)];
			}
		}
		return colors;
	}
	
	public void write(ArrayList cycles, String inputFileName, String outputFileName)
	{
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));
			
			Graph g = Graph.readFromFile(inputFileName,true);
			String[] colors = getRandomColors(cycles.size());
			
			for (int i = 0; i < cycles.size(); i++)
			{
				ArrayList nextCycle = (ArrayList)cycles.get(i);
				for (int j = 0; j < nextCycle.size(); j++)
				{
					Integer nextNode = (Integer)nextCycle.get(j);
					g.vertexList[nextNode].color = i;
				}
			}
			out.write("[\n");
			for (int i = 0; i < g.adjMat.length; i++)
			{
				if (i == 0)
					out.write(
							"l(\"node" + (i+1) + "\",n(\"node" + (i+1) + "\",[a(\"OBJECT\",\"node" + (i+1) + "\")"+
							",a(\"COLOR\",\"" + colors[g.vertexList[i].color] + "\"),a(\"_GO\",\"circle\")]"
					);
				else
					out.write(
							",l(\"node" + (i+1) + "\",n(\"node" + (i+1) + "\",[a(\"OBJECT\",\"node" + (i+1) + "\")"+
							",a(\"COLOR\",\"" + colors[g.vertexList[i].color] + "\"),a(\"_GO\",\"circle\")]"
					);
				out.write(",[");
				for (int j = 0; j < g.adjMat[i].length; j++)
				{				
					if (g.adjMat[i][j] == 1)
					{
						out.write(
								"e(\"n" + i + "->n" + j + "\",[],r(\"node" + (j+1) + "\")),"	
						);
					}
				}
				out.write("]))\n");
			}
			out.write("]\n");
			
			out.close();
			System.out.println("uDraw file is successfully written to " + outputFileName);
		} catch (IOException e) {
			System.err.println("There is an error while creating the uDraw file.");
		}
	}

}
