/**
 * Student ID: 2002103907
 * Project: Cmpe 321 Project #2 - Simple Storage Manager For DBMS
 * @author Emin Þenay
 */

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.ArrayList;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JTextPane;

/**
 * @author  bosisler
 */
public class Cmpe321Project2 extends JFrame 
{
	/** Main Content Panel */
	private JPanel jContentPane = null;
	/** The Menu bar */
	private JMenuBar jJMenuBar = null;
	/** File Menu */
	private JMenu fileMenu = null;
	/** Help Menu */
	private JMenu helpMenu = null;
	/** Exit Item In File Menu */
	private JMenuItem exitMenuItem = null;
	/** About menu Item in Help Menu */ 
	private JMenuItem aboutMenuItem = null;
	/** Table Operations Menu */
	private JMenu TableOpMenu = null;
	/** Add New Table menu item in Table Operations Menu */
	private JMenuItem AddNewTable = null;
	/** Delete Table menu item in Table Operations Menu */
	private JMenuItem DeleteTable = null;
	/** List All Tables menu item in Table Operations Menu */
	private JMenuItem ListAllTables = null;
	/** Record Operations Menu */
	private JMenu RecordOpMenu = null;
	/** Add New Record menu item in Record Operations Menu */
	private JMenuItem AddNewRec = null;
	/** Delete Record menu item in Record Operations Menu */
	private JMenuItem DeleteRec = null;
	/** List all Records menu item in Record Operations Menu */
	private JMenuItem ListAllRec = null;
	/** Search for a Record menu item in Record Operations Menu */
	private JMenuItem SearchRec = null;
	/** Text area to display results */
	private JTextArea MainArea = null;
	/** Used in operations of tables */
	private TableOperations TOpn = null;
	/** Used in operations of Records */
	private RecordOperations ROpn = null;

	/**
	 * This is the default constructor
	 */
	public Cmpe321Project2() {
		super();
		initialize();
	}

	/**
	 * This method initializes this
	 * 
	 * @return void
	 */
	private void initialize() {
		boolean HaveHeaderDirectory = new File("header").isDirectory();
		boolean HaveDataDirectory = new File("data").isDirectory();
		if (!HaveDataDirectory || !HaveHeaderDirectory)
		{
			new File("header").mkdir();
			new File("data").mkdir();
		}
		TOpn = new TableOperations();
		ROpn = new RecordOperations();
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setJMenuBar(getJJMenuBar());
		this.setSize(500, 500);
		this.setContentPane(getJContentPane());
		this.setTitle("Cmpe 321 Project 2");
	}

	/**
	 * This method initializes jContentPane
	 * @return  javax.swing.JPanel
	 * @uml.property  name="jContentPane"
	 */
	private JPanel getJContentPane() {
		if (jContentPane == null) {
			jContentPane = new JPanel();
			jContentPane.setLayout(new BorderLayout());
			jContentPane.add(getJTextArea(), java.awt.BorderLayout.CENTER);
		}
		return jContentPane;
	}

	/**
	 * This method initializes jJMenuBar	
	 * @return  javax.swing.JMenuBar
	 * @uml.property  name="jJMenuBar"
	 */
	private JMenuBar getJJMenuBar() {
		if (jJMenuBar == null) {
			jJMenuBar = new JMenuBar();
			jJMenuBar.add(getFileMenu());
			jJMenuBar.add(getTableOpMenu());
			jJMenuBar.add(getRecordOpMenu());
			jJMenuBar.add(getHelpMenu());
		}
		return jJMenuBar;
	}

	/**
	 * This method initializes FileMenu	
	 * @return  javax.swing.JMenu The file menu
	 * @uml.property  name="fileMenu"
	 */
	private JMenu getFileMenu() {
		if (fileMenu == null) {
			fileMenu = new JMenu();
			fileMenu.setText("File");
			fileMenu.add(getExitMenuItem());
		}
		return fileMenu;
	}

	/**
	 * This method initializes HelpMenu	
	 * @return  javax.swing.JMenu The Help Menu
	 * @uml.property  name="helpMenu"
	 */
	private JMenu getHelpMenu() {
		if (helpMenu == null) {
			helpMenu = new JMenu();
			helpMenu.setText("Help");
			helpMenu.add(getAboutMenuItem());
		}
		return helpMenu;
	}

