package SetSolver;


import javax.swing.*;
import java.util.ArrayList;
import java.util.Collections;
import java.io.*;

/**
 * Student IDs: 2002103907 & 2002101414
 * Date: 17.May.2005
 * Time: 14:23:12
 * @author Emin Þenay & Atilla Soner Balkýr
 */
public class SetSolver {
    /**
     *  Array which contains Vertice objects as its elements.
     */
    Vertice[] NodeArray;

    /**
     * Given a graph, this method returns the optimum solution for
     * finding a maximum weighted independent set.
     */
    public void optimumSolver()
    {
        long beginning, end;

        // getting the time
        beginning = System.currentTimeMillis();

        int maxSum = 0;
        //maxSum is the maximum number of nodes found by findMaxWeight
        //maxList contains the maximum independent list element
        //which we look for
        ArrayList maxList = new ArrayList();
        //For all nodes, look for the maxium weighted independent set
        for( int i = 0; i < NodeArray.length; i++ )
        {
            //Create empty array lists
            ArrayList temp, naList = new ArrayList();
            temp = findMaxWeight(i, naList);
            int sum = calculateWeightSum(temp);
            if( sum > maxSum )
            {
                maxSum = sum;
                maxList = temp;
            }
        }
        // getting the end time
        end = System.currentTimeMillis();

        //Print the conents of maxList on the screen
        String results = "Maximum weight is " + calculateWeightSum(maxList) + "\nThe vertices are:\n";

        for( int i = 0; i < maxList.size(); i++ )
        {
            Vertice tmp =(Vertice) maxList.get(i);
            results += tmp.index + " ";
            //TextIO.put(tmp.index + " ");
        }
        results += "\nTotal running time for optimum solver is " + (end - beginning) + " milliseconds.";
        JOptionPane.showMessageDialog(null,results);
        save(results);
    }

