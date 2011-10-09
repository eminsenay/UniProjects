/**
 * 
 */
package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author HSensoy
 *
 */
public class NoApprDefined extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 
	 */
	private BudgetTO  budget;


	/**
	 * @param pbudget BudgetTO instance.
	 */
	public NoApprDefined(final BudgetTO pbudget) {
		super("Ilgili bütçeye ait tanimli ödenek bulunamadi.");
		budget = pbudget;
	}
	
	/**
	 * @param pbudget BudgetTO instance.
	 * @param msg Exception message.
	 */
	public NoApprDefined(final BudgetTO pbudget, final String msg) {
		super(msg);
		budget = pbudget;
	}

	/**
	 * @return the appr
	 */
	public final BudgetTO getBudget() {
		return budget;
	}

}
