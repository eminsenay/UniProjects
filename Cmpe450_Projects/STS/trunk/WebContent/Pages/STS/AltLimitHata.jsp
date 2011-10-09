<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="sts.stockFollowUp.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/css/gui.css" rel="stylesheet" type="text/css">
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	font-size: 24px;
	font-weight: bold;
}
.style3 {font-size: 16px; color: #FF0000; }
-->
</style>
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600">
  

  <tr>
    <td colspan="2" valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
        
         <%
User userInfo = (User)(session.getAttribute("userClass"));

/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
boolean GDC = false, DDC =false;
if(userInfo.positionID.equals("00000F-POS"))
	GDC = true;
else if(userInfo.positionID.equals("000004-POS"))	{
	DDC = true;
}

if (!GDC && !DDC) { 
	session.setAttribute("error","Alt Limit Hata sayfasına girme hakkınız yok.");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
}
else {
%>
		
				<div align="center" class="style1">
				  <p>&nbsp;</p>
				  <p>&nbsp;</p>
				  <p class="style3">Limit olarak rakam girmelisiniz!</p>
				</div>
				<br>
				<div align="center" class="style1">
				  <p>&nbsp;</p>
				  <p class="style3">Lütfen tekrar deneyiniz!</p>
				</div>
				<div align="center" class="style1">
				  <p>&nbsp;</p>
				  <p class="style3"><a href="javascript:history.go(-1)">Geri</a></p>
				</div>
				
				
				

<% } %>
        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
		
		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50"></td>
  </tr>
</table>
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisliği &copy;2006</font></b></p>
	</div>
	
	
	
	</div>
</body>
</html>




