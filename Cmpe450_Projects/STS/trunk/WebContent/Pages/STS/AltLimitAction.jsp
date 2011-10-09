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
.style3 {
	font-size: 14px;
	font-weight: bold;
	color: #0000FF;
}
-->
</style>
</head>

<body bgcolor="#FFFFFF">
<div align="left"> <div id="toprightt"> </div> <div id="topright2">

	<table border="0" cellspacing="0" cellpadding="0" width="600">


		<tr>
			<td valign="top">
			<%
			//-----------------------------------------------------
			%> <%
 //DYNAMIC PAGE HERE BELOW!!!!
 %>

			<%
				User userInfo = (User) (session.getAttribute("userClass"));

				/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
				boolean GDC = false, DDC = false;
				if (userInfo.positionID.equals("00000F-POS"))
					GDC = true;
				else if (userInfo.positionID.equals("000004-POS")) {
					DDC = true;
				}

				if (!GDC && !DDC) {
					session.setAttribute("error",
					"Alt Limit Belirleme sayfasına girme hakkınız yok.");
					response.sendRedirect("../../alerts/GeneralAlert.jsp");
				} else {
					StockManagement Stok = new StockManagement();

				//	String urunAdi = (String) request.getParameter("select_urun");
				//	String urunNo = Stok.getUrunNo(urunAdi);
					String urunNo = (String) request.getParameter("select_urun");

					int altLimit = 0;
					try {
						altLimit = Integer.valueOf((String) request
						.getParameter("altLimit"));
					} catch (Exception x) {
						response.sendRedirect("./AltLimitHata.jsp");
					}

					if (GDC) {
						if (Stok.addGDLimit(urunNo, altLimit)) {
			%>
			<center><span class="style3">Limit Kaydedildi.</span></center>
			<%
					} else
					response.sendRedirect("./AltLimitHata.jsp");
					}

					if (DDC) {
						//String birimIsmi = Stok.getBirimIsmi(userInfo.getgroupID());
						//String birimNo = Stok.getBirimNo(birimIsmi);
						String groupID = userInfo.getgroupID();
						if (Stok.addADLimit(groupID, urunNo, altLimit)) {
			%>
			<center><span class="style3">Limit Kaydedildi.</span></center>
			<%
					} else
					response.sendRedirect("./AltLimitHata.jsp");
					}
			%> <%
 }
 %> <%
 //DYNAMIC PAGE HERE ABOVE!!!!
 %> <%
 //-----------------------------------------------------
 %>




			</td>
		</tr>
	</table>
</div> <div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar
Mühendisliği &copy;2006</font></b></p>
</div> </div>
</body>
</html>




