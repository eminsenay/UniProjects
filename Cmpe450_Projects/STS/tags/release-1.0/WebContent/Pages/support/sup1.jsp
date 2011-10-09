<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- Bu sayfa Destek birimindeki Satin alma sorumlusunun gelen fisleri  onayladigi sayfadir. -->
<!-- Bu sayfada onaylanan bir fis, ilgili  daire baskanina gönderilmektedir, -->
<!-- nextPageCode ise "000101-PAG"ye set edilmektedir. -->
<!-- Fis reddedilirse, fis sistemden silinmektedir  -->

<%
request.setCharacterEncoding("UTF-8"); 
	//eger login olmadan acmaya calisirsa.  --bll
	if((session.getAttribute("userClass"))==null){	   
		   response.sendRedirect("../../logout.jsp");
		   return;	   
	}
	
	DB db=new DB(true);

try{//sistemin en genel try catch bloc&#287;u  --bll



	
//	SECURITY CODE BEGIN
	int securityIndex=2;  //Buras&#305; javasecurity index parametresi



//	SECURITY CODE END

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
	String grupID = ((User)session.getAttribute("userClass")).getgroupID();
	
	
	String yorum = request.getParameter("yorum");
	//databasede yorum girilmedigini tutmak istiyoruz.
	if(yorum.equals("Lutfen bir yorum giriniz."))
		yorum="Yorum girilmedi.";
		
	
	//Her support unit in bir ust birimi olmali fisi onlara gonderiyorsun.
	ResultSet result_nextGroupId = db.executeSP("UstGrupGoster_sp",new Object[]{grupID}).getResult();
		
	String nextGroupID =null;
	if(result_nextGroupId.next())
		nextGroupID = result_nextGroupId.getString("GrupNo");
	else{
		session.setAttribute("error","Secili bolume ait idari amirlik atanmamis.");
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
		db.closeConnection();
		return;
	}
	
	//Ayni sekilde next pagei de dekan sayfasi olarak ayarliyoruz
	String nextPageCode = "../support/supmud1.jsp";   // *******daha once ../supMudur/supmud1.jsp idi,klasor degisti
	
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
	db.executeSP("IstekAktar_sp", new Object [] {requestFormID, nextGroupID, nextPageCode, userID, yorum,"1"});
	//following result3 is used by SECURITY
	ResultSet result3 = db.getResult();
	if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
		//SECURITY CODE BEGINS
		String historyID = result3.getString(1);
		String security_signature = request.getParameter("imza");
		String security_documentContent = request.getParameter("document_content");
		String security_date = request.getParameter("securityDate");
		Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_SUP1);
		//SECURITY CODE ENDS
	}
	
	//bu sp'nin hatali dönmesi olasiligini kontrol et
	//basarili oldugunu varsayarsak
	//sessiondan aman requestFromID'yi remove et
	session.removeAttribute("requestFormID");
	response.sendRedirect("../../alerts/approve.jsp");
	db.closeConnection();
	return;
}
////// bunun yanlis oldugunu dusunduk ve degistirdik (Selime,Mehmet)


else if(request.getParameter("onay") != null
        && request.getParameter("onay").equals("reddedildi")) {
      
        ResultSet resultset = db.executeSP("IstekFisiSil_sp",new Object[]{requestFormID}).getResult();
      
       session.removeAttribute("requestFormID");
      
       response.sendRedirect("../../alerts/reject.jsp");
       db.closeConnection();

       return;
}


boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null
&& ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;

	//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
	ResultSet _request = db.executeSP("IstekFisiGoster_sp",new Object[]{requestFormID}).getResult();
	if(_request.next()) ;	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
	
	
	//istek fisi gosterilemiyorsa bu bostur , burdan geri dönmeli adam --bll	
	//	patlamas&#305;n diye burdan redirect olur.
	else{ 
		session.setAttribute("error","Istek fisinde hata var . Detay gösterilemiyor");
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
		return;	   
	}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>
<body>

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
<div id="toprightt"> </div>
<div id="topright2">

