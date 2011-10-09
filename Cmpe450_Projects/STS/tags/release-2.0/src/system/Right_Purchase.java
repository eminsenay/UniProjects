package system;

import java.util.Vector;
import java.sql.ResultSet;
import global.DatabaseConnection;
import java.sql.*;

import system.User;

/**
 * Right class for purchase units
 * @author Aykut
 * @version 1.0
 */

public class Right_Purchase
    extends Right {
  /**Keeps the page numbers that user can enter.
   * */
  private Vector pageids;
  /**Which user object that i belong.
   * */
  private User parent;
  /**The users id.
   * */
  private String userid;

  /**
   * Constructor getting and setting userid and calling initialize.
   * <p>Also parent is given. Parent means the which user object that right object belong.
   * <p>This will let the right object to reach pages mySession variable and the database connection in it.
   * <p>Calls initialize {@link #initialize}
   * */

  public Right_Purchase(String userid, User parent) {
    this.parent = parent;
    this.userid = userid;
    initialize();
  }

  /**
   * Fills the pageids vector.
   **/
  public void initialize() {
    ResultSet result;
    result = DatabaseConnection.executeQuery("Get pages that user can enter");
    if (result != null) {
      try {
        while (result.next()) { //assumed that the pageids are kept int 'pageids' rows
          pageids.add(new Integer(result.getInt("pageids")));
        }
      }
      catch (SQLException ex) {
        ex.printStackTrace();
      }

    }
    else {
      System.out.println("I can not get the pageids of the user " + userid +" ,Right_Purchase class");
    }

  }

  /**
   * Checks if pageids vector contains the value you search.
   * @return Returns boolean that show if pageid you searched is in pageids Vector.
   * @param page An integer showing page id that is asked to checked if a user can access.
   */

  public boolean canAccess(int page) {
    boolean result = false;
    if (pageids.contains(new Integer(page)))
      result = true;

    return result;
  }

  /**
     * It is the class where project logic is implemented.
     * <p>The pages will be calling this function for necessary manupulations in database.
     * <p>Example: When an 'onay' action is made, the submit function will know who to send the 'fis'.
     * @param pageid A page number showing in which page the function is called.
     * @param data A Vector that keeps necessary data that can be send to submit function.
     * */

  public void submit(int pageid, Vector data) {
    /* if(pageid==x){
       will be filled
     }
     else if(pageid=y){
       will be filled
     }
     */

  }

}