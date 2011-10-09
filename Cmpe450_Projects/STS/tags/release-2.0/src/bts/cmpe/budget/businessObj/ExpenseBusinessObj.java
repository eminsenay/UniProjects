package bts.cmpe.budget.businessObj;

import java.util.Vector;

import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.mysql.ExpenseDAOMySQL;
import bts.cmpe.budget.transfer.BudgetTO;
import bts.cmpe.budget.transfer.ExpenseStdTO;
import bts.cmpe.budget.transfer.ExpenseWgrTO;

/**
 * @author funda
 *
 */

public class ExpenseBusinessObj {

	/**
	 * 
	 * @param budget DepartmentTO object
	 * @param rangeMin for minimum range
	 * @param rangeMax for maximum range
	 *@param sortType column to sort over the data
	 * @param isAscending ascending or descending order
	 * @return exp ExpenditureTO object.
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */

	public final Vector < ExpenseStdTO > getStdExpenses(final BudgetTO budget,
			final int rangeMin, final int rangeMax, final int sortType,
			final boolean isAscending) throws Exception {

		Transaction tr = null;
		Vector < ExpenseStdTO > exArray;

		try {
			tr = Transaction.create();
			ExpenseDAOMySQL exMySql = new ExpenseDAOMySQL(tr);

			exArray = exMySql.getStdExpense(budget, rangeMin, rangeMax,
					sortType, isAscending);

			tr.commit();

			return exArray;
		} catch (Exception e) {
			tr.rollback();
			throw e;
		} finally {
			tr.terminate();
		}
	}
	/**
	 * 
	 * @param budget DepartmentTO object
	 * @param rangeMin for minimum range
	 * @param rangeMax for maximum range
	 *@param sortType column to sort over the data
	 * @param isAscending ascending or descending order
	 * @return exp ExpenditureTO object.
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */

	public final Vector < ExpenseWgrTO > getWgrExpenses(final BudgetTO budget,
			final int rangeMin, final int rangeMax, final int sortType,
			final boolean isAscending) throws Exception {

		Transaction tr = null;
		Vector < ExpenseWgrTO > exArray;

		try {
			tr = Transaction.create();
			ExpenseDAOMySQL exMySql = new ExpenseDAOMySQL(tr);

			exArray = exMySql.getWgrExpense(budget, rangeMin, rangeMax,
					sortType, isAscending);

			tr.commit();

			return exArray;
		} catch (Exception e) {
			tr.rollback();
			throw e;
		} finally {
			tr.terminate();
		}
	}
	
	/**
	 * 
	 * @param budget DepartmentTO object.
	 * @param expenditure ExpenditureTO object.
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */
	public final void addWgrExpense(final BudgetTO budget,
			final ExpenseWgrTO expenditure) throws Exception {

		Transaction tr = null;

		try {
			tr = Transaction.create();
			ExpenseDAOMySQL trans = new ExpenseDAOMySQL(tr);

			trans.addWgrExpense(budget, expenditure);
			tr.commit();
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}
	
	/**
	 * 
	 * @param budget DepartmentTO object.
	 * @param expenditure ExpenditureTO object.
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */
	public final void addStdExpense(final BudgetTO budget,
			final ExpenseStdTO expenditure) throws Exception {

		Transaction tr = null;

		try {
			tr = Transaction.create();
			ExpenseDAOMySQL trans = new ExpenseDAOMySQL(tr);

			trans.addStdExpense(budget, expenditure);
			tr.commit();
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}
	/**
	 * 
	 * @param budget DepartmentTO object
	 * @param expenditureIndex for index for the expenditure
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */
	public final void deleteExpense(final BudgetTO budget,
			final int expenditureIndex) throws Exception {

		Transaction tr = null;

		try {
			tr = Transaction.create();
			ExpenseDAOMySQL trans = new ExpenseDAOMySQL(tr);

			trans.deleteExpenditure(budget, expenditureIndex);
			tr.commit();
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

	/**
	 * 
	 * @param dept DepartmentTO object
	 * @return totalExp total expenditure amount
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */
	public final double getTotalExpense(final BudgetTO dept)
			throws Exception {

		Transaction tr = null;
		double totalExp;

		try {
			tr = Transaction.create();
			ExpenseDAOMySQL trans = new ExpenseDAOMySQL(tr);

			totalExp = trans.getTotalExpenditure(dept);
			tr.commit();
			return totalExp;
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

}
