<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%//@page import="global.*"%>
<%//@page import="user.*"%>


<%//@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
	<div id="toprightt"> </div>
  <div id="topright2"> 
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">

  <tr>
        <td width="50" height="350"><img src="../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
<form action="../Pages/onayBekleyenler/onaybekleyenler.jsp" method="post">
            <table bgcolor="#FFFFFF" width="500" border="0" cellspacing="0" cellpadding="0" >
              <tr> 
                <td><img src="../images/spacer.gif" width="30"></td>
              </tr>
              <tr> 
                <td><img src="../images/spacer.gif" width="30"></td>
              </tr>
              <tr> 
                <td><img src="../images/spacer.gif" width="30"></td>
              </tr>
              <tr> 
                <td><img src="../images/spacer.gif" width="30"></td>
              </tr>
              <tr>
                <td><img src="../images/spacer.gif" width="40"></td>
                <td><center><font size="6" font = "verdana "color="Indigo"><i>
                İhale Onaya Gönderildi.
                </i> </font></center></td>
              </tr>
              <tr> 
                <td><img src="../images/spacer.gif" width="40"></td>
                <td> <font size="5" font = "verdana "color="Indigo"> 
                   <center>
                    <p>&nbsp;</p><p><input type="submit" name="Submit" value="Devam Et" >
                  </p></center>
                  </font> </td>
              </tr>
            </table>
          </form>
		
		
		
		
		
		
		
        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../images/spacer.gif" width="550" height="50"></td>
  </tr>
</table>
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
	
	
	
	</div>
</body>
<% System.out.println("security signed document: " + session.getAttribute("securityDocument")); %>
</html>
