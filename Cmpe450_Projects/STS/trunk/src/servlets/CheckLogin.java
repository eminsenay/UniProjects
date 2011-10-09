package servlets;
/*
 * CheckLogin.java
 *
 * Created on 29 Ekim 2005 Cumartesi, 22:59
 */

import global.DB;
import java.io.*;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.*;
import javax.servlet.http.*;

import system.*;
/**
 * Tries to login to system by asking permissions from db .
 * <p>Either fails to login and redirected back or logins and 
 * put the "userClass" field to default session of JSP. You can get it by calling
 * </p<code>User userClass =session.getAttribute("userClass")</code><p>
 * All info about user will be carried by this field and must be nullify
 * during logout operation. 
 *
 * @author omer
 * @version
 */
public class CheckLogin extends HttpServlet {
   
	/**
	CREATE PROCEDURE `KullaniciGiris_sp`(KullaniciNameIn VARCHAR(20), KullaniciSifresiIn VARCHAR(20))
    NOT DETERMINISTIC
    SQL SECURITY DEFINER 
    COMMENT ''
    BEGIN  SELECT  KULLANICI.KullaniciNo,  KULLANICI.GrupNo,  KULLANICI.PozisyonNo  FROM  KULLANICI  WHERE  KULLANICI.KullaniciAdi = KullaniciNameIn  AND KULLANICI.KullaniciSifresi = KullaniciSifresiIn  AND KULLANICI.Statu = '1' ; END;
    */
    
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();        
        
        try{
        	
            String userName= request.getParameter("username");
            String password= request.getParameter("password");
            
            // eger bir hata olusursa loginError jspde hatanin ne oldugunu belirtmek icin 
           
            HttpSession session=request.getSession();
            SessionListener s=new SessionListener();
            HttpSessionEvent se=new HttpSessionEvent(session);
            s.sessionCreated(se);
            session.setAttribute("username",userName);
            
            //sessin kill olayi denedik ama olmadi
            
            //session da birden fazla sayfa a�ilamas?n
          //  HashMap deneme=SessionListener.returnSessions();        	     	
        	
            //String currentSessionId=(String)session.getId();
        	//deneme.remove(currentSessionId); //su anki session? oldurme
            //Set e = deneme.keySet();    
           // Iterator it_e=e.iterator(); 
           // int count=0;
           // String[] sessionIds=new String[e.size()];
         
           // while(it_e.hasNext())
           // {
            //   Object it = it_e.next();
            //   HttpSessionEvent sess=(HttpSessionEvent)deneme.get(it);
        	//   if(!currentSessionId.equals(sess.getSession().getId()))
        	//   {
        	//	   System.out.println("geldim");
             //    sessionIds[count]=(String)sess.getSession().getId();
              //   count++;
        	//   }
           // }
        	
           // if(sessionIds!=null){
            //	System.out.println("a"+sessionIds[0]);
	        //	for(int i=0;i<sessionIds.length;i++)
	       // 	{
	     //   		
	        //		SessionListener.destroy_session((String)sessionIds[i]);      		
	        //	} 
         //   }
// session da birden fazla sayfa acilmasin
            ///-----------------------------------//
                     
            DB db=new DB(true);

            ResultSet result=db.executeSP("KullaniciGiris_sp",new Object []{userName,password}).getResult();
         
            if(!result.next()) // user not exists or db error
            {            	 
                response.sendRedirect("./alerts/LoginError.jsp");
                db.closeConnection();
                return;
            }
            else{ //user bilgileri dondu                          
                int hataliGirisSayisi=result.getInt("SifreHatasi");
                if(hataliGirisSayisi >=3 ){
                	db.closeConnection();
                	response.sendRedirect("./alerts/LoginBlock.html");
                	return;
                }
                
                User userClass=new User(); 
                
                userClass.positionID= result.getString("PozisyonNo");                
                userClass.setgroupID( result.getString("GrupNo"));
                userClass.setUserid(  result.getString("KullaniciNo"));
               
                //   login hatali
                if(userClass.getUserid() == null && userClass.positionID==null) 
                {  
                	db.closeConnection();
                	response.sendRedirect("./alerts/LoginError.jsp");
                	db.closeConnection();
                	return;
                }           
                
                                          
                   
               ResultSet result_rights=db.executeSP("KullaniciYetkileriniGoster_sp",new Object []{userClass.getUserid(),userClass.positionID}).getResult();
               System.out.println("call KullaniciYetkileriniGoster_sp('"+userClass.getUserid()+"')");  
               int capacity=0;
               if(result_rights.next()){
            	   result_rights.last();
                    capacity=result_rights.getRow();
                    result_rights.beforeFirst();   
               }
               //System.out.println("capacity:" +capacity);
               String[] allCategories=new String[capacity];
               String[] rightsNames=new String[capacity];
               // Emin Senay 15.12.2006
               // sayfa numaralari sol menude butce, stok ve satin almanin ayrilabilmesi icin lazim
               String[] sayfaNo = new String[capacity]; 
               int[] link=new int[capacity];
               for(int i=0;i<capacity && result_rights.next();i++)
               {            
                   allCategories[i]=result_rights.getString("SayfaKodu"); 
                   rightsNames[i]=result_rights.getString("SayfaAdi");
                   link[i]=result_rights.getInt("SayfaAmaci");
                   // Emin Senay 15.12.2006
                   sayfaNo[i] = result_rights.getString("SayfaNo");
                   
               }
               
               
               userClass.rights=allCategories;
               userClass.rightsNames=rightsNames;
               userClass.link=link;
               // Emin Senay 15.12.2006
               userClass.pageCodes = sayfaNo;
               
                
                //session a user class geciriyoruz ilerde hep b�yle kullan�lmal�
                HttpSession httpSession=request.getSession();
                httpSession.setAttribute("userClass", userClass);
                
               // httpSession.setAttribute("ipAdr",ipAdr);
                //session a user class geciriyoruz ilerde hep b�yle kullan�lmal�
                
                
                // departman hiyerarsindeki yerine gore user a bir sayfa ac. 
                //response.sendRedirect("Pages/Level"+userClass.positionID+".jsp");
                //buray? db ciler bi?i yapm?? anlatacaklar
                //response.sendRedirect("Pages/Level1.jsp");
                response.sendRedirect("Pages/onayBekleyenler/loginned.html");
                //response.sendRedirect("Pages/onayBekleyenler/onaybekleyenler.jsp");
                
                db.closeConnection();
                return;
            }
//            db.closeConnection();
        //}
         }catch(Exception e)
        {
            
//            out.println("<hr/><p><h2>CheckLogin hatasi :"+e+"</h2><hr/><p>");
        	 
            e.printStackTrace(out);
           // response.sendRedirect("LoginError.jsp");
        }        
        out.close();
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}
