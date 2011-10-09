package servlets;

import java.util.HashMap;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;


public class SessionListener implements HttpSessionListener
{
    private static HashMap activeUsers=new HashMap();

    
    
    public SessionListener()
    {
      
    }
    
    public  void sessionCreated(HttpSessionEvent se)
    {
      synchronized(activeUsers)
      {
        activeUsers.put(se.getSession().getId(),se);
      }
    }
    public void sessionDestroyed(HttpSessionEvent se)
    {
      
      synchronized(activeUsers)
      {
        activeUsers.remove(se.getSession().getId());
      }
    }
    public static HashMap returnSessions()
    {
      //HashMap activeUsers=(HashMap)AppConfig.getActiveUsers();
      return activeUsers;
    }
    public static void destroy_session(String id)
    {
      synchronized(activeUsers)
      {
        activeUsers.remove(id);
      }
    }

    
}

