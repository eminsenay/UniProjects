/**
 * 
 */
package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.interfaces.TransferDAO;
import bts.cmpe.budget.dal.exception.NoSuchDepartmentException;
import bts.cmpe.budget.dal.transfer.DepartmentTO;
import bts.cmpe.budget.dal.transfer.TransferTO;

/**
 * @author yanis
 *
 */
public class TransferDAOMySQL extends DAObase implements TransferDAO {

	/**
	 * constant for total transfer.
	 */
	private static final int TOTAL_TRANSFER = 1;
	/**
	 * constant for checkDepartmentExists stored procedure. 
	 */
	private static final int DEPARTMENT_FLAG = 1;
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
	 * constant for transferID.
	 */
	private static final int TRANSFERID = 1;
	/**
	 * constant for Quantity.
	 */
	private static final int QUANTITY = 2;
	/**
	 * constant for description.
	 */
	private static final int DESCRIPTION = 3;
	/**
	 * constant for institude code.
	 */
	private static final int TOWHOM_INST_CODE = 4;
	/**
	 * constant for function code.
	 */
	private static final int TOWHOM_FUNC_CODE = 5;
	/**
	 * constant for economic code.
	 */
	private static final int TOWHOM_ECO_CODE = 6;
	/**
	 * constant for transfer Quantity.
	 */
	private static final int CHECK_QUANTITY = 7;
	/**
	 * constant for make transfer Description.
	 */
	private static final int MAKE_T_DESCRIPTION = 8;



	/**
	 * constant for is available transfer.
	 */
	private static final int IS_AVAILABLE = 1;

	/**
	 * @param tr 	Transaction parameter connects actions of DAO object 
	 * 				to a transaction chain defined by the member of 
	 * 				Transaction object of type Connection.
	 */
	public TransferDAOMySQL(final Transaction tr) {
		super(tr);
	}

