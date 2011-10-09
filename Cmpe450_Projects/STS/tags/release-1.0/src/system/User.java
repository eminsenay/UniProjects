package system;



/**
 * A user object will be generated when a user can login to our system.
 * <p>It also keeps a static login method. Method is static because we want to avoid
 * unnecessarily creating the user object.
 * 
 * <p>The class will be keeping the right object which is a critic object in our system.
 *
 * <p> Login oldugunda JSP session variable 
 * @author Aykut
 * @version 1.0
 */
public class User {
  /** The Users id. A unique number that is given by database.
   * */
  private String userID;

  public void setUserid(String userID)
  {
      this.userID=userID;    
  }
  public String getUserid()
  {
      return userID;    
  }
  
  /** 
   * The users username. The name that he/she logins.
   * 
   */
  public String username=null;

  
  /**    
   * Departmandaki hiyerarsi ile ilgili bir degisken.
   * Sekreter mi bolum baskanimi tarzi bir bilgi.
   */
  public String positionID=null;
  /**
   * The name of the user.
   * 
   */
  public String name=null;

  /** The surname of the user.
   * */
  public String surname=null;

  /** The Group id of the user.
   * */
  protected String groupID=null;

  public void setgroupID(String groupID)
  {
      this.groupID=groupID;    
  }
  public String getgroupID()
  {
      return groupID;    
  }

  /** 
   *  This object will be keeping the page numbers that user can enter.
   * 
   */
  public String[] rights=null;
  
  /** 
   * The name values of right object of the user. This object will be keeping the User friendly page names that user can enter.
   * 
   */
  public String[] rightsNames=null;
  
  public int[] link=null;

  /** Contructor of the object. Sets the session.  
   * 
   */
  public User() {
	 
  }


  
  
}