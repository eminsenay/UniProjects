<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="	java.util.Vector, 
					bts.cmpe.budget.businessObj.TransferBusinessObj, 
					bts.cmpe.budget.transfer.TransferTO,
					bts.cmpe.budget.transfer.BudgetTO, 
					global.InputChecker" %>
<jsp:directive.page import="bts.cmpe.budget.businessObj.ExpenseBusinessObj"/>

<%@ page import="java.util.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="system.*"%>	
<%@ page import="bts.cmpe.budget.businessObj.*"%>
<%@ page import="bts.cmpe.budget.transfer.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
		<link href="css/gui.css" rel="stylesheet" type="text/css" />
	</head>
	
	<STYLE type=text/css>
.style9 {
	FONT-WEIGHT: bold; FONT-SIZE: x-small
}
.style11 {
	FONT-SIZE: small
}
BODY {
	BACKGROUND-COLOR: #ffffff
}
.style13 {
	FONT-SIZE: 12px
}
.style14 {
	FONT-WEIGHT: bold; FONT-SIZE: 12px
}
A:link {
	TEXT-DECORATION: none
}
A:visited {
	TEXT-DECORATION: none
}
A:hover {
	TEXT-DECORATION: none
}
A:active {
	TEXT-DECORATION: none
}
.style15 {
	COLOR: #cc3333
}
.style16 {
	COLOR: #009900
}
.style17 {font-weight: bold}
.style18 {
	font-size: 9px;
	font-weight: bold;
}
</STYLE>
	

	<body bgcolor="#FFFFFF">
		<div align="left">
			<div id="toprightt"></div>
			<div id="topright2">
				<table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
			  		<tr>
			  			<td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350" /></td>
						<td valign="top">
						<h1>Bütçe Kaydı Düzenleme</h1><br /><br />
		
<%//-----------------------------------------------------%>	
<%//DYNAMIC PAGE HERE BELOW!!!!%>
<%
final String ACTION = "action";
final String INVENTORY_INDEX = "inventoryIndex";
final String REQUEST_DATE = "requestDate";
final String REQUEST_AMOUNT = "requestAmount";
final String MATERIAL_TYPE = "materialType";
final String UNIT = "unit";
final String ECONOMIC_CODE = "ecoCode";
final String REALIZATION_ID = "realizationId";
final String REALIZATION_AMOUNT = "realizationAmount";
final String TO_WHOM = "toWhom";
final String REALIZATION_DATE = "realizationDate";
final String SELFPAGE = "normalBudgetUpdate.jsp";

final String INST_CODE = "inst";
final String FUNC_CODE = "func";
final String ECO_CODE = "eco";

String kurumsal = request.getParameter(INST_CODE);
String fonksiyonel = request.getParameter(FUNC_CODE);
String ekonomik = request.getParameter(ECO_CODE);

String requestDateStr = request.getParameter(REQUEST_DATE); // istek tarihi.
String realizationIdStr = request.getParameter(REALIZATION_ID); // tahakkuk no
String requestAmountStr = request.getParameter(REQUEST_AMOUNT); // istek tutarı tam kısım.
String materialTypeStr = request.getParameter(MATERIAL_TYPE); // malzeme cinsi
String unitStr = request.getParameter(UNIT); // birimi
String ecoCodeStr = request.getParameter(ECONOMIC_CODE); // ekonomik kodu
String realizationAmountStr = request.getParameter(REALIZATION_AMOUNT); // tahakkuk tutarı tam kısım
String toWhomStr = request.getParameter(TO_WHOM); // Kime Tahakkuk Ettiği veya Ödendiği
String realizationDateStr = request.getParameter(REALIZATION_DATE); // tahakkuk tarihi
String inventoryIndexStr = request.getParameter(INVENTORY_INDEX); // defter sira no?

String actionStr = request.getParameter(ACTION); // action


int defterSiraInt = Integer.parseInt(inventoryIndexStr);

if(actionStr == null) {
	
}
else if(actionStr.compareTo("do") == 0)
{
	ExpenseBusinessObj expenseBO = new ExpenseBusinessObj();
	
	BudgetTO budgetTO = new BudgetTO(kurumsal,fonksiyonel,ekonomik);
	ExpenseStdTO expense = new ExpenseStdTO();
	
	expense.setInventoryNo(defterSiraInt);
	
	expense.setRealizationAmount(Double.parseDouble(realizationAmountStr));
				
	expense.setRealizationDate(Date.valueOf(realizationDateStr));
	
	expense.setRealizationId(Integer.parseInt(realizationIdStr));
	
	expense.setToWhom(toWhomStr);
	
	expenseBO.updateStdExpenditure(budgetTO, expense);
	if(expense.getStatus() != ExpenseBaseTO.ACTIVE) {
		expenseBO.approveExpenditure(budgetTO, defterSiraInt);
	}
	
	response.sendRedirect("nonAcedemicNormalBudget.jsp?" + INST_CODE + "=" + kurumsal
													+ "&" + FUNC_CODE + "=" + fonksiyonel
													+ "&" + ECO_CODE + "=" + ekonomik);
	return;
}


