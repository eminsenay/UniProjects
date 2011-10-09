<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>
<%@ page import="sts.stockFollowUp.*"%>
<%@ page import="global.*"%>
<%@page import="java.sql.ResultSet"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/css/gui.css" rel="stylesheet" type="text/css" />
<link href="../../index/gui.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="#FFFFFF">
<div align="left"> <div id="toprightt"> </div> <div id="topright2">
<table border="0" cellspacing="0" cellpadding="0" width="600">
	<tr>
		<td width="50"><img src="../../images/spacer.gif" width="50" /></td>
		<td valign="top">
		<%
		//-----------------------------------------------------
		%> <%
 //DYNAMIC PAGE HERE BELOW!!!!
 %>
		<%
				if (request.getParameter("urun") == null) {
				DB d = new DB(true);
				int count = 0;
				ResultSet rs = d
				.executeQuery("call AktarilmamisUrunleriAl_sp()");
		%>
		<form id="urunSec" name="urun" method="post" action="StokGiris.jsp">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="requestTable">
			<tr class="tableHeader">
				<td class="requestTableHeaderCell"><div align="center"><strong> </strong></div></td>
				<td class="requestTableHeaderCell"><div align="center"><strong> Ürün İsmi </strong></div></td>
				<td class="requestTableHeaderCell"><div align="center"><strong> Grup Adi </strong></div></td>
				<td class="requestTableHeaderCell"><div align="center"><strong>Miktar </strong></div></td>
				<td class="requestTableHeaderCell"><div align="center"><strong>Fatura No</strong></div></td>
				<td class="requestTableHeaderCell"><div align="center"><strong>Fatura Tarihi </strong></div></td>
			</tr>
			<%
						while (rs.next()) {
						count++;
						if (count % 2 == 1)
						{
			%>
			<tr class="oddRow">
				<td class="requestTableCell"><input type="checkbox" name="urun"
					value="<%=rs.getString("IstekFisiNo")%>"></input></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("UrunAdi")%></div></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("GrupAdi")%></div></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("Miktar")%></div></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("FaturaNo")%></div></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("FaturaTarihi")%></div></td>
				<input type="hidden" name="urunNo" value="<%=rs.getString("urunNo")%>" />
				<input type="hidden" name="Miktar" value="<%=rs.getString("Miktar")%>" />
				<input type="hidden" name="urun2" value="<%=rs.getString("IstekFisiNo")%>" />
			</tr>
			<%
						}
						else
						{
			%>
			<tr class="evenRow">
				<td class="requestTableCell"><input type="checkbox" name="urun"
					value="<%=rs.getString("IstekFisiNo")%>"></input></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("UrunAdi")%></div></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("GrupAdi")%></div></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("Miktar")%></div></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("FaturaNo")%></div></td>
				<td class="requestTableCell"><div align="center"><%=rs.getString("FaturaTarihi")%></div></td>
				<input type="hidden" name="urunNo" value="<%=rs.getString("urunNo")%>" />
				<input type="hidden" name="Miktar" value="<%=rs.getString("Miktar")%>" />
				<input type="hidden" name="urun2" value="<%=rs.getString("IstekFisiNo")%>" />
			</tr>
			<%
						}
			}
			%>


		</table>

		<%
		if (count != 0) {
		%>
		<table class="requestTable" cellpadding="0" cellspacing="0">
			<tr>
				<td class="generalFormCell_Input"><input name="gonder" type="image" id="gonder"
					value="Gönder" src="../../index/images/ekle.jpg" tabindex="8" /></td>
			</tr>
		</table>
		<%
		}
		%>
		</form>


		<%
			d.closeConnection();
			} else {
				String[] urunNos = request.getParameterValues("urunNo");
				String[] miktars = request.getParameterValues("Miktar");
				String[] values2 = request.getParameterValues("urun2");
				String[] values = request.getParameterValues("urun");
				if (values == null) {
		%>
		
	<tr>
		<td><strong>Aktarılacak Urun Bulunamadı.</strong></td>
	</tr>
	<%
				response.sendRedirect("StokGiris.jsp");
				return;
			}
			if (values.length == 0) {
	%>
	<tr>
		<td><strong>Aktarılacak Urun Bulunamadı.</strong></td>
	</tr>
	<%
				response.sendRedirect("StokGiris.jsp");
				return;
			} else {
				DB e = new DB(true);
				for (int i = 0; i < values2.length; i++) {					
					for (int j = 0; j < values.length; j++)
					{
						if (values[j].equals(values2[i]))					
						{
							e.executeSP("AktarilmamisUrunuAktar_sp",
								new Object[] { values[j] });
							e.executeSP("AddStockGD_sp", new Object[] { urunNos[i],
								miktars[i] });
							e.executeSP("UrunAktarildi_sp",
								new Object[] { values[j] });
						}
					}
				}
				e.closeConnection();
	%>
	<tr>
		<td><strong>Ürünler Genel Depo'ya Aktarıldı</strong></td>
	</tr>
	<%
			}
		}

		//DYNAMIC PAGE HERE ABOVE!!!!
	%>
	<%
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




