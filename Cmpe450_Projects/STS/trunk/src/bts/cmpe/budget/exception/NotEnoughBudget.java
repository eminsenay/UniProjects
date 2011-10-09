package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author Koca Kahin
 *
 */
public class NotEnoughBudget extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 607182855360570798L;
	/**
	 * 
	 */
	private BudgetTO budget;
	
	/**
	 * @param bdgt Budget instance.
	 */
	public NotEnoughBudget(final BudgetTO bdgt) {
		super("Transfer/Harcama için gerekli butce bulunamamistir.");
		budget = bdgt;
	}

	/**
	 * @return Budget field.
	 */
	public final BudgetTO getBudget() {
		return budget;
	}
}
