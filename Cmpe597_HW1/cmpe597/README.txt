Compilation instructions:

1- CD to the directory of .java files.
2- Type:

javac BiConnectedComponents.java Graph.java Str
onglyConnectedComponents.java uDrawWriter.java Vertex.java

Example:

C:\cmpe597>cd com

C:\cmpe597\com>cd eminsenay

C:\cmpe597\com\eminsenay>cd cmpe597

C:\cmpe597\com\eminsenay\cmpe597>javac BiConnectedComponents.java Graph.java Str
onglyConnectedComponents.java uDrawWriter.java Vertex.java

Running instructions:

1 - Change the directory to the directory of the README.txt file.

2a - To run Strongly Connected Components Algorithm, generate cycles and uDraw File, type:

java com.eminsenay.cmpe597.StronglyConnectedComponents

Example:

C:\cmpe597>java com.eminsenay.cmpe597.StronglyConnectedComponents
Elementary cycles:
9
1 5 2
3 4
7 6
8
uDraw file is successfully written to uDrawExampleOutput.udg

2b - To run bi-connected Components Algorithm and generate cycles, type:

java com.eminsenay.cmpe597.BiConnectedComponents 

Example:

C:\cmpe597>java com.eminsenay.cmpe597.BiConnectedComponents exGraphBiconn.txt
Elementary cycles:
(4,2) (3,4) (2,3)
(6,1) (5,6) (2,5) (1,2)
(9,7) (8,9) (7,8)
(1,7)

Note: Detailed information of the usage of these programs can be found with -h flag.

Example:

C:\cmpe597>java com.eminsenay.cmpe597.BiConnectedComponents -h
Usage:
BiConnectedComponents [inputFile]
inputFile: Text file of a graph. Default: exGraphBiconn.txt

C:\cmpe597>java com.eminsenay.cmpe597.StronglyConnectedComponents -h
Usage:
StronglyConnectedComponents [inputFile] [outputFile]
inputFile: Text file of a graph. Default: exGraph.txt
outputFile: A file name to save the representation of the graph.
File is prepared in uDraw(graph) .udg format.
Default output file name: uDrawExampleOutput.udg
