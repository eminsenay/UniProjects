<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Ayniyat Giriş Sayfası</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="toprightt"> </div>
<div id="topright2">
<SCRIPT language="JavaScript">
		function preOnayDugmesi() {
			<!-- formdaki onay isimli hidden inputa "onaylandi" yaziliyor -->
			document.onayFormu.onay.value = "onaylandi";
			
			document.onayFormu.security_onayRed.value = "onaylandi";
			<!-- imzanin olusmasi icin leftFrame deki jscript method cagirilir -->
			parent.leftFrame.securityOnayDugmesi();
		
		}

		function preRedDugmesi() {
			<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
			document.onayFormu.onay.value = "reddedildi";
			
			document.onayFormu.security_onayRed.value = "reddedildi";
			<!-- imzanin olusmasi icin leftFrame deki jscript method cagirilir -->
			parent.leftFrame.securityOnayDugmesi();
		}
		
	<!-- SECURITY ONAY ICIN DE RED ICIN DE BU JAVASCRIPT FONK. CAGIRACAK -->
		function onayDugmesi() {
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
		
		
	function sifirlaDugmesi() {
			<!-- formdaki onay isimli hidden inputa "reset" yaziliyor -->
			document.onayFormu.onay.value = "reset";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
</SCRIPT>

<% 
DB dbCon = new DB(true);

//türkçe karakter çözümü
request.setCharacterEncoding("UTF-8");

//SECURITY CODE BEGIN
int securityIndex=2;  //Burası javasecurity index parametresi

//SECURITY CODE END

try {
	
	//ayniyatin group idsi
	String nextGroupID = "000003-GRP";
	//ayn2 nin page codu
	String ayn2Code = "../ayn/ayn2.jsp";
	//ayn3 un page codu
	String ayn3Code = "../ayn/ayn3.jsp";

	//session'dan baktigimiz formun id'sini ve kullanicinin id'sini cekelim
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	String requestFormID = (String)session.getAttribute("requestFormID");
	
	//bu sayfada muayene raporunu ve ihracat pusulasini gosterecegiz, sayfaya bakan kisinin
	//bu belgeleri imzalamasi gereken muayene kurulunun uyelerinden birisi olmasi gerekiyor

	//sayfada gosterebilmek icin db'den fisle, muayene raporu+ihracat pusulasi ve fatura kalemleri ile bilgileri cekelim
	
	ResultSet fisBilgileri = dbCon.executeSP("IstekFisiGoster_sp",
			new Object[]{requestFormID}).getResult();
	ResultSet ayniyatBilgileri = dbCon.executeSP("AyniyatBilgileriGoster_sp",
			new Object[]{requestFormID}).getResult();
	ResultSet faturaKalemleri = dbCon.executeSP("FaturaKalemleriGoster_sp",
			new Object[]{requestFormID}).getResult();

	fisBilgileri.next();
	String faturaNo = fisBilgileri.getString("faturaNo");
	String requestedBy = fisBilgileri.getString("Isteyen");
	
	ayniyatBilgileri.next();
	String butceTipi = ayniyatBilgileri.getString("butceTipi");
	String butceTipiStr; //human readable
	if(butceTipi.equals("bilimsel"))
		butceTipiStr = "Bilimsel Arastirma Projeleri";
	else
		butceTipiStr = "Katma Deger Butcesi";
	
	String muayeneRaporuNo = ayniyatBilgileri.getString("muayeneRaporuNo");
	String duzenlenmeTarihi = ayniyatBilgileri.getString("pusulaDuzenlemeTarihi");
	String talepMuzekkeresiNo = ayniyatBilgileri.getString("talepMuzekkeresiNo");
	
	String[] uyeIDleri = new String[4];
	String[] uyeImzalari = new String[4];
	String[] uyeImzaTarihleri = new String[4];
	uyeIDleri[0] = ayniyatBilgileri.getString("uye1No");
	uyeImzalari[0] = ayniyatBilgileri.getString("uye1Imzaladi");
	uyeImzaTarihleri[0] = ayniyatBilgileri.getString("uye1ImzaTarihi");
	uyeIDleri[1] = ayniyatBilgileri.getString("uye2No");
	uyeImzalari[1] = ayniyatBilgileri.getString("uye2Imzaladi");
	uyeImzaTarihleri[1] = ayniyatBilgileri.getString("uye2ImzaTarihi");
	uyeIDleri[2] = ayniyatBilgileri.getString("uye3No");
	uyeImzalari[2] = ayniyatBilgileri.getString("uye3Imzaladi");
	uyeImzaTarihleri[2] = ayniyatBilgileri.getString("uye3ImzaTarihi");
	uyeIDleri[3] = ayniyatBilgileri.getString("uye4No");
	uyeImzalari[3] = ayniyatBilgileri.getString("uye4Imzaladi");
	uyeImzaTarihleri[3] = ayniyatBilgileri.getString("uye4ImzaTarihi");
	
	String[] uyeIsimleri = new String[4];
	for(int i=0; i<4; ++i) {
		uyeIsimleri[i] = "";
		ResultSet uyeBilgileri = dbCon.executeSP("KullaniciGoster_sp",
				new Object[]{uyeIDleri[i]}).getResult();
		if(uyeBilgileri.next())
			uyeIsimleri[i] = uyeBilgileri.getString("Ad") + " " + uyeBilgileri.getString("Soyad");
	}
	
	int kalemSayisi = 0;
	if(faturaKalemleri.next())
	{
		faturaKalemleri.last();
		kalemSayisi = faturaKalemleri.getRow();
		faturaKalemleri.beforeFirst();
	}
	AyniyatParca mallar[] = new AyniyatParca[kalemSayisi];
	int rowNo = 0;
	while(faturaKalemleri.next())
	{
		mallar[rowNo] = new AyniyatParca();
		mallar[rowNo].nevi = faturaKalemleri.getString("Nevi");
		mallar[rowNo].miktar = faturaKalemleri.getString("Miktar");
		mallar[rowNo].olcuBirimi = faturaKalemleri.getString("OlcuBirimi");
		mallar[rowNo].birimFiyat = faturaKalemleri.getString("BirimFiyat");
		mallar[rowNo].kdvOrani = faturaKalemleri.getString("kdvOrani");
		mallar[rowNo].ambarDefNo = faturaKalemleri.getString("AmbarDefteriSayfaNo");
		mallar[rowNo].yevmiyeDefNo = faturaKalemleri.getString("YevmiyeDefteriSayfaNo");
		++rowNo;
	}
	long fisToplamiInt = 0;
	for(int i=0; i<kalemSayisi; ++i)
		fisToplamiInt += Long.parseLong(mallar[i].miktar)*Long.parseLong(mallar[i].birimFiyat);
	String fisToplami = String.valueOf(fisToplamiInt);
	
	//bunların dışında bir de saymanın bilgilerine ihtiyacımız var
	String saymanID = "";
	ResultSet saymanBilgileri = dbCon.executeSP("PozisyonaGoreKullaniciGoster_sp",
			new Object[]{"Ayniyat Saymani"}).getResult();
	if(saymanBilgileri.next())
		saymanID = saymanBilgileri.getString("KullaniciNo");
	
	//Sayfanin dogru kisilerce açildigindan emin ol, 
	//ve muayene kurulundaki kaçincu userin açmis oldugunu kaydet
	//buradaki durum şu:
	//sırayla imzaladiN fieldları kontrol edilecek, eğer herhangi bir 2'ye rastlanırsa
	//reddedilmiş bir fiş ile karşı karşıyayız demektir, eğer kullanıcı sayman değilse
	//hatalı access var, sayman ise userNo'yu -1'e set edip bu kontrolden çıkabiliriz
	//imzaladiN 1 ise geç, 0 ise uye_N kullanıcıyla aynı kişi değilse access hatası, kullanıcı ise
	//userNo'yu N'e set edip bu kontrolden çık	
	int userNo = 0;
	int uyeSayisi = 3;
	boolean dortKisi = false;
	if(!butceTipi.equals("bilimsel")) {
		uyeSayisi = 4;
		dortKisi = true;
	}

	for(int i=0; i<uyeSayisi; ++i) {
		if(uyeImzalari[i].equals("0")) {	//bu üye daha imzalamamış
			//o zaman şu andaki kullanıcımızın bu üye olması lazım!
			if(!userID.equals(uyeIDleri[i])) {
				session.removeAttribute("requestFormID");
				dbCon.closeConnection();
				response.sendRedirect("../../alerts/GeneralAlert.jsp");
				System.out.println("this is 1");
				return;
			} else {
				//adamımızı bulduk
				userNo = i+1;
				break;
			}
		} else if(uyeImzalari[i].equals("1")) { //bu üye imzalamış
			//o zaman devam ediyoruz
			continue;
		} else if(uyeImzalari[i].equals("2")) {	//bu üye reddetmiş
			//şu anda sadece sayman bu sayfaya bakabilir
			System.out.println("su anda sadece sayman bu sayfaya bakabilir");
			System.out.println("saymanID = " + saymanID + "\ncurrentID = " + userID);
			if(!userID.equals(saymanID)) {
				session.removeAttribute("requestFormID");
				dbCon.closeConnection();
				response.sendRedirect("../../alerts/GeneralAlert.jsp");
				System.out.println("this is 2");
				return;
			} else {
				//sayman reset modu
				userNo = -1;
				break;
			}
		}
	}
	
	//eğer bütün üyeler imzalamışsa burada ne işimiz var?
	if(userNo == 0) {
		session.removeAttribute("requestFormID");
		dbCon.closeConnection();
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
		System.out.println("this is 3");
		return;
	}
	
	if(request.getParameter("onay") != null 
			&& request.getParameter("onay").equals("onaylandi")) {	
		//burada imzalari kontrol edip duruma gore ya ayn3'e yonlendirmek ya da ayn2'de kalmak gerekiyor
		
		dbCon.beginTransaction();
		try {
			//gidecegimiz page
			String pageCode;
			//raporu imzala
			//bunun icin su anki tarih lazim
			Calendar cal = new GregorianCalendar();
			int buYil = cal.get(Calendar.YEAR);
			int buAy = cal.get(Calendar.MONTH) + 1 - Calendar.JANUARY;
			int buGun =	cal.get(Calendar.DAY_OF_MONTH);
			String imzalamaTarihi = ""+buYil+"-"+buAy+"-"+buGun; //bugunun tarihi
			//sp'de problem var gibi gözüküyor!!
			dbCon.executeSP("AyniyatBilgileriImzala_sp",
					new Object[]{requestFormID, new Integer(userNo), imzalamaTarihi, new Integer(1)});
			if(butceTipi.equals("bilimsel"))
			{
				if(userNo == 1 || userNo == 2)
					//ayn2'de kal
					pageCode = ayn2Code;
				else	//userNo = 3
					//ayn3'e geç
					pageCode = ayn3Code;
			}
			else
			{
				if(userNo == 1 || userNo == 2 || userNo == 3)
					//ayn2'de kal
					pageCode = ayn2Code;
				else	//userNo = 4
					//ayn3'e geç
					pageCode = ayn3Code;
			}
			
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
	
			dbCon.executeSP("IstekAktar_sp",
				new Object[]{requestFormID, nextGroupID, pageCode, userID, "Muayene raporu imzalandi.", "1"});
			
			//following result3 is used by SECURITY
			ResultSet result3 = dbCon.getResult();
			if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
				//SECURITY CODE BEGINS
				String historyID = result3.getString(1);
			
				dbCon.commitTransaction();
				//db'yi kapat
				dbCon.closeConnection();
			
				String security_signature = request.getParameter("imza");
				String security_documentContent = request.getParameter("document_content");
				String security_date = request.getParameter("securityDate");
				Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_AYN2);
				//SECURITY CODE ENDS
			}
			else {
				dbCon.commitTransaction();
				//db'yi kapat
				dbCon.closeConnection();
			}
			
			session.removeAttribute("requestFormID");
			response.sendRedirect("../../alerts/approve.jsp");
			return;
		} catch(Exception e) {
			dbCon.rollbackTransaction();
			//db'yi kapat
			dbCon.closeConnection();
			session.removeAttribute("requestFormID");
			response.sendRedirect("../../alerts/GeneralAlert.jsp");
			System.out.println("this is 4");
			return;
		}
	} else if(request.getParameter("onay") != null 
			 && request.getParameter("onay").equals("reddedildi")) {
		//burada reddeden kullanıcının imza fieldina reddetme anlamına gelen 2 değerini kaydedeceğiz
		//bu noktada fişin ayn3e devam edebilmesi söz konusu değil ayn2de kalacak.

		dbCon.beginTransaction();
		try {
			//gidecegimiz page
			String pageCode = ayn2Code;
			//raporu imzala
			//bunun icin su anki tarih lazim
			Calendar cal = new GregorianCalendar();
			int buYil = cal.get(Calendar.YEAR);
			int buAy = cal.get(Calendar.MONTH) + 1 - Calendar.JANUARY;
			int buGun =	cal.get(Calendar.DAY_OF_MONTH);
			String imzalamaTarihi = ""+buYil+"-"+buAy+"-"+buGun; //bugunun tarihi
			dbCon.executeSP("AyniyatBilgileriImzala_sp",
				new Object[]{requestFormID, new Integer(userNo), imzalamaTarihi, new Integer(2)});
	
			dbCon.executeSP("IstekAktar_sp",
				new Object[]{requestFormID, nextGroupID, pageCode, userID, "Muayene raporu reddedildi.", "0"});

			session.removeAttribute("requestFormID");
			dbCon.commitTransaction();
			dbCon.closeConnection();
			response.sendRedirect("../../alerts/reject.jsp");
			return;
		} catch(Exception e) {
			session.removeAttribute("requestFormID");
			dbCon.rollbackTransaction();
			dbCon.closeConnection();
			response.sendRedirect("../../alerts/GeneralAlert.jsp");
			System.out.println("this is 5");
			return;
		}
	} else if(request.getParameter("onay") != null
			&& request.getParameter("onay").equals("reset")) {
		//bu durumda sayman reddedilmiş olan bir fişin sayfasına girmiş 
		//ve fişi yeniden başlatmaya karar vermiş, imzaları resetletip olayı baştan başlatacağız
		
		dbCon.beginTransaction();
		try {
			//gidecegimiz page
			String pageCode = ayn2Code;
			
			dbCon.executeSP("AyniyatImzalariSifirla_sp",
				new Object[]{requestFormID});
			
			dbCon.executeSP("IstekAktar_sp",
				new Object[]{requestFormID, nextGroupID, pageCode, userID, "Sayman raporu yeniledi.", "1"});
			
			session.removeAttribute("requestFormID");
			dbCon.commitTransaction();
			dbCon.closeConnection();
			response.sendRedirect("../../alerts/approve.jsp");
			return;
		} catch(Exception e) {
			session.removeAttribute("requestFormID");
			dbCon.commitTransaction();
			dbCon.closeConnection();
			response.sendRedirect("../../alerts/GeneralAlert.jsp");
			System.out.println("this is 6");
			return;
		}
	}
%>
 <div align="justify" class="tablefont">
<p>&nbsp;</p>
 <div align="justify">
   <table width="688" border="0" >
     <tr>
       <td width="331">
	     <br>T.C.
         <br>Bo&#287;azi&ccedil;i &Uuml;niversitesi
         <br><span id='security<%=securityIndex++ %>'><%=butceTipiStr%></span>
       </td>
       <td width="341"><p align="right">No: <span id='security<%=securityIndex++ %>'><%=muayeneRaporuNo%></span> </p>
       <p align="right">Tarih: <span id='security<%=securityIndex++ %>'><%=duzenlenmeTarihi%></span> </p></td>
     </tr>
    </table>
 </div>
<p> 
<p>
<p align="center"><strong>MUAYENE RAPORU </strong>
<p align="left">
<p align="left">&#304;li&#351;ik <span id='security<%=securityIndex++ %>'><%=faturaNo%></span> say&#305;l&#305; <span id='security<%=securityIndex++ %>'><%=fisToplami%></span> liral&#305;k 1 adet faturada cins ve miktar&#305; yaz&#305;l&#305; <span id='security<%=securityIndex++ %>'><%=kalemSayisi%></span> e&#351;ya matluba muvaf&#305;kt&#305;r.
<p align="left">Tesellümünde bir mahsur yoktur.
<p align="center"><strong> &#304;HRACAT PUSULASI </strong>
<form action="ayn2.jsp" method="post" name="onayFormu"> 

<table width="750" border="1"  cols="6">
   <tr>
     <td colspan="4">&#304;hraç Olunan E&#351;yan&#305;n </td>
     <td  colspan="2">Talep Müzekkeresi </td>
     <td width="154">K&#305;ymeti</td>
   </tr>
   <tr>
     <td width="186">NEV'I</td>
     <td width="65">Miktar&#305;</td>
     <td width="87">&Ouml;l&ccedil;&uuml; Birimi</td>
     <td width="113">Birim Fiyat&#305; </td>
     <td width="75">Tarih</td>
     <td width="74">No</td>
     <td>YeniLira</td>
   </tr>
	<%
	int numRows = 0;
	if(mallar != null)
		numRows = mallar.length;
	for(int i=0;i<numRows;i++)
	{	
	%>
		<tr>
			<td><label><span id='security<%=securityIndex++ %>'><%=mallar[i].nevi%></span></label></td>
			<td><label><span id='security<%=securityIndex++ %>'><%=mallar[i].miktar%></span></label></td>
			<td><label><span id='security<%=securityIndex++ %>'><%=mallar[i].olcuBirimi%></span></label></td>
		    <td><label><span id='security<%=securityIndex++ %>'><%=mallar[i].birimFiyat%></span></label></td>
		    <td><label><%=duzenlenmeTarihi%></label></td>
	    	<td><label><span id='security<%=securityIndex++ %>'><%=talepMuzekkeresiNo%></span></label></td>
	    	<td><label><%=Long.parseLong(mallar[i].birimFiyat)*Long.parseLong(mallar[i].miktar)%></label></td>
		</tr>
	<%
	}
	%>
 </table>
 <table width="688" border="0">
 
 <tr><td><img src="../../images/spacer.gif" height="20" width="20"></td></tr>
  </table>
 <p align="center"><strong>Muayene Komisyon Üyeleri</strong></p>
 <table width="100%" border="0">
   <tr>	<!-- KURULDAKİ GÖREVİ -->
     <td><div align="center"><u>BA&#350;KAN</u></div></td>
     <td><div align="center"><u>ÜYE</u></div></td>
     <td><div align="center"><u>ÜYE</u></div></td>
     <%if(dortKisi) {%>
     <td><div align="center"><u>ÜYE</u></div></td>
     <%}%>
   </tr>
   <tr>	<!-- KİM OLDUĞU -->
   <%if(!dortKisi) {%>
     <td><div align="center">Ayniyat Sayman&#305;</div></td>
     <td><div align="center">Ayniyat Üyesi</div></td>
     <td><div align="center">
     	Proje Yürütücüsü
     	<p>
     	<i><%=requestedBy%></i>
     	<p>
     	adına
     	<p>
     </div></td>
   <%} else {%>
     <td><div align="center">Ayniyat Sayman&#305;</div></td>
     <td><div align="center">Ayniyat Üyesi</div></td>
     <td><div align="center">
     	İsteği Yapan
     	<p>
     	<i><%=requestedBy%></i>
     	<p>
     	adına
     	<p>
     </div></td>
   <%}%>
   </tr>
   <tr>	<!-- İSMİ -->
     <td><div align="center"><i><%=uyeIsimleri[0]%></i></div></td>
     <td><div align="center"><i><%=uyeIsimleri[1]%></i></div></td>
     <td><div align="center"><i><%=uyeIsimleri[2]%></i></div></td>
     <%if(dortKisi) {%>
     <td><div align="center"><i><%=uyeIsimleri[3]%></i></div></td>
     <%}%>
   </tr>
   <tr>	<!-- İMZALADI / REDDETTİ -->
     <%for(int i=0; i<uyeSayisi; ++i) {%>
     <td><div align="center"><%
     if(uyeImzalari[i].equals("0")) {
    	 %>&nbsp<%
     } else if(uyeImzalari[i].equals("1")) {
    	 %><font color="blue">İMZALADI</font><%
     } else if(uyeImzalari[i].equals("2")) {
    	 %><font color="red">REDDETTİ</font><%
     }
     %></div></td>
     <%}%>
   </tr>
   <tr>	<!-- İMZA/RET TARİHİ -->
     <%for(int i=0; i<uyeSayisi; ++i) {%>
     <td><div align="center"><%
     if(uyeImzalari[i].equals("0")) {
    	 %>&nbsp<%
     } else {
    	 out.print(uyeImzaTarihleri[i]);
     }
     %></div></td>
     <%}%>
   </tr>
   <tr>	<!-- SECURITY VERIFICATION -->
     <%for(int i=0; i<uyeSayisi; ++i) {%>
     <td><div align="center"><%
     if(uyeImzalari[i].equals("0")) {
    	 %>&nbsp<%
     } else {
    	 boolean securityVerified = true;
    	 //security code goes here, 
    	 //no need to include another file, 
    	 //this is the only place the verification is needed
    	 if(securityVerified) {%>
	    	<font color="green">Onaylandı</font>
	     <%} else {%>
	     	<font color="red">Onaylanamadı</font>
	     <%}
     }
     %></div></td>
     <%}%>
   </tr>
 </table>
<%
if(userNo > 0) { %>
  <table width="100%"  border="0">
   <tr>
     <td><div align="center"> 
     	<input name="OnaylaButon" type="button" onClick="preOnayDugmesi()" value="Onayla">
     	</div>
     </td>
     <td><div align="center">
     	<input name="ReddetButon" type="button" onClick="preRedDugmesi()" value="Reddet">
     	</div>
     </td>
   </tr>
 </table>
<%} else if(userNo < 0) {%>
  <table width="100%"  border="0">
   <tr>
     <td><div align="center"> 
     	<input name="SifirlaButton" type="button" onClick="sifirlaDugmesi()" value="Raporu Yeniden İmzaya Aç">
     	</div>
     </td>
   </tr>
 </table>
<%}
} catch(Exception e) {
	//yok öyle bir fiş!
	//form id'yi ve mallari sessiondan cikar
	session.removeAttribute("requestFormID");

	//db yi kapat
	dbCon.closeConnection();
	
	//hata sayfasına git
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	System.out.println("this is 7");
	return;
}
%>

  
 <!-- hidden fieldlar -->
 	<!-- SECURITY ICIN HIDDEN FIELDLAR BEGIN -->
		    <input type="hidden" name='security_onayRed' value='';>
            <input type="hidden" id='security_field_no' value="<%=securityIndex-1%>">
			<input type="hidden" name="imza" value="">
			<input type="hidden" name="document_content" value="">
			<input id="security1" type="hidden" name="securityDate" value="<%=System.currentTimeMillis()%>">
	<!-- SECURITY ICIN HIDDEN FIELDLAR END -->
	<input type="hidden" name="onay" value="">
 <!-- hidden fieldlar -->

</form>
</div>
</div>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
</div>
</body>
</html>
