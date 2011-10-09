<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>İstek Detayları</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {font-size: 16px}
-->
</style>
</head>
<body>
<div id="toprightt"> </div>
<div id="topright2">

<SCRIPT language="JavaScript">
	
	<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->
	
		function onayDugmesi() {
			<!-- formdaki onay isimli hidden inputa "onaylandi" yaziliyor -->
			document.onayFormu.onay.value = "onaylandi";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
		
		function redDugmesi() {
			<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
			document.onayFormu.onay.value = "reddedildi";
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


<%
//SECURITY CODE BEGIN
int securityIndex=2;  //Burası javasecurity index parametresi

//SECURITY CODE END

//türkçe karakter çözümü
request.setCharacterEncoding("UTF-8");

//bu sayfa belli bir fi? için çal???yor, bu fi?in id'si en önemli bilgilerden birisi
String requestFormID = (String)session.getAttribute("requestFormID");

System.out.println("=====> :"+requestFormID);
DB db = new DB(true);

//---------------------approve/disaprove------------------------------------------------

if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("onaylandi")) {


	//eger hersey yolunda giderse, IstekAktar_sp'yi cagir
	String yorum = request.getParameter("yorum");
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	String nextGroupID = "000005-GRP";	//satin almanin grup idsi
	String nextPageCode = "../sat/sat11.jsp"; 
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	//	SECURITY CODE BEGIN
	boolean verification = true;
	if (session.getAttribute("securityEnabled").equals("true")) {
		String security_signature = request.getParameter("imza");
		String security_documentContent = request.getParameter("document_content");
		String security_date = request.getParameter("securityDate");
		session.setAttribute("securityDocument", security_documentContent);
		verification = global.Security.verifySignature(userID, security_documentContent, security_signature,security_date);
	}
	//SECURITY CODE END
	
	//MODIFIED BY SECURITY
	db.executeSP("IstekAktar_sp", 
			new Object [] {requestFormID, nextGroupID, nextPageCode, userID, yorum, "1"});
	//following result3 is used by SECURITY
	ResultSet result3 = db.getResult();
	if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
		//SECURITY CODE BEGINS
		String historyID = result3.getString(1);
		String security_signature = request.getParameter("imza");
		String security_documentContent = request.getParameter("document_content");
		String security_date = request.getParameter("securityDate");
		Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_REK3);
		//SECURITY CODE ENDS
	}
	
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/approve.jsp");
	return;
	
}
else if(request.getParameter("onay") != null 
		 && request.getParameter("onay").equals("reddedildi")) {
	
	//bir adim geriye gotur
	
	//IstekAktar_sp'yi cagir
	String yorum = request.getParameter("yorum");
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	String nextGroupID = "000005-GRP";	//satin almanin grup idsi
	String nextPageCode = "../sat/sat10.jsp"; 
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	ResultSet result3 = db.executeSP("IstekAktar_sp",
			new Object[]{requestFormID, nextGroupID, nextPageCode, userID, yorum, "0"}).getResult();
	//bu sp'nin hatal? dönmesi olas?l?g?n? kontrol et
	//basar?l? oldugunu varsayarsak
	//sessiondan aman requestFromID'yi remove et
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/reject.jsp");
	System.out.println("Reddetme basariyla tamamlandi.");
	return;
	
}

//---------------------display------------------------------------------------

boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null
&& ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;


//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
ResultSet _request = db.executeSP("IstekFisiGoster_sp",
		new Object[]{requestFormID}).getResult();

System.out.println(_request.getRow());

