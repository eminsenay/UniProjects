package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author ozan
 *
 */
public class NoSuchBudgetException extends Exception {

	/**
	 * serial version id.
	 */
	private static final long serialVersionUID = -2009429496949026357L;
	/**
	 *  the non-existant budget.
	 */
	private BudgetTO budget;
	

	/**
	 * @param pbudget Budget Object
	 */
	public NoSuchBudgetException(final BudgetTO pbudget) {
		super("Aradığınız bütçe bilgisi bulunamamıştır.");
		budget = pbudget;
	}
	
	/**
	 * @return  budget.
	 */
	public final BudgetTO getBudget() {
		return budget;
	}
}

