package earthquakeAnalysis;
import java.sql.*;

public class GenerateEarthquake {

	public static void main(String[] Args) {

		DB newDB = new DB();
		Connection conn = newDB.getConnection();


		try {
			conn.setAutoCommit(false);
			Statement st = conn.createStatement();

			int year, month,day, hour, minute, second;
			double eqlatitude, eqlongtitude, eqmagnitude, eqdepth;


			for(int eqid = 1; eqid <= 300; eqid ++) {

				hour = (int)(Math.random()*24);
				minute = (int)(Math.random()*60);
				second = (int)(Math.random()*60);
				year = 2002 + (int) (Math.random()*5);
				month = 1 + (int) (Math.random()*12);
				eqdepth = Math.random()*100;

				if (month == 2) {
					day = 1 + (int) (Math.random()*28);
				} else {
					if( month == 1 || month == 3 || month == 5 || month == 7 ||
							month == 8 || month == 10 || month == 12
					) {		    
						day = 1 + (int) (Math.random()*31);

					} else {

						day = 1 + (int) (Math.random()*30);
					}

					eqlatitude = 36 + (double) (Math.random()*6);
					eqlongtitude = 26 + (double) (Math.random()*19);
					eqmagnitude = 0 + (double) (Math.random()*8);		

					String updateSt = "INSERT INTO `491earthquake`.`eqdata` " +
					"(eqdate, eqtime, eqlatitude, eqlongtitude, eqdepth, eqmagnitude) "
					+ "VALUES  " 
					+ "('" + year + "-" + month + "-" + day
					+ "','" + hour + ":" + minute + ":" + second
					+ "'," + eqlatitude + "," + eqlongtitude + ","
					+ eqdepth + "," + eqmagnitude + ")";

					//System.out.println(updateSt);
					st.executeUpdate(updateSt);
				}

			}

			conn.commit();
			st.close();
			conn.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}