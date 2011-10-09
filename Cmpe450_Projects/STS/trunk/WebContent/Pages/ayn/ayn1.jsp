<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<script language="Javascript">
	function ekleFunc() {
			<!-- formdaki action isimli hidden inputa "ekle" yaziliyor -->
			document.form1.ileri.value = "";
			document.form1.action.value = "ekle";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.form1.submit();
		}
		
	function silFunc() {
			<!-- formdaki action isimli hidden inputa "sil" yaziliyor -->
			document.form1.ileri.value = "";
			document.form1.action.value = "sil";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.form1.submit();
		}

	function ileriFunc() {		
			<!-- formdaki ileri isimli hidden inputa "ileri" yaziliyor -->
			document.form1.ileri.value = "ileri";
			document.form1.action.value = "";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.form1.submit();
		}
		
	function setUyeTipi() {
			document.form1.submit();
		}
		
	function tarihGosterFunc() {
			<!-- bu fonksiyon, tarih goster dugmesine basildikca, tarihGoster -->
			<!-- fieldinin icerigini toggle edecek -->
			if(document.form1.tarihGoster.value == "evet")
				document.form1.tarihGoster.value = "hayir";
			else
				document.form1.tarihGoster.value = "evet";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.form1.submit();
		}		
</script>
<%
DB db = new DB(true);
//bu sayfada ayniyat uyleri tarafindan muayene raporunu olusturulacak ve gerekli fatura 
//bilgileri databasedeki ayniyat ile ilgili tablolara yazilacak. 
//bu sayfa her hangi bir onay islemi icermiyor.

//türkçe karakter çözümü
request.setCharacterEncoding("UTF-8");

//arada şu tarih gosteri aradan çıkaralım
boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null) {
	if(((String)request.getParameter("tarihGoster")).equals("evet"))
		tarihGoster = true;
}

// Sayfanin basinda gosterilecek fis ayrintlari ile ilgili kisim
String userID = ((User)session.getAttribute("userClass")).getUserid();
String requestFormID = (String)session.getAttribute("requestFormID");
ResultSet _request = db.executeSP("IstekFisiGoster_sp", new Object[]{requestFormID}).getResult();
String isteyen = "";
String olusturan = "";
String olusturanID = "";
if(_request.next()) {
	isteyen = _request.getString("Isteyen");
	olusturanID = _request.getString("Olusturan");
	ResultSet olusturanBilgileri = db.executeSP("KullaniciGoster_sp", new Object[]{olusturanID}).getResult();
	if(olusturanBilgileri.next())
		olusturan = olusturanBilgileri.getString("Ad") + " " + olusturanBilgileri.getString("Soyad");
} else {
	//yok öyle bir fiş!
	//form id'yi sessiondan cikar
	session.removeAttribute("requestFormID");

	//db yi kapat
	db.closeConnection();
	
	//hata sayfasına git
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}

//Ayniyat Kullanicilari ile ilgili bilgi topla
int numAyniyatUsers = 0;
String selectedUserID = "", selectedUserID2 = "";
//Databasedeki ayniyat grubunun numarasini set et
String Ayniyat_Grup_No = "000003-GRP";



ResultSet ayniyat_users = db.executeSP("GrubaGoreKullaniciGoster_sp", new Object[]{Ayniyat_Grup_No}).getResult();
if(ayniyat_users.next()) {
	ayniyat_users.last();
	numAyniyatUsers = ayniyat_users.getRow();
	ayniyat_users.beforeFirst();
}
// ayniyattaki user larin adlari ve user nolari
String[] ayniyatUserIDs = new String[numAyniyatUsers]; 
String[] ayniyatUserNames = new String[numAyniyatUsers]; 

