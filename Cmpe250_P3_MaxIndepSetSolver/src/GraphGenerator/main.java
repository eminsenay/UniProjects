package GraphGenerator;


import javax.swing.*;

/**
 * Student IDs: 2002103907 & 2002101414
 * Date: May 8, 2005
 * Time: 7:41:48 PM
 * @author Emin Þenay & Atilla Soner Balkýr
 */
/**
 * Main class to run the program
 */
public class main {
    /**
     * Takes the input and sends it to the graph generator.
     * @param args Not used.
     */
    public static void main (String args[])
    {
        // Creating a new instance of the generator class
        Generator g = new Generator();
        try {
            String fileName = JOptionPane.showInputDialog(null,"Please enter the file name to be saved:");
            String numNodes = JOptionPane.showInputDialog(null,"Please enter the number of nodes:");
            String minDegree = JOptionPane.showInputDialog(null,"Please enter minimum degree:");
            String minWeight = JOptionPane.showInputDialog(null,"Please enter minimum weight:");
            String maxWeight = JOptionPane.showInputDialog(null,"Please enter maximum weight:");
            g.GenerateGraph(Integer.parseInt(numNodes),Integer.parseInt(minDegree),Integer.parseInt(minWeight),
                Integer.parseInt(maxWeight),fileName);
            System.exit(0);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null,"Missing input");
            System.exit(0);
        }

    }
}
