<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@page import="java.sql.*"%>
<%@page import="system.*"%>
<%@ page import="sts.stockFollowUp.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<div align="left"> <div id="toprightt"> </div> <div id="topright2">


<table border="0" cellspacing="0" cellpadding="0" width="600"
	height="500">


	<tr>
		<td width="50" height="350"><img src="../images/spacer.gif"
			width="50" height="350"></td>
		<td valign="top">
		<%
		//-----------------------------------------------------
		%> <%
 //DYNAMIC PAGE HERE BELOW!!!!
 %>

		<%
			// ***********************************
			//String User = "offline";
			User userInfo = (User) (session.getAttribute("userClass"));

			/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
			boolean GDC = false, DDC = false, RektorYrd = false, DDM = false;
			if (userInfo.positionID.endsWith("1G-POS"))
				GDC = true;
			if (userInfo.positionID.endsWith("14-POS"))
				DDC = true;
			if (userInfo.positionID.endsWith("17-POS"))
				RektorYrd = true;
			if (userInfo.positionID.endsWith("15-POS"))
				DDM = true;

			StockManagement sm = null;
			if (!GDC && !DDC && !RektorYrd && !DDM) {
				session.setAttribute("error",
				"Depo Cıkış sayfasına girme hakkınız yok.");
				response.sendRedirect("../../alerts/GeneralAlert.jsp");
			} else {
				sm = new StockManagement();
			}
		%> <%
 	//get all parameters and get the result
 	String depName = request.getParameter("bolumAdi");
 	String goodName = request.getParameter("urunAdi");
 	String arrFromDay = request.getParameter("arrFromDay");
 	String arrFromMonth = request.getParameter("arrFromMonth");
 	String arrFromYear = request.getParameter("arrFromYear");
 	String arrToDay = request.getParameter("arrToDay");
 	String arrToMonth = request.getParameter("arrToMonth");
 	String arrToYear = request.getParameter("arrToYear");

 	String depFromDay = request.getParameter("depFromDay");
 	String depFromMonth = request.getParameter("depFromMonth");
 	String depFromYear = request.getParameter("depFromYear");
 	String depToDay = request.getParameter("depToDay");
 	String depToMonth = request.getParameter("depToMonth");
 	String depToYear = request.getParameter("depToYear");

 	System.out.println(arrFromDay);

 	String arrFrom;
 	String arrTo;
 	String depFrom;
 	String depTo;

 	if (arrFromDay.length() < 2)
 		arrFromDay = "0" + arrFromDay;
 	if (arrFromMonth.length() < 2)
 		arrFromMonth = "0" + arrFromMonth;
 	if (arrToDay.length() < 2)
 		arrToDay = "0" + arrToDay;
 	if (arrToMonth.length() < 2)
 		arrToMonth = "0" + arrToMonth;
 	if (depFromDay.length() < 2)
 		depFromDay = "0" + depFromDay;
 	if (depFromMonth.length() < 2)
 		depFromMonth = "0" + depFromMonth;
 	if (depToDay.length() < 2)
 		depToDay = "0" + depToDay;
 	if (arrToMonth.length() < 2)
 		depToMonth = "0" + depToMonth;

 	arrFrom = arrFromYear + "-" + arrFromMonth + "-" + arrFromDay;
 	arrTo = arrToYear + "-" + arrToMonth + "-" + arrToDay;
 	depFrom = depFromYear + "-" + depFromMonth + "-" + depFromDay;
 	depTo = depToYear + "-" + depToMonth + "-" + depToDay;

 	String fromRector = request.getParameter("rektorMu");
 %>


		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><div align="center"><strong>Ürün İsmi </strong></div></td>
				<td><div align="center"><strong>Talep Eden Birim
				</strong></div></td>
				<td><div align="center"><strong>Mevcut Miktar </strong></div></td>
				<td><div align="center"><strong>Kullanılan
				Miktar </strong></div></td>
				<td><div align="center"><strong>Giriş Tarihi </strong></div></td>
				<td><div align="center"><strong>Çıkış Tarihi </strong></div></td>
				<td><div align="center"><strong>Birim Fiyat</strong></div></td>
			</tr>


			<%
				ResultSet rs = null;
				System.out.println(fromRector);
				if (GDC || fromRector.equals("Genel_Depo")) {
					fromRector = "dummy";
					System.out.println("girdi");
					rs = sm.getGenelDepoSorgu(depName, goodName, arrFrom, arrTo,
					depFrom, depTo);
				} else if (DDC || DDM || !fromRector.equals("dummy")) {
					fromRector = "dummy";
					String birimIsmi;
					//abi burdan da anladigin uzere rektor giris sayfasindan bana gelen bilgi 
					//rektorun hangi birimin deposuna bakmak istedigi bilgisi. 
					//eger rektor degilse bu ddc nin hangi bolumun elemani oldugnu simdilik boyle
					//anliyormus gibi yapiyorum, cunku hangi birimin ddc si oldugunu nasil 
					//anliyacagimi bilmiyorum.
					if (DDC || DDM)
						birimIsmi = sm.getBirimIsmi(userInfo.getgroupID()); /*Buraya get groupname SP si gerekebilir*/
					else
						/* GroupID yollanip GroupName alinacak */
						birimIsmi = fromRector;
					rs = sm.getAkademikDepoSorgu(birimIsmi, goodName, arrFrom,
					arrTo, depFrom, depTo);
				}

				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getString("UrunIsmi")%></td>
				<%
				if (GDC) {
				%>
				<td><%=rs.getString("BirimIsmi")%></td>
				<%
				}
				%>
				<td><%=rs.getString("AlinanMiktar")%></td>
				<td><%=rs.getString("KullanilanMiktar")%></td>
				<td><%=rs.getString("FaturaTarihi")%></td>
				<td><%=rs.getString("CikisTarihi")%></td>
				<td><%=rs.getString("BirimFiyat")%></td>
			</tr>
			<%
			}
			%>

		</table>


		<%
		//DYNAMIC PAGE HERE ABOVE!!!!
		%> <%
 //-----------------------------------------------------
 %>




		</td>
	</tr>
	<tr>
		<td width="50" height="50"><img src="../images/spacer.gif"
			width="50" height="50"></td>
		<td width="550" height="50"><img src="../images/spacer.gif"
			width="550" height="50"></td>
	</tr>
</table>
</div> <div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar
Mühendisliği &copy;2005</font></b></p>
</div> </div>
</body>
</html>




