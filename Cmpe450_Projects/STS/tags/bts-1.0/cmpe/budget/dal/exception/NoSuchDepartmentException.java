package bts.cmpe.budget.dal.exception;

import bts.cmpe.budget.dal.transfer.DepartmentTO;

/**
 * @author ozan
 *
 */
public class NoSuchDepartmentException extends Exception {

	/**
	 * serial version id.
	 */
	private static final long serialVersionUID = -2009429496949026357L;
	/**
	 *  the non-existant department.
	 */
	private DepartmentTO department;
	

	
	/**
	 * @param myInsCode institude code
	 * @param myFuncCode function code
	 * @param myEcoCode economy code
	 */
	public NoSuchDepartmentException(final String myInsCode, 
			final String myFuncCode, final String myEcoCode) {
		super("Aradığınız birim sisteme kayıtlı değildir.");
		department = new DepartmentTO(myInsCode, myFuncCode, 
				myEcoCode);
	}
	
	/**
	 * @return  department.
	 */
	public final DepartmentTO getDepartment() {
		return department;
	}
	
	
}

