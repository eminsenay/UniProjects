
/**
 * Student ID: 2002103907
 * Project: Cmpe 250 Project #2 - Simple Matrix Calculator
 * Date: 28.Nis.2005
 * Time: 11:06:17
 * @author Emin Þenay
 */
public class MyDouble {
    /**
     * Create a new MyDouble with given initial value.
     *
     * @param val Initial value.
     */
    MyDouble (double val)
    {
        value = val;
    }
    /**
     * Change the value of MyDouble.
     *
     * @param val New value.
     */
    void setValue (double val)
    {
        value = val;
    }
    /**
     * Give double value of MyDouble.
     *
     * @return Double Value of MyDouble.
     */
    double todouble()
    {
        return value;
    }
    double value;
    /**
    * Round a double value to a specified number of decimal
    * places.
    *
    * @param places The number of decimal places to round to.
    * @return val Rounded to places decimal places.
    */
    double round(int places)
    {
        double val = value;
	    long factor = (long)Math.pow(10,places);

	    // Shift the decimal the correct number of places
    	// to the right.
    	val = val * factor;

    	// Round to the nearest integer.
    	long tmp = Math.round(val);

    	// Shift the decimal the correct number of places
    	// back to the left.
    	return (double)tmp / factor;
    }
}
