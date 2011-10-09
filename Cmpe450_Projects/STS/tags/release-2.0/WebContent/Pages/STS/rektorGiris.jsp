<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*,system.*,sts.stockFollowUp.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>
Boğaziçi Üniversitesi Satın Alma Sistemi
</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<div align="left">
<div id="toprightt">
</div>
<div id="topright2">


<table border="0" cellspacing="0" cellpadding="0" width="600"
	height="500">


	<tr>
		<td width="50" height="350"><img src="../../images/spacer.gif"
			width="50" height="350"></td>
		<td valign="top">
		<%
			User userInfo = (User) (session.getAttribute("userClass"));

			/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
			/*Rektor yok DBde Rektor yardimcisina gore ayarladim simdilik */
			boolean RektorYrd = false;
			if (userInfo.positionID.equals("00000I-POS"))
				RektorYrd = true;

			if (!RektorYrd) {
				session.setAttribute("error", "Bu sayfayı görme hakkınız yok.");
				response.sendRedirect("../../alerts/GeneralAlert.jsp");
			} else {
				StockManagement sm = new StockManagement();
				ArrayList<String> depNames = new ArrayList<String>();
				depNames = sm.getDepNames();
		%>


		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2">Lütfen stok bilgilerine bakmak istediğiniz
				bölümü veya departmanı seçiniz...</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td width="50%" colspan="2" align="left"><b>Bölüm:</b></td>
			</tr>
			<tr>
				<td colspan="2">
				<form id="rektorMu" name="rektorMu" method="post"
					action="depoSorgu.jsp"><select name="rektorMu" id="rektorMu">
					<option value="Genel_Depo">Genel Depo</option>
					<%
							String depName;
							for (int i = 0; i < depNames.size(); i++) {
								depName = (String)depNames.get(i);
					%>
					<option value="<%=depName%>"><%=depName%></option>
					<%
						}
						}
					%>
				</select>
				</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<input type="submit" name="submit" value="Devam Et" />
					</td>
				</tr>
				</form>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td width="50" height="50"><img src="../../images/spacer.gif"
			width="50" height="50"></td>
		<td width="550" height="50"><img src="../../images/spacer.gif"
			width="550" height="50"></td>
	</tr>
</table>
</div>
<div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar
Mühendisliği &copy;2005</font></b></p>
</div>
</div>
</body>
</html>