for(int i=0; i<numAyniyatUsers; ++i)  {
	ayniyat_users.next();
	ayniyatUserIDs[i] = ayniyat_users.getString("KullaniciNo");
	ayniyatUserNames[i] = ayniyat_users.getString("Ad") + " " + ayniyat_users.getString("Soyad");
}
//bunlarin disinda ayniyat saymaninin ve ambar sefinin de adlarina ve kullaniciIDleri lazim
String saymanID = "", saymanAdi = "";
String sefID = "", sefAdi = "";
ResultSet saymanBilgileri = db.executeSP("PozisyonaGoreKullaniciGoster_sp", new Object[]{"Ayniyat Saymani"}).getResult();
if(saymanBilgileri.next()) {
	saymanID = saymanBilgileri.getString("KullaniciNo");
	saymanAdi = saymanBilgileri.getString("Ad") + " " + saymanBilgileri.getString("Soyad");
}
ResultSet sefBilgileri = db.executeSP("PozisyonaGoreKullaniciGoster_sp", new Object[]{"Ambar Sefi"}).getResult();
if(sefBilgileri.next()) {
	sefID = sefBilgileri.getString("KullaniciNo");
	sefAdi = sefBilgileri.getString("Ad") + " " + sefBilgileri.getString("Soyad");
}

//tarih icin gerekli seyler
String[] gunler = new String[31] ;
String[] aylar = new String[12] ;
String[] yillar = new String[20] ;
for(int i=0; i<gunler.length ;i++ )
	gunler[i] = String.valueOf(i+1);
for(int i=0; i<aylar.length ;i++ )
	aylar[i] = String.valueOf(i+1);
for(int i=0; i<yillar.length ;i++ )
	yillar[i] = String.valueOf(i+2000);
Calendar cal = new GregorianCalendar();
int buYil = cal.get(Calendar.YEAR);
int buAy = cal.get(Calendar.MONTH) + 1 - Calendar.JANUARY;
int buGun =	cal.get(Calendar.DAY_OF_MONTH);

//ileri tusuna basilinca makbuzdaki bilgiler
//databasedeki ayniyat ile ilgili tablolara eklenir 
if(request.getParameter("ileri") != null 
	&& request.getParameter("ileri").equals("ileri")) {
	
	db.beginTransaction();
	try {
		//istek fisine girilecekler
		//bunun icin AyniyatIstekFisiGuncelle_sp cagrilacak
		//istek fisine faturano, faturatarihi ve satici firma adi girilecek
		//buna ilaveten bir de fatura tutarini toplayip onu da yazacaz
		db.executeSP("AyniyatIstekFisiGuncelle_sp",
			new Object[]{requestFormID, request.getParameter("faturaNo"),
				request.getParameter("YilSec")+"-"+request.getParameter("AySec")+"-"+request.getParameter("GunSec"),
				request.getParameter("saticiFirma")});
		
		//ayniyat bilgilerine girilecekler
		//bunun icin AyniyatBilgileriEkle_sp cagrilacak
		//pusula duzenlenme tarihi, butce tipi, cilt, uyenolari ve toplam fatura tutarı girilecek
		String duzenlemeTarihi = ""+buYil+"-"+buAy+"-"+buGun; //bugunun tarihi
		String butceTipi = request.getParameter("butceTipi");
		String cilt = ""+buYil; //su anki yil
		String uyeNo1, uyeNo2, uyeNo3, uyeNo4;
		if(butceTipi.equals("bilimsel")) {
			uyeNo1 = saymanID;
			uyeNo2 = request.getParameter("UyeSec");
			uyeNo3 = olusturanID;
			uyeNo4 = olusturanID;
		} else {
			uyeNo1 = sefID;
			uyeNo2 = request.getParameter("UyeSec");
			uyeNo3 = request.getParameter("UyeSec2");
			uyeNo4 = olusturanID;
		}
		
		//fatura kalemlerine girilecekler
		//bunun icin FaturaKalemiGir_sp cagrilacak
		//nevi, miktar, birim fiyati, kdvorani, ambardefteri, yevmiyedefteri, olcubirimi
		double fisToplami = 0;
		int numMallar = 0;
		if(request.getParameter("numMallar") != null)
			numMallar = Integer.parseInt(request.getParameter("numMallar"));
		for(int i=0; i<numMallar; ++i) {
			db.executeSP("FaturaKalemiGir_sp",
					new Object[]{requestFormID,
					request.getParameter("nevi_"+i),
					request.getParameter("miktar_"+i),
					request.getParameter("birimFiyat_"+i),
					request.getParameter("kdvOrani_"+i),
					request.getParameter("ambarDefNo_"+i),
					request.getParameter("yevmiyeDefNo_"+i),
					request.getParameter("olcubirimi_"+i)});
			
			fisToplami += Integer.parseInt(request.getParameter("miktar_"+i)) * Double.parseDouble(request.getParameter("birimFiyat_"+i));
		}
	
		db.executeSP("AyniyatBilgileriEkle_sp",
				new Object[]{requestFormID, duzenlemeTarihi, butceTipi, cilt,
				uyeNo1, uyeNo2, uyeNo3, uyeNo4, new Double(fisToplami)});
		
		//ve nihayet son olarak IstekAktar_sp'yi cagirarak bu isi bitiriyoruz!!
		db.executeSP("IstekAktar_sp",
				new Object[]{requestFormID, Ayniyat_Grup_No,
				"../ayn/ayn2.jsp", userID, "Fatura bilgileri girildi.", "1"});
		
		//form id'yi sessiondan cikar
		session.removeAttribute("requestFormID");
		
		db.commitTransaction();
		db.closeConnection();
		
		//approval sayfasina yonlendir
		response.sendRedirect("../../alerts/approve.jsp");
		return;
	} catch(Exception e) {
		//form id'yi sessiondan cikar
		session.removeAttribute("requestFormID");
		
		db.rollbackTransaction();
		db.closeConnection();
		
		//hata sayfasına yönlendir
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
		return;
	}
}

