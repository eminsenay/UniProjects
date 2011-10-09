package bts.cmpe.budget.dal.DAO.interfaces;

import java.sql.SQLException;

import bts.cmpe.budget.dal.exception.NoSuchDepartmentException;
import bts.cmpe.budget.dal.transfer.DepartmentTO;
import bts.cmpe.budget.dal.transfer.ExpenditureTO;

/**
 * @author ozan
 *
 */
public interface ExpenditureDAO {
	/**
	 * lists the expenditures made by a department within the range.
	 * min and max values will be swapped if rangeMin is lower 
	 * than rangeMax. But that kind of usage is discouraged. 
	 * 
	 * @param dept department is the owner of the expenditures. 
	 * @param rangeMin minimum value for the range.
	 * @param rangeMax maximum value for the range.
	 * @param sortType sort type of the list
	 * @param isAscending decides if ascending or descending.
	 * @return expenditures in given range and order.
	 * @throws NoSuchDepartmentException if department doese not exist 
	 * @throws SQLException must be catched and written to log file.
	 */
	ExpenditureTO[] getExpenditures(DepartmentTO dept, int rangeMin, 
			int rangeMax, int sortType, boolean isAscending) 
	throws NoSuchDepartmentException, SQLException;
	
	/**
	 * @param dept department of expenditure
	 * @param expenditure expenditure to be added
	 * @throws NoSuchDepartmentException if department doese not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	void addExpenditure(DepartmentTO dept, ExpenditureTO expenditure)
	throws NoSuchDepartmentException, SQLException;
	
	/**
	 * @param dept department.
	 * @return total expenditure done by this department
	 * @throws NoSuchDepartmentException if department doese not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	double getTotalExpenditure(DepartmentTO dept) 
	throws NoSuchDepartmentException, SQLException;
	
	
	/**
	 * @param dept department
	 * @param expenditureIndex defter sıra no of expenditure
	 * @throws NoSuchDepartmentException if department doese not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	void deleteExpenditure(DepartmentTO dept, int expenditureIndex)
	throws NoSuchDepartmentException, SQLException;
}
