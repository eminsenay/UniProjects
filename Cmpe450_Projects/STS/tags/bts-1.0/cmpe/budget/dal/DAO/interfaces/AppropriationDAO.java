package bts.cmpe.budget.dal.DAO.interfaces;

import java.sql.SQLException;


import bts.cmpe.budget.dal.exception.NoSuchDepartmentException;
import bts.cmpe.budget.dal.transfer.AppropriationTO;

/**
 * @author PTHSENSOY
 *
 */
public interface AppropriationDAO {
	/**
	 * @param instCode Institutional code
	 * @param funcCode Functional code
	 * @param ecoCode Economy code
	 * @return Appropriation period
	 * @throws NoSuchDepartmentException when department is not found
	 * @throws SQLException must be catched and written into log
	 */
	int getPeriod(final String instCode, final String funcCode,
			final String ecoCode) throws NoSuchDepartmentException, 
			SQLException;

	/**
	 * @param instCode Institutional code
	 * @param funcCode Functional code
	 * @param ecoCode Economy code
	 * @return list of appropriation periods.
	 * @throws SQLException must be catched and must be written to log file
	 * @throws NoSuchDepartmentException if department does not exist
	 */
	AppropriationTO[] getAllAppropriations(final String instCode, 
			final String funcCode,
			final String ecoCode) throws SQLException, 
			NoSuchDepartmentException;

	
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
	void updateAppropriation(final String instCode, final String funcCode,
			final String ecoCode, final int type, final int index, 
			final double quantity, final String description) throws 
			NoSuchDepartmentException, SQLException;
	
	/**
	 * @param instCode institiuonal code
	 * @param funcCode functional code
	 * @param ecoCode economic code
	 * @param type type of appropriation. can take 3 values<br>
	 * MONTH_3<br> 
	 * MONTH_6<br>
	 * or ADDITIONAL
	 * @param index index of appropriation
	 * @param quantity quantity of appropriation
	 * @param description description of appropriation can be empty string
	 * @throws SQLException must be catched and must be written to log file
	 * @throws NoSuchDepartmentException if department does not exist
	 */
	void insertAppropriation(final String instCode, final String funcCode,
			final String ecoCode, final int type, final int index, 
			final double quantity, final String description) throws 
			NoSuchDepartmentException, SQLException;
	
	/**
	 * @param instCode institiuonal code
	 * @param funcCode functional code
	 * @param ecoCode economic code
	 * @return total of all periodic Appropriations for the 
	 * department specified with parameters
	 * @throws NoSuchDepartmentException if department does not exist
	 * @throws SQLException must be catched and must be written to log file
	 */
	double getPeriodicAppropriationTotal(final String instCode, 
			final String funcCode, final String ecoCode) 
	throws NoSuchDepartmentException, SQLException;
	
	/**
	 * @param instCode institiuonal code
	 * @param funcCode functional code
	 * @param ecoCode economic code
	 * @return total of all additional Appropriations for the 
	 * department specified with parameters
	 * @throws NoSuchDepartmentException if department does not exist
	 * @throws SQLException must be catched and must be written to log file
	 */
	double getAdditionalAppropriationTotal(final String instCode, 
			final String funcCode, final String ecoCode) 
	throws NoSuchDepartmentException, SQLException;
}