// ayniyat makbuzuna yeni bir mal eklendigi durum.
boolean malEklemeyeCalisti = false;
boolean malEkledi = false;
if(request.getParameter("action") != null 
		&& request.getParameter("action").equals("ekle")){
	malEklemeyeCalisti = true;
	boolean neviOK = !request.getParameter("nevi").equals("");
	boolean miktarOK = true;
	try {
		Integer.parseInt(request.getParameter("miktar"));
	} catch(Exception e) {
		miktarOK = false;
	}
	boolean olcuBirimiOK = !request.getParameter("olcuBirimi").equals("");
	boolean birimFiyatiOK = true;
	try {
		Double.parseDouble(request.getParameter("birimFiyat"));
	} catch(Exception e) {
		birimFiyatiOK = false;
	}
	boolean kdvOraniOK = true;
	try {
		Integer.parseInt(request.getParameter("kdvOrani"));
	} catch(Exception e) {
		kdvOraniOK = false;
	}
	boolean ambarDefNoOK = !request.getParameter("ambarDefNo").equals("");
	boolean yevmiyeDefNoOK = !request.getParameter("yevmiyeDefNo").equals("");

	if(neviOK && miktarOK && olcuBirimiOK && birimFiyatiOK && kdvOraniOK && ambarDefNoOK && yevmiyeDefNoOK)
		malEkledi = true;
}
// ayniyat makbuzunda  checkbox lari isaretli olan maddelerin silindigi durum
boolean siliyor = false;
if(request.getParameter("action") != null 
		&& request.getParameter("action").equals("sil")){
	siliyor = true;
}
%>
<div id="toprightt"> </div>
<div id="topright2">
<div align=center>
<div align="center">
<table width="79%"  border="0"  id="baslik" class="tablefont">
	<tr><td width="100%" height="56" align=center>
		<strong>T.C.<br>
        BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;<br>
        Fatura Bilgileri<br>&nbsp;</strong><p>
	</td></tr>
</table>


