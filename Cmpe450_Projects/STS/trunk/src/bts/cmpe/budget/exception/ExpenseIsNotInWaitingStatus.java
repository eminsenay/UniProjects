package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.ExpenseBaseTO;

public class ExpenseIsNotInWaitingStatus extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8665113150494874645L;
	
	/**
	 * 
	 */
	private ExpenseBaseTO expenditure;

	/**
	 * @param exp BaseExpense object.
	 */ 
	public ExpenseIsNotInWaitingStatus(final ExpenseBaseTO exp) {
		super("Harcamalari onaylayabilmeniz icin bekleme "
				+ "durumunda olmalari gerekmektedir.");
		expenditure = exp;
	}


	/**
	 * @param exp BaseExpense object.
	 * @param message More explaination on raising exception.
	 */
	public ExpenseIsNotInWaitingStatus(final ExpenseBaseTO exp, 
			final String message) {
		super(message);
		expenditure = exp;
	}

	/**
	 * @return the expenditure
	 */
	public final ExpenseBaseTO getExpense() {
		return expenditure;
	}

	/**
	 * @param exp expenditure to be set.
	 */
	public final void setExpense(final ExpenseBaseTO exp) {
		this.expenditure = exp;
	}

}
