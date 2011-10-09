<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- bu sayfa onay sayfas? için örnek ?ablon olacak. -->

<%
//security kodlar? buraya!!!
//security kodlar? bitti

//bu sayfa belli bir fi? için çal???yor, bu fi?in id'si en önemli bilgilerden birisi
String requestFormID = (String)session.getAttribute("requestFormID");

//sayfa ilk aç?ld???nda onay field?ndaki bilgiye göre ne yapaca??n? belirleyecek
//e?er sayfa ilk olarak aç?l?yorsa, onay field?n?n null olmas? gerekiyor
//onay null degilse ve value'su "onaylandi"ya e?itse, kullan?c? sayfay? onaylamak
//istedi?i anlam?na geliyor. imzay? verify et ve onay i?lemi için db'den
//IstekAktar_sp'yi çag?r
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("onaylandi")) {
	//ilk olarak imzay? verify etmemiz gerekiyor. bunun için request'ten
	//imza field?n? çekip, security'nin verify fonksiyonuna yolluyoruz
	//if(request.getParameter("imza") == null
	//|| !verify(request.getParameter("imza")))
	//	response.sendRedirect("hata");
	
	//not: eger bu sayfada fi?e yeni bir bilgi ekleniyorsa (sürekli 
	//kulland?g?m?z örnek "ihale fiyat?" gibi) once request'ten ilgili
	//fielddaki datay? oku ve sonra db'nin bu field? update etmekle 
	//ilgili sp'sini çag?r?p bu bilgiyi db'ye yaz

	//eger hersey yolunda giderse, IstekAktar_sp'yi cagir
	String yorum = request.getParameter("yorum");
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	String nextGroupID = "";
	String nextPageCode = "";
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	ResultSet result3 = DatabaseConnection.executeQuery("call IstekAktar_sp('"+requestFormID+"','"+nextGroupID+"','"+nextPageCode+"','"+userID+"','"+yorum+"')");
	//bu sp'nin hatal? dönmesi olas?l?g?n? kontrol et
	//basar?l? oldugunu varsayarsak
	//sessiondan aman requestFromID'yi remove et
	session.removeAttribute("requestFormID");
	response.sendRedirect("../../alerts/approve.jsp");
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
	String nextGroupID = "";
	String nextPageCode = "";
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	ResultSet result3 = DatabaseConnection.executeQuery("call IstekAktar_sp('"+requestFormID+"','"+nextGroupID+"','"+nextPageCode+"','"+userID+"','"+yorum+"')");
	//bu sp'nin hatal? dönmesi olas?l?g?n? kontrol et
	//basar?l? oldugunu varsayarsak
	//sessiondan aman requestFromID'yi remove et
	session.removeAttribute("requestFormID");
	response.sendRedirect("../../alerts/reject.jsp");
}

boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null
&& ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;

//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
ResultSet _request = DatabaseConnection.executeQuery("call IstekFisiGoster_sp('"+requestFormID+"')");
_request.next();	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>
<body>

<SCRIPT language="JavaScript">
	<!-- SECURITY JAVASCRIPT KODLARI -->
		function securityOnayDugmesi() {
			<!-- gecici olarak direk onayDugmesi() cagiriyorum -->
			onayDugmesi();
		}
	<!-- SECURITY JAVASCRIPT KODLARI -->
	
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

