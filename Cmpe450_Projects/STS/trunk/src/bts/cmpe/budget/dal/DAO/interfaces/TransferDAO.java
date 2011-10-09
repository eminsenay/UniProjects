package bts.cmpe.budget.dal.DAO.interfaces;

import java.util.Vector;

import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.exception.NotEnoughBudget;
import bts.cmpe.budget.transfer.BudgetTO;
import bts.cmpe.budget.transfer.TransferTO;

/**
 * <code>TranferDAO</code> class is the interface class for transfers 
 * between budgets of two different departments.
 * 
 * <p> <code>isTransferAvailable</code> method 
 * locks the budget of from department
 * if budget is available until <code>Transaction</code> object 
 * is committed or rolled back. 
 * <code>isTransferAvailable</code> method must 
 * be used with extreme care, because of
 * its locking property.
 * 
 * @author ozan
 *
 */
public interface TransferDAO {

	
	/**
	 * @param from department involved in a transfer
	 * @return all the transfers made with parameterized department
	 * @throws NoTransferMade Transfer Made.
	 * @throws NoSuchDepartmentException if parameter depart does not exist
	 */
	Vector < TransferTO > getAllTransfers(final BudgetTO from)
	throws NoSuchBudgetException;
	
	/**
	 * @param bdgt BudgetTO instance.
	 * @return total transfer amount.
	 * @throws NoSuchBudgetException No budget found with defined parameters.
	 */
	double getTransferTotal(final BudgetTO bdgt)
	throws NoSuchBudgetException;
	
	/**
	 * @param bdgt Budget instance.
	 * @param quantity that transfered from sender to receiver.<br>
	 * negative number usage is discouraged.
	 * @return true if budget is available. false otherwise.
	 * @throws NoSuchBudgetException if any of two 
	 * departments does not exist.
	 */
	boolean isTranferAvailable(final BudgetTO bdgt, final double quantity) 
	throws NoSuchBudgetException;
	
	/**
	 * @param to receiver
	 * @param from sender
	 * @param quantity that transfered from sender to receiver.<br>
	 * negative number usage is discouraged. 
	 * @param description description of the transfer must not be empty or null.
	 * @throws NotEnoughBudget Not enough budget in sender cache. 
	 * @throws NoSuchDepartmentException if any of two 
	 * departments does not exist
	 */
	void makeTransfer(final BudgetTO to, 
			final BudgetTO from, final double quantity,
			final String description)
	throws NoSuchBudgetException, NotEnoughBudget;	
}
