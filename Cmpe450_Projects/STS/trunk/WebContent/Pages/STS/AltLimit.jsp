<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="sts.stockFollowUp.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/css/gui.css" rel="stylesheet" type="text/css">
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
  <table border="0" cellspacing="0" cellpadding="0" width="650" height="9" class=tablefont3>
  <tr>
    <td width="5" height="9"><img src="../../images/spacer.gif" width="7" height="9"></td>

  </tr>
  <tr>
        <td width="5" height="300"><img src="../../images/spacer.gif" width="5" height="9"></td>
    <td valign="top">

<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="650" height="10" align="center">
  <tr><td width="850" height="5"></td></tr>
  

  <tr>
    <td valign="top">
    
    <%
User userInfo = (User)(session.getAttribute("userClass"));

/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
boolean GDC = false, DDC =false;
if(userInfo.positionID.equals("00000F-POS"))
	GDC = true;
else if(userInfo.positionID.equals("000004-POS"))	{
	DDC = true;
}

if (!GDC && !DDC) { 
	session.setAttribute("error","Alt Limit Belirleme sayfasına girme hakkınız yok.");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
}
else {
 	StockManagement sm = new StockManagement();
	ArrayList urun_names = new ArrayList();
   	urun_names = sm.getUrunNames();
   	ArrayList urun_ids = sm.getUrunIDs();
%>

		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
		
		<form id="altLimitFormu" name="altLimitFormu" method="post" action="AltLimitAction.jsp">
  <table width="100%" class="generalFormTable">
    <tr>
	
      <td width="130">&nbsp;</td>
      <td width="1040"><label>
        <div align="center"><strong>ALT LİMİT BELİRLEME</strong> </div>
      </label></td>
    </tr>
    <tr>
            <td width="25%" class="generalFormCell">Ürün : </td>
            <td width="75%" class="generalFormCellInput"><select name="select_urun">
              <% for(int j=0; j<urun_names.size(); j++)
            {
            %>
            
              <option value="<%=urun_ids.get(j).toString()%>"> <%=urun_names.get(j).toString()%> </option>
           
           <%
           }
           %>   
            </select>            </td>
          </tr>
    <tr>
      <td class="generalFormCell">Alt Limit </td>
      <td><label>
        <input type="text" name="altLimit"  class="generalFormCellInput"/>
      </label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td class="generalFormCellInput">
      	<input type="image" name="Kaydet" value="Kaydet" class="formButton"  
      			src="../../index/images/kaydet.jpg" tabIndex="8"/>
      </td>
    </tr>
  </table>
</form>
		<%
           }
           %> 

        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
		
		
</td>
  </tr>

</table>
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisliği &copy;2006</font></b></p>
	</div>
	
	
	
	</div>
</body>
</html>




