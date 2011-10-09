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

	//eger login olmadan acmaya calisirsa.  --bll
	if((session.getAttribute("userClass"))==null){	  
		   response.sendRedirect("../../logout.jsp");
		   return;	   
	}
	
	DB db=new DB(true);
	
try{//sistemin en genel try catch blo&#287;u  --bll
		
String redirect=request.getParameter("redirectPage");	
String redirect2=request.getParameter("redirect");

//SECURITY CODE BEGIN
int securityIndex=2;  //Buras&#305; javasecurity index parametresi



//SECURITY CODE END

//bu sayfa belli bir fis için çalisiyor, bu fisin id'si en önemli bilgilerden birisi
String requestFormID = (String)session.getAttribute("requestFormID");
System.out.println("satistek  "+requestFormID);

System.out.println("Redirect "+redirect );
String IhaleNo= (String)request.getParameter("ihaleNo");

//sayfa ilk açildiginda onay fieldindaki bilgiye göre ne yapacagini belirleyecek
//eger sayfa ilk olarak açiliyorsa, onay fieldinin null olmasi gerekiyor
//onay null degilse ve value'su "onaylandi"ya esitse, kullanici sayfayi onaylamak
//istedigi anlamina geliyor. imzayi verify et ve onay islemi için db'den
//IstekAktar_sp'yi çagir
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("geridon")) {
	
	
	session.removeAttribute("requestFormID");
	
	db.closeConnection();
	System.out.println("redirectPage");
	response.sendRedirect(redirect+"?ihaleNo="+IhaleNo+"&redirect="+redirect2);
	return;
}


boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null
&& ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;

//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
ResultSet result = db.executeQuery("call IstekFisiGoster_sp('"+requestFormID+"')");
if(result.next()) ;	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç


//istek fisi gosterilemiyorsa bu bostur , burdan geri dönmeli adam --bll	
//	patlamas&#305;n diye burdan redirect olur.
else{ 
	session.setAttribute("error","&#304stek fi&#351;inde hata var . Detay gösterilemiyor");
	db.closeConnection();
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;	   
}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
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
            <tr>
        <td width="27%" height="56"><p align="center"><strong> T.C. </strong></p>
        <p align="center"><strong>BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</strong> </p></td>
        <td width="38%"><p align="center"><strong> &#304;STEK F&#304;&#350;&#304; </strong></p>
        <%
        String sayfaAdi = result.getString("SayfaAdi");
        %>
        <p align="center"><%=sayfaAdi%></p></td>
        <%
        //fis no
		String fisKodu = result.getString("IstekFisiKodu");
        %>
        <td width="35%"><p align="center"><strong> Kod:</strong><strong>
          <label><span id='security<%=securityIndex++ %>'><%=fisKodu%></span></label>
        </strong></p></td>
      </tr>
    </table>
	<br>
  </div>
  <div align="center">
    <table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont">
      <tr>
      	<%
		//secilen piyasa secenegi. dahili 1 gelirse dahili piyasad?r de?ilse harici piyasad?r
      	String dahili= result.getString("Dahili");
      	String piyasa="";
      	if(dahili.equals("1"))
      		piyasa="Dahili Piyasa";
      	else
      		piyasa = "Harici Piyasa";
      	%>
        <td width="46%" height="132"><div align="justify">
          <table width="98%"  border="1" bordercolor="#CCCCFF" class="tablefont">
            <tr>
              <td width="49%" align="left">Seçilen Piyasa Seçene&#287;i</td>
              <td width="51%" align=left><span id='security<%=securityIndex++ %>'><%=piyasa%></span></td>
            </tr>
          </table>
        </div></td>
        <%
		//tarih
		String theDate="detay mevcut de&#287;il";
        String kurumsalKod="detay mevcut de&#287;il";
        String fonksiyonelKod="detay mevcut de&#287;il";
        String butceDagilimNo="detay mevcut de&#287;il";
        String anaKalemAdi="detay mevcut de&#287;il";
        String kalemAdi="detay mevcut de&#287;il";
        String mevcutTutar="detay mevcut de&#287;il";
        
        if (result.getString("OlusturmaTarihi") != null)
        theDate= result.getString("OlusturmaTarihi");
		//kurumsal kod 
		if (result.getString("KurumsalKod") != null)
		 kurumsalKod= result.getString("KurumsalKod");
		System.out.println("kurumsalKod"+kurumsalKod);
		//fonksiyonel kod
		if (result.getString("FonksiyonelKodu") != null)
		 fonksiyonelKod= result.getString("FonksiyonelKodu");
		
		//butce dagilim No
		if (result.getString("ButceDagilimNo") != null)
		butceDagilimNo= result.getString("ButceDagilimNo");
		//ana kalem adi
		if (result.getString("AnaKalemAdi") != null)
		 anaKalemAdi= result.getString("AnaKalemAdi");
		//kalem adi
		if (result.getString("KalemAdi") != null)
		 kalemAdi= result.getString("KalemAdi");