<!--  KOPYA FİŞ DETAYLARI  -->
<div align="center">
    <table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
      <tr>
        <td><div align="center"><strong>İstek Detaylar&#305; </strong></div></td>
      </tr>
    </table>
    <% _request.first(); %>
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
            <td width="49%">Se&ccedil;ilen Piyasa Se&ccedil;eneği</td>
            <td width="51%"><%=piyasa%></td>
          </tr>
        </table>
      </div></td>
      <%
		//tarih
		String theDate = _request.getString("OlusturmaTarihi");
		if(theDate == null)
			theDate = "Yok";
		else {
			String parca[] = theDate.split(" ");//yy-aa-gg tt:tt:tt geliyor
			String parca2[] = parca[0].split("-");//get yy aa gg
			theDate = parca2[2]+"/"+parca2[1]+"/"+parca2[0];
		}
		//kurumsal kod 
		String kurumsalKod = _request.getString("KurumsalKod");
		//fonksiyonel kod
		String fonksiyonelKod = _request.getString("FonksiyonelKodu");
		
		//butce dagilim No
		String butceDagilimNo= _request.getString("ButceDagilimNo");
		//ana kalem adi
		String anaKalemAdi = _request.getString("AnaKalemAdi");
		//kalem adi
		String kalemAdi = _request.getString("KalemAdi");

		//mevcut tutar
		String mevcutTutar= _request.getString("MevcutTutar");
		
      %>
      <td width="54%"><table width="100%"  border="1" bordercolor="#CCCCFF" class="tablefont">
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
          <td width="33%"><label>B&#252;t&ccedil;e Dağ&#305;l&#305;m No</label></td>
          <td width="67%"><label><%=butceDagilimNo%></label></td>
        </tr>
        <tr>
         <td width="33%"><label>Ana Kalem Ad&#305;</label></td>
          <td width="67%"><label><%=anaKalemAdi%></label></td>
        </tr>
        <tr>
            <td width="33%" height="19"><label>Kalem Ad&#305;</label></td>
          <td width="67%"><label><%=kalemAdi%></label></td>
        </tr>
        <tr>
            <td width="33%" height="19"><label>Mevcut Tutar</label></td>
          <td width="67%"><label><%=mevcutTutar%></label></td>
        </tr>
      </table></td>
    </tr>
  </table>
	<br>
	
  <table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont2">
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
	<!-- ya bu hiddenı buraya kim koydu ne işe yarıyor bu? securityciler? -->
	<input type="hidden" name='grupNo' value="<%=_request.getString("GrupNo")%>">
    <%
    _request.beforeFirst();
    while(_request.next()) {
			//miktar
			String miktar = _request.getString("Miktar");
			//urun
			String urun = _request.getString("UrunAdi");
			//aciklama
			String aciklama = _request.getString("Aciklama");
			//birimfiyat?
			String birimFiyat = _request.getString("TahminiFiyat");
			//String birimFiyat = "birimFiyat?";	
			//tutari
			
			String tutar = "" ;
			try{
				tutar=""+(Integer.parseInt(miktar) * Integer.parseInt(birimFiyat)) ;				
			}catch(Exception e){}
	      %>
	      <tr align="center">
	        <td><label><%=miktar%></label></td>
	        <td><label><%=urun%></label></td>
	        <td><label><%=aciklama%></label></td>
	        <td><label><%=birimFiyat%></label></td>
	        <td><label><%=tutar%></label></td>
	      </tr>
    <%}%>
  </table>
</div>




<form action="ayn1.jsp" method="post" name="form1">
<input type="hidden" name="action" value="">
<input type="hidden" name="ileri" value="">
<%if(tarihGoster) {%>
<input type="hidden" name="tarihGoster" value="evet">
<%} else {%>
<input type="hidden" name="tarihGoster" value="hayir">
<%}%>

