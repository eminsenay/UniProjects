/**
 * Student ID: 2002103907
 * Project: Cmpe 321 Project #2 - Simple Storage Manager For DBMS
 * @author Emin Þenay
 */

public class TableInfo {
	/** The name of the table */
	char[] TableName; // 2 bytes for each char
	/** True if it is initialized and not deleted */
	boolean isFull;	// 1 byte for boolean
	/** This function initializes TableInfo */
	TableInfo()
	{
		TableName = new char[20];
		isFull = false;
	}
	// Total number of bytes for one instance = 20*2 + 1 = 41
}
