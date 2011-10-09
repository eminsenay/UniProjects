<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">



<%
DB db=new DB(true);
request.setCharacterEncoding("UTF-8");
//bu sayfa belli bir fi? için çal???yor, bu fi?in id'si en önemli bilgilerden birisi
String requestFormID = (String)session.getAttribute("requestFormID");
System.out.println("Onay:" +request.getParameter("onay"));

//ihaleyle alım
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("al1")) {
	
	String yorum = request.getParameter("yorum");
	
	String nextGroupID = "000005-GRP";
	String nextPageCode = "../sat/satx";
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	String query = "call IstekAktar_sp('"+requestFormID+"','"+nextGroupID+"','"+nextPageCode+"','"+userID+"','"+yorum+"','1')";
	System.out.println(query);
	ResultSet result3 = db.executeQuery(query);

	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/approve.jsp");
	return;
}
//doğrudan alım
else if(request.getParameter("onay") != null 
	 && request.getParameter("onay").equals("al2")) {

	//System.out.println("yorum: "+request.getParameter("yorum"));
	String yorum = (String) request.getParameter("yorum");
	//System.out.println("yorum2: "+yorum);
	
	String nextGroupID = "000005-GRP";
	String nextPageCode = "../sat/sat10.jsp";
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	String query = "call IstekAktar_sp('"+requestFormID+"','"+nextGroupID+"','"+nextPageCode+"','"+userID+"','"+yorum+"','1')";
	//System.out.println(query);
	ResultSet result3 = db.executeQuery(query);

	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/approve.jsp");
	return;
	
}else if(request.getParameter("onay") != null 
		 && request.getParameter("onay").equals("red")) {
	
	String yorum = request.getParameter("yorum");
	
	String nextGroupID = "000004-GRP";

	String nextPageCode = "../but/but2.jsp";
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	ResultSet result3 = db.executeQuery("call IstekAktar_sp('"+requestFormID+"','"+nextGroupID+"','"+nextPageCode+"','"+userID+"','"+yorum+"','0')");

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
ResultSet _request = db.executeQuery("call IstekFisiGoster_sp('"+requestFormID+"')");
_request.next();	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript">
		
		function alim1() {
			<!-- formdaki onay isimli hidden inputa "al1" yaziliyor -->
			document.onayFormu.onay.value = "al1";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
		
		function alim2() {
			<!-- formdaki onay isimli hidden inputa "al2" yaziliyor -->
			document.onayFormu.onay.value = "al2";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
		
		function red() {
			<!-- formdaki onay isimli hidden inputa "red" yaziliyor -->
			document.onayFormu.onay.value = "red";
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
<form name="onayFormu" action="sat1.jsp" method="post">
  <div align="center">
    <table width="750"  border="0" id="baslik" class="tablefont">

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
          <label><%=fisKodu%></label>
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
      	if(dahili.equals("1"))
      		piyasa="Dahili Piyasa";
      	else
      		piyasa = "Harici piyasa";
      	%>
        <td width="46%" height="132"><div align="justify">
          <table width="98%"  border="1" class="tablefont">
            <tr>
              <td width="49%">Seçilen Piyasa Seçeneği</td>
              <td width="51%"> <%=piyasa%></td>
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
         <td width="54%"><table width="100%"  border="1" class="tablefont">
          <tr>
            <td width="33%"><label>Tarih</label></td>
            <td width="67%"><label  onFocus=""><span id='security<%=kalemAdi%>'><%=theDate%></span></label></td>
          </tr>
          <tr>
           <td width="33%"><label>Kurumsal</label></td>
            <td width="67%"><label><span id='security<%=kalemAdi%>'><%=kurumsalKod%></span></label></td>
          </tr>
          <tr>
            <td width="33%"><label>Fonksiyonel</label></td>
            <td width="67%"><label><span id='security<%=kalemAdi %>'><%=fonksiyonelKod%></span></label></td>
          </tr>
          <tr>
            <td width="33%"><label>Butce Dagılım No</label></td>
            <td width="67%"><label><span id='security<%=kalemAdi %>'><%=butceDagilimNo%></span></label></td>
          </tr>
          <tr>
           <td width="33%"><label>Ana Kalem Adı</label></td>
            <td width="67%"><label><span id='security<%= kalemAdi%>'><%=anaKalemAdi%></span></label></td>
          </tr>
          <tr>
              <td width="33%" height="19"><label>Kalem Adı</label></td>
            <td width="67%"><label><span id='security<%=kalemAdi %>'><%=kalemAdi%></span></label></td>
          </tr>
          <tr>
              <td width="33%" height="19"><label>Mevcut Tutar</label></td>
            <td width="67%"><label><span id='security<%=kalemAdi %>'><%=mevcutTutar%></span></label></td>
          </tr>
        </table></td>
      </tr>
    </table>
	<br>
	
    <table width="750"  border="1" class="tablefont2">
      <tr>
        <td width="19%">&nbsp;</td>
        <td width="16%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
     
        <td colspan="2"><div align="center"><b>Tahmini</b></div></td>
      </tr>
      <tr>
        <td><div align="center"><b>Miktar</b></div></td>
       
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
			
			
			//urun
			String urun = _request.getString("UrunNo");
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
	        <td><label><%=miktar%></label></td>
	    
	        <td><label><%=urun%></label></td>
	        <td><label><%=aciklama%></label></td>
	        <td><label><%=talepEden%></label></td>
	        <td><label><%=birimFiyat%></label></td>
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
   
  
  
  
  </div>
  
  <!-- onay ve red dugmeleri -->
  <br><div align="center">
  	<input class="tablefont3"  type="button" value="İhaleyle Alım" onClick="alim1()" language="JavaScript">
  	<input class="tablefont3"  type="button" value="Doğrudan Alım"  onClick="alim2()" language="JavaScript">
  	<input class="tablefont3"  type="button" value="Reddet"  onClick="red()"language="JavaScript">
  </div>
  
  <!-- tarih goster dugmesi -->
  <br><div align="center">
  	<input class="tablefont3" type="button" value="Tarihçe Göster" onClick="tarihDugmesi()" language="JavaScript">
  </div>

	<!-- hidden fieldlar -->

		<input type="hidden" name="onay" value="">
		<% if(tarihGoster){%>
		<input type="hidden" name="tarihGoster" value="evet">
		<% }else{%>
		<input type="hidden" name="tarihGoster" value="hayir">
		<%}%>
	<!-- hidden fieldlar -->

	<%
	if(tarihGoster)	{
		
		%>
	        <%@ include file="../../security/istekTarihce.jsp_" %>
		<%
		}
	
	db.closeConnection();
	%>
</form>
</div>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</body>
</html>