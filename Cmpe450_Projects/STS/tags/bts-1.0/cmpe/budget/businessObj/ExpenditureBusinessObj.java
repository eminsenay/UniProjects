package bts.cmpe.budget.businessObj;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.mysql.ExpenditureDAOMySQL;
import bts.cmpe.budget.dal.transfer.DepartmentTO;
import bts.cmpe.budget.dal.transfer.ExpenditureTO;

/**
 * @author funda
 *
 */

public class ExpenditureBusinessObj {
	
	/**
	 * 
	 * @param dept DepartmentTO object
	 * @param rangeMin for minimum range
	 * @param rangeMax for maximum range
	 * @param sortType for which type you sort data
	 * @param isAscending ascending or descending order
	 * @return exp ExpenditureTO object.
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */
	
	public final ExpenditureTO[] getExpenditures(final DepartmentTO dept,
			final int rangeMin, final int rangeMax, final int sortType, 
			final boolean isAscending)throws Exception {
		
		Transaction tr = null;
		ExpenditureTO[] exArray;

		try {
			tr = Transaction.create();
			ExpenditureDAOMySQL trans = new ExpenditureDAOMySQL(tr);

			exArray = trans.getExpenditures(dept, rangeMin,
					rangeMax, sortType, isAscending);

			tr.commit();
			return exArray;
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
	}
	
	
	/**
	 * 
	 * @param dept DepartmentTO object.
	 * @param expenditure ExpenditureTO object.
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */
	public final void addExpenditure(final DepartmentTO dept,
			 final ExpenditureTO expenditure) throws Exception {
		
		Transaction tr = null;
		
		try {
			tr = Transaction.create();
		ExpenditureDAOMySQL trans = new ExpenditureDAOMySQL(tr);
		
		trans.addExpenditure(dept, expenditure);
		tr.commit();
	} catch (Exception e) {
		throw e;
	} finally {
		tr.terminate();
	}
	}
	
	
	/**
	 * 
	 * @param dept DepartmentTO object
	 * @param expenditureIndex for index for the expenditure
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */
	public final void deleteExpenditure(final DepartmentTO dept,
			final int expenditureIndex) throws Exception {
		
		Transaction tr = null;
		
		try {
			tr = Transaction.create();
		ExpenditureDAOMySQL trans = new ExpenditureDAOMySQL(tr);
		
		trans.deleteExpenditure(dept, expenditureIndex);
		tr.commit();
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
		}
	
	
	/**
	 * 
	 * @param dept DepartmentTO object
	 * @return totalExp total expenditure amount
	 * @throws Exception SQLException and NoSuchDepartmentException
	 */
	public final double getTotalExpenditure(final DepartmentTO dept)
	throws Exception {
		
Transaction tr = null;
double totalExp;
		
		try {
			tr = Transaction.create();
		    ExpenditureDAOMySQL trans = new ExpenditureDAOMySQL(tr);
		    
		    totalExp = trans.getTotalExpenditure(dept);
		    tr.commit();
		    return totalExp;
		} catch (Exception e) {
			throw e;
		} finally {
			tr.terminate();
		}
		}
	
		    




	
	

}
