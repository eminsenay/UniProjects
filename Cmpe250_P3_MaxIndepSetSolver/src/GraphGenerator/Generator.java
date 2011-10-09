package GraphGenerator;


import java.util.ArrayList;
import java.util.Random;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;

/**
 * Student IDs: 2002103907 & 2002101414
 * Date: May 8, 2005
 * Time: 8:08:23 PM
 * @author Emin Þenay & Atilla Soner Balkýr
 */
public class Generator {
    /**
     * Generates a graph and saves it to a file.
     * @param numNodes Number of nodes (vertices) to be generated.
     * @param minDeg Minimum degree of one node.
     * @param minWeight Minimum weight of one node.
     * @param maxWeight Maximum weight of one node.
     * @param fileName File name to be saved.
     */
    void GenerateGraph (int numNodes, int minDeg, int minWeight, int maxWeight, String fileName)
    {
        // creating an integer to get random number of elements
        // between mindeg and this.
        // change the value if you want to take more or less random number of elements
        int maxVal = 6;
        if (numNodes < maxVal)
            maxVal = 0;

        // Creating an arraylist array to store neigbours of all elements
        ArrayList[] nodeList = new ArrayList[numNodes];
        for (int i = 0; i<nodeList.length; i++)
        {
            nodeList[i] = new ArrayList();
        }

        // Creating random numbers and setting them to the neighbours
        for (int i = 0; i<nodeList.length; i++)
        {
            ArrayList tmp = new ArrayList();

            // Taking an ArrayList which has random number of elements
            // between minimum degree and maximum degree (mindegree and maxval).
            // The values of elements are also random between 0
            // and number of nodes to be generated.
            tmp = createRandomNumbers(0,nodeList.length,minDeg,minDeg+maxVal,i);

            // Setting the neighbours

            // setting the selected element's neighbours
            for (int j = 0; j < tmp.size(); j++)
                if (!nodeList[i].contains(tmp.get(j)))
                    nodeList[i].add(tmp.get(j));

            // Adding selected element to the neighbour list of all its neighbours
            for (int j = 0; j<nodeList[i].size(); j++)
            {
                Integer nodeVal =(Integer)nodeList[i].get(j);
                if (!nodeList[nodeVal.intValue()].contains(new Integer(i)))
                    nodeList[nodeVal.intValue()].add(new Integer(i));
            }
        }

        // Saving the graph to a file.
        saveToFile(numNodes,minDeg,minWeight,maxWeight,nodeList,fileName);
    }

    /**
     * Returns random number of random numbers.
     * @param minVal All random numbers should be bigger than this.
     * @param maxVal All random numbers should be smaller than this.
     * @param minNum Minimum number of elements to be returned.
     * @param maxNum Maximum number of elements to be returned.
     * @return An Arraylist of random numbers.
     */
    ArrayList createRandomNumbers (int minVal, int maxVal, int minNum, int maxNum, int current)
    {
        // Initializing the Arraylist to store the random numbers.
        ArrayList values = new ArrayList();

        // Finding how many elements are going to be returned
        int diff = maxNum - minNum + 1;
        int rndNum = rnd.nextInt(diff);
        rndNum += minNum;
        if (rndNum > maxVal - minVal)
            rndNum = maxVal - minVal;
        // Method will return rndNum elements

        // creating random numbers to be returned
        for (int i = 0; i<rndNum; i++)
        {
            diff = maxVal - minVal;
            int rndVal = rnd.nextInt(diff);
            rndVal += minVal;

            // if this random number is created before,
            // program should create a new random number
            if (values.contains(new Integer(rndVal)) || rndVal == current)
            {
                i--;
                continue;
            }

            // Adding the created random number to the ArrayList
            values.add(new Integer(rndVal));
        }

        // Returning the ArrayList
        return values;
    }

    /**
     * Creates a random number between minVal and maxVal.
     * @param minVal Minimum value.
     * @param maxVal Maximum value.
     * @return The random number.
     */
    int createRandomNumber (int minVal, int maxVal)
    {
        int diff = maxVal - minVal +1;
        int rndNum = rnd.nextInt(diff);
        rndNum += minVal;
        return rndNum;
    }

    /**
     * Saves the given graph to a file. It also sets random numbers to weights of vertices.
     * @param numNodes Number of nodes in the graph.
     * @param minDeg Minimum degree of the graph.
     * @param minWeight Minimum weight of the graph.
     * @param maxWeight Maximum weight of the graph.
     * @param nodeList ArrayList which contains the vertices.
     * @param fileName File name to be saved.
     * @return True if save is successful.
     */
    boolean saveToFile (int numNodes, int minDeg, int minWeight, int maxWeight, ArrayList[] nodeList, String fileName)
    {
        FileOutputStream out; //declare a file output object
        PrintStream p; //declare a print stream object

        // open the file and bind p to file
        try {
            out = new FileOutputStream(fileName);
        } catch (FileNotFoundException e) {
            return false;
        }
        p = new PrintStream(out);

        // Printing number of nodes, minimum degree,
        // minimum and maximum weight of the graph.
        p.println(numNodes);
        p.println(minDeg);
        p.println(minWeight);
        p.println(maxWeight);

        // Printing the elemenent index, weight and all its neighbours' indexes.
        for (int i = 0 ; i < nodeList.length ; i++)
        {
            // creating a random number for the veight of the vertice
            int rndWeight = createRandomNumber(minWeight, maxWeight);
            p.print(i + " " + rndWeight + " ");
            for (int j = 0; j < nodeList[i].size(); j++)
                p.print(nodeList[i].get(j) + " ");
            p.println();
        }
        return true;
    }
    /**
     * Random seed.
     */
    Random rnd = new Random();
}