	/**
	 * @param from the object that holds the information of current department
	 * @return all the transfers to/from this department. positive number 
	 * indicates the outgoing transfer, negative number indicates incoming 
	 * transfer.
	 * @throws NoSuchDepartmentException user should be informed
	 * @throws SQLException must be catched
	 */
	public final TransferTO[] getAllTransfers(final DepartmentTO from)
	throws NoSuchDepartmentException, SQLException {

		TransferTO []transfers = null;
		CallableStatement proc = null;
		ResultSet rs = null;
		try {

			if (checkDepartmentExists(from.getInstCode(), 
					from.getFuncCode(), from.getEcoCode())) {
				throw new NoSuchDepartmentException(from.getInstCode(), 
						from.getFuncCode(), from.getEcoCode());
			}
			//According to given department codes returns the 
			// previously established transfers. 
			proc = super.getConn()
			.prepareCall("{ call getAllTransfers(?,?,?) }");

			proc.setString(INST_CODE, from.getInstCode());
			proc.setString(FUNC_CODE, from.getFuncCode());
			proc.setString(ECO_CODE, from.getEcoCode());

			rs = proc.executeQuery();

			transfers = new TransferTO[rs.getFetchSize()];

			for (int i = 0; rs.next(); i++) {

				int transferID = rs.getInt(TRANSFERID);
				double quantity = rs.getDouble(QUANTITY);
				String description = rs.getString(DESCRIPTION);
				String toinscode = rs.getString(TOWHOM_INST_CODE);
				String tofunccode = rs.getString(TOWHOM_FUNC_CODE);
				String toecocode = rs.getString(TOWHOM_ECO_CODE);

				DepartmentTO dept = new DepartmentTO(
						toinscode, tofunccode, toecocode);
				transfers[i] = new TransferTO(
						transferID, dept, quantity, description);
			}


			return transfers;
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





	}

	/**
	 * 
	 * @param to receiver
	 * @param from sender
	 * @param quantity positive number indicates 'from' is sending, 
	 * negative number indicates 'to' is sending 
	 * @return true if budget is available, false o/w
	 * @throws NoSuchDepartmentException if one of any departments
	 * does not exist
	 * @throws SQLException indicates a DB error must be catched and 
	 * written into log file
	 */
	public final boolean isTranferAvailable(final DepartmentTO to, 
			final DepartmentTO from, final double quantity) 
	throws NoSuchDepartmentException, SQLException {

		CallableStatement proc = null;
		ResultSet rs = null;
		boolean check = false;
		try {

			if (checkDepartmentExists(from.getInstCode(), 
					from.getFuncCode(), from.getEcoCode())) {
				throw new NoSuchDepartmentException(from.getInstCode(), 
						from.getFuncCode(), from.getEcoCode());
			}
			if (checkDepartmentExists(to.getInstCode(), 
					to.getFuncCode(), to.getEcoCode())) {
				throw new NoSuchDepartmentException(to.getInstCode(), 
						to.getFuncCode(), to.getEcoCode());
			}
			// According to given 2 department's codes and 
			// Quantity returns 0 = false 
			// 1 = true for transfer availbility. 
			proc = super.getConn()
			.prepareCall("{ call isTransferAvailable(?,?,?,?,?,?,?) }");

			proc.setString(INST_CODE, from.getInstCode());
			proc.setString(FUNC_CODE, from.getFuncCode());
			proc.setString(ECO_CODE, from.getEcoCode());
			proc.setString(TOWHOM_INST_CODE, to.getInstCode());
			proc.setString(TOWHOM_FUNC_CODE, to.getFuncCode());
			proc.setString(TOWHOM_ECO_CODE, to.getEcoCode());
			proc.setDouble(CHECK_QUANTITY, quantity);

			rs = proc.executeQuery();

			rs.next();
			if (rs.getInt(IS_AVAILABLE) == 1) {
				check = true;
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
		return check;

	}




	/**
	 * @param to receiver
	 * @param from sender
	 * @param quantity positive number indicates 'from' is sending, 
	 * negative number indicates 'to' is sending 
	 * @param description the description of the transfer.
	 * @throws NoSuchDepartmentException if one of any departments
	 * does not exist
	 * @throws SQLException indicates a DB error must be catched and 
	 * written into log file
	 */
	public final void makeTransfer(final DepartmentTO to, 
			final DepartmentTO from, final double quantity,
			final String description) 
	throws NoSuchDepartmentException, SQLException {

		CallableStatement proc = null;
		ResultSet rs = null;

		try {

			// According to given 2 department's codes, 
			// Quantity and Description accomplishes the transfer
			proc = super.getConn()
			.prepareCall("{ call makeTransfer(?,?,?,?,?,?,?,?) }");

			proc.setString(INST_CODE, from.getInstCode());
			proc.setString(FUNC_CODE, from.getFuncCode());
			proc.setString(ECO_CODE, from.getEcoCode());
			proc.setString(TOWHOM_INST_CODE, to.getInstCode());
			proc.setString(TOWHOM_FUNC_CODE, to.getFuncCode());
			proc.setString(TOWHOM_ECO_CODE, to.getEcoCode());
			proc.setDouble(CHECK_QUANTITY, quantity);
			proc.setString(MAKE_T_DESCRIPTION, description);

			proc.executeUpdate();


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



	}

	/**
	 * @param instCode instituion code
	 * @param funcCode functional code
	 * @param ecoCode economic code
	 * @return true if that department exists in DB.
	 * @author yanis
	 * @throws SQLException  must be catched and must be written to log file
	 */
	private boolean checkDepartmentExists(final String instCode,
			final String funcCode,
			final String ecoCode) throws SQLException {

		boolean check = false;
		CallableStatement proc = null;
		ResultSet rs = null;
		try {
			proc = super.getConn()
			.prepareCall("{ call checkDepartmentExists(?,?,?) }");
			proc.setString(INST_CODE, instCode);
			proc.setString(FUNC_CODE, funcCode);
			proc.setString(ECO_CODE, ecoCode);

			rs = proc.executeQuery();

			if (rs.next()) {
				check =  rs.getBoolean(DEPARTMENT_FLAG);
			}
				

		} catch (SQLException ex) {
			throw ex;
		} finally {
			rs.close();
			proc.close();
		}		

		return check;
	}

	/**
	 * @param dept department
	 * @return transfer balance for the department
	 * @throws NoSuchDepartmentException if department does not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	public final double getTransferTotal(final DepartmentTO dept) 
		throws NoSuchDepartmentException, SQLException {
		
		CallableStatement proc = null;
		ResultSet rs = null;
		
		try {
			proc = super.getConn()
					.prepareCall("{ call getTransferTotal(?,?,?) }");
			proc.setString(INST_CODE, dept.getInstCode());
			proc.setString(FUNC_CODE, dept.getFuncCode());
			proc.setString(ECO_CODE, dept.getEcoCode());
			
			rs = proc.executeQuery();
			double returnValue = 0;
			
			if (!rs.next()) {
				throw new NoSuchDepartmentException(
		    			   dept.getInstCode(), 
		            	dept.getFuncCode(), 
		            	dept.getEcoCode());
			} else {
				returnValue = rs.getDouble(TOTAL_TRANSFER);
			}
				
			return returnValue;
			
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
	}

}
