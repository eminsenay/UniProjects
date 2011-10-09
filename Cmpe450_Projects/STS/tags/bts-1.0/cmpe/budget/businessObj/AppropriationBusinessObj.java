package bts.cmpe.budget.businessObj;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.mysql.AppropriationDAOMySQL;
import bts.cmpe.budget.dal.transfer.AppropriationTO;

/**
 * @author funda
 * 
 */

public class AppropriationBusinessObj {

	/**
	 * @param instCode
	 *            institiuonal code.
	 * @param funcCode
	 *            functional code
	 * @param ecoCode
	 *            economic code
	 * @return periodNum period number.
	 * @throws Exception
	 *             exception
	 */

	public final double getPeriod(final String instCode, final String funcCode,
			final String ecoCode) throws Exception {

		Transaction tr = null;
		double periodNum;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);

			periodNum = trans.getPeriod(instCode, funcCode, ecoCode);

			tr.commit();
			return periodNum;

		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

	/**
	 * @param instCode
	 *            institiuonal code.
	 * @param funcCode
	 *            functional code
	 * @param ecoCode
	 *            economic code
	 * @return appr AppropriationTO object.
	 * @throws Exception
	 *             exception
	 */
	public final AppropriationTO[] getAllAppropriations(final String instCode,
			final String funcCode, final String ecoCode) throws Exception {
		Transaction tr = null;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);

			AppropriationTO[] appr = trans.getAllAppropriations(instCode,
					funcCode, ecoCode);
			tr.commit();
			return appr;

		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

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
	public final void updateAppropriation(final String instCode,
			final String funcCode, final String ecoCode, final int type,
			final int index, final double quantity, final String description)
			throws Exception {
		Transaction tr = null;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);
			trans.updateAppropriation(instCode, funcCode, ecoCode, type, index,
					quantity, description);

			tr.commit();

		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

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
	public final void insertAppropriation(final String instCode,
			final String funcCode, final String ecoCode, final int type,
			final int index, final double quantity, final String description)
			throws Exception {

		Transaction tr = null;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);
			trans.insertAppropriation(instCode, funcCode, ecoCode, type, index,
					quantity, description);

			tr.commit();

		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

	/**
	 * @param instCode
	 *            institiuonal code.
	 * @param funcCode
	 *            functional code
	 * @param ecoCode
	 *            economic code
	 * @return perNum for periodicAppr number.
	 * @throws Exception
	 *             exception
	 */

	public final double getPeriodicAppropriationTotal(final String instCode,
			final String funcCode, final String ecoCode) throws Exception {

		Transaction tr = null;
		double perNum;

		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);
			perNum = trans.getPeriodicAppropriationTotal(instCode, funcCode,
					ecoCode);
			tr.commit();
			return perNum;

		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

	/**
	 * @param instCode
	 *            institiuonal code.
	 * @param funcCode
	 *            functional code
	 * @param ecoCode
	 *            economic code
	 * @return appTotal additional app. total
	 * @throws Exception
	 *             exception
	 * 
	 */
	public final double getAdditionalAppropriationTotal(final String instCode,
			final String funcCode, final String ecoCode) throws Exception {

		Transaction tr = null;
		double appTotal;
		try {
			tr = Transaction.create();
			AppropriationDAOMySQL trans = new AppropriationDAOMySQL(tr);
			appTotal = trans.getAdditionalAppropriationTotal(instCode,
					funcCode, ecoCode);
			tr.commit();
			return appTotal;

		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}

}
