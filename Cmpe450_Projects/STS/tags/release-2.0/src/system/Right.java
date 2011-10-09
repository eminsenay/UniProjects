package system;

import java.util.Vector;



/**
 * Abstract class for right objects
 * @author Aykut
 * @version 1.0
 */

public abstract class Right {

  /**Keeps the page numbers that user can enter.
   * */
  private Vector pageids=new Vector();

  public void addPageID(String pageID)
  {
	  pageids.add(pageID);  
  }
  
  public Vector getRights()
  {
	 return pageids;
  }
  
  /**The users id.
   * */
  private int userid;

  /**Which user object that i belong.
   * */
  private User parent;

  //chid classes need it
  public Right() {}

  /**
   * Constructor getting and setting userid and calling initialize
   * <p>Also parent is given. Parent means the which user object that i belong.
   * <p>This will let the right object to reach pages mySession variable and the database connection in it.
   * <p>Calls initialize {@link #initialize}
   * @param userid An integer showing which user is creating the right object.
   * @param parent The user object that the right object will be kept.
   * */



  public Right(int userid, User parent) {
    this.parent = parent;
    this.userid = userid;
    initialize();

  }

  /**You can fill this part in your child class.
   * <p>this function will be filling pageids vector.
   */

  public void initialize() {


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
   * You must implement this part in child classes.
   * It is the class where project logic is implemented.
   * @param pageid A page number showing in which page i am called.
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