package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author Koca Kahin
 *
 */
public class ApprRedefined extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8665113150494874645L;
	
	/**
	 * Key 2 violation.
	 */
	public static final int ERR_CODE = 1062;
	
	/**
	 * 
	 */
	private BudgetTO budget;

	/**
	 * @param bd Budget causing exception
	 */
	public ApprRedefined(final BudgetTO bd) {
		super("Ayni index numarasi ile tanimli �denek mevcut.");
		budget = bd;
	}

	/**
	 * @param bd Budget causing exception
	 * @param message new message for exception.
	 */
	public ApprRedefined(final BudgetTO bd, final String message) {
		super(message);
		budget = bd;
	}

	/**
	 * @return the budget
	 */
	public final BudgetTO getBudget() {
		return budget;
	}

	/**
	 * @param bdgt the budget to set
	 */
	public final void setBudget(final BudgetTO bdgt) {
		this.budget = bdgt;
	}

}
