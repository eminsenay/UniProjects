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
<link href="../../index/css/gui.css" rel="stylesheet" type="text/css">
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<div align="left"> <div id="toprightt"> </div> <div id="topright2">

<table border="0" cellspacing="0" cellpadding="0" width="600">
	<tr>
		<td colspan=2 valign="top">
		<%
			User userInfo = (User) (session.getAttribute("userClass"));

			/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
			boolean GDC = false, DDC = false, rektor = false, dekan=false, bolumbas = false;
			if (userInfo.positionID.equals("00000F-POS"))
				GDC = true;
			else if (userInfo.positionID.equals("000004-POS")) {
				DDC = true;
			}
			else if(userInfo.positionID.equals("000005-POS")) {
				dekan = true;
			}
			else if(userInfo.positionID.equals("00000I-POS")) {
				rektor = true;
			}
			else if (userInfo.positionID.equals("000003-POS")) {
				bolumbas = true;
			}
			else {
				session.setAttribute("error",
				"Depo inceleme sayfasına girme hakkınız yok.");
				response.sendRedirect("../../alerts/GeneralAlert.jsp");
			}
			global.DB db = new global.DB(true);
			ResultSet rsFromName = null;
			ResultSet rsDepo = null;
			String from = userInfo.getgroupID();
			String grupNo = "";
			String grupAdi = "";
			rsFromName = (ResultSet) db.executeSP("GetGroupName_sp",
					new Object[] { from }).getResult();
			rsFromName.next();
			String fromName = rsFromName.getString("GrupAdi");
			rsFromName.close();

			if (DDC || bolumbas) {
				rsDepo = (ResultSet) db
				.executeSP("BirimDepoGoster_sp",new Object[]{from}).getResult();
				ResultSet rs_grupAdi = db.executeSP("GetGroupName_sp",new Object[]{from}).getResult();
				rs_grupAdi.next();
				grupAdi = rs_grupAdi.getString("GrupAdi") + " Deposu";
				rs_grupAdi.close();
			} else if (GDC) {
				rsDepo = (ResultSet) db
				.executeSP("GenelDepoGoster_sp").getResult();
				grupAdi = "Genel Depo";
				}
			else if (dekan) {
				grupNo = request.getParameter("dekanMi");
				rsDepo = (ResultSet) db
				.executeSP("BirimDepoGoster_sp",new Object[]{grupNo}).getResult();
				ResultSet rs_grupAdi = db.executeSP("GetGroupName_sp",new Object[]{grupNo}).getResult();
				rs_grupAdi.next();
				grupAdi = rs_grupAdi.getString("GrupAdi") + " Deposu";
				rs_grupAdi.close();
			}
			else if (rektor) {
				grupNo = request.getParameter("rektorMu");
				if (grupNo.equals("Genel_Depo")) {
					rsDepo = (ResultSet) db
					.executeSP("GenelDepoGoster_sp").getResult();
					grupAdi = "Genel Depo";
				} else {
					rsDepo = (ResultSet) db
					.executeSP("BirimDepoGoster_sp",new Object[]{grupNo}).getResult();
					ResultSet rs_grupAdi = db.executeSP("GetGroupName_sp",new Object[]{grupNo}).getResult();
					rs_grupAdi.next();
					grupAdi = rs_grupAdi.getString("GrupAdi") + " Deposu";
					rs_grupAdi.close();
				}
			}

		%>
		<p align="center"><strong>Depo İnceleme</strong></p>
		<center><%=grupAdi%></center>
		</td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td colspan=2>
		<table width="100%" class="requestTable" cellpadding="0" cellspacing="0">
			<tr class="tableHeader">
				<td class="requestTableHeaderCell">Ürün Adı</td>
				<td class="requestTableHeaderCell">Depodaki Miktar</td>
				<td class="requestTableHeaderCell">Alt Limit</td>
			</tr>
			<%
				//rsToList.first();
				int rowCount = 0;
				while (rsDepo.next()) {
					rowCount++;
					if (rowCount % 2 == 1)
					{
			%>
			<tr class="oddRow">
				<td class="requestTableCell"><%=rsDepo.getString("UrunAdi")%></td>
				<td class="requestTableCell"><%=rsDepo.getInt("Mevcut")%></td>
				<td class="requestTableCell"><%=rsDepo.getInt("AltLimit")%></td>
			</tr>
			<%
					}
					else
					{
			%>
			<tr class="evenRow">
				<td class="requestTableCell"><%=rsDepo.getString("UrunAdi")%></td>
				<td class="requestTableCell"><%=rsDepo.getInt("Mevcut")%></td>
				<td class="requestTableCell"><%=rsDepo.getInt("AltLimit")%></td>
			</tr>
			<%
					}
			}
			%>
		</table>

		<%
			// end of else
			rsDepo.close();
			db.closeConnection();
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