<!-- bu form sayfadaki tek form olmali ve action'i sayfanin kendisi olmali -->
<form name="onayFormu" action="sup1.jsp" method="post">
  <div align="center">
    <table width="79%"  border="0"  id="baslik" class="tablefont">
            <tr><td><img src="../../images/spacer.gif" height="120"></td>
      </tr><tr>
        <td width="27%" height="56"><p align="center"><strong> T.C. </strong></p>
        <p align="center"><strong>BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</strong> </p></td>
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
    <table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont">
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
          <table width="98%"  border="1" bordercolor="#CCCCFF" class="tablefont">
            <tr>
              <td width="49%" align="left">Seçilen Piyasa Seçenegi</td>
              <td width="51%" align="left"><span id='security<%=securityIndex++ %>'><%=piyasa%></span></td>
            </tr>
          </table>
        </div></td>
        <%
		//tarih
		String theDate = _request.getString("OlusturmaTarihi");
		//kurumsal kod 
		//String kurumsalKod = _request.getString("..............");
		//String kurumsalKod = "";
		//fonksiyonel kod
		//String fonksiyonelKod = _request.getString("................");
		//String fonksiyonelKod = "";
		//finansal kod
		//String finansalKod = _request.getString("...........");
		//String finansalKod = "";
		//ekonomik kodu
		//String ekonomikKod = _request.getString("...........");
		String ekonomikKod = _request.getString("AnaKalemKodu")+"."+_request.getString("KalemKodu");;
		//proje no
		//String projeNo = _request.getString("...........");
		//String projeNo = "5";
        %>
        <td width="54%"><table width="100%"  border="1" bordercolor="#CCCCFF" class="tablefont">
          <tr>
            <td width="33%" align="left"><label>Tarih</label></td>
            <td width="67%" align="left"><label  onFocus=""><span id='security<%=securityIndex++ %>'><%=theDate%></span></label></td>
          </tr>
          <!-- tr>
           <td width="33%"><label>Kurumsal</label></td>
          <td width="67%"><label><span id='security<%//=securityIndex++ %>'><%//=kurumsalKod%></span></label></td>
          </tr -->
          <!-- tr>
            <td width="33%"><label>Fonksiyonel</label></td>
            <td width="67%"><label><span id='security<%//=securityIndex++ %>'><%//=fonksiyonelKod%></span></label></td>
          </tr-->
          <!-- tr>
            <td width="33%"><label>Finansal</label></td>
            <td width="67%"><label><span id='security<%//=securityIndex++ %>'><%//=finansalKod%></span></label></td>
          </tr -->
          <tr>
           <td width="33%" align="left"><label>Ekonomik</label></td>
            <td width="67%" align="left"><label><span id='security<%=securityIndex++ %>'><%=ekonomikKod%></span></label></td>
          </tr>
          <!-- tr>
              <td width="33%" height="19"><label>Proje No</label></td>
            <td width="67%"><label><span id='security<%//=securityIndex++ %>'><%//=projeNo%></span></label></td>
          </tr -->
        </table></td>
      </tr>
    </table>
	<br>
	
    <div align="center"><table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont2">
      <tr>
        <td width="19%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td colspan="3"><div align="center">Tahmini</div></td>
      </tr>
      <tr>
        <td><div align="center">Miktar</div></td>
        <td><div align="center">Ürün</div></td>
        <td><div align="center">Aç&#305;klama</div></td>
        <td width="17%"><div align="center">Birim Fiyat&#305; (YTL)</div></td>
        <td width="13%"><div align="center">Tutar&#305; (YTL)</div></td>
      </tr>
      <%
      String AnaKalemKodu="den";
      String tutar = "" ;
      _request.previous();
      while(_request.next()) {
			//miktar
			String miktar = _request.getString("Miktar");
			//urun
			String urun = _request.getString("UrunAdi");
			//aciklama
			String aciklama = _request.getString("Aciklama");
			//birimfiyat?
			String birimFiyat = _request.getString("TahminiFiyat");
				
			//tutari
			
			
			try{
				tutar=""+(Integer.parseInt(miktar) * Double.parseDouble(birimFiyat)) ;				
			}catch(Exception e){}
			//bu anakalemnoyu almak icin gerekior
			
			AnaKalemKodu=_request.getString("AnaKalemKodu");
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
  	<input type="textarea" name="yorum" value="Lutfen bir yorum giriniz." height="4">
  </div>
  
  <!-- onay ve red dugmeleri -->
  <br><div align="center">
  	<input class="tablefont3"   type="button" value="Onayla" onClick="parent.leftFrame.securityOnayDugmesi()" language="JavaScript">
  	<input class="tablefont3"   type="button" value="Reddet" onClick="redDugmesi()" language="JavaScript">
  </div>
  
  <!-- tarih goster dugmesi -->
  <br><div align="center">
  	<input class="tablefont3"   type="button" value="Tarihce Goster" onClick="tarihDugmesi()" language="JavaScript">
  </div>

	<!-- hidden fieldlar -->
		<!-- security için hidden fieldlar -->
			<input type="hidden" id='security_field_no' value="<%=securityIndex-1%>">
			<input type="hidden" name="imza" value="">
			<input type="hidden" name="document_content" value="deeede  dadad">
			<input id="security1" type="hidden" name="securityDate" value="<%=System.currentTimeMillis()%>">
		<!-- security için hidden fieldlar -->
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
	
//	hata olu&#351;ursa adam&#305; korkutma kendin hallet  --bll
	}catch(Exception e){
		e.printStackTrace();
		db.closeConnection();
		session.setAttribute("error","/support/sup1.jsp : "+e);
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
		return;
	}
	%>
</form>

<center><a href="../printable.jsp" target="_blank">Yazdir</a></center>

	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="black">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
	</div>
</body>
</html>