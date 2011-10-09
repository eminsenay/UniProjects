<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@ page import="java.util.Date" %>


<% // TO DO: set .12 precision of double
   //		 bu fatura tarihini düzelttim galiba, ama sayfayı iyi tanımadığım için emin değilim - can%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Ayniyat Tesell&uuml;m Makbuzu</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	font-size: 36px;
	font-weight: bold;
}
.style2 {font-size: 12px}
.style5 {font-size: 18px}
.style6 {
	font-size: 18px;
	font-weight: bold;
}
.style7 {font-size: 16px}
-->
</style>
</head>

<body>
<div id="toprightt"> </div>
<div id="topright2">
<SCRIPT language="JavaScript">
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
		
	function printPage() { print(document); }
</SCRIPT>


<%
int securityIndex = 2;

String satinAlmaGrupNo = "000005-GRP";
String satinAlmaNextPage = "../sat/sat15.jsp";

String requestFormID = (String)session.getAttribute("requestFormID");
String userID = ((User)session.getAttribute("userClass")).getUserid();

DB dbcon = new DB(true);

//türkçe karakter çözümü
request.setCharacterEncoding("UTF-8");

ResultSet fisBilgileri = dbcon.executeSP("IstekFisiGoster_sp",
		new Object[]{requestFormID}).getResult();
ResultSet ayniyatBilgileri = dbcon.executeSP("AyniyatBilgileriGoster_sp",
		new Object[]{requestFormID}).getResult();
ResultSet faturaKalemleri = dbcon.executeSP("FaturaKalemleriGoster_sp",
		new Object[]{requestFormID}).getResult();

//tarih
Calendar cal = new GregorianCalendar();
int buYil = cal.get(Calendar.YEAR);
int buAy = cal.get(Calendar.MONTH) + 1 - Calendar.JANUARY;
int buGun =	cal.get(Calendar.DAY_OF_MONTH);
String tarih = ""+buYil+"-"+buAy+"-"+buGun; //bugunun tarihi

