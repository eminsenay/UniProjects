
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- Bu sayfa BÃ¶lÃ¼m Ba?kan?'n?n yeni yarat?lan bir fi?i onaylad??? sayfad?r. -->
<!-- Bu sayfada onaylanan bir fi?, RektÃ¶re gÃ¶nderilmektedir, -->
<!-- bunun iÃ§in de nextGroupID "00001D-GRP"ye -->
<!-- nextPageCode ise "../dek/dek1.jsp"ye set edilmektedir. -->
<!-- BÃ¶lÃ¼m Ba?kan? bir fi?i reddederse o fi? silinmektedir, -->
<!-- bunun iÃ§in de nextGroupID bÃ¶lÃ¼m ba?kan?n?n groupID'sine, -->
<!-- nextPageID ise "silindi.jsp"ye set edilmektedir. -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

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
int securityIndex=2;  //BurasÄ± javasecurity index parametresi

//SECURITY CODE END

Object[] parameters = new Object[6];
Object[] parameters2 = new Object[1];
//DB dbcon = new DB(true,"localhost","cmpe450_test","root","12345");
DB db = new DB(true);

//türkçe karakter çözümü
request.setCharacterEncoding("UTF-8");

//bu sayfa belli bir fi? iÃ§in Ã§al???yor, bu fi?in id'si en Ã¶nemli bilgilerden birisi
String requestFormID = (String)session.getAttribute("requestFormID");

//requestFormID = "00003Y-RFM";
System.out.println(requestFormID);


//----------------------------approve/disapprove----------------------------------------


//sayfa ilk aÃ§?ld???nda onay field?ndaki bilgiye gÃ¶re ne yapaca??n? belirleyecek
//e?er sayfa ilk olarak aÃ§?l?yorsa, onay field?n?n null olmas? gerekiyor
//onay null degilse ve value'su "onaylandi"ya e?itse, kullan?c? sayfay? onaylamak
//istedi?i anlam?na geliyor. imzay? verify et ve onay i?lemi iÃ§in db'den
//IstekAktar_sp'yi Ã§ag?r
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("onaylandi")) {

	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	System.out.println("onaylanmak uzere..");
	//ilk olarak imzay? verify etmemiz gerekiyor. bunun iÃ§in request'ten
	
	//eger hersey yolunda giderse, IstekAktar_sp'yi cagir
	String yorum = request.getParameter("yorum");
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	String nextGroupID = "000005-GRP";
	String nextPageCode = "../sat/sat1.jsp";
	
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
	
	parameters[0] = requestFormID;
	parameters[1] = nextGroupID;
	parameters[2] = nextPageCode;
	parameters[3] = userID;
	parameters[4] = yorum;
	parameters[5] = "1";
	
	ResultSet result31 = (db.executeSP("IstekAktar_sp", parameters)).getResult();
	
	//MODIFIED BY SECURITY
	if (session.getAttribute("securityEnabled").equals("true") && result31.next()) {
		//SECURITY CODE BEGINS
		String historyID = result31.getString(1);
		String security_signature = request.getParameter("imza");
		String security_documentContent = request.getParameter("document_content");
		String security_date = request.getParameter("securityDate");
		Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_REK1);
		//SECURITY CODE ENDS
	}
	
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/approve.jsp");
	System.out.println("gonderildi..");
	return;
}
else if(request.getParameter("onay") != null 
	 && request.getParameter("onay").equals("reddedildi")) {

	System.out.println("reddedilmek uzere..");
	String yorum = request.getParameter("yorum");
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	//String nextGroupID = ((User)session.getAttribute("userClass")).getgroupID();
	String nextGroupID = "000004-GRP";
	String nextPageCode = "../but/but2.jsp";
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	//db.executeQuery("call IstekAktar_sp('"+requestFormID+"','"+nextGroupID+"','"+nextPageCode+"','"+userID+"','"+yorum+"')");
	db.executeSP("IstekAktar_sp",new Object[]{requestFormID,nextGroupID,nextPageCode,userID,yorum,"0"}).getResult();

	//sessiondan aman requestFromID'yi remove et
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/reject.jsp");
	System.out.println("gonderildi..");
	return;
}


//----------------------------displaying----------------------------------------

boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null
&& ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;

//bu noktada db'den requestForm ile ilgili bilgileri Ã§ekiyoruz
//ResultSet _request = db.executeQuery("call IstekFisiGoster_sp('"+requestFormID+"')");
ResultSet _request = db.executeSP("IstekFisiGoster_sp",new Object[]{requestFormID}).getResult();

