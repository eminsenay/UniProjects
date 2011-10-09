<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>

    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- Bu sayfa Bölüm Ba?kan?'n?n yeni yarat?lan bir fi?i onaylad??? sayfad?r. -->
<!-- Bu sayfada onaylanan bir fi?, ilgili Dekana gönderilmektedir, -->
<!-- bunun için de nextGroupID "00001C-GRP"ye -->
<!-- nextPageCode ise "000001-PAG"ye set edilmektedir. -->
<!-- Bölüm Ba?kan? bir fi?i reddederse o fi? silinmektedir, -->
<!-- bunun için de nextGroupID bölüm ba?kan?n?n groupID'sine, -->
<!-- nextPageID ise "silindi.jsp"ye set edilmektedir. -->

<%
	request.setCharacterEncoding("UTF-8"); 

	//eger login olmadan acmaya calisirsa.  --bll
	if((session.getAttribute("userClass"))==null){
		   String error="ILK ONCE LOGIN OLMALISINIZ";
		   session.setAttribute("error",error);
		   response.sendRedirect("../../logout.jsp");
		   return;	   
	}
	
	DB db=new DB(true);
	
try{//sistemin en genel try catch blocğu  --bll
		
	

//SECURITY CODE BEGIN
int securityIndex=2;  //Burası javasecurity index parametresi

//SECURITY CODE END

//bu sayfa belli bir fis için çalisiyor, bu fisin id'si en önemli bilgilerden birisi
String requestFormID = (String)session.getAttribute("requestFormID");

//sayfa ilk açildiginda onay fieldindaki bilgiye göre ne yapacagini belirleyecek
//eger sayfa ilk olarak açiliyorsa, onay fieldinin null olmasi gerekiyor
//onay null degilse ve value'su "onaylandi"ya esitse, kullanici sayfayi onaylamak
//istedigi anlamina geliyor. imzayi verify et ve onay islemi için db'den
//IstekAktar_sp'yi çagir
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("onaylandi")) {
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	//ilk olarak imzayi verify etmemiz gerekiyor. bunun için request'ten
	//imza fieldini çekip, security'nin verify fonksiyonuna yolluyoruz
	//if(request.getParameter("imza") == null
	//|| !verify(request.getParameter("imza")))
	//	response.sendRedirect("hata");
	
	
	
	//not: eger bu sayfada fise yeni bir bilgi ekleniyorsa (sürekli 
	//kullandigimiz örnek "ihale fiyat?" gibi) once request'ten ilgili
	//fielddaki datayi oku ve sonra db'nin bu fieldi update etmekle 
	//ilgili sp'sini çag?r?p bu bilgiyi db'ye yaz

	//eger hersey yolunda giderse, IstekAktar_sp'yi cagir
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	//Dekanliga gonerilmesi icin group idyi set ediyoruz
	String groupID = ((User)session.getAttribute("userClass")).getgroupID();
	ResultSet nextGroupResultSet = db.executeSP("UstGrupGoster_sp",new Object []{groupID}).getResult();
	nextGroupResultSet.next(); 
	String nextGroupID=nextGroupResultSet.getString("GrupNo");
//	System.out.println("nextGroupID"+nextGroupID);
	//Ayni sekilde next pagei de dekan sayfasi olarak ayarliyoruz
	String nextPageCode = "../dek/dek1.jsp";
	String yorum = request.getParameter("yorum");
	if(yorum.equals("Lutfen bir yorum giriniz.")){
		yorum="Yorum girilmemis";
	}//eger bi yorum girilmemisse buraya aynen "Lutfen bir yorum giriniz." seklinde gelir
	//biz bunun yerine yorum girilmemis yazıyoruz
	
	//SECURITY CODE BEGIN
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
	db.executeSP("IstekAktar_sp", new Object [] {requestFormID, nextGroupID, nextPageCode, userID, yorum,"1"});
	//following result3 is used by SECURITY
	ResultSet result3 = db.getResult();
	if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
		//SECURITY CODE BEGINS
		String historyID = result3.getString(1);
		String security_signature = request.getParameter("imza");
		String security_documentContent = request.getParameter("document_content");
		String security_date = request.getParameter("securityDate");
		Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_BOL1);
		//SECURITY CODE ENDS
	}
	
	
	//bu sp'nin hatali dönmesi olasiligini kontrol et
	//basarili oldugunu varsayarsak
	//sessiondan aman requestFromID'yi remove et
	
	
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/approve.jsp");
	return;
}
else if(request.getParameter("onay") != null 
	 && request.getParameter("onay").equals("reddedildi")) {
		
	String nextPageCode = "../bol/sekreter.jsp";
	String yorum = request.getParameter("yorum");
	if(yorum.equals("Lutfen bir yorum giriniz.")){
		yorum="Yorum girilmemis";
	}//eger bi yorum girilmemisse buraya aynen "Lutfen bir yorum giriniz." seklinde gelir
	//biz bunun yerine yorum girilmemis yazıyoruz
	
		
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	String nextGroupID = ((User)session.getAttribute("userClass")).getgroupID();
	//System.out.println("userID :"+userID +"nextGroupID:"+nextGroupID);
	

	db.beginTransaction();
	
	db.executeSP("ButceBlokeKaldir_sp",new Object[]{requestFormID});
	
	db.executeSP("IstekAktar_sp",new Object []{requestFormID,nextGroupID,nextPageCode,userID,yorum,"0"}).getResult();
	
	db.commitTransaction();
	
	
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/reject.jsp");
	return;
}

boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null
&& ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;

	//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
	ResultSet result = db.executeSP("IstekFisiGoster_sp", new Object[]{requestFormID}).getResult();
	if(result.next()) ;	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
	
	
	//istek fisi gosterilemiyorsa bu bostur , burdan geri dönmeli adam --bll	
	//	patlamasın diye burdan redirect olur.
	else{ 
		session.setAttribute("error","İstek fişinde hata var . Detay gösterilemiyor");
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

</head>
<body>

<div id="toprightt"> </div>
<div id="topright2">

<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="onayFormu" action="bol1.jsp" method="post">
  <div align="center">
    <table width="79%"  border="0"  id="baslik" class="tablefont">
            <tr>
        <td width="27%" height="56"><p align="center"><strong> T.C. </strong></p>
        <p align="center"><strong>BO&#286;AZ&#304;&Ccedil;&#304; &Uuml;N&#304;VERS&#304;TES&#304;</strong> </p></td>
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
              <td width="49%">Seçilen Piyasa Seçenegi</td>
              <td width="51%"><span id='security<%=securityIndex++ %>'><%=piyasa%></span></td>
            </tr>
          </table>
        </div></td>
        <%
		//tarih
		String theDate = result.getString("OlusturmaTarihi");
		//kurumsal kod 
		String kurumsalKod = result.getString("KurumsalKod");
		//System.out.println("kurumsalKod"+kurumsalKod);
		//fonksiyonel kod
		String fonksiyonelKod = result.getString("FonksiyonelKodu");
		
		//butce dagilim No
		String butceDagilimNo= result.getString("ButceDagilimNo");
		//ana kalem adi
		String anaKalemAdi = result.getString("AnaKalemAdi");
		//kalem adi
		String kalemAdi = result.getString("KalemAdi");

//		mevcut tutar
		String mevcutTutar= result.getString("MevcutTutar");
		
		
        %>
        <td width="54%"><table width="100%"  border="1" bordercolor="#CCCCFF" class="tablefont">
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
            <td width="33%"><label>Bütçe Dağılım No</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=butceDagilimNo%></span></label></td>
          </tr>
          <tr>
           <td width="33%"><label>Ana Kalem Adı</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=anaKalemAdi%></span></label></td>
          </tr>
          <tr>
              <td width="33%" height="19"><label>Kalem Adı</label></td>
            <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=kalemAdi%></span></label></td>
          </tr>
          <tr>
              <td width="33%" height="19"><label>Mevcut Tutar</label></td>
            <td width="67%"><label><%=mevcutTutar%></label></td>
          </tr>
        </table></td>
      </tr>
    </table>
	<br>
	</div>
    <div align="center"><table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont2">
      <tr>
        <td width="19%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td colspan="3"><div align="center">Tahmini</div></td>
      </tr>
      <tr>
        <td><div align="center">Miktar</div></td>
        <td><div align="center">&Uuml;r&uuml;n</div></td>
        <td><div align="center">A&ccedil;&#305;klama</div></td>
        <td width="17%"><div align="center">Birim Fiyat&#305; (YTL)</div></td>
        <td width="13%"><div align="center">Tutar&#305; (YTL)</div></td>
      </tr>
      <%
      
      String tutar = "" ;
      result.previous();
      while(result.next()) {
			//miktar
			String miktar = result.getString("Miktar");
			//urun
			String urun = result.getString("UrunAdi");
			//aciklama
			String aciklama = result.getString("Aciklama");
			//birimfiyat?
			String birimFiyat = result.getString("TahminiFiyat");
			//String birimFiyat = "birimFiyat?";	
		
			try{
				tutar=""+(Double.parseDouble(miktar) * Double.parseDouble(birimFiyat)) ;				
			}catch(Exception e){
				e.printStackTrace();
			}
	      %>
	      <tr align="center">
	        <td><label><span id='security<%=securityIndex++ %>'><%=miktar%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=urun%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=aciklama%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=birimFiyat%></span></label></td>
	        <td><label><%=tutar%></label></td>
	      </tr>
      <%
      }
      %>
    </table></div>
 
   <br><br>
    
  <!-- yorum kutusu -->
  <br><div align="center">
  	<input type="textarea" name="yorum" value="Lütfen bir yorum giriniz." height="4">
  </div>
  
  <!-- onay ve red dugmeleri -->
  <br><div align="center">
  	<input class="tablefont3"   type="button" value="Onayla" onClick="parent.leftFrame.securityOnayDugmesi()" language="JavaScript">
  	<input class="tablefont3"   type="button" value="Reddet" onClick="redDugmesi()" language="JavaScript">
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
	session.setAttribute("error","bol/bol1.jsp : "+e);
   //response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
	%>

</form>
</div>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color:black>Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
	
	
</body>
</html>