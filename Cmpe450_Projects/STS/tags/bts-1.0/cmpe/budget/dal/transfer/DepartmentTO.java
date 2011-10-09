package bts.cmpe.budget.dal.transfer;

/**
 * @author ozan
 *
 */
/**
 * @author ozan
 *
 */
public final class DepartmentTO {
	/**
	 * instituonal code.
	 */
	private String instCode;
	
	/**
	 * functional code. 
	 */
	private String funcCode;
	
	/**
	 * economic code.
	 */
	private String ecoCode;
	
	/**
	 * type of the department Expenditures.
	 */
	private int expenditureType;
	
	/**
	 * @param myInstCode institude code 
	 * @param myFuncCode functional code
	 * @param myEcoCode economic code
	 */
	public DepartmentTO(final String myInstCode, final String myFuncCode,
			final String myEcoCode) {
		instCode = myInstCode;
		funcCode = myFuncCode;
		ecoCode = myEcoCode;
	}

	/**
	 * @return economic code
	 */
	public String getEcoCode() {
		return ecoCode;
	}

	/**
	 * @return functional code
	 */
	public String getFuncCode() {
		return funcCode;
	}

	/**
	 * @return instituonal code
	 */
	public String getInstCode() {
		return instCode;
	}

	/**
	 * @return type of the department expenditures
	 */
	public int getExpenditureType() {
		return expenditureType;
	}

	/**
	 * @param myExpenditureType type of the department expenditures
	 */
	public void setExpenditureType(final int myExpenditureType) {
		expenditureType = myExpenditureType;
	}

}
