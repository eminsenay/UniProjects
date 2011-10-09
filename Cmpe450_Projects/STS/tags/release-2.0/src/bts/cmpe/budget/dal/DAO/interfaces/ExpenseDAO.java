package bts.cmpe.budget.dal.DAO.interfaces;

import java.sql.SQLException;
import java.util.Vector;

import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.exception.NotEnoughBudget;
import bts.cmpe.budget.exception.StdExpenseAlreadyDefined;
import bts.cmpe.budget.exception.WgrExpenseAlreadyDefined;
import bts.cmpe.budget.transfer.BudgetTO;
import bts.cmpe.budget.transfer.ExpenseStdTO;
import bts.cmpe.budget.transfer.ExpenseWgrTO;
/**
 * @author ozan
 *
 */
public interface ExpenseDAO {	
	/**
	 * @param dept department.
	 * @return total expenditure done by this department
	 * @throws NoExpenseFound No expense found.
	 * @throws NoSuchDepartmentException if department doese not exist
	 */
	double getTotalExpenditure(BudgetTO dept) 
	throws NoSuchBudgetException;
	
	
	/**
	 * @param dept department
	 * @param expenditureIndex defter sıra no of expenditure
	 * @throws NoSuchDepartmentException if department doese not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	void deleteExpenditure(BudgetTO dept, int expenditureIndex)
	throws NoSuchBudgetException, SQLException;
	
	/**
	 * @param budget Budget object.
	 * @param expense Expense object.
	 * @throws NoSuchBudgetException No exception defined.
	 * @throws WgrExpenseAlreadyDefined No wager expense defined.
	 * @throws NotEnoughBudget budget is not enough.
	 */
	void addWgrExpense(final BudgetTO budget,
			final ExpenseWgrTO expense) throws NoSuchBudgetException,
			WgrExpenseAlreadyDefined, NotEnoughBudget;
	
	/**
	 * @param budget Budget Object.
	 * @param expense Expense Object.
	 * @throws NoSuchBudgetException No budget found.
	 * @throws StdExpenseAlreadyDefined Expense already defined.
	 * @throws NotEnoughBudget Not enough budget.
	 */
	void addStdExpense(final BudgetTO budget,
			final ExpenseStdTO expense) throws NoSuchBudgetException,
			StdExpenseAlreadyDefined, NotEnoughBudget;
	
	/**
	 * @param b Budget object.
	 * @param startInv Starting inventory number.
	 * @param endInv Ending inventor number.
	 * @param sortCol Sort according to column number.
	 * @param isDesc Sort in asceding order.
	 * @return List of standard expenses.
	 * @throws NoSuchBudgetException No budget found with defined parameters. 
	 */
	Vector < ExpenseStdTO > getStdExpense(final BudgetTO b,
			final int startInv, final int endInv, final int sortCol,
			final boolean isDesc) throws 
			NoSuchBudgetException;
}
