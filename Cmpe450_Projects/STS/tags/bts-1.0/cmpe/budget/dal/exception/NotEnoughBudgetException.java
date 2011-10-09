package bts.cmpe.budget.dal.exception;

import bts.cmpe.budget.dal.transfer.DepartmentTO;

/**
 * Thrown when a department does not have enough budget.
 * @author ozan
 *
 */
public class NotEnoughBudgetException extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1047576073031537998L;
	
	/**
	 * the department which does not have enough budget. 
	 */
	private DepartmentTO dept;
	/**
	 * current quantity.
	 */
	private double current;
	
	/**
	 * demanded quantitiy.
	 */
	private double demanded;
	
	
	/**
	 * @param myDept department that does not have enough budget. 
	 */
	/**
	 * @param myDept department that does not have enough budget.
	 * @param myCurrent current quantity of budget.
	 * @param myDemanded demanded quantity from budget.
	 */
	public NotEnoughBudgetException(final DepartmentTO myDept, 
			final double myCurrent, final double myDemanded) {
		dept = myDept;
		current = myCurrent;
		demanded = myDemanded;
	}
	
	
	/**
	 * @return department that 
	 */
	public final DepartmentTO getDept() {
		return dept;
	}
	
	/**
	 * @return current budget.
	 */
	public final double getCurrent() {
		return current;
	}
	
	/**
	 * @return demanded quantity.
	 */
	public final double getDemanded() {
		return demanded;
	}
}
