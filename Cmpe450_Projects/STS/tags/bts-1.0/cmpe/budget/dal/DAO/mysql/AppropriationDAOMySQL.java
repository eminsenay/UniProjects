/**
 * 
 */
package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.interfaces.AppropriationDAO;
import bts.cmpe.budget.dal.exception.NoSuchDepartmentException;
import bts.cmpe.budget.dal.transfer.AppropriationTO;

/**
 * @author DAIciler
 *
 */
public class AppropriationDAOMySQL extends DAObase implements AppropriationDAO {

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
	 * constant for type.
	 */
	private static final int TYPE = 1;
	/**
	 * constant for index.
	 */
	private static final int INDEX = 2;
	/**
	 * constant for quantity.
	 */
	private static final int QUANTITY = 3;
	/**
	 * constant for description.
	 */
	private static final int DESCRIPTION = 4;
	
	/**
	 * constant for stored procedure type.
	 */
	private static final int UPDATE_INSERT_APP_TYPE = 4;
	/**
	 * constant for stored procedure index.
	 */
	private static final int UPDATE_INSERT_APP_INDEX = 5;
	/**
	 * constant for stored procedure quantity.
	 */
	private static final int UPDATE_INSERT_APP_QUANTITY = 6;
	/**
	 * constant for stored procedure description.
	 */
	private static final int UPDATE_INSERT_APP_DESCRIPTION = 7;
	
	/**
	 * constant for total quantity.
	 */
	private static final int TOTAL_QUANTITY = 1;
	/**
	 * constant for period field.
	 */
	private static final int PERIOD = 1;
	/**
	 * @param tr 	Transaction parameter connects actions of DAO object 
	 * 				to a transaction chain defined by the member of 
	 * 				Transaction object of type Connection.
	 */
	public AppropriationDAOMySQL(final Transaction tr) {
		super(tr);
	}

	/**
	 * @param instCode Institutional code
	 * @param funcCode Functional code
	 * @param ecoCode Economy code
	 * @return Appropriation period
	 * @throws NoSuchDepartmentException when department is not found
	 * @throws SQLException must be catched and written into log
	 */
	public final int getPeriod(final String instCode, final String funcCode,
			final String ecoCode) throws NoSuchDepartmentException, 
			SQLException {
		try {
			CallableStatement proc = super.getConn()
					.prepareCall("{ call getPeriod(?,?,?) }");
			proc.setString(INST_CODE, instCode);
			proc.setString(FUNC_CODE, funcCode);
			proc.setString(ECO_CODE, ecoCode);
	
			ResultSet rs = proc.executeQuery();
	
	        if (!rs.next()) {
	            rs.close(); // closing result set
	            proc.close(); // closeing callable statement
	            throw new NoSuchDepartmentException(instCode, 
	            		funcCode, ecoCode);
	        }
			
			int retVal = rs.getInt(PERIOD);
	
	        rs.close();
	        proc.close();
			return retVal;
		} catch (SQLException ex) {
			throw ex;
		}
	}

	/**
	 * @param instCode Institutional code
	 * @param funcCode Functional code
	 * @param ecoCode Economy code
	 * @return list of all appropriations: first two or 
	 * four appropriations identify normal appropriations 
	 * depending on the period information, the remaining are 
	 *  additional appropriations.
	 * @throws SQLException must be catched and must be written to log file
	 * @throws NoSuchDepartmentException if department does not exist
	 */
	public final AppropriationTO[] getAllAppropriations(final String instCode, 
			final String funcCode, final String ecoCode) 
	throws NoSuchDepartmentException, SQLException {
		AppropriationTO []approps = null;
		try {
			CallableStatement proc = super.getConn()
					.prepareCall("{ call getAllAppropriations(?,?,?) }");
			proc.setString(INST_CODE, instCode);
			proc.setString(FUNC_CODE, funcCode);
			proc.setString(ECO_CODE, ecoCode);
	
			ResultSet rs = proc.executeQuery();
			approps = new AppropriationTO[rs.getFetchSize()];
			int i;
			for (i = 0; rs.next(); i++) {
				approps[i] = new AppropriationTO(rs.getInt(TYPE),
        				rs.getInt(INDEX),
        				rs.getDouble(QUANTITY), 
        				rs.getString(DESCRIPTION));
			}
			
	       
	
	        rs.close();
	        proc.close();
	        
	        if (i == 0) {
	    	
		    	   throw new NoSuchDepartmentException(instCode, 
		            		funcCode, ecoCode);
		       }
			return approps;
		} catch (SQLException ex) {
			throw ex;
		}
	}


	
	/**
	 * @param instCode  institiuonal code
	 * @param funcCode  functional code
	 * @param ecoCode  economic code
	 * @param type  type of appropriation. can take values
	 * <br> MONTH_3<br>  
	 * MONTH_6<br> or ADDITIONAL
	 * @param index  index of appropriation
	 * @param quantity  quantity of appropriation
	 * @param description  description of appropriation can be empty string
	 * @throws SQLException  must be catched and must be written to log file
	 * @throws NoSuchDepartmentException  if department does not exist
	 */
	public final void updateAppropriation(final String instCode, 
			final String funcCode, final String ecoCode, 
			final int type, final int index, 
			final double quantity, final String description) 
			throws NoSuchDepartmentException, SQLException {
		try {
			
			
			// This Stored procedure updates the appropriations's
			// QUANTITY ,DESCRIPTION  fields acc to given parameters
		
			CallableStatement proc = super.getConn()
				.prepareCall("{ call updateAppropriation(?,?,?,?,?,?,?) }");
			proc.setString(INST_CODE, instCode);
			proc.setString(FUNC_CODE, funcCode);
			proc.setString(ECO_CODE, ecoCode);
			proc.setInt(UPDATE_INSERT_APP_TYPE, type);
			proc.setInt(UPDATE_INSERT_APP_INDEX, index);
			proc.setDouble(UPDATE_INSERT_APP_QUANTITY, quantity);
			proc.setString(UPDATE_INSERT_APP_DESCRIPTION, description);
			
			int success = proc.executeUpdate();
			proc.close();
			if (success == 0) {
				throw new NoSuchDepartmentException(instCode, 
	            		funcCode, ecoCode);
			}
		} catch (SQLException ex) {
			throw ex;
		}
	}
	
