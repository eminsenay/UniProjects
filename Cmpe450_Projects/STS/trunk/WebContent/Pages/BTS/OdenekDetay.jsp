<%@page session="true" import="java.util.*,
bts.cmpe.budget.businessObj.*,
bts.cmpe.budget.transfer.*, 
java.sql.SQLException"
%>
<%@ page contentType="text/html; charset=windows-1254" pageEncoding="windows-1254" %>

<%
final String INST_CODE = "kurumsal";
final String FUNC_CODE = "fonksiyonel";
final String ECO_CODE = "ekonomik";

final String errorPage = "error.jsp";
String kurumsal="";
String fonksiyonel="";
//String finanst="";
String ekonomik="";

final String mainPage = "loginned.jsp";

  //check for all the necessary parameters
  if ((request.getParameter(INST_CODE) == null)||
	(request.getParameter(FUNC_CODE) == null)||
	/*(request.getParameter("finanst") == null)||*/
	(request.getParameter(ECO_CODE) == null)){
		response.sendRedirect(mainPage);
		return;
		}

else
{
kurumsal=request.getParameter("kurumsal").toString();
fonksiyonel=request.getParameter("fonksiyonel").toString();
//finanst=request.getParameter("finanst").toString();
ekonomik=request.getParameter("ekonomik").toString();
}

// current budget object.
BudgetTO currentBudget = null;
		try{
			currentBudget = new BudgetTO( kurumsal, fonksiyonel, ekonomik );
		} catch( Exception ex ) {
			session.setAttribute("errorMessage", ex.getMessage());
			response.sendRedirect(errorPage);
			
			return;
		}


Vector <AppropriationTO> odenekler = null;
Vector <TransferTO> transferler = null;

AppropriationBusinessObj abo=new AppropriationBusinessObj();
TransferBusinessObj transfer=new TransferBusinessObj();


try{
			odenekler = abo.getAllAppropriations(currentBudget);//odenekleri al
			transferler = transfer.getAllTransfers(currentBudget);
		} catch( Exception ex ) {
			session.setAttribute("errorMessage", ex.getMessage());
			response.sendRedirect(errorPage);
			return;
		}
