package bts.cmpe.budget.transfer;

import java.sql.Date;

/**
 * @author HSensoy
 *
 */
public class ExpenseBaseTO {
	/**
	 * Active record.
	 */
	public static final int ACTIVE = 1;
	/**
	 * Deleted record.
	 */
	public static final int DELETED = 2;
	
	/**
	 * What we call "Defter No".
	 */
	private int inventoryNo;
	/**
	 * What we call "Tahakkuk Tutarı".
	 */
	private double realizationAmount;
	/**
	 * What we call "Tahakkuk Edilen".
	 */
	private String toWhom;
	/**
	 * What we call "Tahakkuk No".
	 */
	private int realizationId;
	/**
	 * What we call "Tahakkuk tarihi".
	 */
	private Date realizationDate;
	/**
	 * Status of the database record, deleted, active,so.
	 */
	private int status;
	/**
	 * Budget of the expendire.
	 */
	private int budgetId;
	/**
	 * @return the budgetId
	 */
	public final int getBudgetId() {
		return budgetId;
	}
	/**
	 * @param pbudgetId the budgetId to set
	 */
	public final void setBudgetId(final int pbudgetId) {
		this.budgetId = pbudgetId;
	}
	/**
	 * @return the inventoryNo
	 */
	public final int getInventoryNo() {
		return inventoryNo;
	}
	/**
	 * @param pinventoryNo the inventoryNo to set
	 */
	public final void setInventoryNo(final int pinventoryNo) {
		this.inventoryNo = pinventoryNo;
	}
	/**
	 * @return the realizationAmount
	 */
	public final double getRealizationAmount() {
		return realizationAmount;
	}
	/**
	 * @param prealizationAmount the realizationAmount to set
	 */
	public final void setRealizationAmount(final double prealizationAmount) {
		this.realizationAmount = prealizationAmount;
	}
	/**
	 * @return the realizationDate
	 */
	public final Date getRealizationDate() {
		return realizationDate;
	}
	/**
	 * @param prealizationDate the realizationDate to set
	 */
	public final void setRealizationDate(final Date prealizationDate) {
		this.realizationDate = prealizationDate;
	}
	/**
	 * @return the realizationId
	 */
	public final int getRealizationId() {
		return realizationId;
	}
	/**
	 * @param prealizationId the realizationId to set
	 */
	public final void setRealizationId(final int prealizationId) {
		this.realizationId = prealizationId;
	}
	/**
	 * @return the status
	 */
	public final int getStatus() {
		return status;
	}
	/**
	 * @param pstatus the status to set
	 */
	public final void setStatus(final int pstatus) {
		this.status = pstatus;
	}
	/**
	 * @return the toWhom
	 */
	public final String getToWhom() {
		return toWhom;
	}
	/**
	 * @param ptoWhom the toWhom to set
	 */
	public final void setToWhom(final String ptoWhom) {
		this.toWhom = ptoWhom;
	}

	/**
	 * 
	 */
	public ExpenseBaseTO() {
		
	}
		
	
}
