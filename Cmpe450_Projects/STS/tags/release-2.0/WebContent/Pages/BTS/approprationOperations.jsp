<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="bts.cmpe.budget.businessObj.*"%>
<%@ page import="bts.cmpe.budget.transfer.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="global.InputChecker"%>
<%@page import="java.sql.Date"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
<%
final String mainPage = "loginned.jsp";
final String selfPage = "approprationOperations.jsp";
final String errorPage = "error.jsp";

final String INST_CODE = "inst";
final String FUNC_CODE = "func";
final String ECO_CODE = "eco";

final String ACTION = "action";
final String TYPE = "type";
final String PERIOD = "period";
final String AMOUNT = "amount";
final String DESCRIPTION = "desc";



String instStr = request.getParameter(INST_CODE);
String funcStr = request.getParameter(FUNC_CODE);
String ecoStr = request.getParameter(ECO_CODE);

if (( instStr == null) || (funcStr == null) || (ecoStr == null)){
	//response.sendRedirect(mainPage);
	return;
} 

//current budget object.
BudgetTO currentBudget = null;
try{
	currentBudget = new BudgetTO( instStr, funcStr, ecoStr );
} catch( Exception ex ) {
	session.setAttribute("errorMessage", ex.getMessage());
	response.sendRedirect(errorPage);
	return;
}
String action = request.getParameter(ACTION);

// default values of the fields
int type = AppropriationTO.MONTH_3;
int period = 1;
double amount = 0;
String desc = "";



if(action == null){

} 
else if(action.compareTo("add") == 0){
	
	String typeStr   = request.getParameter(TYPE);
	String periodStr = request.getParameter(PERIOD);
	String amountStr = request.getParameter(AMOUNT);
	String descStr   = request.getParameter(DESCRIPTION);
	
	boolean isInputCorrect = true;
	// check input: type
	if( InputChecker.checkInt(typeStr) ) {
		type = Integer.parseInt(periodStr);
	}
	else {
		out.println("*Ödenek tipi alanı kısmını lütfen düzeltiniz.");
		isInputCorrect = false;
	}
	
	if( InputChecker.checkInt(periodStr) ) {
		period = Integer.parseInt(periodStr);
	}
	else {
		out.println("*Periyod alanı kısmını lütfen düzeltiniz.");
		isInputCorrect = false;
	}
	// cehck input: amount
	if(InputChecker.checkDouble(amountStr) ) {
		amount = Double.parseDouble(amountStr);
	}
	else {
		out.println("*Miktar alanı kısmını lütfen düzeltiniz.");
		isInputCorrect = false;
	}
	// check input: description
	if(InputChecker.checkString(descStr)){
		desc = descStr;
	}
	else {
		out.println("*Açıklama alanı kısmını lütfen düzeltiniz.");
		isInputCorrect = false;
	}
	if(isInputCorrect) {
		Date today = new Date(System.currentTimeMillis());
		try{
			AppropriationBusinessObj appropBO = new AppropriationBusinessObj();
			AppropriationTO appropTO = new AppropriationTO(period, amount, today, type);
			appropBO.insertAppropriation(currentBudget, appropTO);
			out.println("Başarı ile eklendi.");
		}
		catch(Exception ex) {
			session.setAttribute("errorMessage", ex.getMessage());
			response.sendRedirect(errorPage);
			return;
		}
	}
}
%>

		
<form method="get" action="<%=selfPage %>">
  <input type="hidden" name="<%=ACTION %>" value="add"/>
  <input type="hidden" name="<%=INST_CODE %>" value="<%=instStr %>"/>
  <input type="hidden" name="<%=FUNC_CODE %>" value="<%=funcStr %>"/>
  <input type="hidden" name="<%=ECO_CODE %>" value="<%=ecoStr %>"/>
  
  <table width="294" border="1">
  	<tr>
		<td width="85"><strong>Tip:</strong></td>
		<td width="193" align="left">
			<select name="<%=TYPE %>">
				<option value="<%=AppropriationTO.MONTH_3 %>">3 aylık</option>
				<option value="<%=AppropriationTO.MONTH_6 %>">6 aylık</option>
				<option value="<%=AppropriationTO.ADDITIONAL %>">ek</option>
			</select>
		</td>
    </tr>
    <tr>
		<td width="85"><strong>Dönem:</strong></td>
		<td width="193" align="left">
			<select name="<%=PERIOD %>">
				<option value="1">1.</option>
				<option value="2">2.</option>
				<option value="3">3.</option>
				<option value="4">4.</option>
			</select>
		</td>
    </tr>
    <tr>
      <td><strong>Miktar:</strong></td>
      <td><input type="text" name="<%=AMOUNT %>" value="<%=amount %>"/></td>
    </tr>
    <tr>
      <td><strong>Açıklama:</strong></td>
      <td><textarea name="<%=DESCRIPTION %>"><%=desc %></textarea></td>
    </tr>
  </table>
  <input type="submit" value="ekle" />
</form>		

        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
		
		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../images/spacer.gif" width="50" height="50"></td>
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




