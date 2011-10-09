/*
 * DB.java
 *
 * Created on September, 2005, 04:00 PM
 *
 
 */

package global;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
//import java.util.Vector;

/**
 * This is the main class to handle db operations.
 * <p>
 * If you want to execute a query first
 * {@link #openConnection open a connection} and execute your query using that
 * connection. Dont forget to close the conn.
 * <p>
 * IMPORTANT :
 * </p>
 * The necessary mysql driver : "mysql-connector-java-3.1.11-bin.jar" archive
 * ,which can be downloaded from www.mysql.com , must be added to project path.
 * 
 * @author Anonymous
 */
public class DB {
	/**
	 * Name of the database that this class supposed to connect to.
	 * <p>
	 * This the name of database in localhost.
	 */
	private static  String p_Ip = "localhost";
	
	/**
	 * Name of the database that this class supposed to connect to.
	 * <p>
	 * This the name of database in localhost.
	 */
	//private static String p_DatabaseName = "Cmpe450_Test";
	private static String p_DatabaseName = "SAS_DB";
	
	/**
	 * User name to connect to {@link #databaseName database}. This will be
	 * given by db group.
	 */
	private static String p_UserName = "SASuser";
	
	/**
	 * Password of {@link #userName user name} to connect to
	 * {@link #databaseName database} . This will be given by db group
	 */
	private static String p_Password = "dbherzamanhaklidir";
	
//	private static int numberOfStartingConnections=10;
//	private static int numberOfCapacityIncrement=5;   
//	private static Vector connectionPool=new Vector(numberOfStartingConnections);
//	private static boolean fillConnectionPool(int numberOfConnection)
//	{          
//		for(int i=0;i<numberOfStartingConnections;i++)
//		{
//			System.out.println("New Connection Thread is Created.");
//			addConnectionToPool aCTP=new addConnectionToPool();
//			new Thread(aCTP).start();
//		}
//		return true;
//	}
//	private static class addConnectionToPool implements Runnable{
//		public addConnectionToPool(){}
//		public void run(){
//			Connection conn=getConnection();
//			if(conn!=null)
//				connectionPool.add(conn);
//		}
//	}
//	private static class fillConnectionPoolRun implements Runnable{
//		private int numberOfConnectionIncrement=numberOfCapacityIncrement; 
//		public fillConnectionPoolRun(int num){
//			numberOfConnectionIncrement=num;
//		}
//		public void run()
//		{
//			System.out.println("New Fill Connection Pool Thread is Created.");
//			fillConnectionPool(numberOfConnectionIncrement);                
//		}
//	}
//	private static boolean startingPool()
//	{
//		Connection conn=getConnection();
//		if(conn!=null)
//			connectionPool.add(conn);
//		fillConnectionPoolRun f=new fillConnectionPoolRun(numberOfStartingConnections);
//		new Thread(f).start();
//		return true;
//	}
//	public static boolean isSuccess=startingPool();
//	private static Connection getConnection()
//	{
//		Connection conn=null;
//		try {
//			Class.forName("com.mysql.jdbc.Driver").newInstance();
//			conn = DriverManager.getConnection("jdbc:mysql://" + p_Ip + "/" + p_DatabaseName, p_UserName, p_Password);
//			System.out.println("New Connection is Created.");
//		} catch (Exception e) {
//			e.printStackTrace(System.out);
//			return null;                               
//		}
//		return conn;
//	}
	/** Bütün i?ler bu conn üzerinden yap?l?r. */
	private Connection p_Conn = null;
	/**	SP execution da kullan?lan Callable Statement*/
	private CallableStatement p_CStmt = null;        
	/**
	 * Bilgi mesajlar?n?n yada hata mesajlar?n?n gönderilece?i PrintStream
	 */
	private static PrintStream p_PWriter=System.out;
	/**
	 * Initialize new instance with default connection parameters
	 * 
	 * @param OpenConn
	 *            true: Connection hemen aç?ls?n. false:Sonra ben kendim
	 *            openConnection methodu ile açar?m.
	 */
	public DB(boolean OpenConn) {
		//if(isSuccess)			
		if (OpenConn)
			openConnection();
	}
	public DB(boolean OpenConn, String ip, String databaseName,
			String username, String password) {
		p_Ip = ip;
		p_DatabaseName = databaseName;
		p_UserName = username;
		p_Password = password;
		//if(isSuccess)
		if (OpenConn)
			openConnection();
	}
	