    /**
     * This method reads each line of a graph data and builds a new
     * graph.
     * @param fileName Name of the file that contains graph data.
     */
    public void loadGraph(String fileName)
    {
        //initialize input file
        File inputFile = new File (fileName);
        BufferedReader reader = null;

        //open input file
        //Opening The File
        try {
                reader = new BufferedReader(new FileReader(inputFile));
            }
            catch (FileNotFoundException e)
            {
                //If the file cannot be found
                //TextIO.putln( e.toString() );
                System.exit(1);
            }

        String line = null;
        try {

            line = reader.readLine();
            int numberOfNodes = Integer.parseInt(line);
            NodeArray = new Vertice[numberOfNodes];
            for( int i = 0; i < numberOfNodes; i++ )
                NodeArray[i] = new Vertice();

            for(int i = 0; i < 3; i++)
                line = reader.readLine();

            while( (line = reader.readLine()) != null )
            {
                if ( line.equals("") )
                    continue;

                //Split the string according to blanks
                String [] result = line.split("\\s");
                //Convert strings to numbers
                int [] values = intValues( result );
                NodeArray[values[0]].weight = values[1];

                NodeArray[values[0]].index = values[0];

                for(int i = 2; i < values.length; i++)
                    NodeArray[values[0]].neighbours.add(new Integer(values[i]) );
            }
        }
        catch(IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

    /** Given an array of strings, this method iterates all array elements
     * and convers them to integer values.
     *
     * @param numbers String array consisting of numbers.
     * @return Integer array consisting of numbers.
     */
    public int[] intValues( String [] numbers)
    {
        int [] result = new int[numbers.length];
        for( int i = 0; i < numbers.length; i++ )
            result[i] = Integer.parseInt( numbers[i] );
        return result;
    }

    /**
     * Given an independent set, this method calculates the total weight sum
     * of adding up individual node weights.
     * @param list A list of independent set elements
     * @return Total sum of weights of the individual set elements.
     */
    public int calculateWeightSum( ArrayList list)
    {
        int sum = 0;
        for( int i = 0; i < list.size(); i++ )
        {
            Vertice tmp = (Vertice)list.get(i);
            sum += tmp.weight;
        }
        return sum;
    }

    /**
     * Recursive method which seeks for the maximum weighted independent set.
     * Given a node in the graph, this method returns the maximum weighted
     * independent set starting from that node to the ones that have higher
     * indexes. naList contains a list of vertices that can no longer be added
     * to the independent set since thay are neighbours of the preceeding ones.
     * Base case occurs when all neighbours of the input node
     * exist inside "naList" and the method returns a list containing only the
     * first node. If base case does not occur, the method calls itself recursively
     * and seeks for solutions.
     *
     * @param beginning Starting element of the maximum weighted
     * independent set.
     * @param naList A list that contains the independent set elements
     * and their negihbours so that they can no longer be added to the
     * resukting independent set.
     * @return Maximum weighted independent set solved by optimum algorithm
     */
    public ArrayList findMaxWeight( int beginning, ArrayList naList )
    {
        ArrayList maxList = new ArrayList();
        //Add beginning to the begining of maxList
        maxList.add( NodeArray[beginning] );
        //Add neighbours of "beginning" to naList
        naList.addAll(NodeArray[beginning].neighbours);
        naList.add(new Integer(beginning));

        //Start Base case
        //If all remaining elements of NodeArray exist in naList
        //then no more elements can be added, return maxList.
        boolean allExists = true;
        for( int i = beginning + 1; i < NodeArray.length; i++)
        {
            if(!naList.contains(new Integer(i)))
            {
                allExists = false;
                break;
            }
        }
        if (allExists)
            return maxList;
        //This is the end of the base case

        //Start inductive case
        ArrayList tempMax = new ArrayList();
        int maxSum = 0, tempSum=0;
        int lastDifferenceIndex = beginning;
        for (int i = beginning; i < NodeArray.length; i++)
        {
            tempSum += NodeArray[i].weight;
        }
        for( int i = beginning + 1; i < NodeArray.length; i++ )
        {
            if(naList.contains(new Integer(i)))
                continue;

           //Performance boost
            for (int j = lastDifferenceIndex; j < i; j++)
                tempSum -= NodeArray[j].weight;
            lastDifferenceIndex = i;
            if (tempSum < maxSum)
                break;
            // end of performance boost

            ArrayList temp = new ArrayList();
            ArrayList naListCopy = new ArrayList(naList);
            temp = findMaxWeight(i, naListCopy);

            int sum = calculateWeightSum(temp);
            if( sum > maxSum )
            {
                maxSum = sum;
                tempMax = temp;
            }
        }

        maxList.addAll(tempMax);
        return maxList;

    }

    /**
     * Heuristic algorithm for seeking a maximum weighted independent
     * set.
     * @return Maximum weighted independent set solved by GWMIN algorithm.
     */
    public ArrayList WMINSolver()
    {
        // construct an arraylist which contains all elements of the nodearray
        ArrayList nodes = new ArrayList();
        for (int i = 0; i < NodeArray.length; i++)
            nodes.add(NodeArray[i]);

        ArrayList resultList = new ArrayList();
        //start WMIN algorithm
        while (!nodes.isEmpty())
        {
            int nodeIndex = WMINNodeSelect(nodes);
            Vertice selected = (Vertice) nodes.get(nodeIndex);
            resultList.add(selected);

            while (!selected.neighbours.isEmpty())
            {
                Integer neighbournum = (Integer)selected.neighbours.get(0);
                Vertice neighbour = NodeArray[neighbournum.intValue()];

                // secilen elemanin ilk komsusunun komsu listesinde secilen elemanin yerini bul
                // remove selected node from the neighbourlist of its neighbour
                int selectedIndex = neighbour.neighbours.indexOf(new Integer(selected.index));
                // bu elemani kaldir
                neighbour.neighbours.remove(selectedIndex);

                // komsunun butun komsularinin komsu listelerinden komsunun
                // kendisini sil, boylece degreelerini 1 dusurmus ol.
                while(!neighbour.neighbours.isEmpty())
                {
                    // komsunun komsusunu bul (bu da komsunun komsu listesinin ilk elemani oluyor)
                    Integer neighboursNeighbourNum = (Integer)neighbour.neighbours.get(0);
                    Vertice neighboursNeighbour = NodeArray[neighboursNeighbourNum.intValue()];

                    //komsunun komsusunun komsu listesinde komsunun kacinci eleman oldugunu bul
                    selectedIndex = neighboursNeighbour.neighbours.indexOf(neighbournum);

                    // o listeden bu elemani cikar
                    neighboursNeighbour.neighbours.remove(selectedIndex);

                    //komsunun komsu listesinden ilk elemani sil
                    neighbour.neighbours.remove(0);
                }

                //komsunun kendisini sil
                selected.neighbours.remove(0);
                int nnum = nodes.indexOf(neighbour);
                nodes.remove(nnum);
            }

            // sectigin elemani sil
            nodes.remove(nodes.indexOf(selected));
        }
        return resultList;
    }

    /** Heuristic algorithm used for finding the maximum
     * weighted independent set.
     *
     */
    public void WMAXSolver()
    {
        long beginning = System.currentTimeMillis();

        int selectedIndex = WMAXSelect();
        while (selectedIndex != -1)
        {
            // komsularin degreelerini birer dusur
            while (!NodeArray[selectedIndex].neighbours.isEmpty())
            {
                Integer tmpIndex = (Integer) NodeArray[selectedIndex].neighbours.get(0);
                Vertice tmp = NodeArray[tmpIndex.intValue()];
                // tmp nin komsu listesinde selectedindex in yerini bul
                int temp = tmp.neighbours.indexOf(new Integer(selectedIndex));
                // tmp nin komsu listesinden selectedindex i sil
                tmp.neighbours.remove(temp);
                // selected in komsu listesinden tmp yi sil
                NodeArray[selectedIndex].neighbours.remove(0);
            }
            // remove selectedIndex from the NodeArray
            NodeArray[selectedIndex] = null;
            selectedIndex = WMAXSelect();
        }

        long end = System.currentTimeMillis();

        // remaining elements will be printed on the screen
        int weightSum = 0;
        String result = "The vertices are:\n";
        int j = 0;
        for (int i = 0; i < NodeArray.length; i++)
        {
            if (NodeArray[i] != null)
            {
                weightSum += NodeArray[i].weight;
                result += i + " ";
                j++;
                if (j%10 == 0)
                    result += "\n";
            }
        }
        result += "\nMaximum weight is: " + weightSum;
        result += "\nTotal running time for GWMAX is " + (end - beginning) + " milliseconds.";
        JOptionPane.showMessageDialog(null,result);
        save(result);
    }

    /** Given an ArrayList that contains graph vertices as its elements,
     *  this method searches for the vertice which has the maximum
     *  weight / (degree + 1)  value and returns it.
     * @param nodes Graph vertices.
     * @return Index of the selected element.
     */
    public int WMINNodeSelect(ArrayList nodes)
    {
        double maxValue = 0;
        int element = 0;
        for (int i = 0 ; i < nodes.size(); i++)
        {
            Vertice tmp = (Vertice)nodes.get(i);
            if ( (tmp.weight) / (double)((tmp.neighbours.size()) + 1) > maxValue)
            {
                maxValue = (tmp.weight) / (double) ((tmp.neighbours.size()) + 1);
                element = i;
            }
        }
        return element;
    }

    /** Given a graph, this method searches for the vertice which has the
     * minumum weight / ( degree * (degree + 1) ) value and returns it.
     *
     * @return  Index of the selected element.
     */
    public int WMAXSelect()
    {
        int minNodeIndex = -1;
        double minGMAXValue = 0;
        int j = 0;
        for (j = 0; j < NodeArray.length; j++)
        {
            if (NodeArray[j] == null)
                continue;
            int NodeDegree = NodeArray[j].neighbours.size();
            if (NodeDegree == 0)
                continue;
            minGMAXValue = NodeArray[j].weight / (double)(NodeDegree*(NodeDegree+1));
            minNodeIndex = j;
            break;
        }
        for (int i = j; i  < NodeArray.length; i++)
        {
            if (NodeArray[i] == null)
                continue;
            int NodeDegree = NodeArray[i].neighbours.size();
            if (NodeDegree == 0)
                continue;
            double GMAXval = (double)NodeArray[i].weight / (double)(NodeDegree*(NodeDegree+1));
            if (GMAXval < minGMAXValue)
            {
                minGMAXValue = GMAXval;
                minNodeIndex = i;
            }
        }
        return minNodeIndex;
    }

    /** Driver method, which calls WMINSolver method.
     *
     */
    public void minSolver()
    {
        long beginning, end;

        // taking the time
        beginning = System.currentTimeMillis();

        ArrayList maxList = WMINSolver();

        // taking the end time of the algorithm
        end = System.currentTimeMillis();

        // taking all vertice indexes
        ArrayList verticeIndexes = new ArrayList();
        for (int i = 0; i < maxList.size(); i++)
        {
            Vertice tmp = (Vertice)maxList.get(i);
            verticeIndexes.add(new Integer(tmp.index));
        }

        // Sorting these indexes
        Collections.sort(verticeIndexes);

        String result = "Maximum weight is: " + calculateWeightSum(maxList) + "\nThe vertices are:";
        for( int i = 0; i < maxList.size(); i++ )
        {
            if (i%10 == 0)
                result += "\n";
            Integer tmp = (Integer)verticeIndexes.get(i);
            result += tmp.intValue() + " ";
        }
        result += "\nTotal running time for GWMIN is " + (end - beginning) + " milliseconds.";
        JOptionPane.showMessageDialog(null,result);
        save(result);
    }
    /**
     * Saves the given string in a file. Filename is taken from the user.
     * @param result The string to be saved.
     * @return True if the operation is successful.
     */
    boolean save (String result)
    {
        FileOutputStream out; //declare a file output object
        PrintStream p; //declare a print stream object
        try{
            String fileName = JOptionPane.showInputDialog(null,"File name to save the output");
            // open the file and bind p to file

            try {
                out = new FileOutputStream(fileName);
                } catch (FileNotFoundException e) {
                    return false;
                }
                p = new PrintStream(out);

                p.println (result);
                return true;
                //If user clicks the cancel button
        } catch(Exception e){
            return true;
        }
    }
}
