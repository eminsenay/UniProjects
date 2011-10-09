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
	 * Database connection string.
	 */
	private static final String SERVER  =
		"jdbc:mysql://193.140.192.245/";
	
	/**
	 * Default database name.
	 */
	private static final String DB = "BTS_DB";
		//"jdbc:mysql://cmpe450.cmpe.boun.edu.tr/BTS_DB";

	
	/**
	 * database username.
	 */
	private static final String USER = "BTSuser";
	
	/**
	 * database password.
	 */
	private static final String PASSWORD = "wasestar";
	
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
	 * @param db Database parameter
	 * @throws InstantiationException Raised when instantiation 
	 * of driver instance.
	 * @throws IllegalAccessException Raised when accessing created 
	 * driver instance.
	 * @throws ClassNotFoundException Raised when desired class can't be found.
	 * @throws SQLException Raised when connection creation fails.
	 */
	private Transaction(final String db, final String user, final String pass)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = (com.mysql.jdbc.Connection) DriverManager.
		getConnection(SERVER + db, user, pass);
		
		conn.setCharacterEncoding("UTF-8");
		conn.setConnectionCollation("utf8_turkish_ci");
			
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
		Transaction tr = new Transaction(DB, USER, PASSWORD);
		return tr;
	}
	
	/**
	 * @param db database
	 * @param name username
	 * @param pass password
	 * @throws Exception run-time
	 * @return Transaction object.
	 */
	public static synchronized Transaction create(final String db, 
			final String name, 
			final String pass) throws Exception {
		
		Transaction tr = new Transaction(db, name, pass);
		return tr;
	}
	
	/**
	 * @param sessionID sessionID
	 * @return an instance of Transaction class.
	 * @throws Exception Run-time SQL exception
	 */
	@SuppressWarnings("unchecked")
	public static synchronized Transaction create(final String sessionID)
			throws Exception {
		if (transactionsTable == null) {
			transactionsTable = new Hashtable();
		}
		if (transactionsTable.get(sessionID) == null) {
			Transaction tr = new Transaction(DB, USER, PASSWORD); 
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
