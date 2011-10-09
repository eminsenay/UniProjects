/**
 * 
 */
package bts.cmpe.budget.businessObj;

import java.util.Vector;

import bts.cmpe.budget.dal.Transaction;

import bts.cmpe.budget.dal.DAO.mysql.CodeDAOMySQL;
import bts.cmpe.budget.transfer.CodeTO;


/**
 * @author Memil
 * 
 */
public class CodeBusinessObj {

	/**
	 * @return Vector of Institutional codes.
	 * @throws Exception Exception
	 */
	public final Vector < CodeTO > getInstCode() throws Exception {

		Transaction tr = null;

		try {
			tr = Transaction.create("SAS_DB", "SASuser", "dbherzamanhaklidir");

			CodeDAOMySQL code = new CodeDAOMySQL(tr);
			
			return code.getInstCodes();
		} catch (Exception e) {
			tr.rollback();
			throw e;
		} finally {
			tr.terminate();
		}
	}
	
	/**
	 * @return Vector of Institutional codes.
	 * @throws Exception Exception
	 */
	public final Vector < CodeTO > getEcoCode() throws Exception {

		Transaction tr = null;

		try {
			tr = Transaction.create("SAS_DB", 
					"SASuser", 
					"dbherzamanhaklidir");

			CodeDAOMySQL code = new CodeDAOMySQL(tr);
			
			return code.getEcoCodes();
		} catch (Exception e) {
			tr.rollback();
			throw e;
		} finally {
			tr.terminate();
		}
	}
	
	/**
	 * @return Vector of Institutional codes.
	 * @throws Exception Exception
	 */
	public final Vector < CodeTO > getFuncCode() throws Exception {

		Transaction tr = null;

		try {
			tr = Transaction.create("SAS_DB", "SASuser", "dbherzamanhaklidir");

			CodeDAOMySQL code = new CodeDAOMySQL(tr);
			
			tr.commit();
			
			return code.getFuncCodes();
		} catch (Exception e) {
			
			tr.rollback();
			
			throw e;
		} finally {
			tr.terminate();
		}
	}

}
