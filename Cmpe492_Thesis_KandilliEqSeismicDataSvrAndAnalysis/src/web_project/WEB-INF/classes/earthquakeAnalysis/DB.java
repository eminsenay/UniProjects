package earthquakeAnalysis;

import java.sql.*;
import java.util.Properties;

public class DB {

	private static  String p_Ip = "localhost";
	private static String p_DatabaseName = "491earthquake";
	private static String p_UserName = "burasi_guvenlik_icin_silinmistir";
	private static String p_Password = "burasi_guvelik_icin_silinmistir";
	private Connection p_Conn = null;      
	
	public DB() {}

	public Connection getConnection()
	{
		if (p_Conn == null)
		{
			openConnection();
		}
		return p_Conn;
	}
	
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
