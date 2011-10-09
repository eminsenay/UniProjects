 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@page import="java.util.Hashtable"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- Bu sayfa Bölüm Ba?kan?'n?n yeni yarat?lan bir fi?i onaylad??? sayfad?r. -->
<!-- Bu sayfada onaylanan bir fi?, ilgili Dekana gönderilmektedir, -->
<!-- bunun için de nextGroupID "00001C-GRP"ye -->
<!-- nextPageCode ise "000001-PAG"ye set edilmektedir. -->
<!-- Bölüm Ba?kan? bir fi?i reddederse o fi? silinmektedir, -->
<!-- bunun için de nextGroupID bölüm ba?kan?n?n groupID'sine, -->
<!-- nextPageID ise "silindi.jsp"ye set edilmektedir. -->

<%

	
	if((session.getAttribute("userClass"))==null){	  
		   response.sendRedirect("../../logout.jsp");
		   return;	   
	}
	
	DB db=new DB(true);
	
try{
		
String redirect=request.getParameter("redirectPage");	
String redirect2=request.getParameter("redirect");

//SECURITY CODE BEGIN
int securityIndex=2;  //Burası javasecurity index parametresi



//SECURITY CODE END

//bu sayfa belli bir fis için çalisiyor, bu fisin id'si en önemli bilgilerden birisi
String requestFormID = (String)session.getAttribute("requestFormID");
System.out.println("satistek  "+requestFormID);

String IhaleNo= (String)request.getParameter("ihaleNo");

//sayfa ilk açildiginda onay fieldindaki bilgiye göre ne yapacagini belirleyecek
//eger sayfa ilk olarak açiliyorsa, onay fieldinin null olmasi gerekiyor
//onay null degilse ve value'su "onaylandi"ya esitse, kullanici sayfayi onaylamak
//istedigi anlamina geliyor. imzayi verify et ve onay islemi için db'den
//IstekAktar_sp'yi çagir
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("geridon")) {
	

	System.out.println("satistek2  "+requestFormID);
	
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect(redirect+"?ihaleNo="+IhaleNo+"&redirect="+redirect2);
	return;
}


boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null && ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;
	//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
ResultSet result = db.executeQuery("SELECT * FROM IHALE_TEKLIF WHERE IHALE_TEKLIF.TeklifNo ='"+requestFormID+"' AND IHALE_TEKLIF.Statu = '1'");
System.out.println("satistek3  "+requestFormID);	
if(result.next()) ;	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
	
	
	//istek fisi gosterilemiyorsa bu bostur , burdan geri dönmeli adam --bll	
	//	patlamasın diye burdan redirect olur.
	else{ 
		
		session.setAttribute("error","İhale Teklifinde hata var . Detay gösterilemiyor");
		db.closeConnection();
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
		return;	   
	}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">

