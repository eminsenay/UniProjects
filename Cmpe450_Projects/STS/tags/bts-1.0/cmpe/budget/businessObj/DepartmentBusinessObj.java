package bts.cmpe.budget.businessObj;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.mysql.DepartmentDAOMySQL;
import bts.cmpe.budget.dal.transfer.DepartmentTO;

/**
 * @author eyyup.
 *
 */
public class DepartmentBusinessObj {
	
	/**
	 * after call to this function type of expenditures for. 
	 * current department is set.
	 * @param dept department.
	 * @return all economic sub parts.
	 * @throws Exception for all kinds of exceptions.
	 */
	public final DepartmentTO[] getEconomicCodes(final DepartmentTO dept)
	throws Exception {
		
		Transaction tr = null;

		try {
			tr = Transaction.create();
			DepartmentDAOMySQL trans = new DepartmentDAOMySQL(tr);

			DepartmentTO[] economicCodes = 
				trans.getEconomicCodes(dept);

			tr.commit();
			return economicCodes;
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}
	/**
	 * this function adds new department.
	 * @param dept department.
	 * @throws Exception for all kinds of exception.
	 */
	public final void insertDepartment(final DepartmentTO dept) 
	throws Exception {
		Transaction tr = null;

		try {
			tr = Transaction.create();
			DepartmentDAOMySQL trans = new DepartmentDAOMySQL(tr);

				trans.insertDepartment(dept);

			tr.commit();
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
		
	}
	
	/**
	 * this function update the current department.
	 * @param oldDept old department.
	 * @param newDept new department.
	 * @throws Exception for all kinds of exception.
	 */
	public final void updateDepartment(final DepartmentTO oldDept, 
			final DepartmentTO newDept)	throws Exception {
		
		Transaction tr = null;

		try {
			tr = Transaction.create();
			DepartmentDAOMySQL trans = new DepartmentDAOMySQL(tr);

				trans.updateDepartment(oldDept, newDept);

			tr.commit();
			
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}
}
