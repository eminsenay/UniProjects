/**
 * Student ID: 2002103907
 * Project: Cmpe 321 Project #2 - Simple Storage Manager For DBMS
 * @author Emin Þenay
 */

public class Record {
	/** True if the record is initialized and not deleted */
	boolean isFull;  // 1 byte for boolean
	/** Char[][] to store the information in fields */
	char[][] FieldData; // 120 bytes for char[][] // TODO deðiþen kýsým
	/** This function initializes the record*/
	Record()
	{
		isFull = false;
		// 6 fields max, and 10 chars max for each field name // TODO deðiþen kýsým
		FieldData = new char[6][10];
		for (int i = 0; i < 6; i++)
		{
			FieldData[i] = new char[10];
		}
	}

}