if(!_request.next())//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
{
	//yok öyle bir fiş!
	//form id'yi sessiondan cikar
	session.removeAttribute("requestFormID");

	//db yi kapat
	db.closeConnection();
	
	//hata sayfasına git
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}	
else
{ //tamam fis varmis

%>

<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="onayFormu" action="rek3.jsp" method="post">
  <div align="center">
    <table width="79%"  border="0" id="baslik"  class="tablefont"> 
            <tr><td><img src="../../images/spacer.gif" height="120"></td>
      </tr>
      <tr>
        <td width="27%" height="56"><p align="center"><strong> T.C. </strong></p>
        <p align="center"><strong>BO&#286;AZ&#304;&Ccedil;&#304; &Uuml;N&#304;VERS&#304;TES&#304;</strong> </p></td>
        <td width="38%"><p align="center"><strong> &#304;STEK F&#304;&#350;&#304; </strong></p>
        <%
        String sayfaAdi = _request.getString("SayfaAdi");
        %>
        <p align="center"><%=sayfaAdi%></p></td>
        <%
        //fis no
		String fisKodu = _request.getString("IstekFisiKodu");
        %>
        <td width="35%"><p align="center"><strong> Kod:</strong><strong>
          <label><span id='security<%=securityIndex++ %>'><%=fisKodu%></span></label>
        </strong></p></td>
      </tr>
    </table>
	<br>
  </div>
  <div align="center">
    <table width="79%"  border="0" class="tablefont">
      <tr>
      	<%
		//secilen piyasa secenegi. dahili 1 gelirse dahili piyasad?r de?ilse harici piyasad?r
      	String dahili = _request.getString("Dahili");
      	String piyasa ="";
      	if(dahili.equals("1"))
      		piyasa="Dahili Piyasa";
      	else
      		piyasa = "Harici Piyasa";
      	%>
        <td width="46%" height="132"><div align="justify">
          <table width="98%"  border="1" class="tablefont">
            <tr>
              <td width="49%">Seçilen Piyasa Seçeneği</td>
              <td width="51%"><span id='security<%=securityIndex++ %>'><%=piyasa%></span></td>
            </tr>
          </table>
        </div></td>
        <%
		//tarih
		String theDate = _request.getString("OlusturmaTarihi");
		
		//finansalKod,ekonomikKod,projeNo yerine 
		//ButceDagilimNo,AnaKalemAdi, KalemAdi gösterilmektedir.
		
		//kurumsal kod 
		String kurumsalKod = _request.getString("KurumsalKod");
		
		//fonksiyonel kod
		String fonksiyonelKod = _request.getString("FonksiyonelKodu");
		
		//finansal kod
		String finansalKod = "2";
		
		//String ekonomikKod = "ekonomikKod";
		//ekonomik kodu
		String anaKalemKodu = _request.getString("AnaKalemKodu");
		String kalemKodu = _request.getString("KalemKodu");
		String urunKodu = _request.getString("UrunKodu");
		
		String ekonomikKod = anaKalemKodu+"."+kalemKodu+"."+urunKodu;
		
        %>
		<td width="54%"><table width="100%"  border="1" class="tablefont">
          <tr>
            <td width="33%"><label>Tarih</label></td>
            <td width="67%"><label  onFocus=""><span id='security<%=securityIndex++ %>'><%=theDate%></span></label></td>
          </tr>
          <tr>
           <td width="33%"><label>Kurumsal</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=kurumsalKod%></span></label></td>
          </tr>
          <tr>
            <td width="33%"><label>Fonksiyonel</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=fonksiyonelKod%></span></label></td>
          </tr>
          <tr>
            <td width="33%"><label>Finansal</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=finansalKod%></span></label></td>
          </tr>
          <tr>
           <td width="33%"><label>Ekonomik</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=ekonomikKod%></span></label></td>
          </tr>
          </table></td>
      </tr>
    </table>
	<br>
	
    <table width="79%"  border="1" class="tablefont2">
      <tr>
        <td width="19%">&nbsp;</td>
        <td width="16%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td colspan="3"><div align="center"><b>Tahmini</b></div></td>
      </tr>
      <tr>
         <td><div align="center"><b>Miktar</b></div></td>
        <td><div align="center"><b>Birim</b></div></td>
        <td><div align="center"><b>&Uuml;r&uuml;n</b></div></td>
        <td><div align="center"><b>A&ccedil;&#305;klama</b></div></td>
          <td><div align="center"><b>Talep Eden</b></div></td>
        <td width="17%"><div align="center"><b>Birim Fiyat&#305; (YTL)</b></div></td>
        <td width="13%"><div align="center"><b>Tutar&#305; (YTL)</b></div></td>
      </tr>
      <%
      _request.previous();
      while(_request.next()) {
			//miktar
			String miktar = _request.getString("Miktar");		
			
			//birim
			//String birim = _request.getString("OlcuBirimi");
			String birim = "birim";	
			
			//urun
			String urun = _request.getString("UrunNo");
			String urunAd = "Yok";
			ResultSet temprs = db.executeSP("UrunGoster_sp",
					new Object[]{urun}).getResult();
			if(temprs.next())
				urunAd = temprs.getString("UrunAdi"); 
			
			//aciklama
			String aciklama = _request.getString("Aciklama");
			
			// talep eden
  			String talepEden=_request.getString("Isteyen");
			
			//birimfiyat?
			//String birimFiyat? = _request.getString("BirimFiyati");
			String birimFiyat = "100";	
			
			//tutari
			double tutar = Double.parseDouble(birimFiyat)* Integer.parseInt(miktar);	
	      %>
	      <tr>
	        <td><label><span id='security<%=securityIndex++ %>'><%=miktar%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=birim%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=urunAd%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=aciklama%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=talepEden%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=birimFiyat%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=tutar%></span></label></td>
	      </tr>
      <%
      }
      %>
    </table>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
  </div>
  

 

   <!-- all teklifs -->
   	<table width="79%" border="1" align="center">
    <tr>
      <td width="9%" rowspan="2">No</td>
      <td width="19%" rowspan="2"><div align="center" class="style1">Mal / Hizmet / Yapım İşi</div></td>
      <td colspan="6"><div align="center"><strong>Teklif İstenen Kişi / Firmalar ve Fiyat Teklifleri (YTL, Ykr) </strong></div></td>
    </tr>
		<tr>
	      <td width="31%">Firma Adı</td>
	    <td width="35%">Fiyat Teklifi </td>
    </tr>
    
 <%  
 int no1 = 1;
 
 ResultSet istekler = db.executeSP("IstekGosterIstekFisineGore_sp",
		 new Object[]{requestFormID}).getResult();
 
 while(istekler.next())
 { %>
 	 
		<%//urun
		String urun = istekler.getString("UrunNo");
		String urunAdi = "Yok";
		ResultSet temprs = db.executeSP("UrunGoster_sp",
				new Object[]{urun}).getResult();
		if(temprs.next())
			urunAdi = temprs.getString("UrunAdi"); 
	 
	 System.out.println("a istek..");
	 
	 ResultSet teklifler = db.executeSP("IstekTeklifleriGoster_sp",
			 new Object[]{istekler.getString("IstekNo")}).getResult();

	 String  f1 = "_";
	 String  t1 = "_";

	 while(teklifler.next())
	 {
		 System.out.println("a teklif..");

				    if(teklifler.getString("FirmaAdi") != null )
						f1 = teklifler.getString("FirmaAdi");
					if(teklifler.getString("TeklifFiyati") != null )
						t1 = teklifler.getString("TeklifFiyati");
		   
	 %>
	 
	    <tr>
	      <td><span id='security<%=securityIndex++ %>'><%=no1%></span></td>
	      <td><span id='security<%=securityIndex++ %>'><%=urunAdi%></span></td>
	      <td><span id='security<%=securityIndex++ %>'><%=f1%></span></td>
	      <td><span id='security<%=securityIndex++ %>'><%=t1%></span></td>
      </tr>
	  
	<% 
	}

	no1++; %>

<%}
%> 
 
</table>
  

  <!-- uygun teklif -->
  
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <table width="79%" border="1" align="center">
    <tr>
      <td width="5%" rowspan="2">No</td>
      <td width="35%" rowspan="2"><div align="center"><span class="style1">Mal / Hizmet Yapım İşi</span></div></td>
      <td colspan="3"><div align="center"><strong>Uygun Görülen Kişi / Firma / Firmalar</strong></div></td>
    </tr>
    <tr>
      <td width="19%"><div align="center">Adı</div></td>
      <td width="17%"><div align="center">Adresi</div></td>
      <td width="24%"><div align="center" class="style1">Teklif Ettiği Fiyat YTL ,Ykr</div></td>
    </tr>
    
	 <%
 
	 int no2 = 1;
	 
	 ResultSet istekler2 = db.executeSP("IstekGosterIstekFisineGore_sp",
			 new Object[]{requestFormID}).getResult();
	 
	 while(istekler2.next())
	 {
	 
	 ResultSet kazananteklif = db.executeSP("IstegeUygunTeklifGoster_sp",
			 new Object[]{istekler2.getString("IstekNo")}).getResult();
	 
		 if(kazananteklif.next())
		 {
			 String urunNo = istekler2.getString("UrunNo");
				String urunAdi = "Yok";
				ResultSet temprs = db.executeSP("UrunGoster_sp",
						new Object[]{urunNo}).getResult();
				if(temprs.next())
					urunAdi = temprs.getString("UrunAdi"); 
		 %>

	    <tr>
	      <td><span id='security<%=securityIndex++ %>'><%=no2%></span></td>
	      <td><span id='security<%=securityIndex++ %>'><%=urunAdi%></span></td>
	      <td><span id='security<%=securityIndex++ %>'><%=kazananteklif.getString("FirmaAdi")%></span></td>
	      <td><span id='security<%=securityIndex++ %>'><%=kazananteklif.getString("FirmaAdres")%></span></td>
	      <td><span id='security<%=securityIndex++ %>'><%=kazananteklif.getString("TeklifFiyati")%></span></td>
	    </tr>
    
    	<%}
    	
    	no2++;
    }
    %>
    
  </table>
  <p align="center">&nbsp;</p>
  <p><br>
  </p>
  <div align="center">
   <input  type="textarea" name="yorum" value="Lütfen bir yorum giriniz." height="4"> 
   <!-- <textarea name="yorum" cols="60" rows="5" value="Lutfen bir yorum giriniz."> </textarea> -->
  
  
  
  </div>
  
  <!-- onay ve red dugmeleri -->
  <br><div align="center">
  	<input type="button" value="Onayla" onClick="parent.leftFrame.securityOnayDugmesi()" language="JavaScript">
    <input type="button" value="Reddet" onClick="redDugmesi()" language="JavaScript">
  </div>
  
  <!-- tarih goster dugmesi -->
  <br><div align="center">
  	<input type="button" value="Tarihçe Göster" onClick="tarihDugmesi()" language="JavaScript">
  </div>

	<!-- hidden fieldlar -->
		<!-- SECURITY HIDDEN FIELDS BEGIN -->
		    <input type="hidden" id='security_field_no' value="<%=securityIndex-1%>">
			<input type="hidden" name="imza" value="">
			<input type="hidden" name="document_content" value="">
			<input id="security1" type="hidden" name="securityDate" value="<%=System.currentTimeMillis()%>">
		<!-- SECURITY  HIDDEN FIELDS END -->
		
		<input type="hidden" name="onay" value="">
		<input type="hidden" name="tarihGoster" value="hayir">
	<!-- hidden fieldlar -->

	<%
	//tarihçe muhabbeti, sayfanin basindaki kod bölümünde set edilen
	//tarihGoster boolean variable?n?n degerine gore tarihçeyi goster
	if(tarihGoster)	{
	%>
        <%@include file="../../security/istekTarihce.jsp_" %>
	<%
	}
	
	db.closeConnection();
	
	}%>
</form>

<a href="../onayBekleyenler/onaybekleyenler.jsp">&lt;&lt; Geri Dön</a>
</div>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
</div>
</body>
</html>