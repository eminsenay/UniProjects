package SetSolver;


import java.util.ArrayList;

/**
 * Student IDs: 2002103907 & 2002101414
 * Date: May 17, 2005
 * Time: 14:51:59
 * @author : Emin Þenay & Atilla Soner Balkýr
 */

/** Class used for creating Vertice objects that have
 * index and weight values and a list of neighbours.
 *
 */
public class Vertice {
    /**
     * Neighbours of the vertice.
     */
    ArrayList neighbours = new ArrayList();
    /**
     * Index number of the vertice.
     */
    int index;
    /**
     * Weight of the vertice.
     */
    int weight;
}

