/**
 * Student ID: 2002103907
 * Project: Cmpe 321 Project #2 - Simple Storage Manager For DBMS
 * @author Emin Þenay
 */

import java.io.IOException;
import java.io.RandomAccessFile;

public class HeaderPage {
	/** Number Of Tables in each page */
	int NumOfTablesInPage; // 4 bytes for each int
	/** Number of tables in database */
	int NumOfTablesInDB;
	/** True if the page is empty */
	boolean isEmpty; // 1 byte for each boolean
	/** True if the page is full */
	boolean isFull;
	/**
	 * TableInfo array to store the information about tables
	 * @uml.property  name="tables"
	 * @uml.associationEnd  multiplicity="(0 -1)"
	 */
	TableInfo []Tables; // 512 - 10 = 502 bytes remaning
	
	// 502 / 41 = 12.xx
	// 41 * 12 = 492, so need to skip 10 bytes for each page
	
	/** This function initializes the Header Page
	 */
	HeaderPage()
	{
		Tables = new TableInfo[12];
		NumOfTablesInDB = 0;
		NumOfTablesInPage = 0;
		isEmpty = true;
		isFull = false;
		for (int i = 0; i < 12; i++)
			Tables[i] = new TableInfo();
	}
	/** This function writes the page into a random access file.
	 * @param rnd The file pointer to the random access file
	 * @throws IOException if writing to file is unsuccessful
	 * 
	 * @return void 
	 */
	void WriteToFile(RandomAccessFile rnd) throws IOException
	{
		rnd.writeInt(NumOfTablesInPage);
		rnd.writeInt(NumOfTablesInDB);
		rnd.writeBoolean(isEmpty);
		rnd.writeBoolean(isFull);
		for (int i = 0; i < 12; i++)
		{
			// write the characters of the TableName
			for (int j = 0; j < 20; j++)
				rnd.writeChar(Tables[i].TableName[j]);
			rnd.writeBoolean(Tables[i].isFull);
		}
		// writing dummy values to complete 512 bytes
		rnd.writeInt(12345);
		rnd.writeInt(12345);
		rnd.writeChar(65);
		//rnd.skipBytes(10);
	}
	/** This function reads the members of the class from a random access file.
	 * @param rnd The file pointer to the random access file
	 * @throws IOException if reading is unsuccessful, most probably because of the end of file
	 *
	 * @return void
	 */
	void ReadFromFile(RandomAccessFile rnd) throws IOException
	{
		NumOfTablesInPage = rnd.readInt();
		NumOfTablesInDB = rnd.readInt();
		isEmpty = rnd.readBoolean();
		isFull = rnd.readBoolean();
		for (int i = 0; i < 12; i++)
		{
			for (int j = 0; j < 20; j++)
				Tables[i].TableName[j] = rnd.readChar();
			Tables[i].isFull = rnd.readBoolean();
		}
		rnd.skipBytes(10);
	}
}
