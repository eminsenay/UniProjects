<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="bts.cmpe.budget.businessObj.*"%>
<%@ page import="bts.cmpe.budget.transfer.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="css/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
    <h1>Ödenek Detayları</h1><br /><br />
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
<%
final String INST_CODE = "inst";
final String FUNC_CODE = "func";
final String ECO_CODE = "eco";


String instString = request.getParameter(INST_CODE);
String funcString = request.getParameter(FUNC_CODE);;
String ecoString  = request.getParameter(ECO_CODE);

final String mainPage  = "loginned.jsp";
final String errorPage = "error.jsp";
final String selfPage  = "appropDetails.jsp";


  //check for all the necessary parameters
if (( instString == null) || (funcString == null) || (ecoString == null)){
	response.sendRedirect(mainPage);
	return;
} 

// current budget object.
BudgetTO currentBudget = null;
try{
	currentBudget = new BudgetTO( instString, funcString, ecoString );
} catch( Exception ex ) {
	session.setAttribute("errorMessage", ex.getMessage());
	response.sendRedirect(errorPage);
	return;
}


Vector<AppropriationTO> approps = null;
Vector<TransferTO> transfers = null;

double mainAppropTotal = 0;
double additionalAppropTotal = 0;

double receivedTransferTotal = 0;
double sendTransferTotal = 0;
double transferTotal = 0;

AppropriationBusinessObj appropBO = new AppropriationBusinessObj();
TransferBusinessObj    transferBO = new TransferBusinessObj();

try{
	approps = appropBO.getAllAppropriations(currentBudget);// odenekleri al
	transfers = transferBO.getAllTransfers(currentBudget); // transferleri al
	
	mainAppropTotal = appropBO.getPeriodicAppropriationTotal(currentBudget);
	additionalAppropTotal = appropBO.getAdditionalAppropriationTotal(currentBudget);
	
	receivedTransferTotal = transferBO.getReceivedTransferTotal(currentBudget);
	sendTransferTotal = -1 * transferBO.getSendTransferTotal(currentBudget);
	transferTotal = transferBO.getTransferTotal(currentBudget);
	
} catch( Exception ex ) {
	session.setAttribute("errorMessage", ex.getMessage());
	response.sendRedirect(errorPage);
	return;
}
				
%>
        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
<table width="64%">
  <tbody>
    <tr>
      <td colspan="3" valign="top"><table bordercolor="#ffffff" align="left" border="0">
        <tbody>
          <tr>
            <td bordercolor="#ffffff" width="69">&nbsp;</td>
            <td  class="generalFormCell">Kurumsal</td>
            <td  class="generalFormCell">Fonksiyonel</td>
            <td  class="generalFormCell">Ekonomik</td>
          </tr>
          <tr>
            <td class="generalFormCell">Bütçe Kodu</td>
            <td bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11"><%=instString %></span></div></td>
            <td bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11"><%=funcString %></span></div></td>
            <td bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11"><%=ecoString %></span></div></td>
          </tr>
        </tbody>
      </table></td>
    </tr>
    <tr>
      <td width="26%" height="132" valign="top">
      <br><br><table width="202" border="0" align="left" bordercolor="#ffffff">
        <tbody>
          <tr>
            <td  class="generalFormCell" colspan="3">Periyodik</td>
          </tr>

<% 
String appropTypeString = null;
int appropIndex = 1;
AppropriationTO anApprop;
Enumeration appropsEnum = approps.elements();
while(appropsEnum.hasMoreElements()) {
	anApprop = (AppropriationTO) appropsEnum.nextElement();
	if( anApprop.getType() == AppropriationTO.MONTH_3 ) {
		appropTypeString = appropIndex + ". 3 Aylık";
		appropIndex++;
	} 
	else if( anApprop.getType() == AppropriationTO.MONTH_6 ) {
		appropTypeString = appropIndex + ". 6 Aylık";
		appropIndex++;
	} 
	else { // if( anApprop.getType() == AppropriationTO.ADDITIONAL ) 
		continue;
	}
%>          
          <tr>
            <td width="59"  class="generalFormCell"><%=appropTypeString %></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11"><%=anApprop.getAmount() %></span></div></td>
          </tr>
   
<% 
}   
%>             
          <tr>
            <td height="19">&nbsp;</td>
            <td width="49" class="generalFormCell">Toplam</td>
            <td width="80" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><%=mainAppropTotal %></div></td>
          </tr>
        </tbody>
      </table>
      </td>
      <td width="26%" valign="top">
      </td>
      <td width="48%" valign="top">
      <br><br><table width="202" border="0" align="left" bordercolor="#ffffff">
        <tbody>
          <tr>
            <td class="generalFormCell" colspan="3">Ek</td>
          </tr>
          <tr>
            <td height="19">&nbsp;</td>
            <td width="49"  class="generalFormCell">Toplam</td>
            <td width="80" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><%=additionalAppropTotal %></div></td>
          </tr>
        </tbody>
      </table></td>
    </tr>
  </tbody>
</table>		

<br /><br />
<table width="202" border="0" align="left" bordercolor="#ffffff">
        <tbody>
          <tr>
            <td class="generalFormCell" colspan="3">Transfer</td>
          </tr>
          <tr>
            <td width="59" class="generalFormCell">Gelen</td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11"><%=receivedTransferTotal %></span></div></td>
          </tr>
          <tr>
            <td class="generalFormCell">Giden</td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11"><%=sendTransferTotal %></span></div></td>
          </tr>
          <tr>
            <td height="19">&nbsp;</td>
            <td width="49" class="generalFormCell">Toplam</td>
            <td width="80" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><%=transferTotal %></div></td>
          </tr>
        </tbody>
      </table>		
		
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