<div align=center>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
<td width="25%">Fatura No :</td>
<td>
<%if(request.getParameter("faturaNo") != null) {%>
	<input value="<%=request.getParameter("faturaNo")%>" name="faturaNo" type="text">
<%} else {%>
	<input value="" name="faturaNo" type="text">
<%}%>
</td>
</tr>
<tr>
<td width="25%">Fatura Tarihi :</td>
<td>
     	  <select size="1" name="GunSec">
		    <%String selectedGun;
		    if(request.getParameter("GunSec") == null)
		    	selectedGun = String.valueOf(buGun);
		    else
		    	selectedGun = request.getParameter("GunSec");
		    for(int i=0; i<gunler.length; ++i) {
				if(gunler[i].equals(selectedGun)) {%>
		    <option selected value="<%=gunler[i]%>"><%=gunler[i]%></option>
			    <%} else {%>	
		    <option value="<%=gunler[i]%>"><%=gunler[i]%></option>							
		    	<%}
			}%>
	      </select>
     	  <select size="1" name="AySec">
            <%String selectedAy;
            if(request.getParameter("AySec") == null)
            	selectedAy = String.valueOf(buAy);
            else
            	selectedAy = request.getParameter("AySec");
            for(int i=0; i<aylar.length; ++i) {
				if(aylar[i].equals(selectedAy)) {%>
            <option selected value="<%=aylar[i]%>"><%=aylar[i]%></option>
    	        <%} else {%>
            <option value="<%=aylar[i]%>"><%=aylar[i]%></option>
            	<%}
			}%>
          </select>
	      <select size="1" name="YilSec">
            <%String selectedYil;
            if(request.getParameter("YilSec") == null)
            	selectedYil = String.valueOf(buYil);
            else
            	selectedYil = request.getParameter("YilSec");
            for(int i=0; i<yillar.length; ++i) {
				if(yillar[i].equals(selectedYil)) {%>
            <option selected value="<%=yillar[i]%>"><%=yillar[i]%></option>
	            <%} else {%>
            <option value="<%=yillar[i]%>"><%=yillar[i]%></option>
            	<%}
			}%>
          </select></td>
</tr>
<tr>
<td width="25%">Sat&#305;c&#305; Firma :</td>
<td>
<%if(request.getParameter("saticiFirma") != null) {%>
	<input value="<%=request.getParameter("saticiFirma")%>" name="saticiFirma" type="text">
<%} else {%>
	<input value="" name="saticiFirma" type="text">
<%}%>
</td>
</tr>
<tr>
<td width="25%">Bütçe Tipi:</td>
<td>
     	<select onChange="setUyeTipi()" size="1" name="butceTipi">
			<%if(request.getParameter("butceTipi")!=null && request.getParameter("butceTipi").equals("bilimsel")){ %>
				<option selected value="bilimsel">Bilimsel Ara&#351;t&#305;rma Proje 
				Bütçesi</option>
				<option value="kdb">Katma De&#287;er Bütçesi</option>			
			<%}else if(request.getParameter("butceTipi")!=null && request.getParameter("butceTipi").equals("kdb")){ %>
				<option value="bilimsel">Bilimsel Ara&#351;t&#305;rma Proje Bütçesi</option>
				<option selected value="kdb">Katma De&#287;er Bütçesi</option>
			<%}else{ %>
				<option selected value="bilimsel">Bilimsel Ara&#351;t&#305;rma Proje 
				Bütçesi</option>
				<option value="kdb">Katma De&#287;er Bütçesi</option>			
			<%}%>
		</select></td>
