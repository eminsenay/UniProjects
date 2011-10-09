package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.interfaces.ExpenditureDAO;
import bts.cmpe.budget.dal.exception.NoSuchDepartmentException;
import bts.cmpe.budget.dal.transfer.DepartmentTO;
import bts.cmpe.budget.dal.transfer.ExpenditureTO;

/**
 * @author fth
 *
 */
public class ExpenditureDAOMySQL extends DAObase implements ExpenditureDAO {

	/**
	 * constant for total expenditure.
	 */
	private static final int TOTAL_EXPENDITURE = 1;
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
	 * constant for economic code.
	 */
	private static final int EXPENDITURE_INDEX = 4;
	/**
	 * constant for rangeMin.
	 */
	private static final int RANGE_MIN = 4;
	/**
	 * constant for rangeMax.
	 */
	private static final int RANGE_MAX = 5;
	/**
	 * constant for sortType.
	 */
	private static final int SORT_TYPE = 6;
	/**
	 * constant for isAscending.
	 */
	private static final int IS_ASCENDING = 7;
	/**
	 * constant for orderNo.
	 */
	private static final int ORDER_NO = 1;
	/**
	 * constant for paidToWhom.
	 */
	private static final int PAID_TO_WHOM = 2;
	/**
	 * constant for tahakkukID.
	 */
	private static final int TAHAKKUK_ID = 3;
	/**
	 * constant for tahakkukDate.
	 */
	private static final int TAHAKKUK_DATE = 4;
	/**
	 * constant for tahakkukQuantity.
	 */
	private static final int TAHAKKUK_QUANTITY = 5;
	/**
	 * constant for unit.
	 */
	private static final int UNIT = 6;
	/**
	 * constant for requestDate.
	 */
	private static final int REQUEST_DATE = 7;
	/**
	 * constant for requestAmount.
	 */
	private static final int REQUEST_AMOUNT = 8;
	/**
	 * constant for typeOfMaterial.
	 */
	private static final int TYPE_OF_MATERIAL = 9;
	/**
	 * constant for ecoCode.
	 */
	private static final int ECONOMIC_CODE = 10;
	/**
	 * constant for additionalFields.
	 */
	private static final int ADDITIONAL_FIELDS = 11;
	/**
	 * constant for type.
	 */
	private static final int TYPE = 17;
	/**
	 * constant for type.
	 */
	private static final int STATUS = 18;
	/**
	 * constant for fieldAmounts.
	 */
	private static final int FIELD_AMOUNTS = 6;
	
	
	/**
	 * @param tr 	Transaction parameter connects actions of DAO object 
	 * 				to a transaction chain defined by the member of 
	 * 				Transaction object of type Connection.
	 */
	public ExpenditureDAOMySQL(final Transaction tr) { 
		super(tr);
	}

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
		 * @throws NoSuchDepartmentException ifdepartment doese not exist 
		 * @throws SQLException must be catched and written to log file.
		 */
		public final ExpenditureTO[] getExpenditures(final DepartmentTO dept,
				final int rangeMin, final int rangeMax, final int sortType, 
				final boolean isAscending) 
		throws NoSuchDepartmentException, SQLException {
			ExpenditureTO[] expenditure = null;
			
			try {
				CallableStatement proc = super.getConn()
						.prepareCall("{ call getExpenditures(?,?,?,?,?,?,?) }");
				proc.setString(INST_CODE, dept.getInstCode());
				proc.setString(FUNC_CODE, dept.getFuncCode());
				proc.setString(ECO_CODE, dept.getEcoCode());
				proc.setInt(RANGE_MIN, rangeMin);
				proc.setInt(RANGE_MAX, rangeMax);
				proc.setInt(SORT_TYPE, sortType);
				proc.setBoolean(IS_ASCENDING, isAscending);
				
				ResultSet rs = proc.executeQuery();
				expenditure = new ExpenditureTO[rs.getFetchSize()];
				
				int i;
				for (i = 0; rs.next(); i++) {
					expenditure[i] = new ExpenditureTO(
							rs.getInt(ORDER_NO),
							rs.getString(PAID_TO_WHOM),
							rs.getString(TAHAKKUK_ID),
							rs.getDate(TAHAKKUK_DATE),
							rs.getDouble(TAHAKKUK_QUANTITY),
							rs.getString(STATUS)
							);
					
					if (rs.getInt(TYPE) == 1) {
						expenditure[i].fillNormal(
							rs.getString(UNIT),
							rs.getDate(REQUEST_DATE),
							rs.getDouble(REQUEST_AMOUNT),
							rs.getString(TYPE_OF_MATERIAL),
							rs.getString(ECONOMIC_CODE)
							);
					} else {
						double[] tempArray = new double[FIELD_AMOUNTS];
						for (i = 0; i < FIELD_AMOUNTS; i++) {
							tempArray[i] = rs.getDouble(ADDITIONAL_FIELDS + i);
						}
						expenditure[i].fillWager(tempArray);
					}
				}
				
		        rs.close();
		        proc.close();
		        
		        if (i == 0) {
		    	
			    	   throw new NoSuchDepartmentException(
			    			   dept.getInstCode(), 
			            	dept.getFuncCode(), 
			            	dept.getEcoCode());
			       }
				return expenditure;
			} catch (SQLException ex) {
				throw ex;
			}
		}

