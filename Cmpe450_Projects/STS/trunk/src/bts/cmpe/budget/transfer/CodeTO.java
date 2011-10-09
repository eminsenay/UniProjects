/**
 * 
 */
package bts.cmpe.budget.transfer;

/**
 * @author Memil
 *
 */
public class CodeTO {
	/**
	 * 
	 */
	public static final int INST = 0;
	/**
	 * 
	 */
	public static final int ECO = 1;
	/**
	 * 
	 */
	public static final int FUNC = 2;
	
	/**
	 * 
	 */
	private String name;
	/**
	 * 
	 */
	private String value;
	/**
	 * 
	 */
	private int type;
	
	/**
	 * @param pname Name to be displayed in drop-down.
	 * @param pvalue Name to be returned from drop-down.
	 * @param ptype Type of the code.
	 */
	public CodeTO(final String pname, final String pvalue, final int ptype) {
		this.name = pname;
		this.value = pvalue;
		this.type = ptype;
	}
	/**
	 * @return the name
	 */
	public final String getName() {
		return name;
	}
	/**
	 * @param pname the name to set
	 */
	public final void setName(final String pname) {
		this.name = pname;
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
	/**
	 * @return the value
	 */
	public final String getValue() {
		return value;
	}
	/**
	 * @param pvalue the value to set
	 */
	public final void setValue(final String pvalue) {
		this.value = pvalue;
	}
	
	

}