</tr>
</table>
</div>
<br>
<div align= center>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
<td colspan="9" align="center">&#304;hraç Olunan E&#351;yan&#305;n</td>
</tr>
<tr>
<td align="center">&nbsp;</td>
<td align="center">NEV'&#304;</td>
<td align="center" nowrap>Yevmiye Defteri<br>Sayfa No</td>
<td align="center" nowrap>Ambar Defteri<br>Sayfa No</td>
<td align="center">Miktar</td>
<td align="center">Ölçü Birimi</td>
<td align="center" nowrap>Birim Fiyat<br>(KDV dahil)</td>
<td align="center" nowrap>KDV Oran&#305;</td>
<td align="center">K&#305;ymeti</td>
</tr>
<%
	int numMallar = 0;
	if(request.getParameter("numMallar") != null)
		numMallar = Integer.parseInt(request.getParameter("numMallar"));

	int numSilinenler = 0;
	
	for(int i=0; i<numMallar; ++i) {
		if(siliyor
			&& request.getParameter("malSil_"+i) != null) {	//bunu null ile compare etmek uygun mu??
				++numSilinenler;
				continue;
		}
		System.out.println("nevi_"+(i-numSilinenler));
		%>
		<tr>
			<td><input type="checkbox" name=<%="malSil_"+(i-numSilinenler)%> value=""></td>
			<td><input type="text" name="<%="nevi_"+(i-numSilinenler)%>" value="<%=request.getParameter("nevi_"+i)%>" size="13" readonly="readonly"></td>
			<td><input type="text" name="<%="yevmiyeDefNo_"+(i-numSilinenler)%>" value="<%=request.getParameter("yevmiyeDefNo_"+i)%>" size="11" readonly="readonly"></td>
			<td><input type="text" name="<%="ambarDefNo_"+(i-numSilinenler)%>" value="<%=request.getParameter("ambarDefNo_"+i)%>" size="11" readonly="readonly"></td>
			<td><input type="text" name="<%="miktar_"+(i-numSilinenler)%>" value="<%=request.getParameter("miktar_"+i)%>" size="4" readonly="readonly"></td>
			<td><input type="text" name="<%="olcuBirimi_"+(i-numSilinenler)%>" value="<%=request.getParameter("olcuBirimi_"+i)%>" size="6" readonly="readonly"></td>
			<td><input type="text" name="<%="birimFiyat_"+(i-numSilinenler)%>" value="<%=request.getParameter("birimFiyat_"+i)%>" size="8" readonly="readonly"></td>
			<td><input type="text" name="<%="kdvOrani_"+(i-numSilinenler)%>" value="<%=request.getParameter("kdvOrani_"+i)%>" size="6" readonly="readonly"></td>
			<td><input type="text" name=<%="kiymeti_"+(i-numSilinenler)%> value="<%=Integer.parseInt(request.getParameter("miktar_"+i)) * Double.parseDouble(request.getParameter("birimFiyat_"+i))%>" size="8" readonly="readonly"></td>
		</tr>
	<%}
	
	//silinenler silindiğine göre..
	numMallar -= numSilinenler;
	
	if(malEkledi) {	//eğer mal ekleme kabul edildiyse, yeni bir satır yapıp aşağıdaki bilgileri yukarı al
		System.out.println(request.getParameter("nevi"));
		%>
		<tr>
			<td><input type="checkbox" name=<%="malSil_"+numMallar%> value=""></td>
			<td><input type="text" name="<%="nevi_"+numMallar%>" value="<%=request.getParameter("nevi")%>" size="13" readonly="readonly"></td>
			<td><input type="text" name="<%="yevmiyeDefNo_"+numMallar%>" value="<%=request.getParameter("yevmiyeDefNo")%>" size="11" readonly="readonly"></td>
			<td><input type="text" name="<%="ambarDefNo_"+numMallar%>" value="<%=request.getParameter("ambarDefNo")%>" size="11" readonly="readonly"></td>
			<td><input type="text" name="<%="miktar_"+numMallar%>" value="<%=request.getParameter("miktar")%>" size="4" readonly="readonly"></td>
			<td><input type="text" name="<%="olcuBirimi_"+numMallar%>" value="<%=request.getParameter("olcuBirimi")%>" size="6" readonly="readonly"></td>
			<td><input type="text" name="<%="birimFiyat_"+numMallar%>" value="<%=request.getParameter("birimFiyat")%>" size="8" readonly="readonly"></td>
			<td><input type="text" name="<%="kdvOrani_"+numMallar%>" value="<%=request.getParameter("kdvOrani")%>" size="6" readonly="readonly"></td>
			<td><input type="text" name="<%="kiymeti_"+numMallar%>" value="<%=Integer.parseInt(request.getParameter("miktar")) * Double.parseDouble(request.getParameter("birimFiyat"))%>" size="8" readonly="readonly"></td>
		</tr>
		<%
		++numMallar;
	}	
