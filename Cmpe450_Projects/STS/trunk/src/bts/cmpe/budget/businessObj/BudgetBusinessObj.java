package bts.cmpe.budget.businessObj;

import java.sql.SQLException;
import java.util.Vector;

import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.mysql.BudgetDAOMySQL;
import bts.cmpe.budget.exception.BudgetAlreadyDefined;
import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author eyyup.
 *
 */
public class BudgetBusinessObj {
	
	/**
	 * Insert a new budget item into database.
	 * 
	 * @param budget Budget item
	 * @throws Exception Run-Time Exception
	 */
	public final void insertBudget(final BudgetTO budget) 
	throws Exception {
		Transaction tr = null;

		try {
			tr = Transaction.create();
		
			BudgetDAOMySQL dao = new BudgetDAOMySQL(tr);

			dao.insertBudget(budget);

			tr.commit();
		} catch (BudgetAlreadyDefined e) {
			tr.rollback();
			throw e;
		} catch (SQLException e) {
			tr.rollback();
			throw e;
		} catch (Exception e) {
			tr.rollback();
			throw e;
		} finally {
			tr.terminate();
		}
	}
	
	/**
	 * after call to this function type of expenditures for. 
	 * current department is set.
	 * @param budget department.
	 * @return all economic sub parts.
	 * @throws Exception for all kinds of exceptions.
	 */
	public final Vector < BudgetTO > getEconomicCodes(final BudgetTO budget)
	throws Exception {
		
		Transaction tr = null;
		Vector < BudgetTO > economicCodes;

		try {
			tr = Transaction.create();
			BudgetDAOMySQL dao = new BudgetDAOMySQL(tr);

			economicCodes = dao.getEconomicCodes(budget);

			tr.commit();
		} catch (NoSuchBudgetException e) {
			throw e;
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
		
		return economicCodes;
	}
	
	/**
	 * @param oldBudget Budget to be updated only setting 
	 * triple definer parameter is enough
	 * @param newBudget New Budget object
	 * @throws Exception Run-Time Exception
	 */
	public final void updateDepartment(final BudgetTO oldBudget, 
			final BudgetTO newBudget)	throws Exception {
		
		Transaction tr = null;

		try {
			tr = Transaction.create();
			BudgetDAOMySQL dao = new BudgetDAOMySQL(tr);

			dao.updateBudget(oldBudget, newBudget);

			tr.commit();
			
		} catch (NoSuchBudgetException e) {
			tr.rollback();
			throw e;
		} catch (SQLException e) {
			tr.rollback();
			throw e;
		} catch (Exception e) {
			tr.rollback();
			throw e;
		} finally {
			tr.terminate();
		}
	}
	
	/**
	 * @param budget budget that needs details
	 * @throws Exception for all kinds of exceptions.
	 */
	public final void getBudgetDetails(final BudgetTO budget) 
	throws Exception {
		Transaction tr = null;

		try {
			tr = Transaction.create();
			BudgetDAOMySQL budgetDAO = new BudgetDAOMySQL(tr);

			BudgetTO details = budgetDAO.getBudgetDetail(budget);
			
			budget.setType(details.getType());
			budget.setNumMainAppr(details.getNumMainAppr());

			tr.commit();
			
		} catch (Exception e) {
			tr.rollback();
			throw e;
		} finally {
			tr.terminate();
		}		
	}
}