if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("onaylandi")) {
	//istekAktar parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	
	//yorum
	String yorum = (String)session.getAttribute("yorum");

	dbcon.beginTransaction();
	try {
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
		
		//onay yapmadan once DB deki AyniyatBilgileri  update et
		dbcon.executeSP("AyniyatMakbuzuEkle_sp",
				new Object[]{requestFormID, tarih});
			
		//satin almaya gonder
		dbcon.executeSP("IstekAktar_sp",
				new Object[]{requestFormID, satinAlmaGrupNo, satinAlmaNextPage, userID, yorum, "1"});
		
		ResultSet result3 = dbcon.getResult();
		if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
			//SECURITY CODE BEGINS
			String historyID = result3.getString(1);
			
			dbcon.commitTransaction();
			dbcon.closeConnection();
			
			String security_signature = request.getParameter("imza");
			String security_documentContent = request.getParameter("document_content");
			String security_date = request.getParameter("securityDate");
			Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_AYN3);
			//SECURITY CODE ENDS
		}
		else {
			dbcon.commitTransaction();
			dbcon.closeConnection();
		}
	
		session.removeAttribute("requestFormID");
		
		
		response.sendRedirect("../../alerts/approve.jsp");
		return;
	} catch(Exception e) {
		session.removeAttribute("requestFormID");
		
		dbcon.commitTransaction();
		dbcon.closeConnection();
		
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
		return;
	}
}
if(fisBilgileri.next() && ayniyatBilgileri.next()) {  
	//satin almanin db'ye yazdiklarini cekip butce turunu ogren
	//eger butce turu Bilimsel Arastirma Projeleri Butcesi ise
	//buraya Proje No'sunu yaz
	String butceTipi = ayniyatBilgileri.getString("butceTipi");
	String butceTipiStr; //human readable
	String projeNoStr =" ";
	String projeNo    =" ";
	if(butceTipi.equals("bilimsel")) {
	  butceTipiStr = "Bilimsel Arastırma Projeleri";
	  projeNoStr = "Proje No:";
	  //projeNo = fisBilgileri.getString("KalemAdi");
	  //"get projeNo from where it is saved"; 
	} else
	  butceTipiStr = "Katma Deger Butcesi";
%>

<div align="center">
  <p align="center">T.C.</p>
  <p align="center">BOĞAZİÇİ ÜNİVERSİTESİ</p>
  <p align="center"><span id='security<%=securityIndex++ %>'><%=butceTipiStr%></span></p>
  <p align="center" class="style1">AYNİYAT TESELLÜM MAKBUZU </p>
  <p align="center" class="style5">Eşyanın verildiği Müessese: 
  <%
	//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
	String olusturanID = fisBilgileri.getString("olusturan");
  
	ResultSet olusturanBilgileri = dbcon.executeSP("KullaniciGoster_sp",
			new Object[]{olusturanID}).getResult();
	olusturanBilgileri.next();
  
	String olusturanGroupID = olusturanBilgileri.getString("GrupNo");
	ResultSet olusturanGroup = dbcon.executeSP("GrupGoster_sp",
			new Object[]{olusturanGroupID}).getResult();
	olusturanGroup.next();

	String olusturanGrupAdi = olusturanGroup.getString("GrupAdi");
  %>
  <span id='security<%=securityIndex++ %>'><%=olusturanGrupAdi%></span></p>
   
  <form name="onayFormu" method="post" action="../ayn/ayn3.jsp">
  <table width="760" border="1" align="center">
    <tr bordercolor="#000000">
      <td width="192">Eşyanın Alındığı Müessese</td>
      <td width="672">
	  <%
	  //db'den firmayi cek - satin almacilarin yazmis olmasi lazim
	  String saticiFirma = fisBilgileri.getString("SaticiFirma");
	  %>
	  <span id='security<%=securityIndex++ %>'><%=saticiFirma%></span>
	  </td>
    </tr>
  </table>
  <table width="760" height="91" border="1" align="center">
    <tr bordercolor="#000000">
      <td width="192" height="26">Fatura Numaras&#305; </td>
      <td width="165">
	  <%//fatura noyu yaz
	  String faturaNo = fisBilgileri.getString("FaturaNo");
	  %>
	  <span id='security<%=securityIndex++ %>'><%=faturaNo%></span>
	  </td>
      <td width="334">Ayniyat Makbuzu S&#305;ra No:</td>
      <td width="161"><span id='security<%=securityIndex++ %>'><%=ayniyatBilgileri.getString("MakbuzNo")%></span></td>
    </tr>
    <tr bordercolor="#000000">
      <td>Fatura Tarihi </td>
      <td>
	  <%//fatura tarihini yaz
	  String faturaTarihi = fisBilgileri.getString("FaturaTarihi"); 
	  %>
	  <span id='security<%=securityIndex++ %>'><%=faturaTarihi%></span>
	  </td>
      <td>Ayniyat Makbuzu Tarihi: </td>
      <td>
	  <span id='security<%=securityIndex++ %>'><%//tarih goster
	  out.print(tarih);%></span>
	  <%//db ye Aynniyat_Bilgileri -> MakbuzDuzenlemeTarihi tarih olarak full date koy %>
	  </td>
    </tr>
    <tr bordercolor="#000000">
      <td>&nbsp; </td>
      <td>&nbsp;</td>
      <td>
	  <span ><%=projeNoStr%></span>
	  </td>
      <td>
	  <span ><%=projeNo%></span>
	  </td>
    </tr>
  </table>
  
  <table width="760" height="52" border="1" align="center">
    <tr bordercolor="#000000">
      <td width="31" height="46"><div align="center">S&#305;ra No: </div></td>
      <td width="74"><div align="center">Ambar Defteri S&#305;ra No: </div></td>
      <td width="74"><div align="center">Yevmiye Defteri Kay&#305;t No: </div></td>
      <td width="74"><div align="center">T&uuml;ketim Malzeme No: </div></td>
      <td width="296"><div align="center">Malzeme Ad&#305;</div></td>
      <td width="56"><div align="center">Ölçü Birimi </div></td>
      <td width="62"><div align="center">Al&#305;nan Miktar </div></td>
      <td width="63"><div align="center">Birim Fiyat&#305; </div></td>
      <td width="90"><div align="center">Toplam Fiyat&#305; </div></td>
    </tr>
</table>
  <table width="760" height="32" border="1" align="center">
  <%
  int siraNo = 1;
  
  double fiyat;
  int miktar;
  double malzemeToplam;  
  double toplam = 0.0;
  
  double KDV ;
  double KDVTutari = 0.0;
  double KDVToplam = 0.0;
  
  while(faturaKalemleri.next()) {
  %>
    <tr bordercolor="#000000">
      <td width="31" height="26"><span id='security<%=securityIndex++ %>'><%=siraNo%></span></td>
      <td width="72"><span id='security<%=securityIndex++ %>'><%=faturaKalemleri.getString("AmbarDefteriSayfaNo")%></span></td>
      <td width="72"><span id='security<%=securityIndex++ %>'><%=faturaKalemleri.getString("YevmiyeDefteriSayfaNo")%></span></td>
      <td width="72"><span id='security<%=securityIndex++ %>'><%=faturaKalemleri.getString("TuketimMalzemeNo")%></span></td>
      <td width="298"><span id='security<%=securityIndex++ %>'><%=faturaKalemleri.getString("Nevi")%></span></td>
      <td width="59"><span id='security<%=securityIndex++ %>'><%=faturaKalemleri.getString("OlcuBirimi")%></span></td>
	  <%miktar = Integer.parseInt(faturaKalemleri.getString("Miktar"));%>
      <td width="64"><span id='security<%=securityIndex++ %>'><%=miktar%></span></td>
	  <%fiyat = Double.parseDouble(faturaKalemleri.getString("BirimFiyat"));%>
      <td width="63"><span id='security<%=securityIndex++ %>'><%=fiyat%></span></td>
	  <%malzemeToplam = miktar * fiyat;%>
      <td width="91"><span id='security<%=securityIndex++ %>'><%=malzemeToplam%></span></td>
    </tr>
	<%
	toplam += malzemeToplam;
	
	KDV = Double.parseDouble( faturaKalemleri.getString("KDVOrani"));
	KDVTutari = KDV * malzemeToplam ;
	KDVToplam += KDVTutari ;
	KDVToplam /= 100 ;	
	siraNo++;
	} //end for
	%>
  </table>
  <table width="760" height="94" border="1" align="center">
    <tr bordercolor="#000000">
      <td width="32" bordercolor="#FFFFFF"><div align="left"></div></td>
      <td width="72" bordercolor="#FFFFFF"><div align="left"></div></td>
      <td width="71" bordercolor="#FFFFFF"><div align="left"></div></td>
      <td width="236" bordercolor="#FFFFFF"><div align="left"></div></td>
      <td width="140">  <div align="left">Toplam</div></td>
      <td width="54"><div align="left"> </div></td>
      <td width="63"><div align="left"> </div></td>
      <td width="63"><div align="left"> </div></td>
      <td width="91"><div align="left"><span id='security<%=securityIndex++ %>'><%=toplam - KDVToplam%></span></div></td>
    </tr>
    <tr bordercolor="#000000">
      <td bordercolor="#FFFFFF"><div align="left"></div></td>
      <td bordercolor="#FFFFFF"><div align="left"></div></td>
      <td bordercolor="#FFFFFF"><div align="left"></div></td>
      <td bordercolor="#FFFFFF"><div align="left"></div></td>
      <td><div align="left">KDV</div></td>
      <td><div align="left"> </div></td>
      <td><div align="left"> </div></td>
      <td><div align="left"> </div></td>
      <td><div align="left"><span id='security<%=securityIndex++ %>'><%=KDVToplam%></span> </div></td>
    </tr>
    <tr bordercolor="#000000">
      <td bordercolor="#FFFFFF"><div align="left"></div></td>
      <td bordercolor="#FFFFFF"><div align="left"></div></td>
      <td bordercolor="#FFFFFF"><div align="left"></div></td>
      <td bordercolor="#FFFFFF"><div align="left"></div></td>
      <td><div align="left">GENEL TOPLAM </div></td>
      <td><div align="left"> </div></td>
      <td><div align="left"> </div></td>
      <td><div align="left"> </div></td>
      <td><div align="left"><span id='security<%=securityIndex++ %>'><%=toplam%></span></div></td>
    </tr>
  </table>
  <p align="center" class="style6"> Ayniyat Sayman&#305; </p>
  <p align="center">Adnan AYDIN </p>
  <p>&nbsp;</p>
  <p align="center">Yukarıda cinsi ve miktarı yazılı <%=toplam%> Lira tutarındaki <%=siraNo-1%> kalem eşya <%=saticiFirma%>'den teslim alınmıştır.</p>

  <p>&nbsp;</p>
  
<%}%>  
    <!-- yorum kutusu -->
    <div align="center">
        <label>
          <input name="yorum" type="text" id="yorum" value="Lütfen yorumunuzu giriniz." size="40" maxlength="40">
        </label>
    </div>
  <br>
  <table width="100%"  border="0">
   <tr>
     <td><div align="center"> 
     	<input name="OnaylaButon" type="button" onClick="parent.leftFrame.securityOnayDugmesi()" value="Onayla">
     </div></td>
     <td><div align="center"></div></td>
   </tr>
  </table>


 <p>
   <!-- hidden fieldlar -->
	    <!-- SECURITY ICIN HIDDEN FIELDLAR BEGIN -->
		    <input type="hidden" id='security_field_no' value="<%=securityIndex-1%>">
			<input type="hidden" name="imza" value="">
			<input type="hidden" name="document_content" value="">
			<input id="security1" type="hidden" name="securityDate" value="<%=System.currentTimeMillis()%>">
		<!-- SECURITY ICIN HIDDEN FIELDLAR END -->
   	<input type="hidden" name="onay" value="">
    <!-- hidden fieldlar -->
</p>
<%dbcon.closeConnection();%>
</div>
</div>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color:black>Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
</div>
</body>
</html>