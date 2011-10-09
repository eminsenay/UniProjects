import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

/** Class for inserting new items to the database. */
public class insertQuery {

	/** Inserts the given query. Each space character is considered as a new argument to the program.
	 *  There are three spaces in the program which is calling this program. (Insert into xxx(a,b,c...) values....) 
	 *  All 4 words are reconnected before inserting a new record.
	 */
	public static void main(String[] Args) {

		DB newDB = new DB();
		Connection conn = newDB.getConnection();

		try {
						
			Statement st = conn.createStatement();

			String updateSt = Args[0] + " " + Args[1] + " " + Args[2] + " " + Args[3];
			
			//System.out.println(updateSt);
			st.executeUpdate(updateSt);

			st.close();
			conn.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}