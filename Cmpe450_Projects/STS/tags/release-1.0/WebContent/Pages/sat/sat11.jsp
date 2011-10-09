<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Vector"%>
  <% request.setCharacterEncoding("UTF-8"); %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- Bu sayfa Bölüm Ba?kan?'n?n yeni yarat?lan bir fi?i onaylad??? sayfad?r. -->
<!-- Bu sayfada onaylanan bir fi?, Rektöre gönderilmektedir, -->
<!-- bunun için de nextGroupID "00001D-GRP"ye -->
<!-- nextPageCode ise "../dek/dek1.jsp"ye set edilmektedir. -->
<!-- Bölüm Ba?kan? bir fi?i reddederse o fi? silinmektedir, -->
<!-- bunun için de nextGroupID bölüm ba?kan?n?n groupID'sine, -->
<!-- nextPageID ise "silindi.jsp"ye set edilmektedir. -->

<%DB db=new DB(true);



//SECURITY CODE BEGIN
int securityIndex=2;  //Burası javasecurity index parametresi
//Checked by Nuri for security codes


//SECURITY CODE END


//bu sayfa belli bir fi? için çal???yor, bu fi?in id'si en önemli bilgilerden birisi
String requestFormID = (String)session.getAttribute("requestFormID");
//String requestFormID="000018-REQ";
//sayfa ilk aç?ld???nda onay field?ndaki bilgiye göre ne yapaca??n? belirleyecek
//e?er sayfa ilk olarak aç?l?yorsa, onay field?n?n null olmas? gerekiyor
//onay null degilse ve value'su "onaylandi"ya e?itse, kullan?c? sayfay? onaylamak
//istedi?i anlam?na geliyor. imzay? verify et ve onay i?lemi için db'den
//IstekAktar_sp'yi çag?r
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("onaylandi")) {
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	//ilk olarak imzay? verify etmemiz gerekiyor. bunun için request'ten
	//imza field?n? çekip, security'nin verify fonksiyonuna yolluyoruz
	
	
		
	int max= Integer.parseInt(request.getParameter("num"));
	System.out.println("Max: "+max);
	String kazanan="";
	for (int i=0; i<=max;i++){
		kazanan=request.getParameter("kazanan"+i);
		System.out.println(kazanan);
		db.execute("update ISTEK_TEKLIF set Uygundur=1 where IstekTeklifNo='"+kazanan+"'");
	}
	
	
	//eger hersey yolunda giderse, IstekAktar_sp'yi cagir
	String yorum = request.getParameter("yorum");
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	String nextGroupID = "000003-GRP";
	String nextPageCode = "../ayn/ayn1.jsp";
	//********************************************************************
	//****** rek3 databasete yok, o uzden su an IstekAktar_sp Hata veriyor
    //********************************************************************
	
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
		Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_SAT11);
		//SECURITY CODE ENDS
	}
    
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/approve5.jsp");
	return;
}
else if(request.getParameter("onay") != null 
	 && request.getParameter("onay").equals("reddedildi")) {
	//burada imza verification'? olmayacak san?r?m
	//db'ye yeni field update etmek de söz konusu degil
	//sadece comment al?n?p, IstekAktar_sp cagrilacak,
	//ama bu kez nextPageCode ve nextGroupID fi?in geri
	//dönmesi gereken sayfaya göre set edilecek

	String yorum = request.getParameter("yorum");
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	String nextGroupID = "000007-GRP";
	String nextPageCode = "../rek/rek3.jsp";
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	db.executeSP("IstekAktar_sp", new Object [] {requestFormID, nextGroupID, nextPageCode, userID, yorum,"0"});
	//bu sp'nin hatal? dönmesi olas?l?g?n? kontrol et
	//basar?l? oldugunu varsayarsak
	//sessiondan aman requestFromID'yi remove et
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/reject.jsp");
	return;
}
else if(request.getParameter("onay") != null 
		 && request.getParameter("onay").equals("ekle")) {
	
 	String istekid= request.getParameter("istekid");
 	String f1= request.getParameter("f1");
 	String f2= request.getParameter("f2");
  	String f3= request.getParameter("f3").replace(',','.');;
  
  
	
	//Teklif eklenecek
	String sp="call IstekTeklifEkle_sp('"+istekid+"', '"+f1+"','','"+ f2+"','',"+ Double.valueOf(f3)+")";
	System.out.println(sp);
	db.execute(sp);

	
	}


boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null
&& ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;

//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
ResultSet _request = db.executeQuery("call IstekFisiGoster_sp('"+requestFormID+"')");
_request.next();	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
if ( _request == null ) System.out.println( "p was null" );
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>
<body>
<script language=javascript src="../validator.js"></script>

<div id="toprightt"> </div>

<div id="topright2">

<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="onayFormu" action="sat11.jsp" method="post">
  <div align="center">
    <table width="750"  border="0" id="baslik"  class="tablefont"> 
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
    <table width="750"  border="0" class="tablefont">
      <tr>
      	<%
		//secilen piyasa secenegi. dahili 1 gelirse dahili piyasad?r de?ilse harici piyasad?r
      	String dahili= _request.getString("Dahili");
      	String piyasa="";
      	if(dahili != null && dahili.equals("1"))
    		piyasa="Dahili Piyasa";
    
      	else
      		piyasa = "Harici Piyasa";
      	%>
        <td width="46%" height="132"><div align="justify">
          <table width="98%"  border="1" bordercolor="#CCCCFF"  class="tablefont">
            <tr>
              <td width="49%">Seçilen Piyasa Seçeneği</td>
              <td width="51%"><span id='security<%=securityIndex++ %>'><%=piyasa%></span></td>
            </tr>
          </table>
        </div></td>
        <%
		//tarih
		String theDate = _request.getString("OlusturmaTarihi");
		//kurumsal kod 
		String kurumsalKod = _request.getString("KurumsalKod");
		System.out.println("kurumsalKod"+kurumsalKod);
		//fonksiyonel kod
		String fonksiyonelKod = _request.getString("FonksiyonelKodu");
		
		//butce dagilim No
		String butceDagilimNo= _request.getString("ButceDagilimNo");
		//ana kalem adi
		String anaKalemAdi = _request.getString("AnaKalemAdi");
		//kalem adi
		String kalemAdi = _request.getString("KalemAdi");

