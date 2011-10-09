package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author HSensoy
 *
 */
public class StdExpenseAlreadyDefined extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1106442365475574599L;

	/**
	 * @param b Budget causing error.
	 */
	public StdExpenseAlreadyDefined(final BudgetTO b) {
		
	}

}