//		mevcut tutar
		if (result.getString("MevcutTutar") != null)
			mevcutTutar = result.getString("MevcutTutar");
		
		
        %>
        <td width="54%"><table width="100%"  border="1" bordercolor="#CCCCFF" class="tablefont">
          <tr>
            <td width="33%" align="left"><label>Tarih</label></td>
            <td width="67%" align="left"><label  onFocus=""><span id='security<%=securityIndex++ %>'><%=theDate%></span></label></td>
          </tr>
          <tr>
           <td width="33%" align="left"><label>Kurumsal</label></td>
            <td width="67%" align="left"><label><span id='security<%=securityIndex++ %>'><%=kurumsalKod%></span></label></td>
          </tr>
          <tr>
            <td width="33%" align="left"><label>Fonksiyonel</label></td>
            <td width="67%" align="left"><label><span id='security<%=securityIndex++ %>'><%=fonksiyonelKod%></span></label></td>
          </tr>
          <tr>
            <td width="33%" align="left"><label>Bütçe Da&#287;&#305;l&#305;m No</label></td>
            <td width="67%" align="left"><label><span id='security<%=securityIndex++ %>'><%=butceDagilimNo%></span></label></td>
          </tr>
          <tr>
           <td width="33%" align="left"><label>Ana Kalem Ad&#305;</label></td>
            <td width="67%" align="left"><label><span id='security<%=securityIndex++ %>'><%=anaKalemAdi%></span></label></td>
          </tr>
          <tr>
              <td width="33%" height="19" align="left"><label>Kalem Ad&#305;</label></td>
            <td width="67%" align="left"><label><span id='security<%=securityIndex++ %>'><%=kalemAdi%></span></label></td>
          </tr>
          <tr>
              <td width="33%" height="19" align="left"><label>Mevcut Tutar</label></td>
            <td width="67%" align="left"><label><span id='security<%=securityIndex++ %>'><%=mevcutTutar%></span></label></td>
          </tr>
        </table></td>
      </tr>
    </table>
	<br>
	
    <div align="center"><table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont2">
      <tr>
        <td width="19%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td colspan="3"><div align="center">Tahmini</div></td>
      </tr>
      <tr>
        <td><div align="center">Miktar</div></td>
        <td><div align="center">Ürün</div></td>
        <td><div align="center">Aç&#305;klama</div></td>
        <td width="13%"><div align="center">Piyasa Fiyat&#305; (YTL)</div></td>
        <td width="17%"><div align="center">Birim Fiyat&#305; (YTL)</div></td>
        <td width="13%"><div align="center">Tutar&#305; (YTL)</div></td>
        
      </tr>
      <%
      
      String tutar = "" ;
      String piyasafiyat="detay mevcut de&#287;il";
      String miktar="detay mevcut de&#287;il";
      String urun="detay mevcut de&#287;il"; 
      String aciklama="detay mevcut de&#287;il";
      String birimFiyat="detay mevcut de&#287;il";
      
      result.previous();
      while(result.next()) {
			//miktar
			if (result.getString("Miktar") != null)
			miktar = result.getString("Miktar");
			//urun
			if (result.getString("UrunAdi") != null)
			urun= result.getString("UrunAdi");
			//aciklama
			if (result.getString("Aciklama") != null)
			aciklama = result.getString("Aciklama");
			//birimfiyat?
			if (result.getString("PiyasaFiyati") != null)
				piyasafiyat=result.getString("PiyasaFiyati");
			//Piyasa Fiyati
			if (result.getString("TahminiFiyat") != null)
			birimFiyat = result.getString("TahminiFiyat");
				
		
			try{
				tutar=""+(Integer.parseInt(miktar) * Integer.parseInt(birimFiyat)) ;				
			}catch(Exception e){}
	      %>
	      <tr align="center">
	        <td><label><span id='security<%=securityIndex++ %>'><%=miktar%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=urun%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=aciklama%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=piyasafiyat%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=birimFiyat%></span></label></td>
	        <td><label><%=tutar%></label></td>
	      </tr>
      <%
      }
      %>
    </table></div>
  
 
   <br><br>
    

  
  <!-- onay ve red dugmeleri -->
  <br><div align="center">
  	<input class="tablefont3"   type="button" value="Geri Dön" onClick="geridonDugmesi()" language="JavaScript">
  </div>
  
  <!-- tarih goster dugmesi -->
  <br><div align="center">
  	<input class="tablefont3"   type="button" value="Tarihçe Göster" onClick="tarihDugmesi()" language="JavaScript">
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
     <%@ include file="../../security/istekTarihce.jsp_" %>
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
</div>
</div>
</form>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
	</div>
</body>
</html>