	/**
	 * @param instCode institiuonal code
	 * @param funcCode functional code
	 * @param ecoCode economic code
	 * @param type type of appropriation. can take values<br>
	 * MONTH_3<br> 
	 * MONTH_6<br>
	 * or ADDITIONAL
	 * @param index index of appropriation
	 * @param quantity quantity of appropriation
	 * @param description description of appropriation can be empty string
	 * @throws SQLException must be catched and must be written to log file
	 * @throws NoSuchDepartmentException if department does not exist
	 */
	public final void insertAppropriation(final String instCode, 
			final String funcCode,
			final String ecoCode, final int type, final int index, 
			final double quantity, final String description) throws 
			NoSuchDepartmentException, SQLException {

		try {


			// This Stored procedure inserts the appropriations's
			// QUANTITY , DESCRIPTION , INDEX , TYPE fields acc 
			// to given parameters

			CallableStatement proc = super.getConn()
			.prepareCall("{ call insertAppropriation(?,?,?,?,?,?,?) }");
			proc.setString(INST_CODE, instCode);
			proc.setString(FUNC_CODE, funcCode);
			proc.setString(ECO_CODE, ecoCode);
			proc.setInt(UPDATE_INSERT_APP_TYPE, type);
			proc.setInt(UPDATE_INSERT_APP_INDEX, index);
			proc.setDouble(UPDATE_INSERT_APP_QUANTITY, quantity);
			proc.setString(UPDATE_INSERT_APP_DESCRIPTION, description);

			int success = proc.executeUpdate();
			proc.close();
			if (success == 0) {
				throw new NoSuchDepartmentException(instCode, 
						funcCode, ecoCode);
			}
		} catch (SQLException ex) {
			throw ex;
		}

	}

	
	/**
	 * @param instCode institiuonal code
	 * @param funcCode functional code
	 * @param ecoCode economic code
	 * @return total of all periodic Appropriations for the 
	 * department specified with parameters
	 * @throws NoSuchDepartmentException if department does not exist
	 * @throws SQLException must be catched and must be written to log file
	 */
	public final double getPeriodicAppropriationTotal(final String instCode, 
			final String funcCode, final String ecoCode) 
	throws NoSuchDepartmentException, SQLException {
		
		double quantity = 0.0;
		try {
			// This SP returns the total quantity of the 
			// 3 & 6 month appropriations.
			CallableStatement proc = super.getConn()
					.prepareCall(
						"{ call getPeriodicAppropriationTotal(?,?,?) }");
			
			proc.setString(INST_CODE, instCode);
			proc.setString(FUNC_CODE, funcCode);
			proc.setString(ECO_CODE, ecoCode);
	
			ResultSet rs = proc.executeQuery();
			if (!rs.next()) {
	            rs.close(); // closing result set
	            proc.close(); // closing callable statement
	            throw new NoSuchDepartmentException(instCode, 
	            		funcCode, ecoCode);
	        }
			quantity = rs.getDouble(TOTAL_QUANTITY);

	
	        rs.close();
	        proc.close();
			
		} catch (SQLException ex) {
			throw ex;
		}
		return quantity;
	}

	/**
	 * @param instCode institiuonal code
	 * @param funcCode functional code
	 * @param ecoCode economic code
	 * @return total of all additional Appropriations for the 
	 * department specified with parameters
	 * @throws NoSuchDepartmentException if department does not exist
	 * @throws SQLException must be catched and must be written to log file
	 */
	public final double getAdditionalAppropriationTotal(final String instCode, 
			final String funcCode, final String ecoCode) 
	throws NoSuchDepartmentException, SQLException {
		double quantity = 0.0;
		try {
			// This SP returns the total quantity of the 
			// addiitional appropriations.
			CallableStatement proc = super.getConn()
					.prepareCall(
							"{ call getAdditionalAppropriationTotal(?,?,?) }");
			
			proc.setString(INST_CODE, instCode);
			proc.setString(FUNC_CODE, funcCode);
			proc.setString(ECO_CODE, ecoCode);
	
			ResultSet rs = proc.executeQuery();
			if (!rs.next()) {
	            rs.close(); // closing result set
	            proc.close(); // closing callable statement
	            throw new NoSuchDepartmentException(instCode, 
	            		funcCode, ecoCode);
	        }
			quantity = rs.getDouble(TOTAL_QUANTITY);

	
	        rs.close();
	        proc.close();
			
		} catch (SQLException ex) {
			throw ex;
		}
		return quantity;
	}
}
