/*
 * Onayla.java
 *
 * Created on 29 Ekim 2005 Cumartesi, 14:06
 */

package servlets;

import global.Request;
import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import global.*;
import system.User;

/**
 *
 * @author ANIL GURSEL
 * @version
 */
public class SubmitRequest extends HttpServlet {
    
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(true);
        Request secRequest = ((Request)(session.getAttribute("request")));
        
        User userInfo = (User)(session.getAttribute("userClass"));
       
        long nextState= secRequest.getNextPositionID();
        //sayfalar aras?nda dolans?n diye buraya sacma bir kod koyacam
        nextState=(nextState%3)+1;
        //
        //þu anda Arif'ten SP beklediðim için kendimce bir þeyler yapýyorum
        DatabaseConnection.execute("update request_form set stateID ='"+nextState+"' where RequestFormID ='"+secRequest.getRequestID()+"'");
        //do necessary operations in the database
        // set the request to another state
        secRequest.writeToDatabase(); 
      
        response.sendRedirect("Pages/Level"+userInfo.positionID+".jsp");
    
        
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
