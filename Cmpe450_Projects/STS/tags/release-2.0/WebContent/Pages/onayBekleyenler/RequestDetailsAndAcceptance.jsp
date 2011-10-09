<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Boğazi&ccedil;i &Uuml;niversitesi Sat&#305;n Alma Sistemi</title>
    </head>
    <body>

        <%
        request.setCharacterEncoding("UTF-8"); 
        //selectedRequestId is sent from Level1 via a form
        String requestIdAsString = request.getParameter("selectedRequestId"); 
        //parse requestIdAsString to int
        long requestId=Long.parseLong(requestIdAsString);       
               
        //get userInfo from previous page
        
//aktif hale getirmek için ömeri bekliyorum
        User userInfo = (User)(session.getAttribute("userClass"));
        //create a request
        //userInfo.groupid öğrenemiyorum, protected olduğu için
//        Request istekFisi = new  Request(requestId,userInfo.groupid,userInfo.defaultPageID);
        //simdilik 1 diyorum
        long depId=Long.parseLong(userInfo.getgroupID());
         long posId=Long.parseLong(userInfo.positionID);
        global.Request istekFisi = new global.Request(requestId,depId,posId);
        //get request from database  //Arif'ten gelecek SP bekleniyor
//        ResultSet resultSet = global.DatabaseConnection.executeQuery("select * from request_form where RequestFormID = '" + requestId+"'");
  
        ResultSet resultSet = global.DatabaseConnection.executeQuery("call IstekFisiGoster_sp( '" + requestId+"')");
        
        if( resultSet != null ){
            
            try{
                
                ResultSetMetaData rsmd=resultSet.getMetaData();
                
               out.println("<table border=1>");
                while(resultSet.next()){                   
                   
                  
                    for(int i=1; i<10; i++){  
                        out.println("<tr>");
                        out.println("<td>"+ rsmd.getColumnLabel(i)+"</td> <td> "+resultSet.getString(i)+"</td>");                   
                        out.println("</tr>");
                    }  
                }
                out.println("</table>");
                //initializes istekFisi according to resultSet
                //istekFisi.readFromDatabase(resultSet); 
                //bu satır kaldırılacak, su anda resultset'in ne döndürdüğünü bilmediğim için, bu eklemek zorunda kaldım geçici olarak
                //istekFisi.setRequestID(requestId);
                
            }
            catch(java.sql.SQLException E){
                out.println("error.coding1.RequestDetailsAndAcceptance.37");
                E.printStackTrace();
            }
        %>
            
        <!-- 
            Emre'nin frontpage'de hazirladigi kodla butunlestime operasyonu basliyor
        -->
        
        
       
            <form action="../SubmitRequest" >
        
                <p><input type='submit' value='Onayla'/>
                
            </form>
       
        
        





        <!-- 
            Emre'nin frontpage'de hazirladigi kodla butunlestime operasyonu burda bitiyor
        -->    
        
        <%
        }
        else{
            out.println("CANNOT DISPLAY REQUEST DETAILS<br>");
        }
        %>
    
    <%
        //send istekFisi to Onayla Page
        session.setAttribute("request", istekFisi);
        
        //aktif hale getirmek için ömer'i bekliyorum
//        session.setAttribute("userClass", userInfo);
     %> 
    
    
    
    
    
    </body>
</html>
