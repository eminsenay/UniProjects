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


<table border="0" cellspacing="0" cellpadding="0" width="600"">


	<tr>
		<td width="50"><img src="../../images/spacer.gif"
			width="50"></td>
		<td valign="top">
		<%
			User userInfo = (User) (session.getAttribute("userClass"));
			
			/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
			
			boolean dekan = false;
			if (userInfo.positionID.equals("000005-POS"))
				dekan = true;

			if (!dekan) {
				session.setAttribute("error", "Bu sayfayı görme hakkınız yok.");
				response.sendRedirect("../../alerts/GeneralAlert.jsp");
			} else {
				StockManagement sm = new StockManagement();
				
				ArrayList depInfo = new ArrayList();
				// depInfo nun ilk elemani grupAdi, digeri GrupNo
				String	grupNo = userInfo.getgroupID();
				depInfo = sm.getDepForDekan(grupNo);
		%>

		<form id="dekanMi" name="dekanMi" method="post" action="DepoGoster.jsp">
		<table width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2" class="generalFormCell">Lütfen stok bilgilerine bakmak istediğiniz
				bölümü veya birimi seçiniz...</td>
			</tr>
			<tr>
				<td colspan="2" class="generalFormCell">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" align="left" class="generalFormCell"><b>Bölüm:</b></td>
			</tr>
			<tr>
				<td class="generalFormCell_Input">

						<select name="dekanMi" id="generalFormTextBox" class="generalComboBox">
					<%
							String depName;
							String grupNb;
							for (int i = 0; i < depInfo.size(); i++) {
								depName = (String)depInfo.get(i++);
								grupNb = (String)depInfo.get(i);
					%>
							<option value="<%=grupNb%>"><%=depName%></option>
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
				<td  class="generalFormCell">&nbsp;</td>
				<td  class="generalFormCell">&nbsp;</td>
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