%>
</table>
<!-- ve numMallar'ı sayfaya yaz -->
<input type="hidden" name="numMallar" value=<%=numMallar%>>
<table width=79%>
<tr>
<td align=left>
<%if(numMallar == 0) {%>
<input type="button" name="silButton" value="Sil" onClick="silFunc()" disabled="disabled">
<%} else {%>
<input type="button" name="silButton" value="Sil" onClick="silFunc()">
<%}%>
</td>
</tr>
</table>
<br>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
	<tr>
		<td align="center">NEV'&#304;</td>
		<td align="center" nowrap>Yevmiye Defteri<br>Sayfa No</td>
		<td align="center" nowrap>Ambar Defteri<br>Sayfa No</td>
		<td align="center">Miktar</td>
		<td align="center">Ölçü Birimi</td>
		<td align="center" nowrap>Birim Fiyat<br>(KDV dahil)</td>
		<td align="center" nowrap>KDV Oran&#305;</td>
	</tr>
	<tr align="center">
	<% //eğer başarısız bir ekleme girişimi olduysa eski değerleri koru
	if(malEklemeyeCalisti && !malEkledi) {
		String neviStr = "";
		if(request.getParameter("nevi") != null)
			neviStr = request.getParameter("nevi");
		String yevmiyeDefNoStr = "";
		if(request.getParameter("yevmiyeDefNo") != null)
			yevmiyeDefNoStr = request.getParameter("yevmiyeDefNo");
		String ambarDefNoStr = "";
		if(request.getParameter("ambarDefNo") != null)
			ambarDefNoStr = request.getParameter("ambarDefNo");
		String miktarStr = "";
		if(request.getParameter("miktar") != null)
			miktarStr = request.getParameter("miktar");
		String olcuBirimiStr = "";
		if(request.getParameter("olcuBirimi") != null)
			olcuBirimiStr = request.getParameter("olcuBirimi");
		String birimFiyatStr = "";
		if(request.getParameter("birimFiyat") != null)
			birimFiyatStr = request.getParameter("birimFiyat");
		String kdvOraniStr = "";
		if(request.getParameter("kdvOrani") != null)
			kdvOraniStr = request.getParameter("kdvOrani");
		%>
	    <td><input name="nevi" type="text" value="<%=neviStr%>" size="14"></td>
	    <td><input name="yevmiyeDefNo" type="text" value="<%=yevmiyeDefNoStr%>" size="12"></td>
	    <td><input name="ambarDefNo" type="text" value="<%=ambarDefNoStr%>" size="11"></td>
	    <td><input name="miktar" type="text" value="<%=miktarStr%>" size="7"></td>
	    <td><input name="olcuBirimi" type="text" value="<%=olcuBirimiStr%>" size="8"></td>
	    <td><input name="birimFiyat" type="text" value="<%=birimFiyatStr%>" size="9"></td>
	    <td><input name="kdvOrani" type="text" value="<%=kdvOraniStr%>" size="9"></td>
	<%} else {%>
	    <td><input name="nevi" type="text" value="" size="14"></td>
	    <td><input name="yevmiyeDefNo" type="text" size="12"></td>
	    <td><input name="ambarDefNo" type="text" size="11"></td>
	    <td><input name="miktar" type="text" size="7"></td>
	    <td><input name="olcuBirimi" type="text" size="8"></td>
	    <td><input name="birimFiyat" type="text" size="9"></td>
	    <td><input name="kdvOrani" type="text" size="9"></td>
	<%}%>
    </tr>
	<tr><td align=left><table width=79%>
		<input type="button" name="ekleButton" value="  Ekle  " onClick="ekleFunc()">
	</table></td></tr>
