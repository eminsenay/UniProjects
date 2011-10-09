<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="bts.cmpe.budget.dal.transfer.*"%>
<%@ page import="bts.cmpe.budget.businessObj.*"%>
<%@ page import="global.InputChecker"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String kurumsal = null;
	String fonksiyonel = null;
	String ekonomik = null;

	String inputCheck = (String) request.getSession().getAttribute(
			"inputcheck");
	String insert = (String) request.getSession().getAttribute(
			"inserted");

	try {
		if (inputCheck.compareTo("1") == 0) {
%>

<p>Girdi hatasi</p>

<%
		}
	} catch (Exception e) {

		if (request.getAttribute("kurumsal") != null) {
			kurumsal = request.getAttribute("kurumsal").toString();
		}
		if (request.getAttribute("fonksiyonel") != null) {
			fonksiyonel = request.getAttribute("fonksiyonel").toString();
		}
		if (request.getAttribute("ekonomik") != null) {
			ekonomik = request.getAttribute("ekonomik").toString();
		}

		if (kurumsal == null || fonksiyonel == null || ekonomik == null) {
%>
<div id="Layer1"
	style="position:absolute; left:33px; top:233px; width:548px; height:35px; z-index:1">
<table width="100%" border="0">
	<tr>
		<form name="kurumsal" method="get" action="">
		<td>38.08.</td>
		<td width="35%">
			<input type="text" name="kurumsal " value=<%= kurumsal %>>
		</td>
		<td width="35%">
			<input type="text" name="fonksiyonel" value=<%=fonksiyonel %>>
		</td>
		<td width="10%">&nbsp;</td>
		<td width="35%">
			<input type="text" name="ekonomik" value=<%= ekonomik %>>
		</td>
		<td>
			<input type="submit" name="Submit" value="EKLE">
		</td>
	</tr>
</table>
</div>
<div id="Layer2"
	style="position:absolute; left:616px; top:236px; width:62px; height:39px; z-index:2">
<form name="form1" method="post" action=""></form>
</div>
<div id="Layer3"
	style="position:absolute; left:473px; top:205px; width:69px; height:22px; z-index:3">Ekonomik</div>
<div id="Layer4"
	style="position:absolute; left:85px; top:205px; width:63px; height:22px; z-index:4">Kurumsal</div>
<div id="Layer5"
	style="position:absolute; left:262px; top:205px; width:82px; height:22px; z-index:5">Fonksiyonel</div>
<div id="Layer6"
	style="position:absolute; left:99px; top:369px; width:706px; height:236px; z-index:6"><img
	src="tree.jpg" width="723" height="407"></div>
<div id="Layer7"
	style="position:absolute; left:82px; top:344px; width:125px; height:25px; z-index:7">Varolan
Birimler</div>
<div id="Layer8"
	style="position:absolute; left:35px; top:2px; width:690px; height:87px; z-index:8"><img
	src="header.gif" width="700" height="100"></div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<%
		try {
		if (insert.compareTo("1") == 0) {
%>
<p>Birim eklendi</p>
<%
			}
			} catch (Exception ex) {
		//hic bir sey yapma...
			}
		}

		else {
			//TODO: bu kisimdaki bir departman tipine tekabul ediyor o duzeltilecek.
			DepartmentTO dept = new DepartmentTO(kurumsal, fonksiyonel,
			ekonomik, 1);

			boolean inputcheck1 = false;
			boolean inputcheck2 = false;
			boolean inputcheck3 = false;

			InputChecker inputcheck = new InputChecker();
			inputcheck1 = inputcheck.checkString(kurumsal);
			inputcheck2 = inputcheck.checkString(fonksiyonel);
			inputcheck3 = inputcheck.checkString(ekonomik);

			if (inputcheck1 == false || inputcheck2 == false
			|| inputcheck3 == false) {
				// TODO: abi burda hangi fieldin hatali oldugu bilgisi de bi sonraki
				// sayfaya aktar lutfen.
		//yeniden ayni sayfayi ac en basa hata mesaji koy
		session.setAttribute("inputcheck", "1");
		response.sendRedirect("idaribirimekle.jsp");
			} else {

		try {
			out.println("<!--ekle kismindayiz-->");
			DepartmentBusinessObj busobj = new DepartmentBusinessObj();
			busobj.insertDepartment(dept);
			session.setAttribute("inserted", "1");
			response.sendRedirect("idaribirimekle.jsp");
		} catch (Exception exx) {
			session.setAttribute("msg", exx);
			response.sendRedirect("error.jsp");
		}
			}
		}
	}//catch

	//Input Check
	//dogru ise insert
	//yanlis ise ekrana hata mesaji
%>
</body>
</html>
