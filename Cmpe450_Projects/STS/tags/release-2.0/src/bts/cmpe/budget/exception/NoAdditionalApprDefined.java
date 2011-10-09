/**
 * 
 */
package bts.cmpe.budget.exception;

import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author PTHSENSOY
 *
 */
public class NoAdditionalApprDefined extends NoApprDefined {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @param pbudget BudgetTO obj.
	 */
	public NoAdditionalApprDefined(final BudgetTO pbudget) {
		super(pbudget, "Ilgili b�t�eye ait ek �denek bulunamad�.");
	}
	


}
