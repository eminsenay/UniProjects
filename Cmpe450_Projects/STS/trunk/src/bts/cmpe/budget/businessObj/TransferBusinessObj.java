package bts.cmpe.budget.businessObj;
import java.util.Vector;

import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.mysql.TransferDAOMySQL;
import bts.cmpe.budget.transfer.BudgetTO;
import bts.cmpe.budget.transfer.TransferTO;

/**
 * @author funda
 *
 */
public class TransferBusinessObj {
	/**
	 * default constructor.
	 */
	public TransferBusinessObj() {
		
	}
	
	/**
	 * @param b department involved in a transfer
	 * @return all the transfers made with parameterized department
	 * @throws Exception if an exception occurs: NoSuchDepartmentException, <br>
	 * SQLException, Exception
	 */
	public final Vector < TransferTO > getAllTransfers(final BudgetTO b)
	throws Exception {
		
		Transaction tr = null;

		try {
			
			tr = Transaction.create();
			
			TransferDAOMySQL trans = new TransferDAOMySQL(tr);

			Vector < TransferTO > transfers = trans.getAllTransfers(b);

			tr.commit();
			
			return transfers;
			
		} catch (Exception e) {
			tr.rollback();
			throw e;
			
		} finally {
			
			tr.terminate();
			
		}
	}
	
	
	/**
	 * @param from sender
	 * @param quantity that transfered from sender to receiver.<br>
	 * negative number usage is discouraged.
	 * @return true if budget is available. false otherwise.
	 * @throws Exception if an exception occurs: NoSuchDepartmentException, <br>
	 * SQLException, Exception
	 */
	public final boolean isTranferAvailable(final BudgetTO from, 
			final double quantity) throws Exception {
		
		Transaction tr = null;

		try {
			
			tr = Transaction.create();
			
			TransferDAOMySQL trans = new TransferDAOMySQL(tr);

			boolean available = trans.isTranferAvailable(from, quantity);

			tr.commit();
			
			return available;
			
		} catch (Exception e) {
			tr.rollback();
			throw e;
			
		} finally {
			
			tr.terminate();
			
		}
	}
	
	
	/**
	 * @param to receiver
	 * @param from sender
	 * @param quantity that transfered from sender to receiver.<br>
	 * negative number usage is discouraged. 
	 * @param description description of the transfer must not be empty or null.
	 * @throws Exception if an exception occurs: NoSuchDepartmentException, <br>
	 * SQLException, Exception
	 */
	public final void makeTransfer(final BudgetTO to,
			final BudgetTO from, final double quantity,
			final String description)
	throws Exception {
		
		Transaction tr = null;

		try {
			
			tr = Transaction.create();
			
			TransferDAOMySQL trans = new TransferDAOMySQL(tr);

			trans.makeTransfer(to, from, quantity, description);

			tr.commit();
			
		} catch (Exception e) {
			
			throw e;
			
		} finally {
			
			tr.terminate();
			
		}
	}
	
	/**
	 * @param dept DepartmentTO object
	 * @return num double.
	 * @throws Exception SQLException
	 */
	public final double getTransferTotal(final BudgetTO dept) 
	throws Exception {
		
		Transaction tr = null;
		double num;

		try {
			
			tr = Transaction.create();
			
			TransferDAOMySQL trans = new TransferDAOMySQL(tr);
			num = trans.getTransferTotal(dept);
			tr.commit();
			return num;
			
		} catch (Exception e) {
			
			throw e;
			
		} finally {
			
			tr.terminate();
			
		}
	}
	/**
	 * @param dept DepartmentTO object
	 * @return num double.
	 * @throws Exception SQLException
	 */
	public final double getReceivedTransferTotal(final BudgetTO dept) 
	throws Exception {
		
		Transaction tr = null;
		double num;

		try {
			
			tr = Transaction.create();
			
			TransferDAOMySQL trans = new TransferDAOMySQL(tr);
			num = trans.getReceivedTransferTotal(dept);
			tr.commit();
			return num;
			
		} catch (Exception e) {
			
			throw e;
			
		} finally {
			
			tr.terminate();
			
		}
	}
	
	/**
	 * @param dept DepartmentTO object
	 * @return num double.
	 * @throws Exception SQLException
	 */
	public final double getSendTransferTotal(final BudgetTO dept) 
	throws Exception {
		
		Transaction tr = null;
		double num;

		try {
			
			tr = Transaction.create();
			
			TransferDAOMySQL trans = new TransferDAOMySQL(tr);
			num = trans.getSendTransferTotal(dept);
			tr.commit();
			return num;
			
		} catch (Exception e) {
			
			throw e;
			
		} finally {
			
			tr.terminate();
			
		}
	}
}
