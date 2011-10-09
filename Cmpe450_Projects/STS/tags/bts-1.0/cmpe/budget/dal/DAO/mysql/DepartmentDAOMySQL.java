/**
 * 
 */
package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.interfaces.DepartmentDAO;
import bts.cmpe.budget.dal.exception.NoSuchDepartmentException;
import bts.cmpe.budget.dal.transfer.DepartmentTO;


/**
 * @author yanis
 *
 */
public class DepartmentDAOMySQL extends DAObase implements DepartmentDAO {


	/**
	 * constant for institude code.
	 */
	private static final int INST_CODE = 1;
	/**
	 * constant for function code.
	 */
	private static final int FUNC_CODE = 2;
	/**
	 * constant for economic code.
	 */
	private static final int ECO_CODE = 3;
	
	/**
	 * constant for department type.
	 */
	private static final int DEPT_TYPE = 4;
	/**
	 * constant for institude code.
	 */
	private static final int UPDATED_INST_CODE = 4;
	/**
	 * constant for function code.
	 */
	private static final int UPDATED_FUNC_CODE = 5;
	/**
	 * constant for economic code.
	 */
	private static final int UPDATED_ECO_CODE = 6;


	/**
	 * @param tr 	Transaction parameter connects actions of DAO object 
	 * 				to a transaction chain defined by the member of 
	 * 				Transaction object of type Connection.
	 */
	public DepartmentDAOMySQL(final Transaction tr) {
		super(tr);
	}

	/**
	 * after call to this function type of expenditures for 
	 * current department is set.
	 * @param dept department
	 * @return all economic sub parts
	 * @throws NoSuchDepartmentException if department does not exist.
	 * @throws SQLException must be catched and written to log file.
	 */
	public final DepartmentTO[] getEconomicCodes(final DepartmentTO dept)
	throws NoSuchDepartmentException, SQLException {

		CallableStatement proc = null;
		ResultSet rs = null;
		DepartmentTO []depts;

		try {

			// returns the sub departments Economic Codes
			proc = super.getConn()
				.prepareCall("{ call getEconomicCodes(?,?,?) }");

			proc.setString(INST_CODE, dept.getInstCode());
			proc.setString(FUNC_CODE, dept.getFuncCode());
			proc.setString(ECO_CODE,  dept.getEcoCode());

			rs = proc.executeQuery();

			depts = new DepartmentTO[rs.getFetchSize()];

			int i;
			for (i = 0; rs.next(); i++) {

				String toinscode  = rs.getString(INST_CODE);
				String tofunccode = rs.getString(FUNC_CODE);
				String toecocode  = rs.getString(ECO_CODE);

				depts[i] = new DepartmentTO(
						toinscode, tofunccode, toecocode);

			}
			
			if (i == 0) {
				throw new NoSuchDepartmentException(dept.getInstCode(), 
						dept.getFuncCode(), dept.getEcoCode());
			}

		} catch (SQLException ex) {
			throw ex;
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (proc != null) {
				proc.close();
			}
		}

		return depts;

	}
	
	/**
	 * @param dept department to insert
	 * @throws SQLException must be catched and written to log file
	 */
	public final void insertDepartment(final DepartmentTO dept) 
	throws SQLException {
		CallableStatement proc = null;
		try {
			// inserts a new Department to the DB.
			
			 proc = super.getConn()
					.prepareCall("{ call insertBudget(?,?,?,?) }");
			proc.setString(INST_CODE, dept.getInstCode());
			proc.setString(FUNC_CODE, dept.getFuncCode());
			proc.setString(ECO_CODE,  dept.getEcoCode());
			proc.setInt(DEPT_TYPE, dept.getBudgetType());
			
	
			proc.executeUpdate();
		
		} catch (SQLException ex) {
			throw ex;
		} finally {
			 proc.close();
		}
		
	}

	/**
	 * @param oldDept  department to update
	 * @param newDept  final state of department
	 * @throws NoSuchDepartmentException  if department does not exist.
	 * @throws SQLException  must be catched and written tol log file.
	 */
	public final void updateDepartment(
			final DepartmentTO oldDept, final DepartmentTO newDept) 
	throws NoSuchDepartmentException, SQLException {
		CallableStatement proc = null;
		try {
			proc = super.getConn()
				.prepareCall("{ call updateDepartment(?,?,?,?,?,?) }");
			proc.setString(INST_CODE, oldDept.getInstCode());
			proc.setString(FUNC_CODE, oldDept.getFuncCode());
			proc.setString(ECO_CODE, oldDept.getEcoCode());
			proc.setString(UPDATED_INST_CODE, newDept.getInstCode());
			proc.setString(UPDATED_FUNC_CODE, newDept.getFuncCode());
			proc.setString(UPDATED_ECO_CODE, newDept.getEcoCode());
			proc.executeUpdate();
		} catch (SQLException ex) {
			throw ex;
		} finally {
			proc.close();
		}
	}

}