<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="onayFormu" action="details.jsp" method="get">
  <div align="center">
    <table width="79%"  border="0" id="baslik">
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
    <table width="79%"  border="0">
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
          <table width="98%"  border="0">
            <tr>
              <td width="49%">Se&ccedil;ilen Piyasa Se&ccedil;eneği</td>
              <td width="51%"> <%=piyasa%></td>
            </tr>
          </table>
        </div></td>
        <%
		//tarih
		String theDate = _request.getString("OlusturmaTarihi");
		//kurumsal kod 
		//String kurumsalKod = _request.getString("..............");
		String kurumsalKod = "kurumsal kod";
		//fonksiyonel kod
		//String fonksiyonelKod = _request.getString("................");
		String fonksiyonelKod = "fonksiyonelKod";
		//finansal kod
		//String finansalKod = _request.getString("...........");
		String finansalKod = "finansalKod";
		//ekonomik kodu
		//String ekonomikKod = _request.getString("...........");
		String ekonomikKod = "ekonomikKod";
		//proje no
		//String projeNo = _request.getString("...........");
		String projeNo = "projeNo";
        %>
        <td width="54%"><table width="100%"  border="1">
          <tr>
            <td width="33%"><label>Tarih</label></td>
            <td width="67%"><label  onFocus=""><%=theDate%></label></td>
          </tr>
          <tr>
           <td width="33%"><label>Kurumsal</label></td>
            <td width="67%"><label><%=kurumsalKod%></label></td>
          </tr>
          <tr>
            <td width="33%"><label>Fonksiyonel</label></td>
            <td width="67%"><label><%=fonksiyonelKod%></label></td>
          </tr>
          <tr>
            <td width="33%"><label>Finansal</label></td>
            <td width="67%"><label><%=finansalKod%></label></td>
          </tr>
          <tr>
           <td width="33%"><label>Ekonomik</label></td>
            <td width="67%"><label><%=ekonomikKod%></label></td>
          </tr>
          <tr>
              <td width="33%" height="19"><label>Proje No</label></td>
            <td width="67%"><label><%=projeNo%></label></td>
          </tr>
        </table></td>
      </tr>
    </table>
	<br>
	
    <table width="79%"  border="1">
      <tr>
        <td width="19%">&nbsp;</td>
        <td width="16%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td colspan="3"><div align="center">Tahmini</div></td>
      </tr>
      <tr>
        <td><div align="center">Miktar</div></td>
        <td><div align="center">Birim</div></td>
        <td><div align="center">&Uuml;r&uuml;n</div></td>
        <td><div align="center">A&ccedil;&#305;klama</div></td>
        <td width="17%"><div align="center">Birim Fiyat&#305; (YTL)</div></td>
        <td width="13%"><div align="center">Tutar&#305; (YTL)</div></td>
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
			//aciklama
			String aciklama = _request.getString("Aciklama");
			//birimfiyat?
			//String birimFiyat? = _request.getString("...........");
			String birimFiyat = "birimFiyat?";	
			//tutari
			String tutar = "tutar";	
	      %>
	      <tr>
	        <td><label><%=miktar%></label></td>
	        <td><label><%=birim%></label></td>
	        <td><label><%=urun%></label></td>
	        <td><label><%=aciklama%></label></td>
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
  	<input type="textarea" name="yorum" value="L&#252;tfen bir yorum giriniz." height="4">
  </div>
  
  <!-- onay ve red dugmeleri -->
  <br><div align="center">
  	<input type="button" value="Onayla" onClick="securityOnayDugmesi()" language="JavaScript">
  	<input type="button" value="Reddet" onClick="redDugmesi()" language="JavaScript">
  </div>
  
  <!-- tarih goster dugmesi -->
  <br><div align="center">
  	<input type="button" value="Tarih&ccedil;e G&#246;ster" onClick="tarihDugmesi()" language="JavaScript">
  </div>

	<!-- hidden fieldlar -->
		<!-- security için hidden fieldlar -->
			<input type="hidden" name="imza">
		<!-- security için hidden fieldlar -->
		
		<input type="hidden" name="onay" value="">
		<input type="hidden" name="tarihGoster" value="hayir">
	<!-- hidden fieldlar -->

	<%
	//tarihçe muhabbeti, sayfanin basindaki kod bölümünde set edilen
	//tarihGoster boolean variable?n?n degerine gore tarihçeyi goster
	if(tarihGoster)	{
	%>
        <br><div align="center">
		<table bgcolor="#FFFFFF" width="438" border="0" cellspacing="0" cellpadding="0" class="tablefont">
			<tr> 
               		 <td width="437">&#304;STEK F&#304;&#350;&#304; GEÇM&#304;&#350; B&#304;LG&#304;LER&#304;:<a name="Gecmis"></a></td>
            </tr>
			
			<tr><td><p>&nbsp;</p>			
				<table bgcolor="#FFFFFF" width="438" border="3" cellspacing="0" cellpadding="0" class="tablefont">
              		<tr>	
						<td width="174">??lem yapan</td>
						<td width="174">??lem zaman?</td>
						<td width="174">Bilgi</td>
					</tr>
					<% 
					ResultSet result3=DatabaseConnection.executeQuery("SELECT K.KUllaniciAdi, I.OlusturmaTarihi, G.Aciklama FROM GECMIS G, ISTEK_FISI I, KULLANICI K WHERE I.IstekFisiNo='"+requestFormID+"' and G.IstekFisiNo=I.IstekFisiNo and K.KullaniciNo=G.KullaniciNo");
					while(result3.next()){
					%>
					<tr> 
						<td width="174"><% 
						String t1=result3.getString("KullaniciAdi");
						out.print(t1);
						%></td>
						<td width="174"><% 
						String t2=result3.getString("OlusturmaTarihi");
						out.print(t2);
						%></td>
						<td width="174"><%
						String t3=result3.getString("Aciklama");
						out.print(t3);
						%></td>
					</tr>
					<%
					}
					%>
				</table>
			</td></tr>
		</table>
		</div>
	<%
	}
	%>
</form>
</div>
<div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black"> Bilgisayar
M&#252;hendisliği ©2005</font></b></p>
</div>
</body>
</html>