package bts.cmpe.budget.dal.transfer;

/**
 * @author yanis
 *	Used to identify the transfer. 
 */
public class TransferTO {
	/**
	 *  Unique transfer  ID.
	 */
	private int transferID;
	
	/**
	 * departmentTo class  of department which takes the money. 
	 */
	private DepartmentTO toWhom;
	
	/**
	 *  The quantity is the money transferred <br>
	 *  from one department to other. <br>
	 *  It can be both positive and negative.
	 */
	private double quantity; 
	
	/**
	 *	Description of the transfer. 
	 */
	private String description;
	
	/**
	 * @param myTransferID assigned to TransferID.
	 * @param myToWhom assigned to toWhom.
	 * @param myQuantity assigned to quantity.
	 * @param myDescription assigned to description.
	 */
	public TransferTO(final int myTransferID, final DepartmentTO myToWhom,
			final double myQuantity, final String myDescription) {
		
		transferID = myTransferID;
		description = myDescription;
		toWhom = myToWhom;
		quantity = myQuantity;
		
	}
	/**
	 * @param myToWhom assigned to toWhom.
	 * @param myQuantity assigned to quantity.
	 * @param myDescription assigned to description.
	 */
	public TransferTO(final DepartmentTO myToWhom,
			final double myQuantity, final String myDescription) {
		
		
		description = myDescription;
		toWhom = myToWhom;
		quantity = myQuantity;
		
	}

	/**
	 * @return the description
	 */
	public final String getDescription() {
		return description;
	}

	/**
	 * @return the quantity
	 */
	public final double getQuantity() {
		return quantity;
	}

	/**
	 * @return the toWhom
	 */
	public final DepartmentTO getToWhom() {
		return toWhom;
	}

	/**
	 * @return the transferID
	 */
	public final int getTransferID() {
		return transferID;
	}
	
	
}
