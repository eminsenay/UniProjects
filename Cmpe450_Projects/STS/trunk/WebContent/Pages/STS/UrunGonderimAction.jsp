<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="sts.stockFollowUp.*"%>
<%@page import="java.sql.ResultSet"%>


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
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  <table border="0" cellspacing="0" cellpadding="0" width="600">
  
  <tr>
        <td width="50"><img src="../../images/spacer.gif" width="50"></td>
    <td valign="top">
    
    <% 

User userInfo = (User)(session.getAttribute("userClass"));
StockManagement sm = new StockManagement();

String select_to = request.getParameter("select_to");
String select_urun = request.getParameter("select_urun");
String aciklama = request.getParameter("aciklama");
String fromID = userInfo.getgroupID();
String rafno = request.getParameter("rafNumarasi");
int miktar = 0;
try{
miktar = Integer.valueOf(request.getParameter("miktar"));
}
catch(Exception ex){
	session.setAttribute("error","Geçerli Miktar Girilmesi Gerekli");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");	
}
//***********************************************************


/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
boolean GDC = false, DDC =false;
if(userInfo.positionID.equals("00000F-POS"))
	GDC = true;
else if(userInfo.positionID.equals("000004-POS"))	{
	DDC = true;
}

if (!GDC && !DDC) { 
	session.setAttribute("error","Depo Gönderim sayfasına girme hakkınız yok.");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
}
else {
%>

		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
		<table width="100%" border="0">
	  <tr>
	    <td><p align="center"><strong>DEPO ÇIKIŞ SONUCU</strong></p>
	    <table width="100%" border="0" cellpadding="0" cellspacing="0">	
	    
<%	    
 	
 	StockApproval sp = new StockApproval();

	int currentAmount = 0;	// dusulmeden once
	int kalan = 0;		// dusuldukten sonra
	int limit = 0;			// urunun limiti
	String uyari1= "Depodan çıkmak istediğiniz miktar depoda mevcut olan miktardan büyüktür. Lütfen bir daha deneyiniz.";
	String uyari2= "Mal depodan başarıyla çıkarıldı.";
	String uyari3= " adlı ürün için belirlenen limitin altına düşüldü!";
	
	if(DDC){
//		***********************************************************
		currentAmount = sm.getADKalan(fromID,select_urun);
	}
	else if(GDC){
//		***********************************************************
		currentAmount = sm.getGDKalan(select_urun);
	}
	%>
	 
	 <tr>
     	<td width="50%" class="generalFormCell">Çıkarmak istediğiniz miktar : </td>
     	<td width="50%" class="generalFormCell"><strong><%=miktar %><strong></td>
  	 </tr>
  	 <tr>
     <td width="50%" class="generalFormCell">Şu an depoda olan miktar : </td>
     <td width="50%" class="generalFormCell"><strong><%=currentAmount%><strong></td>
     </tr><%
	
	if(miktar > currentAmount)	
	{
	%>
         <tr>
            <td colspan="2" class="generalFormCell"><strong><%=uyari1 %><strong></td>
         </tr>
		<% }
		else {
			currentAmount -= miktar;
			
			if(DDC){
				//birinci tablodan cikariliyor
				sp.depoCikisDDC(fromID, select_urun, miktar,aciklama); 
				sm.spendADStock(fromID,select_urun,miktar);
				//ikinci taBLOYa giris yapilacak
				sm.addStockBD(select_to,select_urun,miktar);
				sp.depoGirisDDC(select_to,select_urun,miktar,aciklama);
				kalan = sm.getADKalan(fromID, select_urun);
			}
			else if(GDC){
//				birinci tablodan cikariliyor
				sp.depoCikisGDCtoBDG(select_to,select_urun,miktar,rafno,aciklama);
				sm.spendStockGDC(select_urun, miktar);
//				ikinci taBLOYa giris yapilacak
//				System.out.println("1 " + select_to);
				sm.addStockBD(select_to,select_urun,miktar);
//				System.out.println("2 " + select_to);
				sp.depoGirisDDC(select_to,select_urun,miktar,aciklama);
//				System.out.println("3 " + select_to);
				kalan = sm.getGDKalan(select_urun);
			}
			
		%>	
          <tr>
            <td width="50%" class="generalFormCell">İşlem sonrası depodaki miktar : </td>
            <td width="50%" class="generalFormCell"><strong><%=kalan %><strong></td>
         </tr>
         <tr>
            <td colspan="2" class="generalFormCell"><strong><%=uyari2 %><strong></td>
         </tr>

		<%	
			if(DDC){
				limit = sm.getADLimit(fromID, select_urun);
			}
			else if(GDC){
				limit = sm.getGDLimit(select_urun);	
			}
		
			if(kalan < limit)	
			{ %>
				<tr>
				   <td colspan="2" class="generalFormCell"><strong><%=sm.getUrunAdi(select_urun) %><%=uyari3 %><strong></td>
		        </tr>
			
			<% }
		}
%>

  </table>
</td>
  </tr>
</table>

<% // end of else
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