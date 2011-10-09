/**
 * 
 */
package bts.cmpe.budget.transfer;

import java.sql.Date;

/**
 * @author PTHSENSOY
 *
 */
public class ExpenseStdTO extends ExpenseBaseTO {
	
	/**
	 * 
	 */
	private int id;
	/**
	 * 
	 */
	private Date requestDate;
	/**
	 * 
	 */
	private double requestAmount;
	/**
	 * 
	 */
	private String materialType;
	/**
	 * 
	 */
	private String unit;
	/**
	 * 
	 */
	private String ecoCode;
	
	/**
	 * 
	 */
	public ExpenseStdTO() {
		super();
	}

	/**
	 * @return the ecoCode
	 */
	public final String getEcoCode() {
		return ecoCode;
	}

	/**
	 * @param pecoCode the ecoCode to set
	 */
	public final void setEcoCode(final String pecoCode) {
		this.ecoCode = pecoCode;
	}

	/**
	 * @return the materialType
	 */
	public final String getMaterialType() {
		return materialType;
	}

	/**
	 * @param pmaterialType the materialType to set
	 */
	public final void setMaterialType(final String pmaterialType) {
		this.materialType = pmaterialType;
	}

	/**
	 * @return the requestAmount
	 */
	public final double getRequestAmount() {
		return requestAmount;
	}

	/**
	 * @param prequestAmount the requestAmount to set
	 */
	public final void setRequestAmount(final double prequestAmount) {
		this.requestAmount = prequestAmount;
	}

	/**
	 * @return the requestDate
	 */
	public final Date getRequestDate() {
		return requestDate;
	}

	/**
	 * @param prequestDate the requestDate to set
	 */
	public final void setRequestDate(final Date prequestDate) {
		this.requestDate = prequestDate;
	}

	/**
	 * @return the unit
	 */
	public final String getUnit() {
		return unit;
	}

	/**
	 * @param punit the unit to set
	 */
	public final void setUnit(final String punit) {
		this.unit = punit;
	}

	/**
	 * @return the id
	 */
	public final int getId() {
		return id;
	}

	/**
	 * @param pId the id to set
	 */
	public final void setId(final int pId) {
		this.id = pId;
	}

}
