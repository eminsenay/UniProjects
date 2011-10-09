import java.sql.*;
import java.util.*;
import java.io.*;

/** selectQuery class is used for determining the date and hour on which earthquake location program runs. */
public class selectQuery {

	/** It takes the next "unsuccessful" hour value from the database and executes the earthquake location program on this time. 
	 *  For the hour to be "unsuccessful", either the program never worked with that time values 
	 *  or the execution on that time is unsuccessful because of a specific reason such as data inavailability.
	 */
	public static void main(String[] Args) {

		DB newDB = new DB();
		Connection conn = newDB.getConnection();

		try {
						
			Statement st = conn.createStatement();

			//String updateSt = Args[0] + " " + Args[1] + " " + Args[2] + " " + Args[3];
			
			String selectSt = "SELECT * FROM startdates s where successful = 0 and startdate < now() order by id desc";
			
			ResultSet rs = st.executeQuery(selectSt);
			
			while(rs.next()) {
				
				int id = rs.getInt("id");
				java.sql.Date nextDate = rs.getDate("startdate");
				Time nextTime = rs.getTime("startdate");
				// Başka bir prog. bu saati yapıyor olabilir, sırası gelince 
				// tekrar kontrol et
				String sql_selectID = "SELECT successful FROM startdates WHERE id = " + id;
				Statement st_selectID = conn.createStatement();
				ResultSet rs_selectID = st_selectID.executeQuery(sql_selectID);
				if (rs_selectID.next())
				{
					int successNow = rs_selectID.getInt(1);
					if (successNow == 0) //Hala çalıştırılmamış
					{
						
						System.out.println("------------------------------------------------");
						System.out.println("Next Date and Hour: " + nextDate + " " + nextTime);
						String[] dateSplit = nextDate.toString().split("-");
						String[] timeSplit = nextTime.toString().split(":");
						/*for (int i = 0; i < dateSplit.length; i++)
						{
							System.out.println(dateSplit[i]); //2007-05-23
						}
						for (int i = 0; i < timeSplit.length; i++)
						{
							System.out.println(timeSplit[i]); //16:00:00
						}*/
						String command = "./RUNSINGLEHOUR " + dateSplit[0] + " " + dateSplit[1] + " " +
								dateSplit[2] + " " + timeSplit[0] + " 0";

						Runtime rt = Runtime.getRuntime();						
						Process proc = rt.exec(command);
						
						InputStream stdin = proc.getInputStream();
						InputStreamReader isr = new InputStreamReader(stdin);
						BufferedReader br = new BufferedReader(isr);
						String line = null;
						while ( (line = br.readLine()) != null)
							System.out.println(line);

						int exitVal = proc.waitFor();
//						java.lang.Runtime.getRuntime().exec("pwd");
//						Runtime rt = Runtime.getRuntime();
//						Process proc = rt.exec("pwd");
//						int exitVal = proc.waitFor();
					}
				}
				rs_selectID.close();
				st_selectID.close();
			}
			rs.close();
			st.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