System.out.println("fisi aldi..mi?");
System.out.println(_request.getRow());
%>

<body>

<div id="toprightt"> </div>
  <div id="topright2"> 

<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="onayFormu" action="rek1.jsp" method="get">
  
  <%
  if(_request.next())
  {  
  %>
  
  <div align="center">
    <table width="79%"  border="0" id="baslik"  class="tablefont"> 
            <tr><td><img src="../../images/spacer.gif" height="20"></td>
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
      	String dahili= _request.getString("Dahili");
      	String piyasa="";
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
    	if(theDate == null)
    		theDate = "Yok";
    	else
    	{
    		String parca[] = theDate.split(" ");//yy-aa-gg tt:tt:tt geliyor
    		String parca2[] = parca[0].split("-");//get yy aa gg
    		theDate = parca2[2]+"/"+parca2[1]+"/"+parca2[0];
    	}
		//kurumsal kod 
		String kurumsalKod = _request.getString("KurumsalKod");
		
		//fonksiyonel kod
		String fonksiyonelKod = _request.getString("FonksiyonelKodu");
		
		//finansal kod
		String finansalKod = "2";
		
		//ekonomik kodu
		String anaKalemKodu = _request.getString("AnaKalemKodu");
		String kalemKodu = _request.getString("KalemKodu");
		
		String urunKodu = _request.getString("UrunKodu");
		String urunAdi = "Yok";
					
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
        <td colspan="4"><div align="center"><b>Tahmini</b></div></td>
      </tr>
      <tr>
         <td><div align="center"><b>Miktar</b></div></td>
         <td><div align="center"><b>&Uuml;r&uuml;n</b></div></td>
         <td><div align="center"><b>A&ccedil;&#305;klama</b></div></td>
         <td><div align="center"><b>Talep Eden</b></div></td>
         <td width="20%"><div align="center"><b>Birim Fiyat&#305; (YTL)</b></div></td>
         <td width="13%"><div align="center"><b>Tutar&#305; (YTL)</b></div></td>
     </tr>
      <%
      _request.previous();
      while(_request.next()) {
			//miktar
			String miktar = _request.getString("Miktar");
			//birim
			//String birim = _request.getString("...............");
			String birim = "birim";	
			
			//urun
			String urun = _request.getString("UrunNo");
			urunAdi = "Yok";
			//ResultSet temprs = db.executeQuery("call UrunGoster_sp('"+urun+"')");
			ResultSet temprs = db.executeSP("UrunGoster_sp",new Object[]{urun}).getResult();
			if(temprs.next())
				urunAdi = temprs.getString("UrunAdi");
			
			//aciklama
			String aciklama = _request.getString("Aciklama");
			// talep eden
  			String talepEden=_request.getString("Isteyen");
			
			//birimfiyat?
			double bfiyat = 0.0;
			String birimFiyat = _request.getString("TahminiFiyat");
			if(birimFiyat == null)
				birimFiyat = "Yok";
			else bfiyat = Double.parseDouble(birimFiyat);
			
			//tutari
			String tutar = String.valueOf(Integer.parseInt(miktar)*bfiyat);
	      %>
	      <tr>
	        <td><label><span id='security<%=securityIndex++ %>'><%=miktar%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=urunAdi%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=aciklama%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=talepEden%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=birimFiyat%></span></label></td>
	        <td><label><%=tutar%></label></td>
	      </tr>
      <%
      }
      %>
    </table>
  </div>
  
  <!-- yorum kutusu -->
  <br><div align="center">
   <input  type="textarea" name="yorum" value="Lutfen bir yorum giriniz." height="4"> 
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
  }
   else {
	//yok öyle bir fiş!
	//form id'yi sessiondan cikar
	session.removeAttribute("requestFormID");

	//db yi kapat
	db.closeConnection();
	
	//hata sayfasına git
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
	//tarihÃ§e muhabbeti, sayfanin basindaki kod bÃ¶lÃ¼mÃ¼nde set edilen
	//tarihGoster boolean variable?n?n degerine gore tarihÃ§eyi goster
	if(tarihGoster)	{
	%>
        <%@include file="../../security/istekTarihce.jsp_" %>
	<%
	}
   //Security der ki eger DB kullanmaya baslarsaniz objenizin ismi bu olsun o zmaan kaldirin bunu burdan 
	db.closeConnection();
	%>
</form>
</div>

  <a href="../onayBekleyenler/onaybekleyenler.jsp">&lt;&lt; Geri Dön</a>
  
  <div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black"> Bilgisayar Mühendisliği ©2005</font></b></p>
</div>
</body>
</html>