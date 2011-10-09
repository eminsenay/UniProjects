<%@page session="true" import="java.util.*,
bts.cmpe.budget.businessObj.*,
bts.cmpe.budget.transfer.*,
java.sql.SQLException"
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page import="global.InputChecker"%>
<%@page import="java.sql.Date"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../index/gui.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style9 {font-size: x-small; font-weight: bold; }
.style11 {font-size: small}
body {
	 background-color: #FFFFFF;
	
}
.style13 {font-size: 12px}
.style14 {font-size: 12px; font-weight: bold; }
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: none;
}
a:active {
	text-decoration: none;
}
.style15 {
	font-size: 12;
	color: #CC3333;
}

.style16 {
	font-size: 12;
	color: #009900;
}
.style17 {font-weight: bold}
-->
</style>
</head>


<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
    
<%
String kurumsal = (String)request.getParameter("kurumsal");
String fonksiyonel = (String)request.getParameter("fonksiyonel");
String ekonomik = (String)request.getParameter("ekonomik");

// current budget object.
BudgetTO currentBudget = new BudgetTO( kurumsal, fonksiyonel, ekonomik );

int from;
int to;
int i;

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

final String INST_CODE = "kurumsal";
final String FUNC_CODE = "fonksiyonel";
final String ECO_CODE = "ekonomik";

final String SORT_TYPE = "sortType";
final String IS_ASCENDING = "isAscending";

String  color="";

final String selfPage = "idaribirim.jsp";
final String errorPage = "error.jsp";
final String mainPage = "loginned.jsp";
final String normalPage = "idaribirim.jsp";
final String wagePage = "idaribirimmaas.jsp";

int recperpage=10;//records per page


//check for all the necessary parameters
if ((request.getParameter(INST_CODE) == null)||
	(request.getParameter(FUNC_CODE) == null)||
	(request.getParameter(ECO_CODE) == null)) {
		response.sendRedirect(mainPage);
}

ExpenseBusinessObj expenseBO = new ExpenseBusinessObj();
BudgetBusinessObj budgetBO = new BudgetBusinessObj();
AppropriationBusinessObj appropBO = new AppropriationBusinessObj();