	/**
	 * @param dept department of expenditure
	 * @param expenditure expenditure to be added
	 * @throws NoSuchDepartmentException if department doese not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	public final void addExpenditure(final DepartmentTO dept,
									 final ExpenditureTO expenditure) 
	throws NoSuchDepartmentException, SQLException {
		
		try {
			CallableStatement proc = super.getConn()
			.prepareCall(
			"{ call addExpenditure(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }"
					);
			
			proc.setInt(ORDER_NO, expenditure.getOrderNo());
			proc.setString(PAID_TO_WHOM, expenditure.getPaidToWhom());
			proc.setString(TAHAKKUK_ID, expenditure.getTahakkukID());
			proc.setDate(TAHAKKUK_DATE, expenditure.getTahakkukDate());
			proc.setDouble(TAHAKKUK_QUANTITY, 
					expenditure.getTahakkukQuantity());
			proc.setString(STATUS, expenditure.getStatus());
			proc.setInt(TYPE, expenditure.getType());
			proc.setString(UNIT, expenditure.getUnit());
			proc.setDate(REQUEST_DATE, expenditure.getRequestDate());
			proc.setDouble(REQUEST_AMOUNT, expenditure.getRequestAmount());
			proc.setString(TYPE_OF_MATERIAL, expenditure.getTypeOfMaterial());
			proc.setString(ECONOMIC_CODE, expenditure.getEcoCode());
			
			if (expenditure.getAdditionalFields() != null) {
				
				for (int i = 0; i < FIELD_AMOUNTS; i++) {
					double temp = expenditure.getAdditionalFields()[i];
					proc.setDouble(ADDITIONAL_FIELDS + i, temp);
				}
								
			}
			int success = proc.executeUpdate();
			proc.close();
			if (success == 0) {
				throw new NoSuchDepartmentException(
		    			   dept.getInstCode(), 
		            	dept.getFuncCode(), 
		            	dept.getEcoCode());
			}
			
		} catch (SQLException ex) {
			throw ex;
		}
		
	}
	
	/**
	 * @param dept department
	 * @param expenditureIndex defter sıra no of expenditure
	 * @throws NoSuchDepartmentException if department doese not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	public final void deleteExpenditure(final DepartmentTO dept,
			final int expenditureIndex) 
	throws NoSuchDepartmentException, SQLException {
		
		try {
			CallableStatement proc = super.getConn()
					.prepareCall("{ call deleteExpenditure(?,?,?,?) }");
			proc.setString(INST_CODE, dept.getInstCode());
			proc.setString(FUNC_CODE, dept.getFuncCode());
			proc.setString(ECO_CODE, dept.getEcoCode());
			proc.setInt(EXPENDITURE_INDEX, expenditureIndex);
			
			int success = proc.executeUpdate();
			proc.close();
			if (success == 0) {
				throw new NoSuchDepartmentException(
		    			   dept.getInstCode(), 
		            	dept.getFuncCode(), 
		            	dept.getEcoCode());
			}
			
		
		} catch (SQLException ex) {
			throw ex;
		}
		
	}

	/**
	 * @param dept department.
	 * @return total expenditure done by this department
	 * @throws NoSuchDepartmentException if department doese not exist
	 * @throws SQLException must be catched and written to log file.
	 */
	public final double getTotalExpenditure(final DepartmentTO dept) 
	throws NoSuchDepartmentException, SQLException {
		
		try {
			CallableStatement proc = super.getConn()
					.prepareCall("{ call getTotalExpenditure(?,?,?) }");
			proc.setString(INST_CODE, dept.getInstCode());
			proc.setString(FUNC_CODE, dept.getFuncCode());
			proc.setString(ECO_CODE, dept.getEcoCode());
			
			ResultSet rs = proc.executeQuery();
			double returnValue = 0;
			
			if (!rs.next()) {
				throw new NoSuchDepartmentException(
		    			   dept.getInstCode(), 
		            	dept.getFuncCode(), 
		            	dept.getEcoCode());
			} else {
				returnValue = rs.getDouble(TOTAL_EXPENDITURE);
			}
			
			rs.close();
			proc.close();
			
			return returnValue;
			
		} catch (SQLException ex) {
			throw ex;
		}
		
	}
}



