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
	private BudgetTO bt;
	
	/**
	 * @param bdgt Budget instance.
	 */
	public NotEnoughBudget(final BudgetTO bdgt) {
		super("Transfer/Harcama için gerekli butce bulunamamistir.");
		bt = bdgt;
	}

}
