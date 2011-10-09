<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@page import="java.sql.ResultSet"%>


<%//@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
   session.setAttribute("error",null);
%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  
  <tr>
    <td width="50" height="100"><img src="../images/spacer.gif" width="50" height="100"></td>
    <td width="550" height="100"><img src="../images/spacer.gif" width="550" height="100"></td>
  </tr>
  <tr>
        <td width="50" height="350"><img src="../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
		
<table bgcolor="#FFFFFF" width="420" border="0" bordercolor="#CCCCFF" cellspacing="0" cellpadding="0" align=left class="tablefont3">

     	  <tr>
	   				<td colspan="5" align="center">
	   				              
                <font size="2" ><br><br></font></td>
      </tr>
	  
		       		
		
		        
				<tr>
		        	<td style="FONT-WEIGHT : normal">
			        Şifrenizi hatırlamıyorsanız sistem yöneticimiz ileti göndermeniz gerekmektedir.	Yeni şifreniz e-posta adresinize gönderilecektir.
		        	</td>
		        </tr>
		        	<%
		        	  DB db=new DB(true);
		        	  String webMasterEmail="";
		        	  String webMaster="webmaster";
		        	  ResultSet rs=db.executeSP("SistemBilgileriGoster_sp",new Object[]{webMaster}).getResult();
		        	  if(rs.next())
		        	  {
		        		  webMasterEmail=rs.getString("Degeri");
		        	  }
		        	  else
		        	  {
	                    	String error="Sistem Yoneticisinin Email adressi Kayitli Degildir";
	                    	session.setAttribute("error",error);
	                    	response.sendRedirect("../alerts/GeneralAlert.jsp");
	                    	return;
                      }
		        	  
		        	%>
		        	<tr><td>&nbsp </td> 
		        		<tr><td><a href="<%=webMasterEmail%>">Sistem yöneticisine iletmek için tıklayınız.</a> </td> 
		        	</tr> 
                     
                    
    </table>		
			
		
		
		
		
</td>
  </tr>
  
</table>
	</div>
	
	</div>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</body>
</html>




