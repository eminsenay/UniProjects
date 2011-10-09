package bts.cmpe.budget.transfer;

import java.sql.Date;

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
	 * Transfer Date.
	 */
	private Date transferDate;

	/**
	 * Transfer to.
	 */
	private BudgetTO to;

	/**
	 * Transfer from.
	 */
	private BudgetTO from;
	
	/**
	 * @param id ID
	 * @param transDate Transfer Date
	 * @param pQuantity Quantity 
	 * @param pDesc Description
	 * @param pto To Budget
	 * @param pfrom From Budget
	 */
	public TransferTO(final int id, final Date transDate, 
			final double pQuantity, final String pDesc, 
			final BudgetTO pto, final BudgetTO pfrom) {
		transferID = id;
		transferDate = transDate;
		quantity = pQuantity;
		description = pDesc;
		to = pto;
		from = pfrom;
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
	 * @return from budget id.
	 */
	public final BudgetTO getFrom() {
		return from;
	}
	/**
	 * @return to budget id.
	 */
	public final BudgetTO getTo() {
		return to;
	}
	/**
	 * @return transfer date.
	 */
	public final Date getTransferDate() {
		return transferDate;
	}
	/**
	 * @return the transferID
	 */
	public final int getTransferID() {
		return transferID;
	}
}
