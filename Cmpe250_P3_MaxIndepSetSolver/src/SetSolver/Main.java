package SetSolver;


import javax.swing.*;

/**
 * Student IDs: 2002103907 & 2002101414
 * Date: May 18, 2005
 * Time: 6:14:12 PM
 * @author Emin Þenay & Atilla Soner Balkýr
 */
public class Main {
    /**
     * Main method of the program. Asks user the file that contains the graph and
     * asks which solution he wants.
     * @param args Not used
     */
    public static void main (String [] args)
    {
        // creating a new instance of set solver class
        SetSolver s = new SetSolver();
        try
        {
            // taking the filename to read
            String fileName = JOptionPane.showInputDialog(null,"Please enter the filename to read: ");
            int opt = JOptionPane.showConfirmDialog(null,"Do you want an optimum solution","Optimum solution"
                ,JOptionPane.YES_NO_OPTION);
            int GWMIN = JOptionPane.showConfirmDialog(null,"Do you want a GWMIN solution","GWMIN solution"
                ,JOptionPane.YES_NO_OPTION);
            int GWMAX = JOptionPane.showConfirmDialog(null,"Do you want a GWMAX solution","GWMAX solution"
                ,JOptionPane.YES_NO_OPTION);

            // loading the graph
            s.loadGraph(fileName);
            // Optimum solution
            if (opt == 0)
                s.optimumSolver();
            // GWMIN solution
            if (GWMIN == 0)
                s.minSolver();
            // GWMAX solution
            if (GWMAX == 0)
            {
                s.loadGraph(fileName);
                s.WMAXSolver();
            }
            System.exit(0);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null,"You must enter a file name.");
            System.exit(0);
        }
    }
}