	/**
	 * Ba?lant?y? açar.
	 * 
	 * @see #closeConnection
	 * @return true: E?er ba?ar?l? bir ?ekilde connection aç?lm?? ise, false:
	 *         Herhangi bir hata varsa.
	 */
//	public boolean openConnection() {
//		try{
//			p_PWriter.println("Database Connection is requested."+connectionPool.size());
//			if(!connectionPool.isEmpty())
//			{
//				p_Conn=(Connection)connectionPool.remove(0);
//				if(p_Conn.isClosed())
//					return this.openConnection();
//				p_PWriter.println("Database Connection is held(1).");
//				if(connectionPool.isEmpty()){
//					fillConnectionPoolRun f=new fillConnectionPoolRun(numberOfCapacityIncrement);
//					new Thread(f).start();
//				}
//				
//			}
//			else
//			{
//				p_Conn=getConnection();
//				p_PWriter.println("Database Connection is held(2).");
//				fillConnectionPoolRun f=new fillConnectionPoolRun(numberOfCapacityIncrement);
//				new Thread(f).start();
//			}
//		}catch(Exception exc){
//			System.out.println("Connection Acilamadi, Sebep:");
//			exc.printStackTrace(System.out);
//			return false;
//		}
//		return true;
//	}
	public boolean openConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Properties pro = new Properties();
			pro.setProperty("user",p_UserName);
			pro.setProperty("password",p_Password);
			pro.setProperty("characterEncoding","UTF-8");
			
