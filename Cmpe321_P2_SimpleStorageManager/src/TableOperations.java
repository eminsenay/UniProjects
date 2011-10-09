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

public class TableOperations {
	
	/** This function converts the given string into character array of given length.
	 * It first trims the given string and then adds space characters.
	 * @param TableName the given string
	 * @param length The length of the char array
	 * 
	 * @return Converted character array
	 */
	char[] convert(String TableName, int length)
	{
		String trimmedName = TableName.trim();
		// adding necessary space characters to the end of the tablename
		while (trimmedName.length() < length)
			trimmedName = trimmedName + " ";
		
		return trimmedName.toCharArray();
	}
	
	/** This function creates a table in the database.
	 * @return void
	 */
	void create()
	{
		// take the name of the table
		String TableName = JOptionPane.showInputDialog("Name of The Table");
		if (TableName.length() > 20)
		{
			JOptionPane.showMessageDialog(null,
					"Length of the tablename cannot be longer than 20 characters");
			return;
		}
		
		// convert the tablename into proper format
		char[] TableN = convert(TableName,20);

		// create an arraylist of header pages
		ArrayList HeaderList = new ArrayList();
		
		// Open a Random Access File for reading the header page
		RandomAccessFile rnd = null;
		try
		{
			String s = File.separator;
			rnd = new RandomAccessFile("header" + s + "Header.dat","rw");
		} catch (Exception e)
		{
			JOptionPane.showMessageDialog(null,
					"Header.dat cannot be opened");
			return;
		}
		// read the file until EOF
		try
		{
			while (true)
			{
				HeaderPage h = new HeaderPage();
				h.ReadFromFile(rnd);
				HeaderList.add(h);
			}
		} catch (IOException e)
		{ /* end of file has been reached, do nothing */ }
		// Search the TableN in ArrayList
		if (TableSearch(HeaderList,TableN))
		{
			// if the name of the table is found in the page, this
			// means there is an existing table in the db with the
			// name given. Therefore, display an error.
			JOptionPane.showMessageDialog(null,
			"A table with the given name already exists.");
			return;
		}
		// Search the TableInfo of all pages and try to find
		// an empty TableInfo place
		boolean emptyFound = false;
		HeaderPage hdr = null;
		int EmptyPlace = -1;
		for (int i = 0; i < HeaderList.size(); i++)
		{	
			// get the i th element
			hdr = (HeaderPage)HeaderList.get(i);
			if (hdr.isFull)
				continue;
			for (int j = 0; j < hdr.Tables.length; j++)
			{
				if (!hdr.Tables[j].isFull)
				{
					// Found the place to insert the new table
					// insert the table
					hdr.Tables[j].isFull = true;
					hdr.Tables[j].TableName = TableN;
					emptyFound = true;
					EmptyPlace = i;
					break;
				}	
			}
			if(emptyFound)
				break;
		}
		// if an empty place cannot be found, create a new Header page
		if (!emptyFound)
		{
			hdr = new HeaderPage();
			hdr.isEmpty = false;
			hdr.Tables[0].isFull = true;
			hdr.Tables[0].TableName = TableN;
		}
		// Ask Field Names and The Primary Key
		String FieldNames = JOptionPane.showInputDialog("Please enter the name" +
				" of the fields with a comma (,) between two fields");
		String[] FieldNameArr = FieldNames.split(",");
		String Key = JOptionPane.showInputDialog("Please enter the primary key");
		
		// check if there are more than 9 fields, if so give error
		if (FieldNameArr.length > 6)
		{
			JOptionPane.showMessageDialog(null,"The number of fields can be " +
					"at most 6");
			return;
		}
		// check if the primary key matches one field name
		// and check the length of each field name
		int keyPlace = -1;
		
		for (int i = 0; i < FieldNameArr.length; i++)
		{
			// trim the space characters at the beginning and the end of each
			// field name
			FieldNameArr[i].trim();
			if (FieldNameArr[i].length() > 10)
			{
				JOptionPane.showMessageDialog(null,"Each field can be at most " +
						"10 characters length");
				return;
			}
			if ((FieldNameArr[i].trim()).compareTo(Key.trim()) == 0)
				keyPlace = i;
		}
		if (keyPlace == -1)
		{
			JOptionPane.showMessageDialog(null,"Primary Key must match one of the" +
					" fields");
			return;
		}
		// check the uniqueness of each field
		for (int i = 0; i < FieldNameArr.length ; i++)
		{
			for (int j = i+1; j < FieldNameArr.length; j++)
				if (FieldNameArr[i].toString().compareTo(FieldNameArr[j].toString()) == 0)
				{
					JOptionPane.showMessageDialog(null,"All field names must be " +
							"unique");
					return;
				}
		}
		// convert the field names into proper format
		char[][] FieldNameCharArr = new char[FieldNameArr.length][10];
		for (int i = 0; i < FieldNameArr.length; i++)
		{
			FieldNameCharArr[i] = convert(FieldNameArr[i],10);
		}
		// now, write to the header page and then save it to the header file
		// Increment the number of table variables
		HeaderPage firstPage = null;
		// if the HeaderList is empty, it means that
		// it is the first table of the database
		if (!HeaderList.isEmpty())
		{
			firstPage =(HeaderPage)HeaderList.get(0);
			firstPage.NumOfTablesInDB++;
		}
		else
		{
			hdr.NumOfTablesInDB++;
		}
		hdr.NumOfTablesInPage++;
		// Check if the page become full with the new table
		if (hdr.NumOfTablesInPage == hdr.Tables.length)
			hdr.isFull = true;
		// update the header file, but first try to create the tablename.dat file
		RandomAccessFile rand = null;
		try {
			String s = File.separator;
			rand = new RandomAccessFile("data" + s + TableName.trim() + ".dat","rw");
		} catch (IOException e1) {
			JOptionPane.showMessageDialog(null,"Error creating the data file.");
			return;
		}
		try 
		{
			// seek the beginning of the file
			rnd.seek(0);
			if (!HeaderList.isEmpty())
				firstPage.WriteToFile(rnd);
			// if a page with empty table array found,
			// set the position of the random file and update that page
			// Else, append the new page at the end of the file
			if (emptyFound && EmptyPlace != 0) 
				// if the empty page is the first page,
				// it is already updated, no need to write once more 
			{
				rnd.seek(512*EmptyPlace);
				//rnd.skipBytes(512*(EmptyPlace-1));
				hdr.WriteToFile(rnd);
				rnd.close();
			}
			else if (!emptyFound)
			{
				if (!HeaderList.isEmpty())
					rnd.seek(512*HeaderList.size());
					//rnd.skipBytes(512*(HeaderList.size()-1));
				hdr.WriteToFile(rnd);
				rnd.close();
			}
		} catch (IOException e)
		{
			JOptionPane.showMessageDialog(null,
					"Header.dat cannot be closed, there can be an error.");
			System.exit(-2);
		}
		// create tablename.dat file
		
		try {
			// create a data page and set the necessary fields
			DataPage newPage = new DataPage();
			newPage.setFields(FieldNameCharArr,keyPlace);
			// write this page to the file
			newPage.WriteToFile(rand);
			rand.close();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null,"Error writing to the data file");
			System.exit(-3);
		}
	}
	
	/** This function deletes a table from the database.
	 * @return void
	 */
	void delete()
	{
		// take the name of the table
		String TableName = JOptionPane.showInputDialog("Name of The Table");
		if (TableName.length() > 20)
		{
			JOptionPane.showMessageDialog(null,
					"Length of the tablename cannot be longer than 20 characters");
			return;
		}
		
		// convert the tablename into proper format
		char[] TableN = convert(TableName,20);
		RandomAccessFile rnd = null;
		try {
			String s = File.separator;
			rnd = new RandomAccessFile("header" + s + "Header.dat","rw");
		} catch (FileNotFoundException e) {
			JOptionPane.showMessageDialog(null,"Header file cannot be found");
			return;
		}
		// read page by page and try to find the tablename in the header page
		HeaderPage hdr = new HeaderPage();
		int PageIndex = -1;
		try
		{
			while (true)
			{
				hdr.ReadFromFile(rnd);
				PageIndex++;
				int TableIndex = TableSearch(hdr,TableN);
				if (TableIndex == -1) // if not found
					continue;
				// delete if founded
				hdr.Tables[TableIndex].isFull = false;
				// change numofTables variables
				hdr.NumOfTablesInPage--;
				hdr.isFull = false;
				if (hdr.NumOfTablesInPage == 0)
					hdr.isEmpty = true;
				// update this page
				// rewind one page
				rnd.seek(PageIndex*512);
				hdr.WriteToFile(rnd);
				// read the first page again
				rnd.seek(0);
				hdr.ReadFromFile(rnd);
				hdr.NumOfTablesInDB--;
				// update now
				rnd.seek(0);
				hdr.WriteToFile(rnd);
				break;
			}	
		} catch (IOException e) { //EOF has been reached, which means 
			// a table with the given name does not exist, so display error
			JOptionPane.showMessageDialog(null,"A table with the name given " +
					"does not exist in the database");
			return;
		}
		// change the "tablename".dat to "tablename".old
		File f = new File(TableName + ".dat");
		f.renameTo(new File(TableName + ".old"));
		try {
			rnd.close();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, "Header.dat could not be closed" +
					" There might be an error.");
			return;
		}
	}
	
	/** This function searchs for a table in given header page list.
	 * @param HeaderList ArrayList of a header pages
	 * @param TableN Name of the table to be searched
	 * 
	 * @return True if found, false otherwise
	 */
	boolean TableSearch(ArrayList HeaderList, char[] TableN)
	{
		// Search the TableN in ArrayList
		for (int i = 0; i < HeaderList.size(); i++)
		{
			// get the i th element
			HeaderPage tmp = (HeaderPage)HeaderList.get(i);
			// search the TableN in tmp if tmp is not empty
			if (tmp.isEmpty)
				continue;
			String TableName = new String(TableN);
			for (int j = 0; j < tmp.Tables.length; j++)
			{
				String temp = new String(tmp.Tables[j].TableName);
				if (tmp.Tables[j].isFull && 
						temp.compareTo(TableName) == 0)
				{
					// Given name is found in the arraylist
					return true;
				}	
			}
		}
		return false;
	}
	
	/** This function searchs for a table in a given header page.
	 * @param hdr Header page
	 * @param TableN Name of the table to be searched
	 * 
	 * @return True if found, false otherwise
	 */
	int TableSearch(HeaderPage hdr, char[] TableN)
	{
		if (hdr.isEmpty)
			return -1;
		String TableName = new String(TableN);
		for (int j = 0; j < hdr.Tables.length; j++)
		{
			String temp = new String(hdr.Tables[j].TableName);
			if (hdr.Tables[j].isFull && 
					temp.compareTo(TableName) == 0)
			{
				// Given name is found in the header page
				return j;
			}	
		}
		return -1;
	}
	
	/** This function searches for a table in the entire database.
	 * @param TableName Name of the table
	 * @return True if found, false otherwise
	 */
	boolean TableSearch(String TableName)
	{
		char[] TName = convert(TableName,20);
		// Check if specified tablename exists in the database
		
		// First, open the header file
		RandomAccessFile rnd = null;
		try {
			String s = File.separator;
			rnd = new RandomAccessFile("header" + s + "Header.dat","r");
		} catch (FileNotFoundException e1) {
			JOptionPane.showMessageDialog(null,"Header.dat could not be found");
			return false;
		}
		
		// read pages one by one from the header.dat and search
		// the given tablename in the pages
		HeaderPage hdr = new HeaderPage();
		try
		{
			while (true)
			{
				hdr.ReadFromFile(rnd);
				int j = TableSearch(hdr,TName);
				// if found, j will not be -1
				if (j != -1)
					break;
			}
		} catch(IOException e)
		{
			JOptionPane.showMessageDialog(null,"The table with the given name" +
					" does not exist in the database");
			return false;
		}
		try {
			rnd.close();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null,"Header.dat could not be closed," +
					" there might be an error.");
			return false;
		}
		return true;
	}
	
	/** This function lists all tables in the database
	 * @return String[] of the table names
	 */
	String[] listAll()
	{
		// open header.dat
		RandomAccessFile rnd = null;
		try 
		{
			String s = File.separator;
			rnd = new RandomAccessFile("header" + s + "Header.dat","rw");
		} catch (FileNotFoundException e)
		{
			JOptionPane.showMessageDialog(null,"Header.dat cannot be found");
			return null;
		}
		// read all pages to a linklist //TODO burasý deðiþti Arrayliste gerek yok
		ArrayList AllTables = new ArrayList();
		try
		{
			HeaderPage hdr = new HeaderPage();
			while(true)
			{
				hdr.ReadFromFile(rnd);
				if (hdr.isEmpty)
					continue;
				for (int i = 0; i < hdr.Tables.length; i++)
					if (hdr.Tables[i].isFull)
					{
						String tmp = new String(hdr.Tables[i].TableName);
						AllTables.add(tmp.trim());
					}
			}
		} catch(IOException e)// EOF has been reached, do nothing
		{}
		String[] TableArr = new String[AllTables.size()];
		for (int i = 0; i < AllTables.size(); i++)
			TableArr[i] = (String)AllTables.get(i);
			
	//	String[] TableArr = (String[])AllTables.toArray();
		return TableArr;
	}
}
