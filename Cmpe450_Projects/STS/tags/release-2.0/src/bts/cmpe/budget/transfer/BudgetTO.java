package bts.cmpe.budget.transfer;

/**
 * @author PTHSENSOY
 *
 */

public class BudgetTO {
	
	/**
	 * 
	 */
	public  static final int STD = 1;
	
	/**
	 * 
	 */
	public static final  int WAGER = 2;
	
	/**
	 * 
	 */
	private int id;
	/**
	 * 
	 */
	private int type;
	/**
	 * 
	 */
	private double netBudget;
	/**
	 * 
	 */
	private int numMainAppr;
	/**
	 * 
	 */
	private String instCode;
	/**
	 * 
	 */
	private String funcCode;
	/**
	 * 
	 */
	private String ecoCode;
	
	/**
	 * @param pid budget id
	 * @param ptype budget type
	 * @param pnetBudget net budget
	 * @param pnumMainAppr number of main budgets
	 * @param pinstCode institutional code
	 * @param pfuncCode functional code
	 * @param pecoCode economic code
	 */
	public BudgetTO(final int pid, 
			final int ptype, 
			final double pnetBudget, 
			final int pnumMainAppr,
			final String pinstCode, 
			final String pfuncCode, 
			final String pecoCode) {
		id = pid;
		type = ptype;
		netBudget = pnetBudget;
		numMainAppr = pnumMainAppr;
		instCode = pinstCode;
		funcCode = pfuncCode;
		ecoCode = pecoCode;
	}
	
	/**
	 * @param ptype budget type
	 * @param pnumMainAppr number of main budgets
	 * @param pinstCode institutional code
	 * @param pfuncCode functional code
	 * @param pecoCode economic code
	 */
	public BudgetTO(final String pinstCode, 
			final String pfuncCode, 
			final String pecoCode,
			final int ptype,  
			final int pnumMainAppr) {
		type = ptype;
		numMainAppr = pnumMainAppr;
		instCode = pinstCode;
		funcCode = pfuncCode;
		ecoCode = pecoCode;
	}
	
	/**
	 * @param pinstCode Institutional Code
	 * @param pfuncCode Functional Code
	 * @param pecoCode Economy Code
	 */
	public BudgetTO(final String pinstCode, 
			final String pfuncCode, 
			final String pecoCode) {
		instCode = pinstCode;
		funcCode = pfuncCode;
		ecoCode = pecoCode;
	}

	/**
	 * @param budgetId primary key.
	 */
	public BudgetTO(final int budgetId) {
		id = budgetId;
	}

	/**
	 * @return the _ecoCode
	 */
	public final String getEcoCode() {
		return ecoCode;
	}

	/**
	 * @param pcode the _ecoCode to set
	 */
	public final void setEcoCode(final String pcode) {
		ecoCode = pcode;
	}

	/**
	 * @return the _funcCode
	 */
	public final String getFuncCode() {
		return funcCode;
	}

	/**
	 * @param pcode the _funcCode to set
	 */
	public final void setFuncCode(final String pcode) {
		funcCode = pcode;
	}

	/**
	 * @return the _id
	 */
	public final int getId() {
		return id;
	}

	/**
	 * @param pid the _id to set
	 */
	public final void setId(final int pid) {
		this.id = pid;
	}

	/**
	 * @return the _instCode
	 */
	public final String getInstCode() {
		return instCode;
	}

	/**
	 * @param pcode the _instCode to set
	 */
	public final void setInstCode(final String pcode) {
		instCode = pcode;
	}

	/**
	 * @return the netBudget
	 */
	public final double getNetBudget() {
		return netBudget;
	}
	
	/**
	 * @param pbudget budget balance
	 */
	public final void setNetBudget(final double pbudget) {
		netBudget = pbudget;
	}

	/**
	 * @return the numMainAppr
	 */
	public final int getNumMainAppr() {
		return numMainAppr;
	}



	/**
	 * @param pmainAppr number main appr.
	 */
	public final void setNumMainAppr(final int pmainAppr) {
		numMainAppr = pmainAppr;
	}

	/**
	 * @return the type
	 */
	public final int getType() {
		return type;
	}

	/**
	 * @param ptype Type of Budget
	 */
	public final void setType(final int ptype) {
		this.type = ptype;
	}

}




