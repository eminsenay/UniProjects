package bts.cmpe.budget.dal.DAO.interfaces;

import java.sql.SQLException;

import bts.cmpe.budget.dal.exception.NoSuchDepartmentException;
import bts.cmpe.budget.dal.transfer.DepartmentTO;
import bts.cmpe.budget.dal.transfer.TransferTO;

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
	 * @throws NoSuchDepartmentException if parameter depart does not exist
	 * @throws SQLException must be catched and must be written to log file.
	 */
	TransferTO[] getAllTransfers(final DepartmentTO from)
	throws NoSuchDepartmentException, SQLException;
	
	/**
	 * @param to receiver 
	 * @param from sender
	 * @param quantity that transfered from sender to receiver.<br>
	 * negative number usage is discouraged.
	 * @return true if budget is available. false otherwise.
	 * @throws NoSuchDepartmentException if any of two 
	 * departments does not exist.
	 * @throws SQLException must be catched and must be written to log file.
	 */
	boolean isTranferAvailable(final DepartmentTO to, 
			final DepartmentTO from, final double quantity) 
	throws NoSuchDepartmentException, SQLException;
	
	/**
	 * @param to receiver
	 * @param from sender
	 * @param quantity that transfered from sender to receiver.<br>
	 * negative number usage is discouraged. 
	 * @param description description of the transfer must not be empty or null.
	 * @throws NoSuchDepartmentException if any of two 
	 * departments does not exist
	 * @throws SQLException must be catched and written into log file.
	 */
	void makeTransfer(final DepartmentTO to, 
			final DepartmentTO from, final double quantity,
			final String description)
	throws NoSuchDepartmentException, SQLException;
	
	
	/**
	 * @param dept department
	 * @return transfer balance for the department
	 * @throws NoSuchDepartmentException if department does not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	double getTransferTotal(final DepartmentTO dept)
	throws NoSuchDepartmentException, SQLException;;
	
}