%>
<form name="confirmTransfer" action="<%=SELFPAGE %>" method="get">
<TABLE borderColor=#ffffff height=142 width="450" bgColor=#ffffff border=0>
  <TBODY>
  <TR borderColor=#000000>
    <TD borderColor=#999999 width=60 bgColor=#cccccc height=37>
      <DIV class=style11 align=center><STRONG>Defter Sıra No 
      </STRONG>&nbsp;</DIV></TD>
      <TD borderColor=#999999 width=60 bgColor=#cccccc height=37>
      <DIV class=style11 align=center><STRONG><%=inventoryIndexStr %> 
      </STRONG>&nbsp;</DIV></TD>
      </TR><TR>
    <TD borderColor=#999999 width=62 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>İstek F. Tarihi 
      </STRONG>&nbsp;</DIV></TD>
     <TD borderColor=#999999 width=62 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG><%=requestDateStr %>
      </STRONG>&nbsp;</DIV></TD>
      </TR><TR>
    <TD borderColor=#999999 width=72 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>İstek F. 
      Tutarı</STRONG>&nbsp;</DIV></TD>
       <TD borderColor=#999999 width=72 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG><%=requestAmountStr %></STRONG>&nbsp;</DIV></TD>
      </TR><TR>
    <TD borderColor=#999999 width=82 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>Ekonomik Kodu 
    </STRONG>&nbsp;</DIV></TD>
     <TD borderColor=#999999 width=82 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG><%=ecoCodeStr %> 
    </STRONG>&nbsp;</DIV></TD>
      </TR><TR>
    <TD borderColor=#999999 width=111 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>Malzemenin Cinsi 
      </STRONG>&nbsp;</DIV></TD>
         <TD borderColor=#999999 width=111 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG><%=materialTypeStr %> 
      </STRONG>&nbsp;</DIV></TD>
      </TR><TR>
    <TD borderColor=#999999 width=94 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>Birimi</STRONG>&nbsp;</DIV></TD>
         <TD borderColor=#999999 width=94 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG><%=unitStr %></STRONG>&nbsp;</DIV></TD>
      </TR><TR>
    <TD borderColor=#999999 width=98 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>Kime Tahakkuk Ettiği veya Ödendiği 
      </STRONG>&nbsp;</DIV></TD>
         <TD borderColor=#999999 width=98 bgColor=#cccccc>
      <DIV class=style11 align=center>
      <input class="inputCell" name="<%=TO_WHOM %>" type="text" value="<%=toWhomStr %>" />
</DIV></TD>
      </TR><TR>
    <TD borderColor=#999999 width=85 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>Tahakkuk No 
    </STRONG>&nbsp;</DIV></TD>
        <TD borderColor=#999999 width=85 bgColor=#cccccc>
      <DIV class=style11 align=center><input class="inputCell" name="<%=REALIZATION_ID %>" type="text" value="<%=realizationIdStr %>" /></DIV></TD>
    
      </TR><TR>
    <TD borderColor=#999999 width=82 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>Tahakkuk Tarihi 
      </STRONG>&nbsp;</DIV></TD>
         <TD borderColor=#999999 width=82 bgColor=#cccccc>
      <DIV class=style11 align=center>
<input class="inputCell" name="<%=REALIZATION_DATE %>" type="text" value="<%=realizationDateStr %>" />
</DIV></TD>
      </TR><TR>
    <TD borderColor=#999999 width=77 bgColor=#cccccc>
      <DIV class=style11 align=center><STRONG>Tahakkuk Tutarı 
      </STRONG>&nbsp;</DIV></TD>
      <TD borderColor=#999999 width=77 bgColor=#cccccc>
      <DIV class=style11 align=center>
<input class="inputCell" name="<%=REALIZATION_AMOUNT %>" type="text" value="<%=realizationAmountStr %>" />
</DIV></TD>
  </TR>
<tr><td><br /><input class="mybutton" type="submit" value="Güncelle" /></td></tr>
  <input type="hidden" name="<%=INST_CODE %>" value="<%=kurumsal %>" />
  <input type="hidden" name="<%=FUNC_CODE %>" value="<%=fonksiyonel %>" />
  <input type="hidden" name="<%=ECO_CODE %>" value="<%=ekonomik %>" />
  <input type="hidden" name="<%=INVENTORY_INDEX %>" value="<%=inventoryIndexStr %>" />
  <input type="hidden" name="<%=ACTION %>" value="do" />

</TBODY></TABLE></form>

<%//DYNAMIC PAGE HERE ABOVE!!!!%>
<%//-----------------------------------------------------%>
		
						</td>
			  		</tr>
			    	<tr>
			    		<td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50" /></td>
			    		<td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50" /></td>
			  		</tr>
				</table>
			</div>
	
			<div id="footer3">	  
			</div>
		</div>
	</body>
</html>
