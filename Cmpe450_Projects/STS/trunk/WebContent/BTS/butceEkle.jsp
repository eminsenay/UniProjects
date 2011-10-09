<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="bts.cmpe.budget.businessObj.BudgetBusinessObj"%>
<%@page import="bts.cmpe.budget.dal.transfer.DepartmentTO"%>
<%@page import="global.InputChecker"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	// page mode
	String mode = request.getParameter("mode");

	String inst = request.getParameter("inst");
	String func = request.getParameter("func");
	String eco = request.getParameter("eco");
	String expenditureType = request.getParameter("expenditureType");
	String period = request.getParameter("period");

	String selfPage = "ozanTest.jsp";
	String redirectPage = "ozanTest.jsp?inst=" + inst + "&func=" + func
	+ "&eco=" + eco + "&expenditureType=" + expenditureType + "&period="
	+ period;
	String errorPage = "error.jsp";
	if (mode == null) {
		// normal
	}

	else if (mode.compareTo("insert") == 0) {
		// input check block
		if (!InputChecker.checkString(inst)) {
	response.sendRedirect(redirectPage
	+ "&mode=error&field=kurumsal");
		}

		if (!InputChecker.checkString(func)) {
	response.sendRedirect(redirectPage
	+ "&mode=error&field=fonksiyonel");
		}

		if (!InputChecker.checkString(eco)) {
	response.sendRedirect(redirectPage
	+ "&mode=error&field=ekonomik");
		}

		if (!InputChecker.checkInt(expenditureType)) {
	response.sendRedirect(redirectPage
	+ "&mode=error&field=bütçe tipi");
		}

		if (!InputChecker.checkInt(period)) {
	response.sendRedirect(redirectPage
	+ "&mode=error&field=periyot büyüklüğü");
		} else if (Integer.parseInt(period) != 3
		& Integer.parseInt(period) != 6) {
	response.sendRedirect(redirectPage
	+ "&mode=error&field=periyot büyüklüğü");
		}

		DepartmentTO dept = new DepartmentTO(inst, func, eco, Integer
		.parseInt(expenditureType), 12 / Integer.parseInt(period));

		// insertion block
		try {
	BudgetBusinessObj bussObj = new BudgetBusinessObj();
	bussObj.insertDepartment(dept);
	out.println("sisteme başarı ile kaydedildi.");
		} catch (Exception ex) {
	session.setAttribute("errorMessage", ex.getMessage());
	response.sendRedirect(errorPage);
		}
	} else if (mode.compareTo("error") == 0) {
%>

<p><%=request.getParameter("field")%> kutucuğunun değerini lütfen düzeltiniz</p>
<%	} %>
<form name="bütçe" action=<%=selfPage %> method="get">
	<input type="hidden" name="mode" value="insert">
	<table cellpadding="1" cellspacing="1">
		<tr>
			<td>kurumsal kod:</td>
			<td>
				<input type="text" name="inst"> 
			</td>
		</tr>
		<tr>
			<td>foksiyonel kod:</td>
			<td>
				<input type="text" name="func"> 
			</td>
		</tr>
		<tr>
			<td>Ekonomik kod:<td>
				<input type="text" name="eco"> 
			</td>
		</tr>
		<tr>
			<td>Harcama tipi:</td>
			<td>
				<select name="expenditureType">
				<option value="1">Normal</option>
				<option value="2">Maaş</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Bütçe tipi:</td>
			<td>	
				<select name="period">
				<option value="3">3 aylık</option>
				<option value="6">6 aylık</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><input type ="submit" value ="ekle"></td>
		</tr>
</table>
</form>
</body>
</html>
