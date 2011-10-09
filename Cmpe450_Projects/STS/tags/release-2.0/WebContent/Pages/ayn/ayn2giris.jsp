<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Onay Bekleyen Muayene Raporlari</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<%
User userInfo = (User)(session.getAttribute("userClass"));
String userID = userInfo.getUserid();

//türkçe karakter çözümü
request.setCharacterEncoding("UTF-8");

String ayn2Kodu = "../ayn/ayn2.jsp";
String aynGrupNo = "000003-GRP";

if(request.getParameter("IstekFisiNo") != null) {
    //herhangi bir istek secildi.
	session.setAttribute("requestFormID", (String)request.getParameter("IstekFisiNo"));
	response.sendRedirect("../ayn/ayn2.jsp");
	return;
}
%>
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
		
    <form action="ayn2giris.jsp" method="post">
		 <table bgcolor="#FFFFFF" width="420" border="2" bordercolor="#CCCCFF" cellspacing="0" cellpadding="0" class="tablefont3">
           		<tr>
	   				<td colspan="4"><font size="2">Onay Bekleyen Muayene Raporlar&#305; </font></td>
           		</tr>     
		  		<tr>
		  		    <td>&nbsp</td>
   					<td>İstek Tarihi</td>
   					<td>İsteyen</td>
   					<td>&nbsp</td>
                </tr>
		        <%
		        DB dbcon = new DB(true);
				//kullanıcının üzerindeki tüm fişleri çek
				ResultSet fisBilgileri = dbcon.executeSP("SayfaVeGrubunIstekFisiniGoster_sp",
						new Object[]{ayn2Kodu, aynGrupNo}).getResult();
		        //bu bool, hem ilk fişin seçili gelmesini hem de listenin boş olup olmadığını anlamamızı saglayacak
		        boolean first = true;
		        //ayrıca kullanıcımız ayniyat saymanı ise, reddedilmiş fişleri de göstereceğiz
  		        boolean sayman = false;
		        ResultSet saymanBilgileri = dbcon.executeSP("PozisyonaGoreKullaniciGoster_sp", 
		        		new Object[]{"Ayniyat Saymani"}).getResult();
		        if(saymanBilgileri.next())
		        	sayman = saymanBilgileri.getString("KullaniciNo").equals(userID);
		        
		        //her bir fiş için
				while(fisBilgileri.next()) {
					//söz konusu fiş
					String istekFisiNo = fisBilgileri.getString("IstekFisiNo");
					//ile ilgili ayniyat bilgilerini çek
					ResultSet ayniyatBilgileri = dbcon.executeSP("AyniyatBilgileriGoster_sp",
							new Object[]{istekFisiNo}).getResult();
					//böyle bir bilgi varsa
					if(ayniyatBilgileri.next()) {
						boolean dortKisi = !ayniyatBilgileri.getString("ButceTipi").equals("bilimsel");
						//bu bilgilere bakıp bu kullanıcının imzasının gerekip gerekmediğine bak
						if(  (ayniyatBilgileri.getString("Uye1No").equals(userID) && ayniyatBilgileri.getString("Uye1Imzaladi").equals("0"))
						||   (ayniyatBilgileri.getString("Uye2No").equals(userID) && ayniyatBilgileri.getString("Uye2Imzaladi").equals("0"))
						||   (ayniyatBilgileri.getString("Uye3No").equals(userID) && ayniyatBilgileri.getString("Uye3Imzaladi").equals("0"))
						||   (dortKisi
								&& (ayniyatBilgileri.getString("Uye4No").equals(userID) && ayniyatBilgileri.getString("Uye4Imzaladi").equals("0")))  ) {
							//bu fişi goster
							%> <tr> <%
							if(first) {
								first = false;
								%> <td><input type="radio" name="IstekFisiNo" value="<%=istekFisiNo%>" checked></td> <% 
							} else {
								%> <td><input type="radio" name="IstekFisiNo" value="<%=istekFisiNo%>"></td> <%
							}
							%>
							<td><%=ayniyatBilgileri.getString("PusulaDuzenlemeTarihi")%></td>				        	
				        	<td><%=fisBilgileri.getString("Isteyen")%></td>
				        	<td>&nbsp;</td>
					        </tr>
							<%
						}
						//bir fiş daha önce reddedildiği için de gösterilebilir
						boolean red1 = ayniyatBilgileri.getString("Uye1Imzaladi").equals("2");
						boolean red2 = ayniyatBilgileri.getString("Uye2Imzaladi").equals("2");
						boolean red3 = ayniyatBilgileri.getString("Uye3Imzaladi").equals("2");
						boolean red4 = ayniyatBilgileri.getString("Uye4Imzaladi").equals("2");
						if(sayman && (red1 || red2 || red3 || (dortKisi && red4))) {
							//bu fişi goster
							%> <tr> <%
							if(first) {
								first = false;
								%> <td><input type="radio" name="IstekFisiNo" value="<%=istekFisiNo%>" checked></td> <% 
							} else {
								%> <td><input type="radio" name="IstekFisiNo" value="<%=istekFisiNo%>"></td> <%
							}
							%>
							<td><%=ayniyatBilgileri.getString("PusulaDuzenlemeTarihi")%></td>				        	
				        	<td><%=fisBilgileri.getString("Isteyen")%></td>
				        	<td>REDDEDİLMİŞ!</td>
					        </tr>
							<%
						}
					}
				}
		        
		        //eğer hiç fiş çıkmamışsa
		        if(first) {	//first hala true olacak
		        	%><tr><td colspan=4>Sistemde onay bekleyen Muayene Raporu bulunmamaktad&#305;r.</td></tr><%
		        } %>
	    </table>

		<% 
		if(!first) {	//eğer fiş varsa..
			%><input type="submit" value="Detay Göster"><%
		}
		%>
</form>
<% dbcon.closeConnection(); %>
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50"></td>
  </tr>
</table>
</div>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color:black>Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div></div>
</body>
</html>