			p_Conn = DriverManager.getConnection("jdbc:mysql://" + p_Ip + "/"
					+ p_DatabaseName, pro);
			p_PWriter.println("DB connection is established.");
			return true;
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return false;
	}
	
	/**
	 * Print Stream? set eden z?mb?rt?.
	 * Default olarak System.out ile set edilidir. Yani consola yazd?r?r.
	 * @param pw Bilgi mesajlar?n?n ve hata mesajlar?n?n, stacktracelerinin yaz?laca?? stream
	 * 
	 * @return verilen printstreamde bi yamuk varsa false. ba?ar?l? bir ?ekilde set ederse true döner
	 */
	public boolean setPrintStream(PrintStream pw)
	{
		if(pw==null)
			return false;
		if(pw.checkError())
			return false;
		try{
			System.out.println("printWriter de?i?tiriliyor");
			pw.println("Yeni printWriter'a geçildi.");
			p_PWriter=pw;
		}catch(Exception exc){
			System.out.println("printWriter de?i?tirilemedi, Sebep:");
			exc.printStackTrace(System.out);
			return false;
		}		
		return true;
	}
	
	/**
	 * Stored procedure execute eder. Result set döndermez.
	 * @param procedureName execute edilecek olan SP'nin ad?
	 * @param parameters procedure'e yollanacak olan parametreler. 
	 * @return Execution ba?ar?l? ise kendisini, ba?ar?s?z ise null döndürür.
	 * önemli: geriye kendisini dönderince, getResult ile varsa Resultseti al?rs?n?z.
	 * yani,SP geriye data dönüyorsa
	 *  <p><tt> ResultSet rs=db.executeSP("x",new Object[]{"a",1}).getResult(); </tt>
	 *  ?eklinde kullan?labilir.
	 *  SP geriye data dönmüyorsa
	 *  <p><tt>if(db.executeSP("x",new Object[]{"a",1})==null)</tt>
	 * 	<p><tt>		hata var;</tt>
	 * 	<p><tt>else</tt>
	 * 	<p><tt>		devam;</tt>
	 * <p>?eklinde kullan?labilir.
	 */
	

	public DB executeSP(String procedureName, Object[] parameters) {
		try {
			String callQuery = "{call " + procedureName + "(?";
			for (int i = 1; i < parameters.length; i++)
				callQuery += ",?";
			p_CStmt = p_Conn.prepareCall(callQuery + ")}");
			for (int i = 0; i < parameters.length; i++)
				p_CStmt.setObject(i + 1, parameters[i]);
			
			p_CStmt.execute();
			return this;
			
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return null;
	}
	/**
	 * Stored procedure execute eder. Result set döndermez.
	 * @param procedureName execute edilecek olan SP'nin ad?
	 * @return Execution ba?ar?l? ise kendisini, ba?ar?s?z ise null döndürür.
	 * önemli: geriye kendisini dönderince, getResult ile varsa Resultseti al?rs?n?z.
	 * yani,SP geriye data dönüyorsa
	 *  <p><tt>	ResultSet rs=db.executeSP("x",new Object[]{"a",1}).getResult();</tt>
	 *  <p>?eklinde kullan?labilir.
	 *  <p>SP geriye data dönmüyorsa
	 *  <p><tt>if(db.executeSP("x",new Object[]{"a",1})==null)</tt>
	 * 	<p><tt>		hata var;</tt>
	 * 	<p><tt>else</tt>
	 * 	<p><tt>		devam;</tt>
	 * <p>?eklinde kullan?labilir.
	 */
	public DB executeSP(String procedureName) {
		try {
			p_CStmt = p_Conn.prepareCall("{call " + procedureName + "()}");
			p_CStmt.execute();
			return this;
			
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return null;
	}
	
	/** Execute edilen bir SP den dönen ResultSeti döndürür.
	 * @return SP den gelen Result Set 
	 */
	public ResultSet getResult() {
		try {
			return p_CStmt.getResultSet();
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return null;
	}
	
	/** Yeni bir transaction ba?lat?r
	 * @return ba?ar?l? ise true, herhangi bir aksilik ile kar??la??rsa false döner.
	 */
	public boolean beginTransaction() {
		try {
			p_Conn.setAutoCommit(false);
			p_PWriter.println("Transaction Basladi\n");
			return true;
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return false;
	}
	
	/** Ba?lam?? bir transaction? bitiri
	 * @return ba?ar?l? ise true, herhangi bir aksilik ile kar??la??rsa false döner.
	 */
	public boolean commitTransaction() {
		try {
			if (p_Conn.getAutoCommit())
				return false;
			p_Conn.commit();
			p_Conn.setAutoCommit(true);
			p_PWriter.println("Transaction Commit Edildi\n");
			return true;
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return false;
	}
	
	/** Transaction s?ras?nda bir aksilik ç?k?nca rollback yapmak içindir.
	 * @return true rollback ba?ar?l? ise, false rollback yaparken bir aksilik ç?karsa.
	 */
	public boolean rollbackTransaction() {
		try {
			if (p_Conn.getAutoCommit())
				return false;
			p_Conn.rollback();
			p_Conn.setAutoCommit(true);
			p_PWriter.println("Rollback Yapildi\n");
			return true;
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return false;
	}
	
	/**
	 * Executes the given query, 
	 * 
	 * @param query
	 *            Query string that will be executed.
	 * @return if is succesful (true/false)
	 */
	public boolean execute(String query) {
		try {
			
			Statement stmt;
			stmt = p_Conn.createStatement();
			boolean retValue = stmt.execute(query);
			
			return retValue;
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return false;
	}
	/**
	 * Executes the given query, 
	 * 
	 * @param query
	 *            Query string that will be executed.
	 * @return if is succesful (true/false)
	 */
	public ResultSet executeQuery(String query) {
		try {
			return p_Conn.createStatement().executeQuery(query);
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return null;
	}
	
	/**
	 * Closes the given db connction .
	 * <p>
	 * NOT:
	 * </p>
	 * Later we may need to use connection pooling for some reosons.
	 * @return true if the connection is succesfully closed ,false o/w
	 */
//	public boolean closeConnection() {
//		try {
//			rollbackTransaction();
//			if(p_Conn.isClosed())
//				return true;
//			connectionPool.add(p_Conn);
//			p_Conn=null;
//			p_PWriter.println("Database Connection is released.");
//			return true;
//		} catch (Exception e) {
//			e.printStackTrace(p_PWriter);
//		}
//		return false;
//	}
	public boolean closeConnection() {
		try {
			p_Conn.close();
			p_PWriter.println("DB Connection is closed.");
			return true;
		} catch (Exception e) {
			e.printStackTrace(p_PWriter);
		}
		return false;
	}
	
	
	
	//private ResultSet p_Result = null;
}
