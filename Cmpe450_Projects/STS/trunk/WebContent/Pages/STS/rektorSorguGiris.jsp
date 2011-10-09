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
<link href="../../index/css/gui.css" rel="stylesheet" type="text/css">
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<div align="left">
<div id="toprightt">
</div>
<div id="topright2">


<table border="0" cellspacing="0" cellpadding="0" width="600">
	<tr>
		<td width="50"><img src="../../images/spacer.gif"
			width="50"></td>
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
				ArrayList<String> groupNoAndDepNames = new ArrayList<String>();
				groupNoAndDepNames = sm.getGroupNoAndDepNames();
		%>

		<form id="rektorMu" name="rektorMu" method="post" action="depoSorgu.jsp">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2" class="generalFormCell">Lütfen stok bilgilerine bakmak istediğiniz
				bölümü veya birimi seçiniz...</td>
			</tr>
			<tr>
				<td colspan="2" class="generalFormCell">&nbsp;</td>
			</tr>
			<tr>
				<td width="50%" colspan="2" align="left" class="generalFormCell"><b>Bölüm:</b></td>
			</tr>
			<tr>
				<td class="generalFormCell_Input">
				<select name="rektorMu" id="generalFormTextBox" class="generalComboBox">
					<option value="Genel_Depo">Genel Depo</option>
					<%
							String depName;
							String grupNo;
							for (int i = 0; i < groupNoAndDepNames.size(); i++) {
								grupNo = (String)groupNoAndDepNames.get(i++);
								depName = (String)groupNoAndDepNames.get(i);
								
					%>
					<option value="<%=grupNo%>"><%=depName%></option>
					<%
						}
						}
					%>
				</select>
				</td>
				<td align="center" class="generalFormCell_Input">
					<input type="image" name="submit" value="Devam Et" src="../../index/images/sec.jpg" tabindex="8"/>
				</td>
			</tr>				
			<tr>
				<td class="generalFormCell">&nbsp;</td>
				<td class="generalFormCell">&nbsp;</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
</table>
</div>
<div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar
Mühendisliği &copy;2006</font></b></p>
</div>
</div>
</body>
</html>
