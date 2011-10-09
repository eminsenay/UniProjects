package bts.cmpe.budget.businessObj;

import java.util.Vector;

import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.mysql.AppropriationDAOMySQL;
import bts.cmpe.budget.transfer.AppropriationTO;
import bts.cmpe.budget.transfer.BudgetTO;
import bts.cmpe.budget.exception.NoAdditionalApprDefined;
import bts.cmpe.budget.exception.NoApprDefined;

/**
 * @author funda
 * 
 */

public class AppropriationBusinessObj {

	
	/**
	 * @param budget budget
	 *            economic code
	 * @return periodNum period number.
	 * @throws Exception
	 *             exception
	 */

	public final double getPeriod(final BudgetTO budget) throws Exception {

		Transaction tr = null;
		double periodNum;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);

			periodNum = trans.getPeriod(budget);

			tr.commit();
			return periodNum;

		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

	/**
	 * @param budget budget
	 * @return appr AppropriationTO object.
	 * @throws Exception
	 *             exception
	 */
	public final Vector < AppropriationTO > getAllAppropriations(
			final BudgetTO budget) throws Exception {
		Transaction tr = null;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);

			Vector < AppropriationTO > appr = 
				trans.getAllAppropriations(budget);
			tr.commit();
			return appr;

		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}
// TODO: buna gore mcgaywer
	/**
	 * @param instCode
	 *            institiuonal code.
	 * @param funcCode
	 *            functional code
	 * @param ecoCode
	 *            economic code
	 * @param type
	 *            for type
	 * @param index
	 *            for index
	 * @param quantity
	 *            for quantity
	 * @param description
	 *            for description
	 * @throws Exception
	 *             exception
	 */
	/*public final void updateAppropriation(
	  final BudgetTO budget, final int type,
			final int index, final double quantity, final String description)
			throws Exception {
		Transaction tr = null;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);
			trans.updateAppropriation(
			budget.getInstCode(), budget.getFuncCode(), 
					budget.getEcoCode(), type, index, quantity, description);

			tr.commit();

		} catch (NoApprDefined e) {
			throw e;
		} catch (SQLException e) {
			tr.rollback();
			throw e;	
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}*/
// TODO: bu fonksiyon bolunecek
	
	/**
	 * @param budget budget
	 * @param appr appropriation
	 * @throws Exception exception
	 */
	public final void insertAppropriation(final BudgetTO budget, 
			final AppropriationTO appr)
			throws Exception {

		Transaction tr = null;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);
			if (appr.getType() == AppropriationTO.ADDITIONAL) {
				trans.insertAddAppropriation(budget, appr);
			} else {
				trans.insertMainAppropriation(budget, appr);
			}
			

			tr.commit();

		} catch (Exception e) {
			tr.rollback();
			throw e;
		} finally {
			tr.terminate();
		}
	}

	
	/**
	 * @param budget budget
	 * @return periodic appropriation total
	 * @throws Exception exception
	 */
	public final double getPeriodicAppropriationTotal(
			final BudgetTO budget) throws Exception {

		Transaction tr = null;
		double perNum;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);
			perNum = trans.getPeriodicAppropriationTotal(budget);
			tr.commit();
			return perNum;

		} catch (NoApprDefined e) {
			throw e;
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}


	/**
	 * @param budget budget
	 * @return total additional appropriation
	 * @throws Exception for all kind of exceptions
	 */
	public final double getAdditionalAppropriationTotal(final BudgetTO budget) 
	throws Exception {

		Transaction tr = null;
		double appTotal;
		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);
			appTotal = trans.getAdditionalAppropriationTotal(budget);
			tr.commit();
			return appTotal;

		} catch (NoAdditionalApprDefined e) {
			throw e;
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

}
