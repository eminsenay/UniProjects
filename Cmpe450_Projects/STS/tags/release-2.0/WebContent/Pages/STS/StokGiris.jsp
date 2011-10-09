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
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
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
		<%if(request.getParameter("gonder") == null){
			DB d = new DB(true);
			int count = 0;
			ResultSet rs = d.executeQuery("call AktarilmamisUrunleriAl_sp()");
		%>
		<form id="urunSec" name="urun" method="post" action="StokGiris.jsp">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><div align="center"><strong>          </strong></div></td>
				<td><div align="center"><strong> Ürün İsmi </strong></div></td>
				<td><div align="center"><strong> Grup Adi </strong></div></td>
				<td><div align="center"><strong>Miktar </strong></div></td>
				<td><div align="center"><strong>Fatura No</strong></div></td>
				<td><div align="center"><strong>Fatura Tarihi </strong></div></td>
			</tr>
		<%	while (rs.next()) {
			count++;
			%>
			<tr>
				<td><input type="checkbox" name="urun" value="<%=rs.getString("IstekFisiNo")%>"></input></td>
				<td><div align="center"><%=rs.getString("UrunAdi")%></div></td>
				<td><div align="center"><%=rs.getString("GrupAdi")%></div></td>
				<td><div align="center"><%=rs.getString("Miktar")%></div></td>
				<td><div align="center"><%=rs.getString("FaturaNo")%></div></td>
				<td><div align="center"><%=rs.getString("FaturaTarihi")%></div></td>
			</tr>
			<%
			}
			%>
			

		</table>

		<%if(count != 0){%>
		<table>
		<tr><td><input name="gonder" type="submit" id="gonder" value="Gönder"> </td></tr>
		</table>
		<%}%>
		</form>


        <%
        	d.closeConnection();
		}
		else{
			String[] values = request.getParameterValues("urun");
			if(values == null){
				%><tr><td><strong>Aktarılacak Urun Bulunamadı.</strong></td></tr><%
				response.sendRedirect("StokGiris.jsp");
				return;
			}
			if(values.length==0){
				%><tr><td><strong>Aktarılacak Urun Bulunamadı.</strong></td></tr><%
				response.sendRedirect("StokGiris.jsp");
				return;
			}
			else{
				DB e = new DB(true);
				for(int i = 0; i < values.length; i++){
					e.executeSP("AktarilmamisUrunuAktar_sp", new Object[]{ values[i]});
					e.executeSP("UrunAktarildi_sp",new  Object[]{ values[i]});
					
				}
				e.closeConnection();
				%><tr><td><strong>Urunler Aktarıldı</strong></td></tr><%
				response.sendRedirect("StokGiris.jsp");
				return;
			}
		}
			
		//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
		
		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50"></td>
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
</html>




