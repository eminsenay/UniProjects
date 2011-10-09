import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

/** updateStartDates class is used for updating the database table named "startdates". 
 *  This table used for determining hourly data files which will be copied from the storage element. 
 *  The earthquake epicenter location function then runs in these hourly data. 
 *  After that, it sets a flag in this table so that another instance of the program will not rerun on the same data again.
 */
public class updateStartDates {
	
	/** Executes the update query which sets the "successful" flag. The use of this flag is explained above. */
	public static void main(String[] args) {
		DB newDB = new DB();
		Connection conn = newDB.getConnection();

		try {
						
			Statement st = conn.createStatement();

			String updateSt = args[0] + " " + args[1] + " " + args[2] + " " + args[3] + 
					" " + args[4] + " " + args[5] + " " + args[6];
			
			System.out.println("java: " + updateSt);
			st.executeUpdate(updateSt);

			st.close();
			conn.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
