/*
 * DatabaseConnection.java
 *
 * Created on October 28, 2005, 12:33 PM
 *

 */

package global;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
 
/**
 * This is the main class to handle db operations.
 * <p>If you want to execute a query first {@link #openConnection open a connection} 
 * and execute your query using that connection.
 * <p> IMPORTANT :</p>
 * The necessary mysql driver :
 * "mysql-connector-java-3.1.11-bin.jar" archive ,which can be downloaded from www.mysql.com ,
 * must be added to project path.  
 *
 * @author omer
 */
public class DatabaseConnection {
    
    /**Name of the database that this class supposed to connect to. 
     * <p>This the name of database in localhost.
     */
    //private final static String databaseName= "Cmpe450_Test";
    private final static String databaseName= "SAS_DB";
    
    /**
     * User name to connect to {@link #databaseName database}. 
     * This will be given by db group. 
     */
    private final static String userName = "SASuser";
    
     /**
     * Password of {@link #userName user name} to connect to 
      * {@link #databaseName database} . 
     * This will be given by db group
     */
    private final static String password = "dbherzamanhaklidir";
            
    
    /** 
     * You do not need to create an instance of this class so constructor is private.
     * Instead, use static functions to open connections and execute queries.
     */
    private DatabaseConnection() {
    }
    
    /**
     * Creates and returns an java.sql.Connection object. 
     * Later use this returned object to execute db queries.
     * <p>IMPORTANT </p>
     * Mysql driver jar archive must be added to the project class path.
     *
     * @see #closeConnection
     * @return created connection to db or null if an error occures.
     */
    public static Connection openConnection()
    {
        Connection conn=null;
        try{
            String url = "jdbc:mysql://localhost/"+databaseName;
            
            Class.forName ("com.mysql.jdbc.Driver").newInstance();
         
            conn = DriverManager.getConnection (url, userName, password);
            
            System.out.println("DB connection is established."); 
            
        }catch(Exception e){           
            e.printStackTrace();
        }
        return conn;
    }
    
    /**
     * Closes the given db connction .<p> NOT:</p> 
     * Later we may need to use connection pooling for some reosons.
     *
     * @see #openConnection
     * @param conn The connection object that you want to close.
     * @return true if the connection is succesfully closed ,false o/w
     */
    public static boolean closeConnection(Connection conn)
    {        
        try{            
            conn.close();
            return true;
        }catch(Exception e){           
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Executes the given query 
     * and returns the ResultSet of the query . 
     *
     * @see #openConnection    
     * @param query Query string that will be executed.
     * @return ResultSet if is succesful, null o/w
     */
    public static ResultSet executeQuery(String query)
    {        
        Connection conn=null;
        try{           
            conn=openConnection();
            Statement stmt;
            stmt = conn.createStatement();  
            
            ResultSet result = stmt.executeQuery(query);
            
            //conn.close();            
            return result;
            
        }catch(Exception e){           
            e.printStackTrace();
            
            if(conn!=null)
            try{       
                if(conn!=null)
                    if(!conn.isClosed())
                        conn.close();
            }catch(Exception ex){ }  
        }
        return null;
    }
    
     /**
     * Executes the given query using the given conn object 
     * and returns true / false . 
     * <p>This function is for insert , delete and create Table sort queries.  
     *
     * @see #openConnection
     * @param conn The connection object that you want execute this query.
     * @param query Query string that will be executed.
     * @return if is succesful (true/false)
     */
    public static boolean execute(String query)
    {        
        
        Connection conn=null;
        try{               
            conn=openConnection();
            
            Statement stmt;
            stmt = conn.createStatement();      
            
            boolean retValue = stmt.execute(query);      
            conn.close();
            return retValue;
        }catch(Exception e){           
            e.printStackTrace();
            try{       
                if(conn!=null)
                    if(!conn.isClosed())
                        conn.close();
            }catch(Exception ex){ }
        }
        return false;
    }
    
}
