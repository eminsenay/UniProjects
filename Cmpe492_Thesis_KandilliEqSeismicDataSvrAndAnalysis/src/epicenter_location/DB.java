import java.sql.*;
import java.util.Properties;

/** DB class. It is used for connecting the earthquake database. */
public class DB {

	private static String p_Ip = "zumrut.grid.boun.edu.tr";
	private static String p_DatabaseName = "491earthquake";
	private static String p_UserName = "burasi_guvenlik_icin_silinmistir";
	private static String p_Password = "burasi_guvenlik_icin_silinmistir";
	private Connection p_Conn = null;
	
	/** Default constructor */
	public DB() {}

	/** Returns the current connection if there is any; otherwise a new connection is established and returned. */
	public Connection getConnection()
	{
		if (p_Conn == null)
		{
			openConnection();
		}
		return p_Conn;
	}
	
	/** Establishes a new connection. */
	public boolean openConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Properties pro = new Properties();
			pro.setProperty("user",p_UserName);
			pro.setProperty("password",p_Password);
			pro.setProperty("characterEncoding","UTF-8");
	
			p_Conn = DriverManager.getConnection("jdbc:mysql://" + p_Ip + "/"
					+ p_DatabaseName, pro);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/** Closes the current connection. */
	public boolean closeConnection() {
		try {
			p_Conn.close();
			System.out.println("DB Connection is closed.");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
