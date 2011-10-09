package bts.cmpe.budget.dal.transfer;

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
	public static final int ADDITIONAL = 0;

	/**
	 * type of appropiration. 
	 */
	private int type;
	
	/**
	 * index that marks the position of appropiation.
	 */
	private int index;
	
	/**
	 * quantity of appropiration.
	 */
	private double quantity;
	
	/**
	 * description of appropiration.
	 */
	private String description;
	
	
	/**
	 * @param myType type can be MONTH_3 MONTH_6 or ADDITIONAL
	 * @param myIndex index marks the position of appropriation
	 * @param myQuantity quantity
	 * @param myDescription description
	 */
	public AppropriationTO(final int myType, final int myIndex,
			final double myQuantity, final String myDescription) {
		type = myType;
		index = myIndex;
		quantity = myQuantity;
		description = myDescription;
	}

	/**
	 * @return quantity
	 */
	public final double getQuantity() {
		return quantity;
	}

	/**
	 * @return type
	 */
	public final int getType() {
		return type;
	}
	
	/**
	 * @return index
	 */
	public final int getIndex() {
		return index;		
	}
	/**
	 * @return description
	 */
	public final String getDescription() {
		return description;
	}
	
	
}
