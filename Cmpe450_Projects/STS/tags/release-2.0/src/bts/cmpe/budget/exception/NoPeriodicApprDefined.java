package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author HSensoy
 *
 */
public class NoPeriodicApprDefined extends NoApprDefined {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @param budget BudgetTO instance
	 */
	public NoPeriodicApprDefined(final BudgetTO budget) {
		super(budget, "Ilgili bütçeye ait periodik ödenek bulunamadý.");
	}

}