//EconomicBusinessObj ebo=new EconomicBusinessObj();
//DepartmentTO[] otherdeps=ebo.getEconomicCodes(dep);//mevcut ekonomik kodlarý al


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boðaziçi Üniversitesi Satýn Alma Sistemi</title>
<link href="../index/gui.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.style11 {	FONT-SIZE: small
}
.style13 {	FONT-SIZE: 12px
}
.style14 {	FONT-WEIGHT: bold; FONT-SIZE: 12px
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
<table width="64%">
  <tbody>
    <tr>
      <td colspan="3" valign="top"><table bordercolor="#ffffff" align="left" border="0">
        <tbody>
          <tr>
            <td bordercolor="#ffffff" width="69">&nbsp;</td>
            <td bordercolor="#999999" width="65" bgcolor="#cccccc"><div class="style14" align="center"><span class="style13">Kurumsal </span></div></td>
            <td bordercolor="#999999" width="79" bgcolor="#cccccc"><div class="style14" align="center"><span class="style13">Fonksiyonel </span></div></td>
            <td bordercolor="#999999" width="66" bgcolor="#cccccc"><div class="style14" align="center"><span class="style13">Ekonomik </span></div></td>
          </tr>
          <tr>
            <td bordercolor="#999999" bgcolor="#cccccc"><span class="style14">B&uuml;t&ccedil;e 
              Kodu</span> </td>
            <td bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11"><%=kurumsal%></span></div></td>
            <td bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11"><%=fonksiyonel%></span></div></td>
            <td bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span 
        class="style11"><%=ekonomik%></span></div></td>
          </tr>
        </tbody>
      </table></td>
    </tr>
    <tr>
      <td width="26%" height="132" valign="center"><table width="202" border="0" align="left" bordercolor="#ffffff">
        <tbody>
          <tr>
            <td bordercolor="#999999" bgcolor="#cccccc" colspan="3"><div align="left"><strong>Periyodik</strong></div></td>
          </tr>
          <tr>
            <td width="59" bordercolor="#999999" bgcolor="#cccccc"><span class="style13"><strong>1. 3 Ayl&#305;k </strong></span></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11">2255300</span></div></td>
          </tr>
          <tr>
            <td bordercolor="#999999" bgcolor="#cccccc"><span class="style13"><strong>2. 3 Ayl&#305;k </strong></span></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11">2255500</span></div></td>
          </tr>
          <tr>
            <td height="19" bordercolor="#999999" bgcolor="#cccccc"><span 
            class="style17 style13"><strong>3. 3 Ayl&#305;k </strong></span></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span 
        class="style11">2555500</span></div></td>
          </tr>
          <tr>
            <td height="19" bordercolor="#999999" bgcolor="#cccccc"><span class="style13"><strong>4. 3 Ayl&#305;k </strong></span></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right" class="style13">3465466
              </div></td>
            </tr>
            <%
            Enumeration en = odenekler.elements();
            while(en.hasMoreElements())
            {
           		 out.println("<tr>");
            	 out.println("<td width=\"59\" bordercolor=\"#999999\" bgcolor=\"#cccccc\"><span class=\"style13\"><strong>"+((AppropriationTO)en.nextElement()).getIndex()+"."+((AppropriationTO)en.nextElement()).getType()+"Aylýk"+"</strong></span></td>");
           		 out.println("<td colspan=\"2\" bordercolor=\"#e4e4e4\" bgcolor=\"#f5f5f5\"><div align=\"right\"><span class=\"style11\">"+((AppropriationTO)en.nextElement()).getAmount()+"</span></div></td>");
           		 out.println("</tr>");
            }%>
          <tr>
            <td height="19">&nbsp;</td>
            <td width="49" bordercolor="#999999" bgcolor="#cccccc"><span class="style14">Toplam</span></td>
            <td width="80" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><span class="style11"><%=abo.getPeriodicAppropriationTotal(currentBudget)%></span><br /></td>
          </tr>
        </tbody>
      </table></td>
      <td width="26%" valign="center"><table width="202" border="0" align="left" bordercolor="#ffffff">
        <tbody>
          <tr>
            <td bordercolor="#999999" bgcolor="#cccccc" colspan="3" valign="top"><div align="left"><strong>Transfer</strong></div></td>
          </tr>
          <tr>
            <td width="59" bordercolor="#999999" bgcolor="#cccccc"><span class="style13"><strong>Eklenen </strong></span></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11">2255300</span></div></td>
          </tr>
          <tr>
            <td bordercolor="#999999" bgcolor="#cccccc"><span class="style13"><strong>Harcanan </strong></span></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11">2255500</span></div></td>
          </tr>
          <tr>
            <td height="19" bordercolor="#999999" bgcolor="#cccccc">&nbsp;</td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span 
        class="style11">2555500</span></div></td>
          </tr>
          <tr>
            <td height="19" bordercolor="#999999" bgcolor="#cccccc">&nbsp;</td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right" class="style13">3465466 </div></td>
          </tr>
          <tr>
            <td height="19">&nbsp;</td>
            <td width="49" bordercolor="#999999" bgcolor="#cccccc" class="style14">Toplam</td>
            <td width="80" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><%=transfer.getTransferTotal(currentBudget)%></td>
          </tr>
        </tbody>
      </table></td>
      <td width="48%" valign="center"><table width="202" border="0" align="left" bordercolor="#ffffff">
        <tbody>
          <tr>
            <td bordercolor="#999999" bgcolor="#cccccc" colspan="3"><div align="left"><strong>Ek</strong></div></td>
          </tr>
          <tr>
            <td width="59" bordercolor="#999999" bgcolor="#cccccc"><span class="style13"><strong>Eklenen </strong></span></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11">2255300</span></div></td>
          </tr>
          <tr>
            <td bordercolor="#999999" bgcolor="#cccccc"><span class="style13"><strong>Harcanan </strong></span></td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span class="style11">2255500</span></div></td>
          </tr>
          <tr>
            <td height="19" bordercolor="#999999" bgcolor="#cccccc">&nbsp;</td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right"><span 
        class="style11">2555500</span></div></td>
          </tr>
          <tr>
            <td height="19" bordercolor="#999999" bgcolor="#cccccc">&nbsp;</td>
            <td colspan="2" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><div align="right" class="style13">3465466 </div></td>
          </tr>
          <tr>
            <td height="19">&nbsp;</td>
            <td width="49" bordercolor="#999999" bgcolor="#cccccc" class="style14">Toplam</td>
            <td width="80" bordercolor="#e4e4e4" bgcolor="#f5f5f5"><%=abo.getAdditionalAppropriationTotal(currentBudget)%></td>
          </tr>
        </tbody>
      </table></td>
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
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisliði &copy;2005</font></b></p>
	</div>
	
	
	
	</div>



</body>
</html>
