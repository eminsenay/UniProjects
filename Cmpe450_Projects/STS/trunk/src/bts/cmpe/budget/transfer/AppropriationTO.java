package bts.cmpe.budget.transfer;

import java.sql.Date;

/**
 * @author ozan
 *
 */
public class AppropriationTO {

	/**
	 * once in 3 months. 
	 */
	public static final int MONTH_3 = 3;

	/**
	 * once in 6 months.
	 */
	public static final int MONTH_6 = 6;

	/**
	 * additional from government.
	 */
	public static final int ADDITIONAL = 1;

	/**
	 * Appropriation id defined in database.
	 */
	private int id;

	/**
	 * index that marks the position of appropiation.
	 */
	private int index;

	/**
	 * amount of appropiration.
	 */
	private double amount;

	/**
	 * date of appropiration.
	 */
	private Date date;

	/**
	 * type of appropiration. 
	 */
	private int type;

	/**
	 * Budget that appropriation belongs to.
	 */
	private int budget;

	

	/**
	 * @param pid id
	 * @param pindex index
	 * @param pamount amount
	 * @param pdate date
	 * @param ptype type
	 * @param pbudget budget
	 */
	public AppropriationTO(final int pid, final int pindex, 
			final double pamount, final Date pdate, 
			final int ptype, final int pbudget) {
		this.id = pid;
		this.index = pindex;
		this.amount = pamount;
		this.date = pdate;
		this.type = ptype;
		this.budget = pbudget;
	}
	
	/**
	 * @param pindex index
	 * @param pamount amount
	 * @param pdate date
	 * @param ptype type
	 */
	public AppropriationTO(final int pindex, 
			final double pamount, final Date pdate, 
			final int ptype) {
		this.id = 0;
		this.index = pindex;
		this.amount = pamount;
		this.date = pdate;
		this.type = ptype;
		this.budget = 0;
	}


	/**
	 * @return the amount
	 */
	public final double getAmount() {
		return amount;
	}



	/**
	 * @param pamount the amount to set
	 */
	public final void setAmount(final double pamount) {
		this.amount = pamount;
	}



	/**
	 * @return the budget
	 */
	public final int getBudget() {
		return budget;
	}



	/**
	 * @param pbudget the budget to set
	 */
	public final void setBudget(final int pbudget) {
		this.budget = pbudget;
	}



	/**
	 * @return the date
	 */
	public final Date getDate() {
		return date;
	}



	/**
	 * @param pdate the date to set
	 */
	public final void setDate(final Date pdate) {
		this.date = pdate;
	}



	/**
	 * @return the id
	 */
	public final int getId() {
		return id;
	}



	/**
	 * @param pid the id to set
	 */
	public final void setId(final int pid) {
		this.id = pid;
	}



	/**
	 * @return the index
	 */
	public final int getIndex() {
		return index;
	}



	/**
	 * @param pindex the index to set
	 */
	public final void setIndex(final int pindex) {
		this.index = pindex;
	}



	/**
	 * @return the type
	 */
	public final int getType() {
		return type;
	}



	/**
	 * @param ptype the type to set
	 */
	public final void setType(final int ptype) {
		this.type = ptype;
	}
}
