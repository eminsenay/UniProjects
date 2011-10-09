package bts.cmpe.budget.transfer;

/**
 * @author HSensoy
 *
 */
public class ExpenseWgrTO extends ExpenseBaseTO {
	
	/**
	 * 
	 */
	private int id;
	
	/**
	 * 
	 */
	private double[] additional; 
	/**
	 * 
	 */
	private static final int SIZE = 6;

	/**
	 * 
	 */
	public ExpenseWgrTO() {
		super();
		additional = new double[SIZE];
	}
	
	/**
	 * @param index Which additional attribute.
	 * @return the attribute value.
	 */
	public final double getAdditional(final int index) {
		return additional[index];
	}
	
	/**
	 * @param index Which additional attribute.
	 * @param value New value.
	 */
	public final void setAdditional(final int index, final double value) {
		additional[index] = value;
	}

	/**
	 * @return the sIZE
	 */
	public static final int getSIZE() {
		return SIZE;
	}

	/**
	 * @return Expense ID
	 */
	public final int getId() {
		return id;
	}

	/**
	 * @param pid Expense ID
	 */
	public final void setId(final int pid) {
		this.id = pid;
	}

}
