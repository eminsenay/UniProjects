package bts.cmpe.budget.dal.DAO.interfaces;

import java.sql.SQLException;

import bts.cmpe.budget.dal.exception.NoSuchDepartmentException;
import bts.cmpe.budget.dal.transfer.DepartmentTO;

/**
 * @author ozan
 *
 */
public interface DepartmentDAO {
	/**
	 * after call to this function type of expenditures for 
	 * current department is set.
	 * @param dept department
	 * @return all economic sub parts
	 * @throws NoSuchDepartmentException if department does not exist.
	 * @throws SQLException must be catched and written to log file.
	 */
	DepartmentTO[] getEconomicCodes(DepartmentTO dept) 
	throws NoSuchDepartmentException, SQLException;
	
	
	/**
	 * @param dept department to insert
	 * @throws SQLException must be catched and written to log file
	 */
	void insertDepartment(DepartmentTO dept) throws SQLException;
	
	/**
	 * @param oldDept department to update
	 * @param newDept final state of department
	 * @throws NoSuchDepartmentException if department does not exist.
	 * @throws SQLException must be catched and written tol log file.
	 */
	void updateDepartment(DepartmentTO oldDept, DepartmentTO newDept)
	throws NoSuchDepartmentException, SQLException;
}
