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
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {
	font-size: 14px;
	color: #FF0000;
}
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

User userInfo = (User)(session.getAttribute("userClass"));
StockManagement sm = new StockManagement();

String select_dep="" ;
String birimNo="";
String rafNumarasi="";

String groupID;
groupID = userInfo.getgroupID();

/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
boolean GDC = false, DDC =false;
if(userInfo.positionID.equals("00000F-POS")){
	GDC = true;
	//select_dep= sm.getBirimIsmi(userInfo.getgroupID());
	//birimNo = sm.getBirimNo(select_dep);
	
	rafNumarasi= (String)request.getParameter("rafNumarasi");
}
if(userInfo.positionID.equals("000004-POS")){
	DDC = true;
	//select_dep= sm.getBirimIsmi(userInfo.getgroupID());
	//birimNo = sm.getBirimNo(select_dep);
}

if (!GDC && !DDC) { 
	session.setAttribute("error","Depo Cıkış sayfasına girme hakkınız yok.");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
}
else {
%>

		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
		<table width="100%" border="0">
	  <tr>
	    <td><p align="center"><strong>DEPO HARCAMA SONUCU</strong></p>
	    <table width="100%" border="0">	
	    
<%	    
 	
 	StockApproval sp = new StockApproval();

	//get parameters from depoCikis page

	
	//String select_urun="";
	//select_urun= request.getParameter("select_urun");
	String urunID = request.getParameter("select_urun");
	
	boolean flag=false;
	
	int miktar=0;
	try{
	miktar=Integer.valueOf(request.getParameter("miktar"));
	}
	catch(Exception x){
		
		flag=true;
		%>
		
		<tr>
         <td><strong><span class="style3">Lütfen miktar kısmına rakam girip tekrar deneyiniz!<strong></span></td>
         </tr>
         <tr>
		<td>		  <p class="style3"><a href="javascript:history.go(-1)">Geri</a></p> </td>

				</tr>
      
      
      <%
      
	}
	
	if(!flag)	{
	
		String aciklama="";
		aciklama= request.getParameter("aciklama");	
		//String birimID = sm.getBirimNo(select_dep);
	
		int currentAmount = 0;	// dusulmeden once
		int kalan = 0;			// dusuldukten sonra
		int limit=0;			// urunun limiti
		String uyari1= "Depodan harcamak istediğiniz miktar depoda mevcut olan miktardan büyüktür. Lütfen miktari duzelterek tekrar deneyiniz.";
		String uyari2= "Mal depodan başarıyla harcandı.";
		String uyari3= " adlı ürün için belirlenen limitin altına düşüldü!";
		
		
		if (DDC){ // akademik birim depo cikis islemleri	
			
			currentAmount = sm.getADKalan(groupID, urunID);
			if(miktar > currentAmount)	
			{
			%>
		
		 <tr>
            <td width="50%">Harcamak istediğiniz miktar : </td> <td width="50%"><strong><%=miktar %><strong></td>
         </tr>
         <tr>
            <td width="50%">Şu an depoda olan miktar : </td> <td width="50%"><strong><%=currentAmount %><strong></td>
         </tr>
         <tr>
            <td colspan="2"><strong><%=uyari1 %><strong></td>
         </tr>
         <tr>
		<td>		  <p class="style3"><a href="javascript:history.go(-1)">Geri</a></p> </td>

				</tr>
         
		<% }
		else {
			currentAmount -= miktar;
			sp.depoCikisDDC(groupID, urunID, miktar, aciklama);
			sm.spendADStock(groupID, urunID, miktar);
			kalan = sm.getADKalan(groupID, urunID);
		%>	
		
		 <tr>
            <td width="50%">Çıkarmak istediğiniz miktar : </td> <td width="50%"><strong><%=miktar %><strong></td>
         </tr>
         <tr>
            <td width="50%">Şu an depoda olan miktar : </td> <td width="50%"><strong><%=currentAmount + miktar%><strong></td>
         </tr>
          <tr>
            <td width="50%">İşlem sonrası depodaki miktar : </td> <td width="50%"><strong><%=currentAmount %><strong></td>
         </tr>
         <tr>
            <td colspan="2"><strong><%=uyari2 %><strong></td>
         </tr>

		<%	
			limit = sm.getADLimit(groupID, urunID);
			String urunIsmi="";
			urunIsmi = sm.getUrunAdi(urunID);
			if( kalan < limit)	
			{ %>
				<tr>
		            <td colspan="2"><strong><%=urunIsmi %><%=uyari3 %><strong></td>
		         </tr>
			
			<% }
		}
	}
	
	else if (GDC)		// genel depo cikis islemleri
	{
		currentAmount = sm.getGDKalan(urunID);
		if(miktar > currentAmount)	
		{ %>
			
			 <tr>
	            <td width="50%">Çıkarmak istediğiniz miktar : </td> <td width="50%"><strong><%=miktar %><strong></td>
	         </tr>
	         <tr>
	            <td width="50%">Şu an depoda olan miktar : </td> <td width="50%"><strong><%=currentAmount %><strong></td>
	         </tr>
	         <tr>
	            <td colspan="2"><strong><%=uyari1 %><strong></td>
	         </tr>
	         <tr>
	         <tr>
		<td>		  <p class="style3"><a href="javascript:history.go(-1)">Geri</a></p> </td>

				</tr>
		
		<% }
		else {
			currentAmount -= miktar;
			//String mktr = String.valueOf(miktar);
			sp.depoCikisGDC(urunID, miktar, rafNumarasi, aciklama);
			sm.spendStockGDC(urunID, miktar);
			kalan = sm.getGDKalan(urunID); 
			%>	
			
			 <tr>
	            <td width="50%">Çıkarmak istediğiniz miktar : </td> <td width="50%"><strong><%=miktar %><strong></td>
	         </tr>
	         <tr>
	            <td width="50%">Şu an depoda olan miktar : </td> <td width="50%"><strong><%=currentAmount + miktar%><strong></td>
	         </tr>
	          <tr>
	            <td width="50%">İşlem sonrası depodaki miktar : </td> <td width="50%"><strong><%=currentAmount %><strong></td>
	         </tr>
	         <tr colspan="2">
	            <td><strong><%=uyari2 %><strong></td>
	         </tr>

			<%	
			
			limit = sm.getGDLimit(urunID);
			String urunIsmi="";
			urunIsmi = sm.getUrunAdi(urunID);
			if( kalan < limit)	
			{ %>
				<tr>
		            <td><strong><%=urunIsmi %><%=uyari3 %><strong></td>
		         </tr>
		         <tr></tr>
			
			<% }
			}
			
		}
	}
	else{
%>

  </table>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
</table>

<% 
	}
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




