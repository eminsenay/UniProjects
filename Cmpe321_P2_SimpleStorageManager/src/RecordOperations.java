/**
 * Student ID: 2002103907
 * Project: Cmpe 321 Project #2 - Simple Storage Manager For DBMS
 * @author Emin Þenay
 */

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.ArrayList;

import javax.swing.JOptionPane;

public class RecordOperations {

	/** This function inserts a new record to a table
	 * @return void
	 */
	void insert()
	{
		// Take the values
		String TableName = JOptionPane.showInputDialog("Enter the name of the table");
		String Fields = JOptionPane.showInputDialog("Enter the fields with" +
				" a comma (,) between them");
		// TODO key i sormaya gerek yok, table oluþturulurken 1 kere sorulmasý yeterli
		// String Key = JOptionPane.showInputDialog("Enter the primary key");
		if (TableName == null || Fields == null)
			return;
		String[] FieldArr = Fields.split(",");
		
		// Check if the given data obey the constraints
		if (TableName.length() > 20)
		{
			JOptionPane.showMessageDialog(null,"Length of the tablename cannot be" +
					" more than 20 characters");
			return;
		}
		if (FieldArr.length > 6)
		{
			JOptionPane.showMessageDialog(null,"There can be at most 6 fields " +
					"in the database.");
			return;
		}
		for (int i = 0; i < FieldArr.length; i++)
		{
			if (FieldArr[i].length() > 10)
			{
				JOptionPane.showMessageDialog(null,"The length of each field can" +
						" be at most 10 characters.");
				return;
			}
		}
		
		// Check if specified tablename exists in the database
		TableOperations t_op = new TableOperations();
		if (!t_op.TableSearch(TableName))
			return;
		
		// Convert the fields into the proper form
		char[][] Records = new char[FieldArr.length][10];
		for (int i = 0; i < FieldArr.length; i++)
		{
			Records[i] = t_op.convert(FieldArr[i],10);
		}
		// Check Primary Key exists in the previous records
		// Primary Key must be unique
		
		// To do this, first open the tablename.dat file,
		// read all of the pages and store them in an arraylist
		RandomAccessFile rand = null;
		String s = File.separator;
		String FileName = "data" + s + TableName + ".dat";
		try {
			rand = new RandomAccessFile(FileName,"rw");
		} catch (FileNotFoundException e) {
			JOptionPane.showMessageDialog(null,FileName + "could not be found");
			return;
		}
		// Create an arraylist of DataPages
		ArrayList DataArray = new ArrayList();
		DataPage dat = null;
		try
		{
			while(true)
			{
				dat = new DataPage();
				dat.ReadFromFile(rand);
				DataArray.add(dat);
			}
		} catch (IOException e)
		{/* EOF has been reached, no need to do anything */}
		
		// Search the primary key in all of the records (in the arraylist)
		DataPage FirstPage = (DataPage)DataArray.get(0);
		int KeyLocation = FirstPage.PrimaryKey;
		int NF = FirstPage.NumOfFields;
		// check if number of the given fields exceeds the NumOfFields
		if(Records.length > NF)
		{
			JOptionPane.showMessageDialog(null,"The number of fields given for this table are more than the" +
					" number of the fields specified in the database");
			return;
		}

		// take pages from the linklist one by one and search the primary key
		// Also, search the Records of all pages and try to find an empty Record place
		int PageNumber = -1, RecordNumber = -1;
		boolean emptyFound = false;
		String CheckKey = new String(Records[KeyLocation]);
		for (int i = 0; i < DataArray.size(); i++)
		{
			dat = (DataPage)DataArray.get(i);
			for (int j = 0; j < dat.Records.length; j++)
			{
				// Search in the non-empty records
				String temp = new String(dat.Records[j].FieldData[KeyLocation]);
				if (dat.Records[j].isFull && temp.compareTo(CheckKey) == 0)
				{
					JOptionPane.showMessageDialog(null,"Primary Key must be unique");
					return;
				}

				// Search for an empty field, which will be needed for entering the data
				else if (!dat.Records[j].isFull && !emptyFound)
				{
					PageNumber = i;
					RecordNumber = j;
					emptyFound = true;
				}
			}
		}
		// Check is complete, now enter the data
		// if an empty place is found in pages, insert immediately
		// if not, first create 8 empty pages, then insert to the first one
		if (emptyFound)
		{
			dat = (DataPage)DataArray.get(PageNumber);
			Record r = dat.Records[RecordNumber];
			for (int i = 0; i < Records.length; i++)
				r.FieldData[i] = Records[i];
			r.isFull = true;
			dat.NumOfRecordsInPage++;
			dat.isEmpty = false;
			if(dat.NumOfRecordsInPage == dat.Records.length)
				dat.isFull = true;
			// need to change NumOfRecordsInTable var in the first page
			FirstPage.NumOfRecordsInTable++;
			// apply changes to the file
			try {
				rand.seek(512*PageNumber);
				dat.WriteToFile(rand);
				if (PageNumber != 0)
				{
					rand.seek(0);
					FirstPage.WriteToFile(rand);
				}
			} catch (IOException e) {
				JOptionPane.showMessageDialog(null,"Error writing to the file");
				return;
			}
		}
		else
		{
			DataPage[] newPages = new DataPage[8];
			for (int i = 0; i < 8; i++)
				newPages[i] = new DataPage();
			newPages[0].isEmpty = false;
			newPages[0].NumOfRecordsInPage++;
			for (int i = 0; i < NF; i++)
				newPages[0].Records[0].FieldData[i] = Records[i];
			newPages[0].Records[0].isFull = true;
			// need to change NumOfRecordsInTable var in the first page
			FirstPage.NumOfRecordsInTable++;
			
			// apply changes to the file
			try {
				rand.seek(0);
				FirstPage.WriteToFile(rand);
				// written to first page, skip all remaining pages
				// and write the new 8 pages
				rand.seek(512*DataArray.size());
				for (int i = 0; i < newPages.length; i++)
					newPages[i].WriteToFile(rand);
			} catch (IOException e) {
				JOptionPane.showMessageDialog(null,"Error writing to the file");
				return;
			}
		}
		try {
			rand.close();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null,"Error in closing  " + FileName +
					". There might be an error");
			return;
		}
		return;
	}
	
	/** This function deletes one record from a table.
	 * @return void
	 */
	void delete()
	{
		// Take the values
		String TableName = JOptionPane.showInputDialog("Enter the name of the table");
		String Key = JOptionPane.showInputDialog("Enter the Primary Key");
		// Check if the data obey the constraints
		if (TableName == null || Key == null)
			return;
		String s = File.separator;
		String FileName = "data" + s + TableName.trim() + ".dat";
		if (FileName.length() > 24)
		{
			JOptionPane.showMessageDialog(null,"The length of the table name" +
					" cannot exceed 20 characters.");
			return;
		}
		if (Key.trim().length() > 10)
		{
			JOptionPane.showMessageDialog(null,"The length of the Primary Key" +
					" cannot exceed 10 characters.");
			return;
		}
		// Check if specified tablename exists in the database
		TableOperations t_op = new TableOperations();
		if (!t_op.TableSearch(TableName))
			return;
		
		// open the data file and try to find the primary key
		RandomAccessFile rnd = null;
		try {
			rnd = new RandomAccessFile(FileName,"rw");
		} catch (FileNotFoundException e) {
			JOptionPane.showMessageDialog(null,FileName + " cannot be found");
			return;
		}

		// convert the primary key into proper format
		char[] CharKey = t_op.convert(Key,10);
		
		// read the first page from the file
		DataPage FirstPage = new DataPage();
		try
		{
			FirstPage.ReadFromFile(rnd);
		} catch(IOException e)
		{
			JOptionPane.showMessageDialog(null,"Data file cannot be read");
			return;
		}	
		int KeyPlace = FirstPage.PrimaryKey;
		
		// search in the first page
		int KeyLocation = search(CharKey,FirstPage,KeyPlace);

		// change the necessary fields in the record and update datafile
		if (KeyLocation != -1)
		{
			FirstPage.Records[KeyLocation].isFull = false;
			FirstPage.NumOfRecordsInPage--;
			FirstPage.NumOfRecordsInTable--;
			if (FirstPage.NumOfRecordsInPage == 0)
				FirstPage.isEmpty = true;
		}
		else // Record is not in the first page
		{
			DataPage dat = new DataPage();
			int PageIndex = 0;
			while (true)
			{
				try {
					dat.ReadFromFile(rnd);
				} catch (IOException e) {
					JOptionPane.showMessageDialog(null,"A record with the given key" +
					" cannot be found in the database");
					return;
				}
				KeyLocation = search(CharKey, dat,KeyPlace);
				PageIndex++;
				if (KeyLocation != -1) // field is found in another page
					break;
			}
			dat.Records[KeyLocation].isFull = false;
			FirstPage.NumOfRecordsInTable--;
			dat.NumOfRecordsInPage--;
			if (dat.NumOfRecordsInPage == 0)
				dat.isEmpty = true;
			
			// update the datafile
			try
			{
				rnd.seek(0);
				rnd.skipBytes(PageIndex*512);
				dat.WriteToFile(rnd);
			} catch (IOException e)
			{
				JOptionPane.showMessageDialog(null,"Datafile cannot be updated");
				return;
			}
		}
		// update the first page
		try {
			rnd.seek(0);
			FirstPage.WriteToFile(rnd);
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null,"Datafile cannot be updated");
			return;
		}
	}
	
	/** This function searchs for a record in a table. Search is done using the primary key. 
	 * @return String[] If record is found, it is returned, otherwise null is returned.
	 */
	String[] SearchRecord()
	{
		// Take the values
		String TableName = JOptionPane.showInputDialog("Enter the name of the table");
		String Key = JOptionPane.showInputDialog("Enter the Primary Key");
		// Check if the data obey the constraints
		if (TableName == null || Key == null)
			return null;
		String s = File.separator;
		String FileName = "data" + s + TableName.trim() + ".dat";
		if (FileName.length() > 24)
		{
			JOptionPane.showMessageDialog(null,"The length of the table name" +
					" cannot exceed 20 characters.");
			return null;
		}
		if (Key.trim().length() > 10)
		{
			JOptionPane.showMessageDialog(null,"The length of the Primary Key" +
					" cannot exceed 10 characters.");
			return null;
		}
		// Check if specified tablename exists in the database
		TableOperations t_op = new TableOperations();
		if (!t_op.TableSearch(TableName))
			return null;
		
		// open the data file and try to find the primary key
		RandomAccessFile rnd = null;
		try {
			rnd = new RandomAccessFile(FileName,"rw");
		} catch (FileNotFoundException e) {
			JOptionPane.showMessageDialog(null,FileName + " cannot be found");
			return null;
		}

		// convert the primary key into proper format
		char[] CharKey = t_op.convert(Key,10);

		// read the first page from the file
		DataPage dat = new DataPage();
		try
		{
			dat.ReadFromFile(rnd);
		} catch(IOException e)
		{
			JOptionPane.showMessageDialog(null,"Data file cannot be read");
			return null;
		}
		// Take the place of the primary key and the number of fields
		int KeyPlace = dat.PrimaryKey;
		int NF = dat.NumOfFields;
		// search in the first page
		int KeyLocation = search(CharKey,dat,KeyPlace);
		// if not found, search all of the remaining pages one by one
		if (KeyLocation == -1)
		{
			try
			{
				while (true)
				{
					dat.ReadFromFile(rnd);
					KeyLocation = search(CharKey,dat,KeyPlace);
					if (KeyLocation != -1)
						break;
				}
				
			} catch(IOException e) // EOF has been reached, record cannot be found
			{
				JOptionPane.showMessageDialog(null,"The record with the given primary key cannot be" +
						" found");
				return null;
			}
		}
		// The place of the record is found. Now, convert
		// the record into string array
		return ConvertToStrArray(dat,KeyLocation,NF);
	}
	
	/** This function converts the fields of a given Record to a string array.
	 * @param dat DataPage which contains the record.
	 * @param KeyLocation the place in Records array of the datapage which contains the fields.
	 * @param NumOfFields Number of the fields
	 *
	 * @return String[] the fields of the record
	 */
	String [] ConvertToStrArray(DataPage dat, int KeyLocation, int NumOfFields)
	{
		String[] FieldArr = new String[NumOfFields];
		for (int i = 0; i < NumOfFields; i++)
			FieldArr[i] = new String(dat.Records[KeyLocation].FieldData[i]);
		return FieldArr;
	}
	
	/** This function searchs for a record in a given page. Search is done using the primary key.
	 * @param CharKey The Primary Key to be searched for
	 * @param dat The page in which search is done
	 * @param KeyPlace the place of the Primary key in the Records array
	 * 
	 * @return if found, the index number of the Records array, if not -1.
	 */
	int search(char[] CharKey, DataPage dat, int KeyPlace)
	{
		String PrimaryKey = new String(CharKey);
		for (int i = 0; i < dat.Records.length; i++)
		{
			String temp = new String(dat.Records[i].FieldData[KeyPlace]);
			if (dat.Records[i].isFull && temp.compareTo(PrimaryKey) == 0)
				return i;
		}
		return -1;
	}
	
	/** This function lists all records in a table 
	 * @return ArrayList of the records 
	 */
	ArrayList list()
	{
		// take the name of the table
		String TableName = JOptionPane.showInputDialog("Enter the table" +
				" you want to list");
		if (TableName == null)
			return null;
		
		if (TableName.trim().length() > 20)
		{
			JOptionPane.showMessageDialog(null,"Length of the table cannot" +
					" be more than 20 characters");
			return null;
		}
		// Check if specified tablename exists in the database
		TableOperations t_op = new TableOperations();
		if (!t_op.TableSearch(TableName))
			return null;
		// open the corresponding data file and read
		// all pages to an arraylist
		String s = File.separator;
		String FileName = "data" + s + TableName.trim() + ".dat";
		RandomAccessFile rnd = null;
		try {
			rnd = new RandomAccessFile(FileName,"r");
		} catch (FileNotFoundException e) {
			JOptionPane.showMessageDialog(null,FileName + " could not be found");
			return null;
		}
		ArrayList DataArray = new ArrayList();
		DataPage dat = null;
		try
		{
			int count = 0;
			while(true)
			{
				dat = new DataPage();
				rnd.seek(512*(count++)); // burasý saçma
				dat.ReadFromFile(rnd);
				DataArray.add(dat);
			}
		} catch (IOException e)
		{/*No need to do anything, EOF has been reached*/}
		ArrayList FieldArray = new ArrayList();
		// Print all non-empty records
		
		// first, get the number of fields in the table
		dat = (DataPage)DataArray.get(0);
		int NF = dat.NumOfFields;
		// get one page from the list and then add
		// all non-empty elements to fieldarray arraylist
		for (int i = 0; i < DataArray.size(); i++)
		{
			dat = (DataPage)DataArray.get(i);
			for (int j = 0; j < dat.Records.length; j++)
				if (dat.Records[j].isFull)
				{
					// take the nonempty fields and return them
					char[][] tmp = new char[NF][10];
					for (int k = 0; k < NF; k++)
						tmp[k] = dat.Records[j].FieldData[k];
					//FieldArray.add(dat.Records[j].FieldData);
					FieldArray.add(tmp);
				}
		}
		return FieldArray;
	}

	
}
