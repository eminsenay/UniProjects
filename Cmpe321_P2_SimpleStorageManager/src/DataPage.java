/**
 * Student ID: 2002103907
 * Project: Cmpe 321 Project #2 - Simple Storage Manager For DBMS
 * @author Emin Þenay
 */

import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * @author  bosisler
 */
public class DataPage {
	/** Number Of Records In Table */
	int NumOfRecordsInTable; // 4 bytes for each int
	/** Number Of Records In Page */
	int NumOfRecordsInPage;
	/** True if page is full */
	boolean isFull; // 1 byte for each boolean
	/** True if page is empty */
	boolean isEmpty;
	/** The Location Of the Primary Key in FildNames Array */
	int PrimaryKey;
	/** Number Of fields */
	int NumOfFields;
	/** Character[][] to store the names of the fields */
	char[][] FieldNames; // 2 bytes for each char
	/**
	 * Record array to store records
	 * @uml.property  name="records"
	 * @uml.associationEnd  multiplicity="(0 -1)"
	 */
	Record[] Records; // 121 bytes for each record
	
	// 4 + 4 + 1 + 1 + 4 + 4 + 120 + 121 * x = 512
	// 121 * x = 512 - 138 = 374
	// x = 374 / 121
	// x = 3  3 * 121 = 363, so need to skip 11 bytes for each page
	/**
	 * This function initializes DataPage
	 */
	DataPage()
	{
		NumOfRecordsInTable = 0;
		NumOfRecordsInPage = 0;
		isFull = false;
		isEmpty = true;
		PrimaryKey = -1;
		NumOfFields = 0;
		// 6 fields max, and 12 chars max for each field
		// TODO deðiþen kýsým
		FieldNames = new char[6][10];
		for (int i = 0; i < 6; i++)
			FieldNames[i] = new char[10];
		Records = new Record[3];
		for (int i = 0; i < 3; i++)
			Records[i] = new Record();	
	}
	/**
	 * This function sets the field names and the primary key
	 * @param fNames Field Names
	 * @param keyPlace The place of the key in the fNames Array 
	 * 
	 * @return void
	 */
	void setFields(char[][] fNames,int keyPlace)
	{
		for (int i = 0; i < fNames.length; i++)
			FieldNames[i] = fNames[i];
		PrimaryKey = keyPlace;
		NumOfFields = fNames.length;
	}
	/** This function writes the page to a random access File.
	 * @param rnd File pointer of the random access file
	 * @throws IOException If writing to file is unsuccessful
	 *
	 * @return void
	 */
	void WriteToFile(RandomAccessFile rnd) throws IOException
	{
		rnd.writeInt(NumOfRecordsInTable);
		rnd.writeInt(NumOfRecordsInPage);
		rnd.writeBoolean(isFull);
		rnd.writeBoolean(isEmpty);
		rnd.writeInt(PrimaryKey);
		rnd.writeInt(NumOfFields);
		// write FieldNames character by character
		for (int i = 0; i < 6; i++)
			for (int j = 0; j < 10; j++)
				rnd.writeChar(FieldNames[i][j]);
		// write Records
		for (int i = 0; i < 3; i++)
		{
			// write FiedData character by character
			for (int j = 0; j < 6; j++)
				for (int k = 0; k < 10; k++)
					rnd.writeChar(Records[i].FieldData[j][k]);
			// write isFull boolean
			rnd.writeBoolean(Records[i].isFull);
		}
		// write dummy values to complete 512 bytes
		rnd.writeInt(12345);
		rnd.writeInt(12345);
		rnd.writeChar(65);
		rnd.writeBoolean(true);
	}
	/** This function reads the fields of the class from a random access file.
	 * @param rnd File pointer of the random access file
	 * @throws IOException if reading is unsuccessful, most probably because of the end of file
	 * @return void
	 */
	void ReadFromFile(RandomAccessFile rnd) throws IOException
	{
		NumOfRecordsInTable = rnd.readInt();
		NumOfRecordsInPage = rnd.readInt();
		isFull = rnd.readBoolean();
		isEmpty = rnd.readBoolean();
		PrimaryKey = rnd.readInt();
		NumOfFields = rnd.readInt();
		
		for (int i = 0; i < 6; i++)
			for (int j = 0; j < 10; j++)
				FieldNames[i][j] = rnd.readChar();
		
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 6; j++)
				for (int k = 0; k < 10; k++)
					Records[i].FieldData[j][k] = rnd.readChar();
			Records[i].isFull = rnd.readBoolean();
		}
		rnd.skipBytes(11);
	}
}
