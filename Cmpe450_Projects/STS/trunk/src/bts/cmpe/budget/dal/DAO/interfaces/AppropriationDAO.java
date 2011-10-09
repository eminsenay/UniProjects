package bts.cmpe.budget.dal.DAO.interfaces;

import java.util.Vector;

import bts.cmpe.budget.exception.ApprRedefined;
import bts.cmpe.budget.exception.MoreApprThanExpected;
import bts.cmpe.budget.exception.NoAdditionalApprDefined;
import bts.cmpe.budget.exception.NoApprDefined;
import bts.cmpe.budget.exception.NoPeriodicApprDefined;
import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.transfer.AppropriationTO;
import bts.cmpe.budget.transfer.BudgetTO;


/**
 * @author HSensoy
 *
 */
public interface AppropriationDAO {

	/**
	 * @param budget Budget transfer object.
	 * @return Appropriation period
	 * @throws NoSuchBudgetException Budget not found.
	 */
	int getPeriod(final BudgetTO budget)
			throws NoSuchBudgetException;

	/**
	 * @param budget Budget transfer object.
	 * @return Vector of all appropriations.
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws NoApprDefined Appr not found.
	 */
	Vector < AppropriationTO > getAllAppropriations(final BudgetTO budget) 
	throws  NoSuchBudgetException, NoApprDefined;
	

	/**
	 * @param budget Budget to which appr will be added.
	 * @param appr Appropriation object instance
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws MoreApprThanExpected More than expected 
	 * number of appropriation definition.
	 * @throws ApprRedefined Appropriation redefined.
	 */
	void insertMainAppropriation(final BudgetTO budget, 
			final AppropriationTO appr)
			throws NoSuchBudgetException, MoreApprThanExpected, ApprRedefined;
	

	/**
	 * @param budget Budget to which appr will be added.
	 * @param appr Appropriation object instance
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws ApprRedefined Appropriation redefined.
	 */
	void insertAddAppropriation(final BudgetTO budget, 
			final AppropriationTO appr)
			throws NoSuchBudgetException, ApprRedefined;
	
	/**
	 * @param budget Budget to be queried.
	 * @return Sum(main_appr)
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws NoPeriodicApprDefined Appr of the following type can't be found.
	 * @throws ApprRedefined Appropriation redefined.
	 */
	double getPeriodicAppropriationTotal(final BudgetTO budget)
			throws  NoSuchBudgetException, NoPeriodicApprDefined, ApprRedefined;

	/**
	 * @param budget Budget to be queried.
	 * @return Sum(main_appr)
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws NoAdditionalApprDefined Appr of the 
	 * following type can't be found.
	 */
	double getAdditionalAppropriationTotal(final BudgetTO budget)
			throws NoSuchBudgetException, NoAdditionalApprDefined;
}