<SCRIPT language="JavaScript">
	
	<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->
	
		function geridonDugmesi() {
			<!-- formdaki onay isimli hidden inputa "geridon" yaziliyor -->
			document.onayFormu.onay.value = "geridon";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
		
	
		
		function tarihDugmesi() {
			<!-- bu fonksiyon, tarih goster dugmesine basildikca, tarihGoster -->
			<!-- fieldinin icerigini toggle edecek -->
			if(document.onayFormu.tarihGoster.value == "evet")
				document.onayFormu.tarihGoster.value = "hayir";
			else
				document.onayFormu.tarihGoster.value = "evet";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
	
	<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->
</SCRIPT>

</head>
<body>

<div id="toprightt"> </div>
<div id="topright2">

<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="onayFormu" action="satistektakip.jsp" method="post">
  <input type="hidden" name="redirectPage" value="<%=redirect%>">
  <input type="hidden" name="ihaleNo" value="<%=IhaleNo%>">
    <input type="hidden" name="redirect" value="<%=redirect2%>">
  <div align="center">
    <table width="79%"  border="0"  id="baslik" class="tablefont">
            <tr><td><img src="../../images/spacer.gif" height="120"></td>
      </tr><tr>
        <td width="27%" height="56"><p align="center"><strong> T.C. </strong></p>
        <p align="center"><strong>BO&#286;AZ&#304;&Ccedil;&#304; &Uuml;N&#304;VERS&#304;TES&#304;</strong> </p></td>
        <td width="38%"><p align="center"><strong> IHALE TEKLIF </strong></p>
        
      </tr>
    </table>
	<br>
  </div>
  <div align="center">
    <table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont">
      <tr>
      
        <%
        String TeklifNo="detay mevcut değil";
        String Ihaleno="detay mevcut değil";
        String FirmaAdi="detay mevcut değil";
        String FirmaTel="detay mevcut değil";
        String FirmaAdres="detay mevcut değil";
        String FirmaTanimi="detay mevcut değil";
        String TeklifFiyati="detay mevcut değil";
        
		//tarih
		if (result.getString("TeklifNo") != null)
		 TeklifNo = result.getString("TeklifNo");
		//kurumsal kod
		if (result.getString("IhaleNo") != null)
		 Ihaleno = result.getString("IhaleNo");
		if (result.getString("FirmaAdi") != null)
		 FirmaAdi = result.getString("FirmaAdi");
		
		//butce dagilim No
		if (result.getString("FirmaTel") != null)
		 FirmaTel= result.getString("FirmaTel");
		//ana kalem adi
		if (result.getString("FirmaAdres") != null)
		 FirmaAdres = result.getString("FirmaAdres");
		//kalem adi
		if (result.getString("FirmaTanimi") != null)
		 FirmaTanimi = result.getString("FirmaTanimi");

		//		mevcut tutar
		if (result.getString("TeklifFiyati") != null)
		 TeklifFiyati= result.getString("TeklifFiyati");
		
        %>
        <td width="54%"><table width="100%"  border="1" bordercolor="#CCCCFF" class="tablefont">
          <tr>
            <td width="33%"><label>TeklifNo</label></td>
            <td width="67%"><label  onFocus=""><span id='security<%=securityIndex++ %>'><%=TeklifNo%></span></label></td>
          </tr>
          <tr>
           <td width="33%"><label>IhaleNo</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=Ihaleno%></span></label></td>
          </tr>
          <tr>
            <td width="33%"><label>FirmaAdi</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=FirmaAdi%></span></label></td>
          </tr>
          <tr>
            <td width="33%"><label>FirmaTel</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=FirmaTel%></span></label></td>
          </tr>
          <tr>
           <td width="33%"><label>FirmaAdres</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=FirmaAdres%></span></label></td>
          </tr>
          <tr>
              <td width="33%" height="19"><label>FirmaTanimi</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=FirmaTanimi%></span></label></td>
          </tr>
          <tr>
              <td width="33%" height="19"><label>TeklifFiyati</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=TeklifFiyati%></span></label></td>
          </tr>
        </table></td>
      </tr>
    </table>
	<br>
	
    <div align="center"><table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont2">
      
     
    </table></div>
  
 
   <br><br>
    

  
  <!-- onay ve red dugmeleri -->
  <br><div align="center">
  	<input class="tablefont3"   type="button" value="Geri Dön" onClick="geridonDugmesi()" language="JavaScript">
  </div>
  

	<!-- hidden fieldlar -->
		<!-- SECURITY ICIN HIDDEN FIELDLAR BEGIN -->
		    <input type="hidden" id='security_field_no' value="<%=securityIndex-1%>">
			<input type="hidden" name="imza" value="">
			<input type="hidden" name="document_content" value="">
			<input id="security1" type="hidden" name="securityDate" value="<%=System.currentTimeMillis()%>">
		<!-- SECURITY ICIN HIDDEN FIELDLAR END -->
		
		<input type="hidden" name="onay" value="">
		<% if(tarihGoster){%>
		<input type="hidden" name="tarihGoster" value="evet">
		<% }else{%>
		<input type="hidden" name="tarihGoster" value="hayir">
		<%}%>
	<!-- hidden fieldlar -->

	<%
	//tarihçe muhabbeti, sayfanin basindaki kod bölümünde set edilen
	//tarihGoster boolean variable?n?n degerine gore tarihçeyi goster
	if(tarihGoster)	{
	%>
   <!--  %@ include file="../../security/istekTarihce.jsp_" %> -->
	<%
	}
	

	db.closeConnection();

}catch(Exception e){
	e.printStackTrace();
	db.closeConnection();
	session.setAttribute("error","dek1.jsp : "+e);
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
	%>

</form>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisligi &copy;2005</font></b></p>
	</div>
</body>
</html>