String action = (String) request.getParameter("action");
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

	if(InputChecker.checkDate(requestDateStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz istek tarihi tarih formatında değil.</font><br>");		
	} 
	else if(InputChecker.checkInt(realizationIdStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz tahakkuk no sayı formatında değil.</font><br>");		
	} 
	else if(InputChecker.checkInt(requestAmountStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz istek tutarının tam sayı kısmı sayı formatında değil.</font><br>");
	} 
	else if(InputChecker.checkInt(requestAmountFloatStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz istek tutarının ondalık kısmı sayı formatında değil.</font><br>");
	}
	else if(InputChecker.checkString(materialTypeStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz malzeme cinsinde hata var.</font><br>");
	}
	else if(InputChecker.checkString(unitStr)){
		out.println("<font color=\"red\">*HATA: birimi kısmında hatalı girildi.</font><br>");
	}
	else if(InputChecker.checkString(ecoCodeStr)){
		out.println("<font color=\"red\">*HATA: economik kod hatalı girildi.</font><br>");
	}
	else if(InputChecker.checkInt(realizationAmountStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz tahakkuk tutarının tam kısmı sayı formatında değil</font><br>");
	}
	else if(InputChecker.checkInt(realizationAmountFloatStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz tahakkuk tutarının ondalık kısmı sayı formatında değil</font><br>");
	}
	else if(InputChecker.checkString(toWhomStr)){
		out.println("<font color=\"red\">*HATA: girdiğiniz Kime Tahakkuk Ettiği veya Ödendiği kısmı hatalı girildi.</font><br>");
	}
	else if(InputChecker.checkDate(realizationDateStr)){
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
		
		try{
			expenseBO.addStdExpense(currentBudget, expense);
		} catch( Exception ex ) {
			session.setAttribute("errorMessage", ex.getMessage());
			response.sendRedirect(errorPage);
		}
	}
}
else if( action.compareTo("deleteExpense") == 0) {
	String invNoString = request.getParameter(INVENTORY_INDEX);
	if( InputChecker.checkString(invNoString) ) {
		out.println("<font color=\"red\">Silmeye çalıştığınız harcama bulunamadı.</font><br>");		
	}
	else {
		int invNo = Integer.parseInt(invNoString);
		try {
			expenseBO.deleteExpense(currentBudget,invNo);
		} catch( Exception ex ) {
			session.setAttribute("errorMessage", ex.getMessage());
			response.sendRedirect(errorPage);
		}
	}
}


String fromString  = request.getParameter("from");
String toString    = request.getParameter("to");

if( InputChecker.checkInt(fromString ) & InputChecker.checkInt(toString ))
{
	from = Integer.parseInt( fromString );
	to   = Integer.parseInt( toString );
}
else
{
	from=1;
	to=10;	
}

%>

<body>
<p>
  <%/*@ include file="header.jsp" */%>
</p>
<table width="100%" border="0">
  <tr>
    <td width="150" bgcolor="#CCCCCC"><span class="style14">Mevcut Ekonomik Kodlar: 
<%
	//writes ecoCodes to screen
	Enumeration en = budgetBO.getEconomicCodes(currentBudget).elements();

	out.println("<table cellspacing=\"1\" cellpadding=\"1\"><tr>");
	while( en.hasMoreElements() ){
		BudgetTO ecoCodeBudget = (BudgetTO) en.nextElement();
		
		if(ecoCodeBudget.getType()==1)//goto normal page
		out.println("<td><a href=\"" + normalPage + "?" + 
			INST_CODE + "=" + ecoCodeBudget.getInstCode() + "&" +
			FUNC_CODE + "=" + ecoCodeBudget.getFuncCode() + "&" +
			ECO_CODE + "=" + ecoCodeBudget.getEcoCode() + "\">" +
			ecoCodeBudget.getEcoCode() + 
			"</td>");
			
		if(ecoCodeBudget.getType()==0)//goto wage page
		out.println("<td><a href=\"" + wagePage + "?" + 
			INST_CODE + "=" + ecoCodeBudget.getInstCode() + "&" +
			FUNC_CODE + "=" + ecoCodeBudget.getFuncCode() + "&" +
			ECO_CODE + "=" + ecoCodeBudget.getEcoCode() + "\">" +
			ecoCodeBudget.getEcoCode() + 
			"</td>");
		
}

out.println("<\\tr><\\table>");
%>
    </span></td>
    <td width="799" bgcolor="#F5F5F5">&nbsp;
    </td>
  </tr>
</table>
<table width="100%">
  <tr>
    <td width="38%" valign="top"><table border="0" align="left" bordercolor="#FFFFFF">
      <tr>
        <td width="69" bordercolor="#FFFFFF">&nbsp;</td>
        <td width="65" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style14"><span class="style13"> Kurumsal </span></div></td>
        <td width="79" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style14"><span class="style13"> Fonksiyonel </span></div></td>
        <td width="66" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style14"><span class="style13"> Ekonomik </span></div></td>
      </tr>
      <tr>
        <td bordercolor="#999999" bgcolor="#CCCCCC"> <span class="style14">Bütçe Kodu</span> </td>
        <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="right"><span class="style11"><%=kurumsal%></span></div></td>
        <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="right"><span class="style11"><%=fonksiyonel%></span></div></td>
        <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="right"><span class="style11"><%=ekonomik%></span></div></td>
      </tr>
    </table></td>
    <td width="35%" rowspan="3">&nbsp;</td>
    <td width="27%" rowspan="3" valign="top"><TABLE width="202" border=0 align=right borderColor=#ffffff>
      <TBODY>
        <TR>
          <TD borderColor=#999999 bgColor=#cccccc colSpan=3><div align="right"><strong>Toplam</strong></div></TD>
        </TR>
        <TR>
          <TD width="59" borderColor=#999999 bgColor=#cccccc><span class="style13"><STRONG>Periyodik</STRONG></span></TD>
          <TD colspan="2" borderColor=#e4e4e4 bgColor=#f5f5f5><DIV align=right><SPAN class=style11><%=appropBO.getAdditionalAppropriationTotal(currentBudget)%><br></SPAN></DIV></TD>
        </TR>
        <TR>
          <TD borderColor=#999999 bgColor=#cccccc><span class="style13"><strong>Ek</strong></span></TD>
          <TD colspan="2" borderColor=#e4e4e4 bgColor=#f5f5f5><DIV align=right><SPAN class=style11><%=appropBO.getAdditionalAppropriationTotal(currentBudget)%></SPAN></DIV></TD>
        </TR>
        <TR>
          <TD height="19" borderColor=#999999 bgColor=#cccccc><SPAN 
            class="style17 style13"><STRONG>Transfer</STRONG></SPAN></TD>
          <TD colspan="2" borderColor=#e4e4e4 bgColor=#f5f5f5><DIV align=right><SPAN 
        class=style11><%=0%></SPAN></DIV></TD>
        </TR>
        <TR>
          <TD height="19" borderColor=#FFFFFF bgColor=#FFFFFF>&nbsp;<a href="OdenekDetay.jsp?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%=ekonomik%>">Detay</a></TD>
          <TD width="61" borderColor=#999999 bgColor=#cccccc><DIV align=right class="style13">
              <div align="left"><STRONG>Harcanan</STRONG></div>
          </DIV></TD>
          <TD width="68" borderColor=#e4e4e4 bgColor=#f5f5f5>&nbsp;<%=expenseBO.getTotalExpense(currentBudget)%></TD>
        </TR>
        <TR>
          <TD height="19" borderColor=#FFFFFF bgColor=#FFFFFF>&nbsp;</TD>
          <TD borderColor=#999999 bgColor=#cccccc><DIV align=right class="style13">
              <div align="left"><STRONG>Kalan</STRONG></div>
          </DIV></TD>
          <TD borderColor=#e4e4e4 bgColor=#f5f5f5>&nbsp;</TD>
        </TR>
      </TBODY>
    </TABLE></td>
  </tr>
  
</table>
<p>&nbsp;</p>
<% 
String sortTypeStr = request.getParameter(SORT_TYPE);
String isAscendingStr = request.getParametr(IS_ASCENDING);
int sortType = 1;
boolean isAscending = true;
if (InputChecker.checkInt(sortTypeStr)) {
	sortType = Integer.parseInt(sortTypeStr);
}
if (InputChecker.checkBoolean(isAscendingStr))
{
//parse boolean
if(isAscendingStr.equals("true"))
isAscending="true";
else if(isAscendingStr.equals("false")
isAscending="false";
}
%>


<table width="100%" height="142" border="0" bordercolor="#FFFFFF" bgcolor="#FFFFFF">
  <tr bordercolor="#000000">
    <td width="60" height="37" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=1&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">Defter Sıra No</A></strong>&nbsp;</div></td>
    <td width="62" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=2&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">İstek F. Tarihi</A></strong></div></td>
    <td width="72" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=3&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">İstek F. Tutarı</A></strong>&nbsp;</div></td>
    <td width="82" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=4&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">Ekonomik Kodu </A></strong>&nbsp;</div></td>
    <td width="111" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=5&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">Malzemenin Cinsi&nbsp;</A></strong></div></td>
    <td width="94" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=6&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">Birimi</A></strong>&nbsp;</div></td>
    <td width="98" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=7&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">Kime Tahakkuk Ettiği veya Ödendiği </A></strong>&nbsp;</div></td>
    <td width="85" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=8&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">Tahakkuk No </A></strong>&nbsp;</div></td>
    <td width="82" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=9&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">Tahakkuk Tarihi </A></strong>&nbsp;</div></td>
    <td width="77" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center" class="style11"><strong><A HREF="<%=selfPage%>?kurumsal=<%=kurumsal%>&fonksiyonel=<%=fonksiyonel%>&ekonomik=<%ekonomik%>&sorttype=10&isascending=<% if(isAscending) out.println("false");else out.println("true");%>&from=<%=from %>&to=<%=to%>">Tahakkuk Tutarı </A></strong>&nbsp;</div></td>
    <td colspan="2" bordercolor="#999999" bgcolor="#CCCCCC"><div align="center">&nbsp;</div>      <div align="center">&nbsp;</div></td>
  </tr>
<%
//kalemleri göster
expenseBO.getStdExpenses(currentBudget, from, to, sortType,isAscending );
ExpenseStdTO currentKalem;
for(i = 0; i <= recperpage; i++) {
	
//str=unit.satirGoster(i);
//str[9] = unit.rakamBasamakla(str[9]);
//str[0]=currentKalem.getOrderNo();
//str[1]=currentKalem.getRequestDate();
//str[2]=currentKalem.getRequestAmount();
//str[3]=currentKalem.getEcoCode();
//str[4]=currentKalem.getTypeOfMaterial();
//str[5]=currentKalem.getUnit();
//str[6]=currentKalem.getPaidToWhom();
//str[7]=currentKalem.getTahakkukID();
//str[8]=currentKalem.getTahakkukDate();
//str[9]=currentKalem.getTahakkukQuantity();
//str[10]=currentKalem.getStatus();


if(str[10].equals("deleted"))
color="red";
else
color="black";
out.println("<tr bordercolor=\"#E4E4E4\" bgcolor=\"#F5F5F5\">");
out.println("<td width=\"70\"><div align=\"center\"><FONT COLOR=\""+color+"\">"+currentKalem.getOrderNo()+/*i+*/"&nbsp;</FONT></div></td>");
out.println("<td width=\"70\"><div align=\"center\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getRequestDate()+"</FONT></div></td>");
out.println("<td width=\"72\"><div align=\"center\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getRequestAmount()+"</FONT></div></td>");
out.println("<td width=\"82\"><div align=\"center\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getEcoCode()+"</FONT></div></td>");
out.println("<td width=\"111\"><div align=\"center\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getTypeOfMaterial()+"</FONT></div></td>");
out.println("<td width=\"94\"><div align=\"center\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getUnit()+"</FONT></div></td>");
out.println("<td width=\"98\"><div align=\"center\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getPaidToWhom()+"</FONT></div></td>");
out.println("<td width=\"70\"><div align=\"center\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getTahakkukID()+"</FONT></div></td>");
out.println("<td width=\"80\"><div align=\"center\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getTahakkukDate()+"</FONT></div></td>");
out.println("<td width=\"80\"><FONT COLOR=\""+color+"\">&nbsp;"+currentKalem.getTahakkukQuantity()+"</FONT></td>");
out.println("<td width=\"66\" bordercolor=\"#E4E4E4\" bgcolor=\"#E0ECDF\"><a href=\"SatirDuzenle.jsp?kurumsal="+""+kurumsal+"&fonksiyonel="+""+fonksiyonel+"&ekonomik="+""+ekonomik+"&inventoryIndex="+""+i+"\" class=\"style16\">düzenle</a></td> <td width=\"42\" bordercolor=\"#E4E4E4\" bgcolor=\"#EBE0E2\"><a href=\""selfPage"?kurumsal="+""+kurumsal+"&fonksiyonel="+""+fonksiyonel+"&ekonomik="+""+ekonomik+"&inventoryIndex="+""+i+"&action=deleteExpense"+"&from="+from+"&to="+to+"\" class=\"style15\" >İptal</a></td>");
out.println("</tr>");
}    




%>




    
  <tr bordercolor="#FFFFFF">
    <td colspan="12">&nbsp;</td>
  </tr>
  <tr><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td><td valign="top"><br></td></tr><tr bordercolor="#000000">
    <td height="26" bordercolor="#E4E4E4" bgcolor="#F5F5F5">&nbsp;</td>
	<form action="IdariBirim.jsp" method="get" name="gonder">
    <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="center">
      <input name="istekTarihi" type="text" class="style9" size="10">
    </div></td>
    <TD align="right" nowrap borderColor=#e4e4e4 bgColor=#f5f5f5>
        <div align="center">
          <INPUT name=istekTutari class="style9" size=5>
          <span class="style18">,</span>
          <input name=istekTutari2 class="style9" size=1 maxlength="2" align=left>
          </div></TD>
    <td bordercolor="#E4E4E4" bgcolor="#F5F5F5" nowrap="nowrap"><div align="center">
      <%=ekonomik%>.<input name="ekonomikKod" type="text" class="style9" size="6">
    </div></td>
    <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="center">
      <input name="malzemeCinsi" type="text" class="style9" size="13">
    </div></td>
    <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="center">
      <input name="birim" type="text" class="style9" size="13">
    </div></td>
    <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="center">
      <input name="tahakkuk" type="text" class="style9" size="13">
    </div></td>
    <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="center">
      <input name="tahakkukNo" type="text" class="style9" size="11">
    </div></td>
    <td bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="center">
      <input name="tahakkukTarihi" type="text" class="style9" size="10">
    </div></td>
    <TD nowrap borderColor=#e4e4e4 bgColor=#f5f5f5><div align="center">
        <INPUT class=style9 size=5 name=tahakkukTutari>
        <span class="style18"> , </span>
        <INPUT name=tahakkukTutari2 class=style9 size=1 maxlength="2">
    </div></TD>
    <input name="kurumsal" type="hidden" value="<%=kurumsal%>" />
	<input name="fonksiyonel" type="hidden" value="<%=fonksiyonel%>" />
	<input name="ekonomik" type="hidden" value="<%=ekonomik%>" />
	<input name="action" type="hidden" value="addExpense" />
	<input name="from" type="hidden" value="<%=from%>" />
	<input name="to" type="hidden" value="<%=to%>" />
    <td width="81" bordercolor="#E4E4E4" bgcolor="#F5F5F5"><div align="center">
      <input type="submit" value="ekle">
    </div></td>
    </form>
	<td width="5" bordercolor="#FFFFFF">&nbsp;</td>
  </tr>
</table>


<p align="right">
<%
if((from-recperpage<1)||(from-recperpage)>unit.toplamSatir())
//no prev button
{}
else
out.println("<a href=\""+selfPage+"?kurumsal="+kurumsal+"&fonksiyonel="+fonksiyonel+"&ekonomik="+ekonomik+"&from="+""+(int)(from-recperpage)+"&to="+""+(int)(to-recperpage)+"\">&lt;Geri</a>");

//TODO: toplam harcamaları döndüren fonksiyon gerekli.
//if(from+recperpage>unit.toplamSatir())
//no next button
//{}
//else
out.println("<a href=\""+selfPage+"?kurumsal="+kurumsal+"&fonksiyonel="+fonksiyonel+"&ekonomik="+ekonomik+"&from="+""+(int)(from+recperpage)+"&to="+""+(int)(to+recperpage)+"\">İleri&gt;</a>");
%>
</p>

</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50"></td>
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
