package bts.cmpe.budget.dal.DAO.interfaces;

import java.util.Vector;

import bts.cmpe.budget.exception.BudgetAlreadyDefined;
import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author ozan
 *
 */
public interface BudgetDAO {
	/**
	 * after call to this function type of expenditures for 
	 * current department is set.
	 * @param budget Budget to be queried.
	 * @return all economic sub parts
	 * @throws NoSuchDepartmentException if department does not exist.
	 */
	Vector < BudgetTO > getEconomicCodes(
			BudgetTO budget) throws NoSuchBudgetException;
	
	/**
	 * @param bgdt B
	 * @return Budget instance
	 * @throws NoSuchBudgetException No budget found.
	 */
	BudgetTO getBudgetDetail(final BudgetTO bgdt) 
	throws NoSuchBudgetException;
	
	
	/**
	 * @param budget budget to insert
	 * @throws BudgetAlreadyDefined Don't allow duplicate entry.
	 */
	void insertBudget(BudgetTO budget) throws BudgetAlreadyDefined;
	
	/**
	 * @param oldBudget budget to update
	 * @param newBudget final state of budget
	 * @throws NoSuchDepartmentException if department does not exist.
	 */
	void updateBudget(BudgetTO oldBudget, BudgetTO newBudget)
	throws NoSuchBudgetException;
}
