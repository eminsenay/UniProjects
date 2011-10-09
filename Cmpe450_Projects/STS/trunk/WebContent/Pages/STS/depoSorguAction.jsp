<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@page import="java.sql.*"%>
<%@page import="system.*"%>
<%@ page import="sts.stockFollowUp.*"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.ListIterator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/css/gui.css" rel="stylesheet" type="text/css">
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<div align="left"> <div id="toprightt"> </div> <div id="topright2">


<table border="0" cellspacing="0" cellpadding="0" width="600">


	<tr>
		<td width="50"></td>
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
			boolean GDC = false, DDC = false, RektorYrd = false, DDM = false, dean = false;
			if(userInfo.positionID.equals("00000F-POS"))
				GDC = true;
			else if(userInfo.positionID.equals("000004-POS") || userInfo.positionID.equals("07-POS"))
				DDC = true;
			else if(userInfo.positionID.equals("00000I-POS"))
				RektorYrd = true;
			else if (userInfo.positionID.equals("000003-POS"))
				DDM = true;
			else if (userInfo.positionID.equals("000005-POS"))
				dean = true;


			StockManagement sm = null;
			if (!GDC && !DDC && !RektorYrd && !DDM && !dean) {
				session.setAttribute("error",
				"Depo Cıkış sayfasına girme hakkınız yok.");
				response.sendRedirect("../../alerts/GeneralAlert.jsp");
			} else {
				sm = new StockManagement();
			}
		%> <%
 	//get all parameters and get the result

 	String groupNo = request.getParameter("bolumID");
 	String urunNo = request.getParameter("urunID");

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

 	if (urunNo == null){
 		%>
 		<p>
 		Lütfen sorgulamaya Depo Sorgulama linkinden tekrar başlayınız
 		</p>
 		<% 
 	}
 	else{


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
 	//System.out.println("tarihler:"+depFromDay.length()+" "+depFromMonth.length()+" "+depFromYear.length());
 	if (depFromDay.length() < 2 || depFromMonth.length() < 2 || depFromYear.length() < 4 || 
 			depToYear.length() < 4 || depToMonth.length() < 2 || depToDay.length() < 2){
 		depTo = "5000-00-00";
 		depFrom = "5000-00-00";
 		//System.out.println("tarihler yenilendi");
 	}
 	else
 		depTo = depToYear + "-" + depToMonth + "-" + depToDay;

 	String fromRector = request.getParameter("rektorMu");
 	String fromDean = request.getParameter("dekanMi");
 %>
		<table width="100%" cellspacing="0" cellpadding="0" class="requestTable">
			<tr class = "tableHeader">
			<td class="requestTableHeaderCell" colspan=3><div align="center"><strong>Girişler </strong></div></td>
			</tr>
			<tr class="tableHeader">
				<td class="requestTableHeaderCell"><div align="center"><strong>Ürün İsmi </strong></div></td>
				<td class="requestTableHeaderCell"><div align="center"><strong>Alım Tarihi </strong></div></td>
				<td class="requestTableHeaderCell"><div align="center"><strong>Alım Miktarı </strong></div></td>
			</tr>


			<%
	//			ResultSet rs = null;
				ArrayList sorguResult = new ArrayList();
				//System.out.println(fromRector);
				//System.out.println(DDC+""+GDC+""+DDM);
				if (GDC || fromRector.equals("Genel_Depo")) {
					sorguResult = sm.getGDGirisSorgusu(urunNo, arrTo, arrFrom);
				} else if (DDC || DDM || !fromRector.equals("dummy") || !fromDean.equals("dummy")) {
					String birimIsmi;
					if (DDC || DDM){
						birimIsmi = sm.getBirimIsmi(userInfo.getgroupID()); /*Buraya get groupname SP si gerekebilir*/
						sorguResult = sm.getBDGirisSorgusu(userInfo.getgroupID(), urunNo, arrFrom, arrTo);
					}
					else if (!fromRector.equals("dummy")){
						/* GroupID yollanip GroupName alinacak */
						sorguResult = sm.getBDGirisSorgusu(fromRector, urunNo, arrFrom, arrTo);
					}
					else {
						/* GroupID yollanip GroupName alinacak */
						sorguResult = sm.getBDGirisSorgusu(fromDean, urunNo, arrFrom, arrTo);
					}
					
			
				}

				ListIterator li = sorguResult.listIterator();
				int rowCount = 0;
				while (li.hasNext()) {
					rowCount++;
					if (rowCount % 2 == 1)
					{
			%>
				<tr class="oddRow">
					<td class="requestTableCell"><%=(String)li.next()%></td>
					<td class="requestTableCell"><%=(String)li.next()%></td>
					<%
						Integer harcanan = (Integer)li.next();
						String str_harcanan = String.valueOf(harcanan);
						if (harcanan == -1000)
							str_harcanan = "-";
					%>
					<td class="requestTableCell"><%=str_harcanan%></td>
				</tr>
			<%
					}
					else
					{
			%>
				<tr class="evenRow">
					<td class="requestTableCell"><%=(String)li.next()%></td>
					<td class="requestTableCell"><%=(String)li.next()%></td>
					<%
						Integer harcanan = (Integer)li.next();
						String str_harcanan = String.valueOf(harcanan);
						if (harcanan == -1000)
							str_harcanan = "-";
					%>
					<td class="requestTableCell"><%=str_harcanan%></td>				
				</tr>			
				<%
					}
				}
//				fromRector = "dummy";
//				fromDean = "dummy";
			%>
		</table>
		<br><br>
		<table width="100%" cellspacing="0" cellpadding="0" class="requestTable">
			<tr class = "tableHeader">
			<td class="requestTableHeaderCell" colspan=4><div align="center"><strong>Çıkışlar </strong></div></td>
			</tr>
			<tr class="tableHeader">
				<td class="requestTableHeaderCell"><div align="center"><strong>Ürün İsmi </strong></div></td>
				<%if (GDC || fromRector.equals("Genel_Depo")) {%>
				<td class="requestTableHeaderCell"><div align="center"><strong>Birim İsmi </strong></div></td>
				<%} %>
				<td class="requestTableHeaderCell"><div align="center"><strong>Harcama Tarihi </strong></div></td>
				<td class="requestTableHeaderCell"><div align="center"><strong>Harcama Miktarı </strong></div></td>
			</tr>


			<%
	//			ResultSet rs = null;
				//ArrayList sorguResult = new ArrayList();
				//System.out.println(fromRector);
				//System.out.println(DDC+""+GDC+""+DDM);
				sorguResult.clear();
				if (GDC || fromRector.equals("Genel_Depo")) {
					sorguResult = sm.getGDHarcamaSorgusu(urunNo, groupNo, depTo, depFrom);
				} else if (DDC || DDM || !fromRector.equals("dummy") || !fromDean.equals("dummy")) {
					String birimIsmi;
					if (DDC || DDM){
						birimIsmi = sm.getBirimIsmi(userInfo.getgroupID()); /*Buraya get groupname SP si gerekebilir*/
						sorguResult = sm.getBDHarcamaSorgusu(userInfo.getgroupID(), urunNo, depFrom, depTo);
					}
					else if (!fromRector.equals("dummy")){
						/* GroupID yollanip GroupName alinacak */
						sorguResult = sm.getBDHarcamaSorgusu(fromRector, urunNo, depFrom, depTo);
					}
					else {
						/* GroupID yollanip GroupName alinacak */
						sorguResult = sm.getBDHarcamaSorgusu(fromDean, urunNo, depFrom, depTo);
					}
					
			
				}

				ListIterator li1 = sorguResult.listIterator();
				rowCount = 0;
				while (li1.hasNext()) {
					rowCount++;
					if (rowCount % 2 == 1)
					{
			%>
				<tr class="oddRow">
					<td class="requestTableCell"><%=(String)li1.next()%></td>
					<%if (GDC || (RektorYrd && fromRector.equals("Genel_Depo")) ) { %>
					<td class="requestTableCell"><%=(String)li1.next()%></td>
					<%} %>
					<%
					String cikisTarihi = (String)li1.next();
					if (cikisTarihi.equals("4999-11-30"))
						cikisTarihi = "-";
				    %>
				    <td class="requestTableCell"><%=cikisTarihi%></td>
					<%
						Integer harcanan = (Integer)li1.next();
						String str_harcanan = String.valueOf(harcanan);
						if (harcanan == -1000)
							str_harcanan = "-";
					%>
					<td class="requestTableCell"><%=str_harcanan%></td>
				</tr>
			<%
					}
					else
					{
			%>
				<tr class="evenRow">
					<td class="requestTableCell"><%=(String)li1.next()%></td>
					<%if (GDC || (RektorYrd && fromRector.equals("Genel_Depo")) ) { %>
					<td class="requestTableCell"><%=(String)li1.next()%></td>
					<%} %>
					<%
					String cikisTarihi = (String)li1.next();
					if (cikisTarihi.equals("4999-11-30"))
						cikisTarihi = "-";
				    %>
				    <td class="requestTableCell"><%=cikisTarihi%></td>
					<%
						Integer harcanan = (Integer)li1.next();
						String str_harcanan = String.valueOf(harcanan);
						if (harcanan == -1000)
							str_harcanan = "-";
					%>
					<td class="requestTableCell"><%=str_harcanan%></td>
				</tr>			
				<%
					}
				}
				fromRector = "dummy";
				fromDean = "dummy";
			%>
		</table>

<%		} %>


		<%
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