</table>
<% //eğer başarısız bir ekleme girişimi olduysa buraya bir uyarı yaz
if(malEklemeyeCalisti && !malEkledi) {%>
<font color="red">Lütfen girdiğiniz bilgileri kontrol edip tekrar deneyiniz.</font>
<%}%>
<br>
<%
if(request.getParameter("butceTipi") == null
	|| request.getParameter("butceTipi").equals("bilimsel")) {%>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">

<tr>
<td colspan="3" align="center">Muayene Komisyon Üyeleri</td>
</tr>

<tr>
<td align="center" width=33%>Ba&#351;kan</td>
<td align="center" width=33%>Üye</td>
<td align="center">Üye</td>
</tr>

<tr>
<td align="center">Ayniyat Sayman&#305;</td>
<td align="center">Ayniyat Üyesi</td>
<td align="center">Proje Yürütücüsü</td>
</tr>

<tr>
<td align="center"><%=saymanAdi%></td>
<td align="center">
     	<select size="1" name="UyeSec">
			<%for(int i=0; i<numAyniyatUsers; ++i) {
				if(saymanID.equals(ayniyatUserIDs[i]))
					continue;
				if(selectedUserID.equals(ayniyatUserIDs[i])) {%>
			<option selected value="<%=ayniyatUserIDs[i]%>"><%=ayniyatUserNames[i]%></option>
			<%	} else {%>	
			<option value="<%=ayniyatUserIDs[i]%>"><%=ayniyatUserNames[i]%></option>							
			<%	}
			}%>
		</select></td>
<td align="center"><%=isteyen%></td>
</tr>


<tr>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">ad&#305;na</td>
</tr>


<tr>
<td align="center"></td>
<td align="center">&nbsp;</td>
<td align="center"><%=olusturan%></td>
</tr>
</table>
 <%} else { //kdb butcesi%>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">

<tr>
<td colspan="4" align="center">Muayene Komisyon Üyeleri</td>
</tr>

<tr>
<td align="center" width=25%>Ba&#351;kan</td>
<td align="center" width=25%>Üye</td>
<td align="center" width=25%>Üye</td>
<td align="center">Üye</td>

</tr>

<tr>
<td align="center">Ambar &#350;efi</td>
<td align="center">Ayniyat Üyesi</td>
<td align="center">Ayniyat Üyesi</td>
<td align="center">İsteği Yapan</td>

</tr>

<tr>
<td align="center"><%=sefAdi%></td>
<td align="center">
        <select size="1" name="UyeSec">
			<%for(int i=0; i<numAyniyatUsers; ++i) {
				if(sefID.equals(ayniyatUserIDs[i]))
					continue;
				if(selectedUserID.equals(ayniyatUserIDs[i])) {%>
			<option selected value="<%=ayniyatUserIDs[i]%>"><%=ayniyatUserNames[i]%></option>
			<%	} else {%>	
			<option value="<%=ayniyatUserIDs[i]%>"><%=ayniyatUserNames[i]%></option>							
			<%	}
			}%>
		</select></td>
<td align="center">
        <select size="1" name="UyeSec2">
            <%for(int i=0; i<numAyniyatUsers; ++i) {
            	if(sefID.equals(ayniyatUserIDs[i]))
					continue;
				if(selectedUserID2.equals(ayniyatUserIDs[i])) {%>
			<option selected value="<%=ayniyatUserIDs[i]%>"><%=ayniyatUserNames[i]%></option>
			<%	} else {%>	
			<option value="<%=ayniyatUserIDs[i]%>"><%=ayniyatUserNames[i]%></option>							
			<%	}
			}%>
	     </select></td>
<td align="center"><%=isteyen%></td>

</tr>

<tr>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">ad&#305;na</td>

</tr>
<tr>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center"><%=olusturan%></td>

</tr>

<tr>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>

</tr>
</table>
<%}%>

<table width=79%>
<tr>
<td width=100%>
    <p align="right">
    <input name="ileriButton" type="button" value="  ileri >>  " onClick="ileriFunc()">
</td>
</tr>
</table>
</div>
</form>

<input name="tarihGosterButton" type="button" value="Tarihçe Göster" onClick="tarihGosterFunc()">
<%if(tarihGoster) {%>
<%@ include file="../../security/istekTarihce.jsp_" %>
<%}%>
<% db.closeConnection(); %>
</div>
 <div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
</div>
</body>
</html>