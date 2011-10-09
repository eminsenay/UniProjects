/**
 * 
 */
package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author yanis
 *
 */
public class MoreApprThanExpected extends BudgetAlreadyDefined {


	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1298451434963190567L;

	

	/**
	 * @param bd Budget causing exception
	 */
	public MoreApprThanExpected(final BudgetTO bd) {
		super(bd, "Ayný isimli birden fazla ödenek tanýmlý.");
	}



	
	
}
