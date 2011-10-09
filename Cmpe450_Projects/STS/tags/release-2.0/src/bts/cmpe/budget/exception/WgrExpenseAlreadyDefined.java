package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author HSensoy
 *
 */
public class WgrExpenseAlreadyDefined extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2182924202282407820L;
	/**
	 * 
	 */
	private BudgetTO budget;
	
	/**
	 * @param b Budget instance causing error.
	 */
	public WgrExpenseAlreadyDefined(final BudgetTO b) {
		budget = b;
	}
}
