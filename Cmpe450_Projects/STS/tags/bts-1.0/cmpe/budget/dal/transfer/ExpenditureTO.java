/**
 * 
 */
package bts.cmpe.budget.dal.transfer;
import java.sql.Date;

/**
 * @author Yanis
 *
 */
public class ExpenditureTO {
	
	/**
	 * type of expenditure.
	 */
	private static final int NORMAL = 1;
	/**
	 * type of expenditure.
	 */
	private static final int WAGER = 2;
	
	/**
	 * type.
	 */
	private int type;
	
	
	/**
	 * status.
	 */
	private String status; 
	
	/**
	 *  Corresponds to "defter Sira No".
	 */
	private int orderNo;

	/**
	 * Corresponds to "Tutar".
	 */ 
	private double tahakkukQuantity;

	/**
	 * Corresponds to "istek fisi tarihi". 
	 */
	private Date requestDate;

	/**
	 * Corresponds to "istek fisi tutari". 
	 */
	private double requestAmount;


	/**
	 * Corresponds to "Malzemenin cinsi".
	 */
	private String typeOfMaterial;

	/**
	 * Corresponds to "Birimi".
	 */
	private String unit;

	/**
	 * Correspond to "Kime tahakkuk etti�i veya odendi�i". 
	 */
	private String paidToWhom;

	/**
	 * Corresponds to "tahakkuk NO".
	 */
	private String tahakkukID;

	/**
	 * Corresponds to "tahakkuk tarihi". 
	 */
	private Date tahakkukDate;

	/**
	 * economic code.
	 */
	private String ecoCode;

	/**
	 * additional array. 
	 */
	private double[] additionalFields;
	
	/**
	 * Amount of additional fields.
	 */
	private final int fieldAmount = 6;


	/**
	 * @param myOrderNo Defter sıra no.
	 * @param myTahakkukQuantity tahakkuk tutar�
	 * @param myPaidToWhom kime odendi�i
	 * @param myTahakkukID tahakkuk no
	 * @param myTahakkukDate tahakkuk tarihi
	 * @param myStatus active or deleted
	 */
	public ExpenditureTO(final int myOrderNo,
			final String myPaidToWhom, final String myTahakkukID,
			final Date myTahakkukDate, final double myTahakkukQuantity,
			final String myStatus) {

		orderNo = myOrderNo;
		tahakkukQuantity = myTahakkukQuantity;	
		paidToWhom = myPaidToWhom;
		tahakkukID = myTahakkukID;
		tahakkukDate = myTahakkukDate;
		status = myStatus;



	} 

	/**
	 * @param myUnit birimi
	 * @param myRequestDate istek tarihi
	 * @param myRequestAmount istek miktar
	 * @param myTypeOfMaterial malzemenin cinsi
	 * @param myEcoCode Ekonomik kodu	 
	 */
	public final void fillNormal(final String myUnit,
			final Date myRequestDate,
			final Double myRequestAmount, final String myTypeOfMaterial,
			final String myEcoCode) {
		
		requestDate = myRequestDate;
		requestAmount = myRequestAmount;
		typeOfMaterial = myTypeOfMaterial;
		unit = myUnit;
		ecoCode = myEcoCode;
		type = NORMAL;
		

	}
	
	/**
	 * @param myAdditionalFields additional.
	 */
	public final void fillWager(final double[] myAdditionalFields) {
		
		additionalFields = new double[fieldAmount];
		type = WAGER;
		for (int i = 0; i < fieldAmount; i++) {
			additionalFields[i] = myAdditionalFields[i];
		}
	}

	/**
	 * @return the additionalFields
	 */
	public final double[] getAdditionalFields() {
		return additionalFields;
	}

	/**
	 * @return the ecoCode
	 */
	public final String getEcoCode() {
		return ecoCode;
	}

	/**
	 * @return the fieldAmount
	 */
	public final int getFieldAmount() {
		return fieldAmount;
	}

	/**
	 * @return the orderNo
	 */
	public final int getOrderNo() {
		return orderNo;
	}

	/**
	 * @return the paidToWhom
	 */
	public final String getPaidToWhom() {
		return paidToWhom;
	}

	/**
	 * @return the requestAmount
	 */
	public final double getRequestAmount() {
		return requestAmount;
	}

	/**
	 * @return the requestDate
	 */
	public final Date getRequestDate() {
		return requestDate;
	}

	/**
	 * @return the tahakkukDate
	 */
	public final Date getTahakkukDate() {
		return tahakkukDate;
	}

	/**
	 * @return the tahakkukID
	 */
	public final String getTahakkukID() {
		return tahakkukID;
	}

	/**
	 * @return the tahakkukQuantity
	 */
	public final double getTahakkukQuantity() {
		return tahakkukQuantity;
	}

	/**
	 * @return the typeOfMaterial
	 */
	public final String getTypeOfMaterial() {
		return typeOfMaterial;
	}

	/**
	 * @return the unit
	 */
	public final String getUnit() {
		return unit;
	}

	/**
	 * @return the type
	 */
	public final int getType() {
		return type;
	}

	/**
	 * @return the status
	 */
	public final String getStatus() {
		return status;
	}



}
