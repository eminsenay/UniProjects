<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="sts.stockFollowUp.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
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

User userInfo = (User)(session.getAttribute("userClass"));

/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
boolean GDC = false, DDC =false;
if(userInfo.positionID.equals("00000F-POS"))
	GDC = true;
else if(userInfo.positionID.equals("000004-POS"))	{
	DDC = true;
}
	
if (!GDC && !DDC) { 
	session.setAttribute("error","Urun gonderim sayfasına girme hakkınız yok.");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
}
else {
	global.DB db = new global.DB(true);
	StockManagement sm = new StockManagement();
	
	ResultSet rsToList = null;
	ResultSet rsGoodList = null;
	ResultSet rsFromName = null;
	

	//***********************************************************
	String from = userInfo.getgroupID();
	
	rsFromName = (ResultSet) db.executeSP("GetGroupName_sp",new Object [] {from}).getResult();
	rsFromName.next();
	String fromName = rsFromName.getString("GrupAdi");
	rsFromName.close();
	//DEGISMELI
	//Eger Depolar Birime Gore tutuluosa
	//grup ID den birim ID ve birim adı alınması gerekebilir.
	rsToList = (ResultSet) db.executeSP("GetGroups_sp").getResult();
	//rsToList = sm.getGroups();
	//if(GDC){
    //	rsToList = sm.getUnits();
    //}
    //else if(DDC){
    //	rsToList = sm.getDepartments();
    //}

	//***********************************************************
	if(GDC){
		//rsGoodList = sm.getExistingItemsGD();
		rsGoodList = (ResultSet) db.executeSP("GetExistingItemsGD_sp").getResult();
	}
	else if(DDC){
		//rsGoodList = sm.getExistingItemsAD(userInfo.getgroupID());
		rsGoodList = (ResultSet) db.executeSP("GetExistingItemsAD_sp",new Object[] {from}).getResult();
	}
	 //Grup ID'den Birim ID alinmali

%>

		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
	
	
	<table width="100%" border="0">
  <tr>
    <td><p align="center"><strong>Ürün Gönderim</strong></p>
      <form id="urunGonderimFormu" name="urunGonderimFormu" method="post" action="UrunGonderimAction.jsp">
        <table width="100%" border="0">
        	<tr>
            <td>Gönderen Birim : <%=fromName%></td>
            </tr>
            <tr></tr>
          	<tr>
            <td>Gönderilecek Birim :             </td>
            </tr>
          <tr>
            <td><select name="select_to">
            <%
            	//rsToList.first();
            	while(rsToList.next()){
            %>
              <option value="<%=rsToList.getString("GrupNo")%>"> <%=rsToList.getString("GrupAdi")%> </option>
            <%
           		}
           	%>
            </select></td>
          </tr>         
          <tr>
            <td>Ürün :             </td>
            </tr>
          <tr>
            <td><select name="select_urun">
             <%
            	//rsGoodList.first();
            	while(rsGoodList.next()){
            %>
              <option value="<%=rsGoodList.getString("UrunNo")%>"> <%=rsGoodList.getString("UrunAdi")%> </option>
            <%
           		}
           	%>
            </select></td>
            
          </tr>
          
          <tr>
          <td>
            	Raf Numarası:
            	</td>
            	</tr>
            	
            <tr>
          <td>	
            <input type="text" name="rafno" /></td>
          </tr>
          
          <tr>
            <td>Miktar : </td>
            </tr>
          <tr>
            <td><input type="text" name="miktar" /></td>
          </tr>
                  
            <tr>
            <td>Açıklama : </td>
            </tr>
          <tr>
            <td><textarea rows="4" cols="35" name="aciklama" /></textarea></td>
          </tr>          
          <tr>              
          <tr>
            <td><div align="center">
              <input type="submit" name="submit" value="Çıkış Yap" />            
            </div></td>
            </tr>
        </table>
      </form>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
</table>

<% // end of else
	rsGoodList.close();
	rsToList.close();
	db.closeConnection();
	} 
%>
	
				

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
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</div>
</body>
</html>