//		mevcut tutar
		String mevcutTutar= _request.getString("MevcutTutar");
        %>
        
        <td width="54%"><table width="100%"  bordercolor="#CCCCFF" border="1" class="tablefont">
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
            <td width="33%"><label>Butce Dagılım No</label></td>
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
	
    <table width="750"  border="1" bordercolor="#CCCCFF" class="tablefont2">
      <tr>
        <td width="19%">&nbsp;</td>
        <td width="16%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td colspan="2"><div align="center"><b>Tahmini</b></div></td>
        <td width="20%">&nbsp;</td>
         <td width="20%">&nbsp;</td>
        
      </tr>
      <tr>
      	<td><div align="center"><b>İstek No</b></div></td> 
         <td><div align="center"><b>Miktar</b></div></td>
       
        <td><div align="center"><b>&Uuml;r&uuml;n</b></div></td>
        <td><div align="center"><b>A&ccedil;&#305;klama</b></div></td>
          <td><div align="center"><b>Talep Eden</b></div></td>
        <td width="17%"><div align="center"><b>Birim Fiyat&#305; (YTL)</b></div></td>
        <td width="13%"><div align="center"><b>Tutar&#305; (YTL)</b></div></td>
        <td><div align="center"><b>Firma Adi</b></div></td>
        <td><div align="center"><b>Teklif</b></div></td>
        </tr>
      <%
      _request.previous();
      Vector names = new Vector();
      
      String sp2="Select * from ISTEK_TEKLIF where (  ";
      while(_request.next()) {
    	  String istekno=_request.getString("IstekNo");
  	    	names.add(istekno);
  	    	sp2+="IstekNo= '"+istekno+"' or ";
      }
      
      sp2=sp2.substring(0,sp2.length()-3);
      sp2+=")";
      
      System.out.println(sp2);
     
      
      _request.beforeFirst();
      int j;
      for(j=0;_request.next();j++) {
    	  
    	    
    	 	String istekno=_request.getString("IstekNo");
			//miktar
			String miktar = _request.getString("Miktar");

			//urun
			String urun = _request.getString("UrunKodu");
			//aciklama
			String aciklama = _request.getString("Aciklama");
			// talep eden
  			String talepEden=_request.getString("Isteyen");
			
			//birimfiyat?
			String birimFiyat = _request.getString("TahminiFiyat");
				
			//tutari
			
			double tutar =(Double.parseDouble(birimFiyat)* Double.parseDouble(miktar));	
	      %>
	      <tr>
	         <td><label><span id='security<%=securityIndex++%>'><%=istekno%></span></label></td> 
	        <td><label><span id='security<%=securityIndex++%>'><%=miktar%></span></label></td>
	        <td><label><span id='security<%=securityIndex++%>'><%=urun%></span></label></td>
	        <td><label><span id='security<%=securityIndex++%>'><%=aciklama%></span></label></td>
	        <td><label><span id='security<%=securityIndex++%>'><%=talepEden%></span></label></td>
	        <td><label><span id='security<%=securityIndex++%>'><%=birimFiyat%></span></label></td>
	        <td><label><%=tutar%></label></td>
	        <% ResultSet rsx= db.executeQuery("Select * from ISTEK_TEKLIF where IstekNo='"+istekno+"'and Uygundur=1"); 
	        	rsx.next(); %>
        	<td><label><span id='security<%=securityIndex++%>'><%=rsx.getString("FirmaAdi")%></span></label></td>	
        	<td><label><span id='security<%=securityIndex++%>'><%=rsx.getDouble("TeklifFiyati")%></span></label></td>
	       
	       
	      </tr>
      <%
      }
      %>
     
    </table>
    <input type="button" value="Onayla" onClick="parent.leftFrame.securityOnayDugmesi()" language="JavaScript">
  	<input type="button" value="Reddet" onClick="redDugmesi()" language="JavaScript">
  	<br>
  	<input type="button" value="Tarihçe Göster" onClick="tarihDugmesi()" language="JavaScript">
     <input type="hidden" name="num" value="<%=(j-1)%>">
 
 
      <%ResultSet rs =db.executeQuery(sp2);
      
      	if(rs.next()){
      		rs.previous();
      	
      %>
     <br><div align="center">
	Tüm Teklifler:
	<br>
	<table width="750"  border="1" bordercolor="#CCCCFF" class="tablefont2">
	
      <tr>
      	<td><div align="center"><b>İstek No</b></div></td> 
      	<td><div align="center"><b>Teklif No</b></div></td> 
         <td><div align="center"><b>Firma Adı</b></div></td>
       
        <td><div align="center"><b>Firma Adresi</b></div></td>
        <td><div align="center"><b>Teklif ettiği fiyat</b></div></td>
         
        </tr>
       <%   	
      	while(rs.next()){
      	%> 
        <tr>
      	
        <td><div align="center"><b><span id='security<%=securityIndex++%>'><%=rs.getString("IstekNo")%></span></b></div></td>
        <td><div align="center"><b><span id='security<%=securityIndex++%>'><%=rs.getString("IstekTeklifNo")%></span></b></div></td>
         <td><div align="center"><b><span id='security<%=securityIndex++%>'><%=rs.getString("FirmaAdi")%></span></b></div></td>
         <td><div align="center"><b><span id='security<%=securityIndex++%>'><%=rs.getString("FirmaAdres")%></span></b></div></td>
         <td><div align="center"><b><span id='security<%=securityIndex++%>'><%=rs.getDouble("TeklifFiyati")%></span></b></div></td>
    
        </tr>
        <%} %>
    
</table>
     </div> 
     <%}%>
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
		
		function teklifekle(){
			           
			
		}
	
	<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->

</SCRIPT>
     
  <br><div align="center">
   <input  type="textarea" name="yorum" value="Lütfen bir yorum giriniz." height="4"> 
   
   </div>
  
 
  <!-- onay ve red dugmeleri -->
  <br><div align="center">
  	
  </div>
  
  <!-- tarih goster dugmesi -->
  <br><div align="center">
  	
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
	%>
</form>
</div>
</div>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</body>
</html>