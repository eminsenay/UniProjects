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
	session.setAttribute("error","Depo Cıkış sayfasına girme hakkınız yok.");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
}
else {
	StockManagement sm = new StockManagement();
   	ArrayList urun_names = new ArrayList();
   	String groupID;
   	
   	global.DB db = new global.DB(true);
   	ResultSet rsGoodList = null;
   	

%>

		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
	
	
	<table width="100%" border="0">
  <tr>
    <td><p align="center"><strong>DEPO HARCAMA</strong></p>
      <form id="depoCikisFormu" name="depoCikisFormu" method="post" action="DepoCikisAction.jsp">
        <table width="100%" border="0">
        
        <% 
		
        if(GDC)	{
        	//urun_names = sm.getGDexistingItemNames();
        	rsGoodList = (ResultSet) db.executeSP("GetExistingItemsGD_sp").getResult();
        }
        if(DDC)	{
        	//String birimIsmi = sm.getBirimIsmi(userInfo.getgroupID());
        	//urun_names = sm.getADexistingItemNames(birimIsmi);
        	groupID = userInfo.getgroupID();
        	rsGoodList = (ResultSet) db.executeSP("GetExistingItemsAD_sp",new Object[] {groupID}).getResult();
        }

        %>     
          
          <tr>
            <td>Ürün : </td>
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
            <td>Miktar : </td>
            </tr>
          <tr>
            <td><input type="text" name="miktar" /></td>
          </tr>
          
             <%
		  
          if(GDC) {
        	  
        	  ResultSet raflar = null;
        	  raflar = (ResultSet) db.executeSP("GDepoRafGetir_sp").getResult();
        	  
        	  %>
        	  
           <tr>
            <td>Raf Numarası : </td>
            </tr>
           <tr>
	           <td><select name="rafNumarasi">
	            <%
	            	//rsGoodList.first();
	            	while(raflar.next()){
	            %>
	              <option value="<%=raflar.getString("RafNo")%>"> <%=raflar.getString("RafNo")%> </option>
	            <%
	           		}
	           	%>
	            </select></td>
           </tr>
          
          <% 
          raflar.close();
          } %>
          
          <tr>
            <td>Açıklama : </td>
            </tr>
          <tr>
            <td><textarea name="aciklama" cols="50"></textarea></td>
          </tr>
          

          <tr>
            <td><div align="center">
              <p>&nbsp;                </p>
              <p>
                <input type="submit" name="submit" value="Çıkış Yap" />            
                </p>
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



