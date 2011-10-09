package bts.cmpe.budget.dal;

import java.sql.Connection;

/**
 * @author PTHSENSOY
 * 
 */
public class DAObase {

	/**
	 * Connection obejct, protected access for extending classes.
	 */
	private Connection conn;

	/**
	 * @param tr
	 *            Transaction.conn parameter is set to this.conn for internal
	 *            usage.
	 */
	protected DAObase(final Transaction tr) {
		conn = tr.pick();
	}
	
	/**
	 * @return conn connection object for mysql database.
	 */
	protected final Connection getConn() {
		return conn;
	}
	
}
