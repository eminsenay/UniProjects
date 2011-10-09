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
.style19 {
	COLOR: blue
}
.style17 {font-weight: bold}
.style18 {
	font-size: 9px;
	font-weight: bold;
}
</STYLE>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
    <h1>Bütçe Görüntüleme - Standart Bütçe</h1><br /><br />
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
<%
final String ACTION = "action";
final String INVENTORY_INDEX = "inventoryIndex";
final String REQUEST_DATE = "requestDate";
final String REQUEST_AMOUNT = "requestAmount";
final String REQUEST_AMOUNT_FLOAT = "requestAmountFloat";
final String MATERIAL_TYPE = "materialType";
final String UNIT = "unit";
final String ECONOMIC_CODE = "ecoCode";
final String REALIZATION_ID = "realizationId";
final String REALIZATION_AMOUNT = "realizationAmount";
final String REALIZATION_AMOUNT_FLOAT = "realizationAmountFloat";
final String TO_WHOM = "toWhom";
final String REALIZATION_DATE = "realizationDate";

final String INST_CODE = "inst";
final String FUNC_CODE = "func";
final String ECO_CODE = "eco";

//final String SORT_TYPE = "sortType";
//final String IS_ASCENDING = "isAscending";


final String errorPage = "error.jsp";
final String mainPage = "loginned.jsp";
final String selfPage = "nonAcedemicNormalBudget.jsp";
final String wagePage = "nonAcedemicWagerBudget.jsp";
final String editExpensePage = "normalBudgetUpdate.jsp";

int recperpage=10;//records per page

ExpenseBusinessObj expenseBO = new ExpenseBusinessObj();
BudgetBusinessObj budgetBO = new BudgetBusinessObj();
AppropriationBusinessObj appropBO = new AppropriationBusinessObj();
TransferBusinessObj transferBO = new TransferBusinessObj();

String kurumsal = request.getParameter(INST_CODE);
String fonksiyonel = request.getParameter(FUNC_CODE);
String ekonomik = request.getParameter(ECO_CODE);

User userInfo = (User) (session.getAttribute("userClass"));
boolean editable = false;
if(userInfo.positionID.equals("00000D-POS") || userInfo.positionID.equals("00000E-POS")){
	editable = true;
}
//check for all the necessary parameters
if (!InputChecker.checkString(kurumsal) ||
	!InputChecker.checkString(fonksiyonel) ||
	!InputChecker.checkString(ekonomik)) {

CodeBusinessObj codeBO = new CodeBusinessObj();

Vector<CodeTO> codeInst = codeBO.getInstCode();
Vector<CodeTO> codeFunc = codeBO.getFuncCode();
Vector<CodeTO> codeEco = codeBO.getEcoCode();

		%>
	<form action="<%=selfPage %>" method="get">
	<table>
		<tr>
			<td>Kurumsal:</td>
			<td>
				<input class="inputCell" type="text" name="<%=INST_CODE %>">
			</td>
		</tr>
		<tr>
			<td>Fonksiyonel:</td>
			<td>
				<input class="inputCell" type="text" name="<%=FUNC_CODE %>">
			</td>
		</tr>
		<tr>
			<td>Ekonomik:</td>
			<td>
				<input class="inputCell" type="text" name="<%=ECO_CODE %>">
			</td>
		</tr>
		<tr>
			<td></td>	
			<td>
				<input class="mybutton" type="submit" value="Seç">
			</td>
		</tr>
	</table>
</form>
<br />
<br />
<form action="<%=selfPage %>" method="get">
	<table>
		<tr>
			<td>Kurumsal:</td>
			<td>
				<select class="inputCell" name="<%=INST_CODE %>">
				<% for(CodeTO c : codeInst) { %>
				<option value="<%=c.getValue() %>"><%=c.getName() %></option>
				<%} %>
				</select>
			</td>
		</tr>
		<tr>
			<td>Fonksiyonel:</td>
			<td>
				<select class="inputCell" name="<%=FUNC_CODE %>">
				<% for(CodeTO c : codeFunc) { %>
				<option value="<%=c.getValue() %>"><%=c.getName() %></option>
				<%} %>
				</select>
			</td>
		</tr>
		<tr>
			<td>Ekonomik:</td>
			<td>
				<select class="inputCell" name="<%=ECO_CODE %>">
				<% for(CodeTO c : codeEco) { %>
				<option value="<%=c.getValue() %>"><%=c.getName() %></option>
				<%} %>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>	
			<td>
				<input class="mybutton" type="submit" value="Seç" />
			</td>
		</tr>
	</table>
</form>
<%
		return;
	

}
//current budget object.
BudgetTO currentBudget = new BudgetTO( kurumsal, fonksiyonel, ekonomik );

