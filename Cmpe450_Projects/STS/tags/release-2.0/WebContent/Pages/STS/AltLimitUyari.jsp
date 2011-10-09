<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="sts.stockFollowUp.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style4 {
	font-size: 14px;
	color: #FF0000;
}
-->
</style>
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
		<%

StockManagement Stok = new StockManagement();
User userInfo = (User)(session.getAttribute("userClass"));


/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
boolean GDC = false, DDC =false;
if(userInfo.positionID.equals("00000F-POS"))
	GDC = true;
else if(userInfo.positionID.equals("000004-POS"))	{
	DDC = true;
}

if (!GDC && !DDC) { 
	session.setAttribute("error","Alt Limit Uyarı sayfasına girme hakkınız yok.");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
}
else {

String urunAdi;
String urunID;
global.DB db = new global.DB(true);
	//ResultSet rsGoodList = null;
	ResultSet limitAlti = null;
	
	//rsGoodList = (ResultSet) db.executeSP("GetAllUrunNo_sp").getResult();
	

	if(GDC)
	{
	limitAlti = (ResultSet) db.executeSP("LimitUrunGD_sp").getResult();
	//ArrayList<String> urun_names = new ArrayList<String>();
   	//urun_names = Stok.getUrunNames();
   	%>
   	<table width="100%" border="1">
   	<%
   	
   	if(limitAlti.next())	{
   	
   		%>
   		<tr> 
 <td><b>LİMİTİN ALTINA DÜŞEN ÜRÜNLERİN LİSTESİ</b></td>
 </tr>
 </table>
<table width="100%" border="1">
<tr>
    				<td width="50%">ÜRÜN ADI</td>
    				<td width="25%">KALAN MİKTAR</td>
    				<td width="25%">LİMİT</td>
 </tr>
 </table>
 <%
 		limitAlti = (ResultSet) db.executeSP("LimitUrunGD_sp").getResult();
   		while(limitAlti.next())
   		{

			urunID = limitAlti.getString("UrunNo");

	%>
	
 
 
 <table width="100%" border="1">
				 <tr>
    				<td width="50%"><%=Stok.getUrunAdi(urunID) %></td>
    				<td width="25%"><%=Stok.getGDKalan(urunID) %></td>
    				<td width="25%"><%=Stok.getGDLimit(urunID) %></td>
 				 </tr>
	<%	
 		}
	}
   	else if(!limitAlti.next())	{
		%>
		<tr>
		<td><span class="style4">Depoda limitin altına düşen ürün bulunmamaktadır.</span>
		<td>
		</tr>
		<%
	}
	%>
	</table>
<%

}
		
	if(DDC)
	{
		String groupID = userInfo.getgroupID();
		limitAlti = (ResultSet) db.executeSP("LimitUrunAD_sp",new Object[] {groupID}).getResult();
		//ArrayList<String> urun_names = new ArrayList<String>();
	   	//urun_names = Stok.getUrunNames();
	   	%>
	   	<table width="100%" border="1">
	   	<%
	   	
	   	if(limitAlti.next())	{
	   	   	
	   		%>
	   		<tr> 
	 <td><b>LİMİTİN ALTINA DÜŞEN ÜRÜNLERİN LİSTESİ</b></td>
	 </tr>
	 </table>
	<table width="100%" border="1">
	<tr>
	    				<td width="50%">ÜRÜN ADI</td>
	    				<td width="25%">KALAN MİKTAR</td>
	    				<td width="25%">LİMİT</td>
	 </tr>
	 </table>
	 <%
	 		limitAlti = (ResultSet) db.executeSP("LimitUrunAD_sp",new Object[] {groupID}).getResult();
	   		while(limitAlti.next())
	   		{

				urunID = limitAlti.getString("UrunNo");

		%>
		
	 
	 
	 <table width="100%" border="1">
					 <tr>
	    				<td width="50%"><%=Stok.getUrunAdi(urunID) %></td>
	    				<td width="25%"><%=Stok.getADKalan(groupID,urunID) %></td>
	    				<td width="25%"><%=Stok.getADLimit(groupID,urunID) %></td>
	 				 </tr>
		<%	
	 		}
		}
	   	else if(!limitAlti.next())	{
			%>
			<tr>
			<td><span class="style4">Depoda limitin altına düşen ürün bulunmamaktadır.</span>
			<td>
			</tr>
			<%
		}
		%>
		</table>
	<%

	}
	limitAlti.close();
	db.closeConnection();
}
	%>

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
      Mühendisliği &copy;2005</font></b></p>
	</div>
	
	
	
	</div>
</body>
</html>




