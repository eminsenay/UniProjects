<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="sts.stockFollowUp.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/css/gui.css" rel="stylesheet" type="text/css" />
<link href="../../index/gui.css" rel="stylesheet" type="text/css" />
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
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600"> 
  

  <tr>     
    <td colspan=2 valign="top">
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
   	<table width="100%" align="center" class="requestTable" cellpadding="0" cellspacing="0">
   	<%
   	
   	if(limitAlti.next())	{
   	
   		%>
   		<tr class="tableHeader"> 
 <td class="requestTableHeaderCell" colspan="3"><b>LİMİTİN ALTINA DÜŞEN ÜRÜNLERİN LİSTESİ</b></td>
 </tr>
<tr class="tableHeader">
    				<td width="50%" class="requestTableHeaderCell">ÜRÜN ADI</td>
    				<td width="25%" class="requestTableHeaderCell">KALAN MİKTAR</td>
    				<td width="25%" class="requestTableHeaderCell">LİMİT</td>
 </tr>
 <%
 		limitAlti = (ResultSet) db.executeSP("LimitUrunGD_sp").getResult();
 		int rowCounter = 0;
   		while(limitAlti.next())
   		{
			urunID = limitAlti.getString("UrunNo");
			rowCounter++;
			if (rowCounter % 2 == 1)
			{

	%>
				 <tr class="oddRow">
    				<td width="50%" class="requestTableCell"><%=limitAlti.getString("UrunAdi") %></td>
    				<td width="25%" class="requestTableCell"><%=limitAlti.getString("Mevcut") %></td>
    				<td width="25%" class="requestTableCell"><%=limitAlti.getString("AltLimit") %></td>
 				 </tr>
	<%	
			}
			else
			{

	%>
				 <tr  class="evenRow">
    				<td width="50%" class="requestTableCell"><%=limitAlti.getString("UrunAdi") %></td>
    				<td width="25%" class="requestTableCell"><%=limitAlti.getString("Mevcut")%></td>
    				<td width="25%" class="requestTableCell"><%=limitAlti.getString("AltLimit")%></td>
 				 </tr>
	<%	
			}
 		}
	}
   	else if(!limitAlti.next())	{
		%>
		<tr class="oddRow">
		<td colspan="3" class="requestTableCell"><span class="style4">Depoda limitin altına düşen ürün bulunmamaktadır.</span>
		</td>
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
	   	<table width="100%"align="center" class="requestTable" cellpadding="0" cellspacing="0">
	   	<%
	   	
	   	if(limitAlti.next())	{
	   	   	
	   		%>
	   		<tr  class="tableHeader"> 
	 <td class="requestTableCell" colspan="3"><b><font color="white">LİMİTİN ALTINA DÜŞEN ÜRÜNLERİN LİSTESİ</font></b></td>
	 </tr>
	<tr class="tableHeader">
	    				<td width="50%" class="requestTableCell"><font color="white">ÜRÜN ADI</font></td>
	    				<td width="25%" class="requestTableCell"><font color="white">KALAN MİKTAR</font></td>
	    				<td width="25%" class="requestTableCell"><font color="white">LİMİT</font></td>
	 </tr>
	 <%
	 		limitAlti = (ResultSet) db.executeSP("LimitUrunAD_sp",new Object[] {groupID}).getResult();
	 		int rowCounter = 0;
	   		while(limitAlti.next())
	   		{
				rowCounter++;
				urunID = limitAlti.getString("UrunNo");
				if (rowCounter % 2 == 1)
				{
		%>
					 <tr class="oddRow">
	    				<td width="50%" class="requestTableCell"><%=limitAlti.getString("UrunAdi") %></td>
	    				<td width="25%" class="requestTableCell"><%=limitAlti.getString("Mevcut") %></td>
	    				<td width="25%" class="requestTableCell"><%=limitAlti.getString("AltLimit") %></td>
	 				 </tr>
		<%	
				}
				else
				{
		%>
					 <tr class="evenRow">
	    				<td width="50%" class="requestTableCell"><%=limitAlti.getString("UrunAdi") %></td>
	    				<td width="25%" class="requestTableCell"><%=limitAlti.getString("Mevcut") %></td>
	    				<td width="25%" class="requestTableCell"><%=limitAlti.getString("AltLimit") %></td>
	 				 </tr>
		<%	
				}
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
</table>
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisliği &copy;2006</font></b></p>
	</div>
	
	
	
	</div>
</body>
</html>




