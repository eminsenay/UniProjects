package bts.cmpe.budget.dal;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Hashtable;

import com.mysql.jdbc.Connection;

/**
 * @author PTHSENSOY
 * 
 */
public final class Transaction {
	/**
	 * Each transaction has its own connection object initialzed by
	 * getConnection method.
	 */
	private Connection conn = null;

	/**
	 * Since bussiness tier will be using instances of Transaction class instead
	 * of raising SQL,IO etc. exceptions, class methods raises RunTime
	 * exceptions.
	 */
	private Exception exc = null;
	
	/**
	 * Database connection string.
	 */
	private static final String CONN_STRING  =
		"jdbc:mysql://193.140.192.245/BTS_DB";
		//"jdbc:mysql://cmpe450.cmpe.boun.edu.tr/BTS_DB";

	
	/**
	 * database username.
	 */
	private static final String DB_USER = "BTSuser";
	
	/**
	 * database password.
	 */
	private static final String DB_PASSWORD = "wasestar";
	
	/**
	 * this is the object that holds all transaction per all sessions.
	 */
	private static Hashtable < String, Transaction > transactionsTable;
	/**
	 * Private constructor of class
	 * <li>Initialize cache manager instance if it hasn't been 
	 * initialized yet.</li>
	 * <li>Get a new connection from Cache</li>
	 * 
	 * @param user User for database connection
	 * @param pass Password for database connection
	 * @throws InstantiationException Raised when instantiation 
	 * of driver instance.
	 * @throws IllegalAccessException Raised when accessing created 
	 * driver instance.
	 * @throws ClassNotFoundException Raised when desired class can't be found.
	 * @throws SQLException Raised when connection creation fails.
	 */
	private Transaction(final String user, final String pass)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = (com.mysql.jdbc.Connection) DriverManager.
		getConnection(CONN_STRING, user, pass);
		conn.setAutoCommit(false);
	}
	
	/**
	 * @return an instance of Transaction class.
	 * @throws Exception Run-time SQL exception
	 */
	public static synchronized Transaction create() 
	throws Exception {
		//return create("");
		//TODO: sonradan yapi duzeltilecek her defasinda yeni hata yollanmayacak
		Transaction tr = new Transaction(DB_USER, DB_PASSWORD);
		return tr;
	}
	
	/**
	 * @param sessionID sessionID
	 * @return an instance of Transaction class.
	 * @throws Exception Run-time SQL exception
	 */
	public static synchronized Transaction create(final String sessionID)
			throws Exception {
		if (transactionsTable == null) {
			transactionsTable = new Hashtable();
		}
		if (transactionsTable.get(sessionID) == null) {
			Transaction tr = new Transaction(DB_USER, DB_PASSWORD); 
			transactionsTable.put(sessionID, tr);
		}
		return transactionsTable.get(sessionID);
	}

	/**
	 * Commits the current transaction.
	 */
	public void commit() {
		try {
			conn.commit();
		} catch (SQLException e) {
			conn = null;
			//TODO Decide what to do.
		}
	}

	/**
	 * Rollbacks the current transaction.
	 */
	public void rollback() {
		try {
			conn.rollback();
		} catch (SQLException e) {
			conn = null;
			//TODO Decide what to do.
		}
	}

	/**
	 * Closes current connection and gives it back to the connection cache.
	 * 
	 * @throws Exception
	 */
	public void terminate() {
		try {
			conn.close();
		} catch (SQLException e) {
			conn = null;
		}
	}

	/**
	 * Pick-up the connection object for various operations at DAL. Such as, for
	 * calling PreparedStatements.
	 * 
	 * @return private Connection member.
	 */
	public Connection pick() {
		return conn;
	}

}