try {
	budgetBO.getBudgetDetails(currentBudget);
} catch(Exception ex) {
	session.setAttribute("errorMessage", ex.getMessage());
	response.sendRedirect(errorPage);
	return;
}

if(currentBudget.getNumMainAppr() == 2)

if( currentBudget.getType() == BudgetTO.WAGER ) {
	response.sendRedirect(wagePage + "?" +
			INST_CODE + "=" + kurumsal + "&" +
			FUNC_CODE + "=" + fonksiyonel + "&" +
			ECO_CODE  + "=" + ekonomik);
	return;
}

// getting the vector of side budgets
Vector budgets = budgetBO.getEconomicCodes(currentBudget);


String action = (String) request.getParameter(ACTION);
if(action == null) {
	
}
else if( action.compareTo("addExpense") == 0) {

	String requestDateStr = request.getParameter(REQUEST_DATE); // istek tarihi
	String realizationIdStr = request.getParameter(REALIZATION_ID); // tahakkuk no
	String requestAmountStr = request.getParameter(REQUEST_AMOUNT); // istek tutarı tam kısım
	String requestAmountFloatStr = request.getParameter(REQUEST_AMOUNT_FLOAT); // istek tutarı ondalık kısım
	String materialTypeStr = request.getParameter(MATERIAL_TYPE); // malzeme cinsi
	String unitStr = request.getParameter(UNIT); // birimi
	String ecoCodeStr = request.getParameter(ECONOMIC_CODE); // ekonomik kodu
	String realizationAmountStr = request.getParameter(REALIZATION_AMOUNT); // tahakkuk tutarı tam kısım
	String realizationAmountFloatStr = request.getParameter(REALIZATION_AMOUNT_FLOAT); // tahakkuk tutarı ondalık kısım
	String toWhomStr = request.getParameter(TO_WHOM); // Kime Tahakkuk Ettiği veya Ödendiği
	String realizationDateStr = request.getParameter(REALIZATION_DATE); // tahakkuk tarihi

	if(! InputChecker.checkDate(requestDateStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz istek tarihi tarih formatında değil.</font><br>");		
	} 
	else if(! InputChecker.checkInt(realizationIdStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz tahakkuk no sayı formatında değil.</font><br>");		
	} 
	else if(! InputChecker.checkInt(requestAmountStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz istek tutarının tam sayı kısmı sayı formatında değil.</font><br>");
	} 
	else if(! InputChecker.checkInt(requestAmountFloatStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz istek tutarının ondalık kısmı sayı formatında değil.</font><br>");
	}
	else if(! InputChecker.checkString(materialTypeStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz malzeme cinsinde hata var.</font><br>");
	}
	else if(! InputChecker.checkString(unitStr)){
		out.println("<font color=\"red\">*HATA: birimi kısmında hatalı girildi.</font><br>");
	}
	else if(! InputChecker.checkString(ecoCodeStr)){
		out.println("<font color=\"red\">*HATA: economik kod hatalı girildi.</font><br>");
	}
	else if(! InputChecker.checkInt(realizationAmountStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz tahakkuk tutarının tam kısmı sayı formatında değil</font><br>");
	}
	else if(! InputChecker.checkInt(realizationAmountFloatStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz tahakkuk tutarının ondalık kısmı sayı formatında değil</font><br>");
	}
	else if(! InputChecker.checkString(toWhomStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz Kime Tahakkuk Ettiği veya Ödendiği kısmı hatalı girildi.</font><br>");
	}
	else if(! InputChecker.checkDate(realizationDateStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz tahakkuk tarihi tarih formatında değil.</font><br>");		
	}
	// all inputs are valid. 
	else {
		ExpenseStdTO expense = new ExpenseStdTO();
		expense.setBudgetId(BudgetTO.STD);
		expense.setMaterialType(materialTypeStr);
		expense.setRealizationAmount( Double.parseDouble(realizationAmountStr) 
				+ Double.parseDouble(realizationAmountFloatStr) / 100 );
		expense.setRealizationDate(Date.valueOf(realizationDateStr));
		expense.setRealizationId(Integer.parseInt(realizationIdStr));
		expense.setRequestAmount(Double.parseDouble(requestAmountStr) 
				+ Double.parseDouble(requestAmountFloatStr) / 100);
		expense.setRequestDate(Date.valueOf(requestDateStr));
		expense.setToWhom(toWhomStr);
		expense.setUnit(unitStr);
		expense.setEcoCode(ecoCodeStr);
		expense.setStatus(ExpenseBaseTO.ACTIVE);
		try{
			expenseBO.addStdExpense(currentBudget, expense);
		} catch( Exception ex ) {
			session.setAttribute("errorMessage", ex.getMessage());
			response.sendRedirect(errorPage);
			return;
		}
	}
}
else if( action.compareTo("deleteExpense") == 0) {
	String invNoString = request.getParameter(INVENTORY_INDEX);
	if(! InputChecker.checkInt(invNoString) ) {
		out.println("<font color=\"red\">Silmeye çalıştığınız harcama bulunamadı.</font><br>");		
	}
	else {
		int invNo = Integer.parseInt(invNoString);
		try {
			expenseBO.deleteExpense(currentBudget,invNo);
		} catch( Exception ex ) {
			session.setAttribute("errorMessage", ex.getMessage());
			response.sendRedirect(errorPage);
			return;
		}
	}
}
else if( action.compareTo("approveExpense") == 0) {
	String invNoString = request.getParameter(INVENTORY_INDEX);
	if(! InputChecker.checkInt(invNoString) ) {
		out.println("<font color=\"red\">Silmeye çalıştığınız harcama bulunamadı.</font><br>");		
	}
	else {
		int invNo = Integer.parseInt(invNoString);
		try {
			expenseBO.approveExpenditure(currentBudget,invNo);
		} catch( Exception ex ) {
			session.setAttribute("errorMessage", ex.getMessage());
			response.sendRedirect(errorPage);
			return;
		}
	}
}
//balanse measurements
double periodicVal = appropBO.getPeriodicAppropriationTotal(currentBudget);
double additionalVal = appropBO.getAdditionalAppropriationTotal(currentBudget);
double transferVal = transferBO.getTransferTotal(currentBudget);
double expenseVal = expenseBO.getTotalExpense(currentBudget);
double balanceVal = periodicVal + additionalVal + transferVal - expenseVal;
%>		
		
<P></P>
<TABLE width="100%" border=0>
 <TBODY>
  <TR>
    <TD width=150 class="generalFormCell">Mevcut Ekonomik Kodlar:</TD>
<%
Enumeration budgetsEnum = budgets.elements();
BudgetTO oneSideBudget;
while(budgetsEnum.hasMoreElements()) {
	oneSideBudget = (BudgetTO)budgetsEnum.nextElement();
%>
    <TD width=799 bgColor=#f5f5f5><a href="<%=selfPage+"?" +
    		INST_CODE + "=" + oneSideBudget.getInstCode() + "&" + 
    		FUNC_CODE + "=" + oneSideBudget.getFuncCode() + "&" +
    		ECO_CODE  + "=" + oneSideBudget.getEcoCode()
    %>"><%=oneSideBudget.getEcoCode() %></a></TD>
<%
}
%>
   </TR>
  </TBODY>
 </TABLE>
 <br><br>
<TABLE width="100%">
  <TBODY>
  <TR>
    <TD vAlign=top width="38%">
      <TABLE borderColor=#ffffff align=left border=0>
        <TBODY>
        <TR>
          <TD borderColor=#ffffff width=69>&nbsp;</TD>
          <TD width=65 class="generalFormCell">Kurumsal</TD>
          <TD width=79 class="generalFormCell">Fonksiyonel</TD>
          <TD width=66 class="generalFormCell">Ekonomik</TD>
          </TR>
        <TR>
          <TD class="generalFormCell">Bütçe Kodu</TD>
          <TD borderColor=#e4e4e4 bgColor=#f5f5f5>
            <DIV align=right><SPAN class=style11><%=kurumsal %></SPAN></DIV></TD>
          <TD borderColor=#e4e4e4 bgColor=#f5f5f5>
            <DIV align=right><SPAN class=style11><%=fonksiyonel %></SPAN></DIV></TD>
          <TD borderColor=#e4e4e4 bgColor=#f5f5f5>
      <DIV align=right><SPAN 
        class=style11><%=ekonomik %></SPAN></DIV></TD></TR></TBODY></TABLE></TD>
    <TD width="35%" rowSpan=3>&nbsp;</TD>
    <TD width="27%" rowSpan=3 valign="top"><TABLE width="202" border=0 align=right borderColor=#ffffff>
      <TBODY>
        <TR>
          <TD class="generalFormCell" colSpan=3><div align="right"><strong>Toplam</strong></div></TD>
        </TR>
        <TR>
          <TD width="59" borderColor=#999999 bgColor=#cccccc><span class="style13">
          <a href="AppropDetails.jsp?<%=INST_CODE %>=<%=currentBudget.getInstCode() %>&<%=FUNC_CODE %>=<%=currentBudget.getFuncCode() %>&<%=ECO_CODE %>=<%=currentBudget.getEcoCode() %>"><STRONG>Periyodik</STRONG></a></span></TD>
          <TD colspan="2" borderColor=#e4e4e4 bgColor=#f5f5f5><DIV align=right><SPAN class=style11><%=periodicVal %></SPAN></DIV></TD>
        </TR>
        <TR>
          <TD borderColor=#999999 bgColor=#cccccc><span class="style13">
          <a href="AppropDetails.jsp?<%=INST_CODE %>=<%=currentBudget.getInstCode() %>&<%=FUNC_CODE %>=<%=currentBudget.getFuncCode() %>&<%=ECO_CODE %>=<%=currentBudget.getEcoCode() %>"><strong>Ek</strong></a></span></TD>
          <TD colspan="2" borderColor=#e4e4e4 bgColor=#f5f5f5><DIV align=right><SPAN class=style11><%=additionalVal%></SPAN></DIV></TD>
        </TR>
        <TR>
          <TD height="19" borderColor=#999999 bgColor=#cccccc><SPAN 
            class="style17 style13">
            <a href="transfer.jsp?action=view&<%=INST_CODE %>=<%=currentBudget.getInstCode() %>&<%=FUNC_CODE %>=<%=currentBudget.getFuncCode() %>&<%=ECO_CODE %>=<%=currentBudget.getEcoCode() %>"><STRONG>Transfer</STRONG></a></SPAN></TD>
          <TD colspan="2" borderColor=#e4e4e4 bgColor=#f5f5f5><DIV align=right><SPAN 
        class=style11><%=transferVal %></SPAN></DIV></TD>
        </TR>
        <TR>
          <TD height="19" borderColor=#FFFFFF bgColor=#FFFFFF>&nbsp;</TD>
          <TD width="61" borderColor=#999999 bgColor=#cccccc><DIV align=right class="style13">
              <div align="left"><STRONG>Harcanan</STRONG></div>
          </DIV></TD>
          <TD width="68" borderColor=#e4e4e4 bgColor=#f5f5f5><%=expenseVal %></TD>
        </TR>
        <TR>
          <TD height="19" borderColor=#FFFFFF bgColor=#FFFFFF>&nbsp;</TD>
          <TD borderColor=#999999 bgColor=#cccccc><DIV align=right class="style13">
              <div align="left"><STRONG>Kalan</STRONG></div>
          </DIV></TD>
          <TD borderColor=#e4e4e4 bgColor=#f5f5f5><%=balanceVal %></TD>
        </TR>
      </TBODY>
    </TABLE></TD>
  </TR>
  <TR>
    <TD vAlign=center height=74>&nbsp;</TD>
</TR></TBODY></TABLE>
<TABLE borderColor=#ffffff width="100%" bgColor=#ffffff border=0>
  <TBODY>
  <TR borderColor=#000000>
    <TD class="generalFormCell" width=60>Defter Sıra No 
      </TD>
    <TD class="generalFormCell" width=62>İstek F. Tarihi 
      </TD>
    <TD class="generalFormCell" width=72>İstek F. 
      Tutarı</TD>
    <TD class="generalFormCell" width=82>Ekonomik Kodu </TD>
    
    <TD class="generalFormCell" width=111>Malzemenin Cinsi 
    </TD>
    <TD class="generalFormCell" width=94>Birimi</TD>
    <TD class="generalFormCell" width=98>Kime Tahakkuk Ettiği veya Ödendiği 
</TD>
    <TD class="generalFormCell" width=85>Tahakkuk No 
    </TD>
    <TD class="generalFormCell" width=82>Tahakkuk Tarihi 
  </TD>
    <TD class="generalFormCell" width=77>Tahakkuk Tutarı 
      </TD>
    <TD class="generalFormCell" colSpan=3>
      </TD>
  </TR>
  
<%
Vector<ExpenseStdTO> expenses = expenseBO.getStdExpenses(currentBudget,0,100,1,false);
Enumeration expensesEnum = expenses.elements();
ExpenseStdTO oneStdExpense;
String color;
while(expensesEnum.hasMoreElements()) {
	oneStdExpense = (ExpenseStdTO) expensesEnum.nextElement();
	if(oneStdExpense.getStatus() == ExpenseBaseTO.ACTIVE){
		color = "black";
	}
	else if(oneStdExpense.getStatus() == ExpenseBaseTO.DELETED){
		color = "red";
	} else {
		color = "blue";		
	}
	
%>
  <TR borderColor=#e4e4e4 bgColor=#f5f5f5>
    <TD width=70>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getInventoryNo() %></FONT></DIV></TD>
    <TD width=70>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getRequestDate() %></FONT></DIV></TD>
    <TD width=72>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getRequestAmount() %></FONT></DIV></TD>
    <TD width=82>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getEcoCode() %></FONT></DIV></TD>
    <TD width=111>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getMaterialType() %></FONT></DIV></TD>
    <TD width=94>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getUnit() %></FONT></DIV></TD>
    <TD width=98>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getToWhom() %></FONT></DIV></TD>
    <TD width=70>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getRealizationId() %></FONT></DIV></TD>
    <TD width=80>
      <DIV align=center><FONT color=<%=color %>><%=oneStdExpense.getRealizationDate() %></FONT></DIV></TD>
    <TD width=80><FONT color=<%=color %>><%=oneStdExpense.getRealizationAmount() %></FONT></TD>
<%
	if(oneStdExpense.getStatus() != ExpenseStdTO.DELETED && editable){
%>

    <TD borderColor=#e4e4e4 width=66 bgColor=#e0ecdf><A class=style16 
      href="<%=editExpensePage + "?" +
    		  INST_CODE + "=" + kurumsal + "&" +
    		  FUNC_CODE + "=" + fonksiyonel + "&" +
    		  ECO_CODE  + "=" + ekonomik + "&" +
    		  INVENTORY_INDEX + "=" + oneStdExpense.getInventoryNo() + "&" +
    		  REQUEST_DATE + "=" + oneStdExpense.getRequestDate() + "&" +
    		  REQUEST_AMOUNT + "=" + oneStdExpense.getRequestAmount() + "&" +
    		  MATERIAL_TYPE + "=" + oneStdExpense.getMaterialType() + "&" +
    		  UNIT + "=" + oneStdExpense.getUnit() + "&" +
    		  ECONOMIC_CODE + "=" + oneStdExpense.getEcoCode() + "&" +
    		  REALIZATION_ID + "=" + oneStdExpense.getRealizationId() + "&" +
    		  REALIZATION_AMOUNT + "=" + oneStdExpense.getRealizationAmount() + "&" +
    		  TO_WHOM + "=" + oneStdExpense.getToWhom() + "&" +
    		  REALIZATION_DATE + "=" + oneStdExpense.getRealizationDate()
    	  %>">Tahakkuk et</A></TD>

        <TD borderColor=#e4e4e4 width=42 bgColor=#ebe0e2><A class=style15 
      href="<%=selfPage + "?" +
    		  ACTION    + "=deleteExpense" + "&" +
    		  INST_CODE + "=" + kurumsal + "&" +
    		  FUNC_CODE + "=" + fonksiyonel + "&" +
    		  ECO_CODE  + "=" + ekonomik + "&" +
    		  INVENTORY_INDEX + "=" + oneStdExpense.getInventoryNo()
    	  %>">İptal</A>
    </TD>
  </TR>
<%
	}
}
%>  
	<TR borderColor=#ffffff>
		<TD colSpan=12>&nbsp;</TD>
	</TR>
	<TR borderColor=#000000>
		<TD borderColor=#e4e4e4 bgColor=#f5f5f5 height=26>&nbsp;</TD>
		<%if(editable){ %>
		<FORM action=<%=selfPage %> method="get">
    	<TD borderColor=#e4e4e4 bgColor=#f5f5f5>
      		<DIV align=center>
      			<INPUT class="inputCell"  size=9 name="<%=REQUEST_DATE %>"> 
      		</DIV>
    	</TD>
    	<TD align="right" nowrap borderColor=#e4e4e4 bgColor=#f5f5f5>
			<div align="right">
         		<INPUT class="inputCell" name="<%=REQUEST_AMOUNT %>" class="style9" size=5>
            	<span class="style18">,</span>
            	<input class="inputCell" name="<%=REQUEST_AMOUNT_FLOAT %>" class="style9" size=1 maxlength="2" align=left>      
       		</div></TD>
    	<TD borderColor=#e4e4e4 bgColor=#f5f5f5>
      		<DIV align=center><INPUT class="inputCell" class=style9 size=10 name="<%=ECONOMIC_CODE %>"> </DIV>
      	</TD>
    	<TD borderColor=#e4e4e4 bgColor=#f5f5f5>
      		<DIV align=center><INPUT class="inputCell" class=style9 size=13 name="<%=MATERIAL_TYPE %>"> </DIV>
      	</TD>
    	<TD borderColor=#e4e4e4 bgColor=#f5f5f5>
      		<DIV align=center><INPUT class="inputCell" class=style9 size=13 name="<%=UNIT %>"> </DIV>
      	</TD>
    	<TD borderColor=#e4e4e4 bgColor=#f5f5f5>
      		<DIV align=center><INPUT class="inputCell" class=style9 size=10 name="<%=TO_WHOM %>"> </DIV>
      	</TD>
    	<TD borderColor=#e4e4e4 bgColor=#f5f5f5>
      		<DIV align=center><INPUT class="inputCell" class=style9 size=11 name="<%=REALIZATION_ID %>"> </DIV>
      	</TD>
    	<TD borderColor=#e4e4e4 bgColor=#f5f5f5>
      		<DIV align=center><INPUT class="inputCell" class=style9 size=9 name="<%=REALIZATION_DATE %>"> </DIV>
      	</TD>
    	<TD nowrap borderColor=#e4e4e4 bgColor=#f5f5f5>
        	<div align="center">
          		<INPUT class="inputCell" class=style9 size=5 name="<%=REALIZATION_AMOUNT %>">
          		<span class="style18">          ,          </span>
          		<INPUT class="inputCell" name="<%=REALIZATION_AMOUNT_FLOAT %>" class=style9 size=1 maxlength="2">
         	</div>
        </TD>
        <INPUT type=hidden value="<%=kurumsal %>" name="<%=INST_CODE %>"> 
        <INPUT type=hidden value="<%=fonksiyonel %>" name="<%=FUNC_CODE %>"> 
        <INPUT type=hidden value="<%=ekonomik %>" name="<%=ECO_CODE %>"> 
		<INPUT type=hidden value="<%="addExpense" %>" name="<%=ACTION %>">
		<TD borderColor=#e4e4e4 width=81 bgColor=#f5f5f5>
      		<DIV align=center>
      			<INPUT class="mybutton" type="submit" value=" ekle ">
      		</DIV>
      	</TD>
		</FORM>
		<%} %>
    	<TD borderColor=#ffffff width=5>&nbsp;</TD>
    </TR>
    </TBODY>
</TABLE>
<P align=right></P>
</TD>
<TD>&nbsp;</TD> 
</TR>
<TR>
	<TD colspan="2"><p></p></TD> 
	<TD>&nbsp;</TD>
</TR> 
</TABLE>
</TABLE>				

        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
		
		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50"></td>
  </tr>
</table>
	</div>
	
	<div id="footer3">	  

	</div>
	
	
	
	</div>
</body>
</html>