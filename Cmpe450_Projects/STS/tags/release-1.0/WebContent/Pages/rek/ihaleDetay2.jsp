<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Boğazi&ccedil;i &Uuml;niversitesi Sat&#305;n Alma Sistemi</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->
		
		function redDugmesi() {
			<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
			document.onayFormu.onay.value = "reddedildi";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
		
		function ilgiliFisler() {
			
			<!-- fieldinin icerigini toggle edecek -->
			if(document.onayFormu.fisGoster.value == "evet")
				document.onayFormu.fisGoster.value = "hayir";
			else
				document.onayFormu.fisGoster.value = "evet";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
	

</SCRIPT>


<%
//SECURITY CODE BEGIN
int securityIndex=2;  //Burası javasecurity index parametresi

//SECURITY CODE END
//türkçe karakter çözümü
request.setCharacterEncoding("UTF-8");

String IhaleNo=(String)session.getAttribute("IhaleNo");

DB db = new DB(true);

//------------------------------approve/disapprove----------------------------
if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("onaylandi")) {
	
	// ?lgili ihalenin DURUM field i 3 e set edilecek		
	if(db.execute("UPDATE IHALE set Durum=5 where IhaleNo='"+IhaleNo+"'"))
		System.out.println("Onaylama başarıyla tamamlandı.");
	
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	//following result3 is used by SECURITY
	if (session.getAttribute("securityEnabled").equals("true")) {
		//SECURITY CODE BEGINS
		String historyID = null;
		String security_signature = request.getParameter("imza");
		String security_documentContent = request.getParameter("document_content");
		String security_date = request.getParameter("securityDate");
		Security.addSignature(userID, IhaleNo,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_IHALEDETAY2);
		//SECURITY CODE ENDS
	}
	
	//db yi kapat
	db.closeConnection();
	response.sendRedirect("../../alerts/approve.jsp");
	return;
}
else if(request.getParameter("onay") != null 
		 && request.getParameter("onay").equals("reddedildi")) {
	
	if(db.execute("UPDATE IHALE set Durum=3 where IhaleNo='"+IhaleNo+"'"))
		System.out.println("Reddetme başarıyla tamamlandı.");
	
	//	db yi kapat
	db.closeConnection();
	response.sendRedirect("../../alerts/reject.jsp");
	return;
}

//------------------------------display----------------------------
boolean fisGosterFlag=false;
if(request.getParameter("fisGoster") != null
		&& ((String)request.getParameter("fisGoster")).equals("evet"))
			fisGosterFlag = true;

String IhaleAltTipi = "detaya ulasilamadi";
//String IhaleTipi = "detaya ulasilamadi";
String IhaleUrunTipi = "detaya ulasilamadi";


Date  Tarih = new Date();
String BelgeTarihi = String.valueOf(Tarih.getDate())+"/"+String.valueOf(Tarih.getMonth()+1)+"/"+String.valueOf(Tarih.getYear()+1900) ;

String IhaleAdi = "detaya ulasilamadi";
String IsinNiteligi = "detaya ulasilamadi";
String  IsinMiktari = "detaya ulasilamadi";

String BeklenenMaliyet = "detaya ulasilamadi";
double KdvliBeklenenMaliyet = 0.0;
String  KullanilabilirOdTut = "detaya ulasilamadi";
String  YatirimProjeNo = "detaya ulasilamadi";
String  ButceTertibi = "detaya ulasilamadi";
String  AvansSartlari = "detaya ulasilamadi";
String  IhaleUsulu = "detaya ulasilamadi";
String  IlanSekliAdedi = "detaya ulasilamadi";
String  OyidSatisBedeli = "detaya ulasilamadi";
String  BakanlarKuruluKarari = "detaya ulasilamadi";

String IhaleTarihi = "detaya ulasilamadi";
String KazananTeklifNo = "detaya ulasilamadi";

String FirmaAdi = "detaya ulasilamadi";
String TelNo = "detaya ulasilamadi";
String FirmaAdres = "detaya ulasilamadi";
String FirmaTanitim = "detaya ulasilamadi";
String TeklifFiyat = "detaya ulasilamadi";


ResultSet rs = db.executeSP("IhaleGoster_sp", new Object[]{IhaleNo}).getResult();


if(!rs.next())
{//yok oyle bi ihale
	//form id'yi sessiondan cikar
	session.removeAttribute("IhaleNo");

	//db yi kapat
	db.closeConnection();
	
	//hata sayfasına git
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
else
{ //tamam varmis
	
	IhaleAltTipi = rs.getString("IhaleAltTipi");
	if(IhaleAltTipi == null)
		IhaleAltTipi = "Yok";
	
	IhaleUrunTipi = rs.getString("IhaleUrunTipi");
	if(IhaleUrunTipi == null)
		IhaleUrunTipi = "Yok";
	//IhaleTipi = "detaya ulasilamadi";
	

	IhaleTarihi = rs.getString("IhaleTarihi");
	if(IhaleTarihi == null)
		IhaleTarihi = "Yok";
	else
	{
		String parca[] = IhaleTarihi.split("-");//yy-aa-gg geliyor
		IhaleTarihi = parca[2]+"/"+parca[1]+"/"+parca[0];
	}
	
	IhaleAdi = rs.getString("IhaleAdi");
	if(IhaleAdi == null)
		IhaleAdi = "Yok";
	IsinNiteligi = rs.getString("IhaleAdi");
	if(IsinNiteligi == null)
		IsinNiteligi = "Yok";
	IsinMiktari = rs.getString("IhaleAdi");
	if(IsinMiktari == null)
		IsinMiktari = "Yok";
	
	BeklenenMaliyet = rs.getString("BeklenenMaliyet");
	if(BeklenenMaliyet != null)
		KdvliBeklenenMaliyet = Double.parseDouble(BeklenenMaliyet)*0.18;
	else
		BeklenenMaliyet = "0.0";
	
	ResultSet res1=db.executeQuery("SELECT * FROM ISTEK_FISI WHERE IhaleNo='"+IhaleNo+"' " );
	if(res1.next())
	{
		String ifn = res1.getString("IstekFisiNo");
		
		ResultSet res2=db.executeSP("IstekFisiNoButceBlokeGoster_sp",new Object[]{ifn}).getResult();
		if(res2.next())
		KullanilabilirOdTut = res2.getString("Miktar");
		if(KullanilabilirOdTut == null)
		KullanilabilirOdTut = "Yok";
	}
	
	YatirimProjeNo = rs.getString("YatirimProjeNo");
	if(YatirimProjeNo == null)
		YatirimProjeNo = "Yok";
	ButceTertibi = rs.getString("ButceTertibi");
	if(ButceTertibi == null)
		ButceTertibi = "Yok";
	AvansSartlari = rs.getString("AvansSartlari");
	if(AvansSartlari == null)
		AvansSartlari = "Yok";
	IhaleUsulu = rs.getString("IhaleUsulu");
	if(IhaleUsulu == null)
		IhaleUsulu = "Yok";
	IlanSekliAdedi = rs.getString("IlanSekliAdedi");
	if(IlanSekliAdedi == null)
		IlanSekliAdedi = "Yok";
	OyidSatisBedeli = rs.getString("OyidSatisBedeli");
	if(OyidSatisBedeli == null)
		OyidSatisBedeli = "Yok";
	BakanlarKuruluKarari = rs.getString("BakanlarKuruluKarari");
	if(BakanlarKuruluKarari == null)
		BakanlarKuruluKarari = "Yok";
 
	KazananTeklifNo = rs.getString("KazananTeklifNo");
	if(KazananTeklifNo == null)
		KazananTeklifNo = "Yok";
	
	System.out.println(KazananTeklifNo);
	System.out.println(IhaleNo);
	
	ResultSet rs2 = db.executeQuery("select * from IHALE_TEKLIF where TeklifNo ='"+KazananTeklifNo+"' and IhaleNo = '"+IhaleNo+"' and Statu = '1'");
	if(rs2.next())
	{
		FirmaAdi = rs2.getString("FirmaAdi");
		if(FirmaAdi == null)
			FirmaAdi = "Yok";
		TelNo = rs2.getString("FirmaTel");
		if(TelNo == null)
			TelNo = "Yok";
		FirmaAdres = rs2.getString("FirmaAdres");
		if(FirmaAdres == null)
			FirmaAdres = "Yok";
		FirmaTanitim = rs2.getString("FirmaTanimi");
		if(FirmaTanitim == null)
			FirmaTanitim = "Yok";
		TeklifFiyat = rs2.getString("TeklifFiyati");
		if(TeklifFiyat == null)
			TeklifFiyat = "Yok";
	}
 
}



%>
<body>
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
<form name="onayFormu" method="post" action="ihaleDetay2.jsp">
  <div align="center">
  <table width="750" border="0"> 
  <tr>
    <td width="50" height="20"><img src="../../images/spacer.gif" width="100" height="20"></td>
    <td width="550" height="20"><img src="../../images/spacer.gif" width="550" height="20"></td>
  </tr>
  </table>
    <table width="700" border="1" class="tablefont3">
      <tr bordercolor="0">
        <td colspan="3"><div align="center"><strong>ONAY BELGESİ </strong></div></td>
      </tr>
      <tr bordercolor="0">
        <td width="388" ><strong>İHALEYİ YAPAN İDARENİN ADI </strong></td>
        <td colspan="2" ><div align="center"><strong>T.C BOĞAZİÇİ ÜNİVERSİTESİ </strong></div></td>
      </tr>
      <tr bordercolor="0">
        <td class="xl40"><strong>BELGE TARİH VE SAYISI </strong></td>
        <td width="242" ><div align="center" class="xl29"><%=BelgeTarihi%></div></td>
        <td width="148" >
          <div align="center"><span id='security<%=securityIndex++ %>'><%=IhaleNo%></span></div></td>
      </tr>
      <tr bordercolor="0">
        <td colspan="3" ><div align="center"><strong>REKTÖRLÜK MAKAMINA </strong></div></td>
      </tr>
    </table>
    <p>&nbsp;</p>
    <table width="700" border="1" class="tablefont3">
      <tr bordercolor="#000000">
        <td><div align="center"><strong>&#304;HALE İLE İLGİLİ BİLGİLER </strong></div></td>
      </tr>
    </table>

    <table width="700" border="1">
      <tr bordercolor="#000000">
        <td width="399"><div align="left">Yaklaşık Maliyet</div></td>
        <td width="135"><span id='security<%=securityIndex++ %>'><%=BeklenenMaliyet%></span></td>
        <td width="27"><strong>YTL</strong></td>
        <td width="100"><span id='security<%=securityIndex++ %>'><%=KdvliBeklenenMaliyet%></span></td>
        <td width="37"><strong>YTL</strong></td>
        <td width="62" class="style2">KDV Dahil </td>
      </tr>
      <tr bordercolor="#000000">
        <td><div align="left">Kullanılabilir Ödenek Tutarı</div></td>
        <td><span id='security<%=securityIndex++ %>' class="xl29"><%=KullanilabilirOdTut%></span></td>
        <td><strong>YTL</strong></td>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr bordercolor="#000000">
        <td><div align="left">Yatırım Proje Numarası (varsa)</div></td>
        <td colspan="5"><span id='security<%=securityIndex++ %>' class="xl29"><%=YatirimProjeNo%></span></td>
      </tr>
      <tr bordercolor="#000000">
        <td><div align="left">Bütçe Tertibi (varsa)</div></td>
        <td colspan="5"><span id='security<%=securityIndex++ %>' class="xl29"><%=ButceTertibi%></span></td>
      </tr>
      <tr bordercolor="#000000">
        <td><div align="left">Avans Verilecekse Şartları</div></td>
        <td colspan="5"><span id='security<%=securityIndex++ %>' class="xl29"><%=AvansSartlari%></span></td>
      </tr>
      <tr bordercolor="#000000">
        <td><div align="left">İhale Usulü</div></td>
        <td colspan="5"><span id='security<%=securityIndex++ %>' class="xl29"><%=IhaleUsulu%></span></td>
      </tr>
      <tr bordercolor="#000000">
        <td><div align="left">İlanın Şekli ve Adedi</div></td>
        <td colspan="5"><span id='security<%=securityIndex++ %>' class="xl29"><%=IlanSekliAdedi%></span></td>
      </tr>
      <tr bordercolor="#000000">
        <td><div align="left">Ön Yeterlik / İhale Dokümanı Satış Bedeli</div></td>
        <td colspan="5"><span id='security<%=securityIndex++ %>' class="xl29"><%=OyidSatisBedeli%></span></td>
      </tr>
      <tr bordercolor="#000000">
        <td><div align="left">Fiyat Farkı Ödenecekse Dayanağı Bakanlar Kurulu Kararı</div></td>
        <td colspan="5"><span id='security<%=securityIndex++ %>' class="xl29"><%=BakanlarKuruluKarari%></span></td>
      </tr>
    </table>
    <p>&nbsp;</p>
    <table width="700" border="1">
      <tr>
        <td><div align="center"><strong>Kazanan Firma Belgileri </strong></div></td>
      </tr>
    </table>
    <table width="700" border="1">
      <tr>
        <td width="135" class="xl40">İhale Tarihi </td>
        <td width="234"><span id='security<%=securityIndex++ %>' class="xl29"><%=IhaleTarihi%></span></td>
        <td width="103">Teklif No </td>
        <td width="204"><span id='security<%=securityIndex++ %>' class="xl29"><%=KazananTeklifNo%></span></td>
      </tr>
      <tr>
        <td>Firma Adı</td>
        <td colspan="3"><span id='security<%=securityIndex++ %>' class="xl29"><%=FirmaAdi%></span></td>
      </tr>
      <tr>
        <td>Firma Adres </td>
        <td colspan="3"><span id='security<%=securityIndex++ %>' class="xl29"><%=FirmaAdres%></span></td>
      </tr>
      <tr>
        <td>Firma Tel </td>
        <td colspan="3"><span id='security<%=securityIndex++ %>' class="xl29"><%=TelNo%></span></td>
      </tr>
      <tr>
        <td>Firma Tanımı</td>
        <td colspan="3"><span id='security<%=securityIndex++ %>' class="xl29"><%=FirmaTanitim%></span></td>
      </tr>
      <tr>
        <td>Teklif Fiyatı </td>
        <td colspan="3"><span id='security<%=securityIndex++ %>' class="xl29"><%=TeklifFiyat%></span></td>
      </tr>
    </table>
    <p>
		<!-- SECURITY ICIN HIDDEN FIELDLAR BEGIN -->
		    <input type="hidden" id='security_field_no' value="<%=securityIndex-1%>">
			<input type="hidden" name="imza" value="">
			<input type="hidden" name="document_content" value="">
			<input id="security1" type="hidden" name="securityDate" value="<%=System.currentTimeMillis()%>">
		<!-- SECURITY ICIN HIDDEN FIELDLAR END -->
      <input type="hidden" name="onay" value="">
      <input type="hidden" name="fisGoster" value="hayir">
      <!-- hidden fieldlar -->
      <!-- onay red dugmesi -->
    </p>
    <div align="center">
      <input name="button" type="button" onClick="parent.leftFrame.securityOnayDugmesi()" value="Onayla" language="JavaScript">
      <input name="button" type="button" onClick="redDugmesi()" value="Reddet" language="JavaScript">
    </div>
    <!-- ilgiliFisler goster dugmesi -->
    <br>
    <div align="center">
      <input name="button" type="button" onClick="ilgiliFisler()" value="İlgili İstekleri Göster" language="JavaScript">
    </div>
    <%
	
	//fisGoster boolean variable?n?n degerine gore ilgili fisleri goster
	if(fisGosterFlag)	{
	%>
    <br>
    <div align="center">
      <table bgcolor="#FFFFFF" width="438" border="0" cellspacing="0" cellpadding="0" class="tablefont">
        <tr>
          <td width="437"><div align="center"><strong>&#304;HALE &#304;LE &#304;LG&#304;L&#304; İSTEKLER <a name="Gecmis"></a></strong></div></td>
        </tr>
        <tr>
          <td><table bgcolor="#FFFFFF" width="800" border="3" cellspacing="0" cellpadding="0" class="tablefont">
              <tr>
                <td width="141"><div align="center">&#304;stek Fi&#351;i No</div></td>
                <td width="253"><div align="center">Olu&#351;turulma Tarihi</div></td>
                <td width="394"><div align="center">&#304;stekte Bulunan</div></td>
              </tr>
              <% 
					ResultSet result3=db.executeQuery("SELECT * FROM ISTEK_FISI WHERE IhaleNo='"+IhaleNo+"' and Statu = '1'" );
					while(result3.next()){
					%>
              <tr>
                <td width="141"><% 
						String t1=result3.getString("IstekFisiNo");
						out.print(t1);
						%></td>
                <td width="253"><% 
						String t2=result3.getString("OlusturmaTarihi");
						out.print(t2);
						%></td>
                <td width="394"><%
						String t3=result3.getString("Isteyen");
						out.print(t3);
						%></td>
              </tr>
              <%
					}
					%>
          </table></td>
        </tr>
      </table>
    </div>
    <%
	}
    db.closeConnection();
	%>
  </div>
</form>
</div>

</div>
</div>
<a href="../onayBekleyenler/rek5.jsp">&lt;&lt; Geri Dön</a> 
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color:black>Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
</div>


</body>
</html>