	/**
	 * This method initializes Exit Menu item	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="exitMenuItem"
	 */
	private JMenuItem getExitMenuItem() {
		if (exitMenuItem == null) {
			exitMenuItem = new JMenuItem();
			exitMenuItem.setText("Exit");
			exitMenuItem.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					System.exit(0);
				}
			});
		}
		return exitMenuItem;
	}

	/**
	 * This method initializes About Menu Item	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="aboutMenuItem"
	 */
	private JMenuItem getAboutMenuItem() {
		if (aboutMenuItem == null) {
			aboutMenuItem = new JMenuItem();
			aboutMenuItem.setText("About");
			aboutMenuItem.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					JDialog AboutDialog = new JDialog(Cmpe321Project2.this, "About", true);
					JTextPane AboutLabel = new JTextPane();
					AboutDialog.setSize(new Dimension(300,100));
					AboutDialog.setLocation(500,330);
					AboutLabel.setEditable(false);
					//AboutLabel.setBackground(new Color(000000));
					StringBuffer str = new StringBuffer();
					str.append("Cmpe 321 - Introduction To Database Systems");
					str.append("\n");
					str.append("       Author: Emin Þenay - 2002103907");
					String stri = new String(str);
					System.out.println(stri);
					AboutLabel.setText(stri);
					AboutDialog.add(AboutLabel);
					AboutDialog.show();
				}
			});
		}
		return aboutMenuItem;
	}

	/**
	 * This method initializes Table Operations Menu	
	 * @return  javax.swing.JMenu
	 * @uml.property  name="tableOpMenu"
	 */
	private JMenu getTableOpMenu() {
		if (TableOpMenu == null) {
			TableOpMenu = new JMenu();
			TableOpMenu.setText("Table Operations");
			TableOpMenu.add(getAddNewTable());
			TableOpMenu.add(getDeleteTable());
			TableOpMenu.add(getListAllTables());
		}
		return TableOpMenu;
	}

	/**
	 * This method initializes Add New Table Menu Item	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="addNewTable"
	 */
	private JMenuItem getAddNewTable() {
		if (AddNewTable == null) {
			AddNewTable = new JMenuItem();
			AddNewTable.setText("Add New Table");
			AddNewTable.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					TOpn.create();
				}
			});
		}
		return AddNewTable;
	}

	/**
	 * This method initializes Delete Table Menu Item	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="deleteTable"
	 */
	private JMenuItem getDeleteTable() {
		if (DeleteTable == null) {
			DeleteTable = new JMenuItem();
			DeleteTable.setText("Delete A Table");
			DeleteTable.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					TOpn.delete();
				}
			});
		}
		return DeleteTable;
	}

	/**
	 * This method initializes List All Tables Menu Item	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="listAllTables"
	 */
	private JMenuItem getListAllTables() {
		if (ListAllTables == null) {
			ListAllTables = new JMenuItem();
			ListAllTables.setText("List All Tables");
			ListAllTables.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					String[] tmp = TOpn.listAll();
					if (tmp != null)
					{
						StringBuffer written = new StringBuffer();
						for (int i = 0; i < tmp.length; i++)
						{
							written.append(tmp[i]);
							written.append('\n');
						}
						MainArea.setText(written.toString());
					}
				}
			});
		}
		return ListAllTables;
	}

	/**
	 * This method initializes Record Operations Menu	
	 * @return  javax.swing.JMenu
	 * @uml.property  name="recordOpMenu"
	 */
	private JMenu getRecordOpMenu() {
		if (RecordOpMenu == null) {
			RecordOpMenu = new JMenu();
			RecordOpMenu.setText("Record Operations");
			RecordOpMenu.add(getAddNewRec());
			RecordOpMenu.add(getDeleteRec());
			RecordOpMenu.add(getListAllRec());
			RecordOpMenu.add(getSearchRec());
		}
		return RecordOpMenu;
	}

	/**
	 * This method initializes Add New Record Menu Iten	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="addNewRec"
	 */
	private JMenuItem getAddNewRec() {
		if (AddNewRec == null) {
			AddNewRec = new JMenuItem();
			AddNewRec.setText("Add New Record");
			AddNewRec.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					ROpn.insert();
				}
			});
		}
		return AddNewRec;
	}

	/**
	 * This method initializes Delete A Record Menu Item	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="deleteRec"
	 */
	private JMenuItem getDeleteRec() {
		if (DeleteRec == null) {
			DeleteRec = new JMenuItem();
			DeleteRec.setText("Delete A Record");
			DeleteRec.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					ROpn.delete();
				}
			});
		}
		return DeleteRec;
	}

	/**
	 * This method initializes List All Records Menu Item	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="listAllRec"
	 */
	private JMenuItem getListAllRec() {
		if (ListAllRec == null) {
			ListAllRec = new JMenuItem();
			ListAllRec.setText("List All Records");
			ListAllRec.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					ArrayList RecordArray = ROpn.list();
					if (RecordArray != null)
					{
						StringBuffer written = new StringBuffer();
						for (int i = 0; i < RecordArray.size(); i++)
						{
							char[][] temp = (char[][])RecordArray.get(i);
							for (int j = 0; j < temp.length; j++)
							{
								written.append(temp[j]);
								written.append(' ');
							}
							written.append('\n');
						}
						MainArea.setText(written.toString());
					}
				}
			});
		}
		return ListAllRec;
	}

	/**
	 * This method initializes Search For A Record Menu Item	
	 * @return  javax.swing.JMenuItem
	 * @uml.property  name="searchRec"
	 */
	private JMenuItem getSearchRec() {
		if (SearchRec == null) {
			SearchRec = new JMenuItem();
			SearchRec.setText("Search For A Record");
			SearchRec.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					String[] FoundRec = ROpn.SearchRecord();
					StringBuffer written = new StringBuffer();
					if (FoundRec != null)
					{
						written.append("The record is found in the table");
						written.append('\n');
						for (int i = 0; i < FoundRec.length; i++)
						{
							written.append(FoundRec[i]);
							written.append(' ');
						}
						written.append('\n');
					}
					else
					{
						written.append("The record cannot be found in the table");
					}
					MainArea.setText(written.toString());
				}
			});
		}
		return SearchRec;
	}

	/**
	 * This method initializes Main Text Area To display Output	
	 * 	
	 * @return javax.swing.JTextArea	
	 */
	private JTextArea getJTextArea() {
		if (MainArea == null) {
			MainArea = new JTextArea();
		}
		return MainArea;
	}

	/**
	 * Launches this application
	 */
	public static void main(String[] args) {
		Cmpe321Project2 application = new Cmpe321Project2();
		application.show();
	}

}
