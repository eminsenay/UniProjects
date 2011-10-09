<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@ page import="java.util.Date" %>
<% request.setCharacterEncoding("UTF-8"); %>


<% // TO DO: set .12 precision of double
   //        print butonu calismayabilir, deneme yapmadik..
   //        simdilik sat15 -- satx.jsp ye gonderiyoruz (onay), gercek sayfayi koy 
   //        reddet yok 
   //        fatura tarihinde yanlislik -- simdilik xxx%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<SCRIPT language="JavaScript">

	function tarihGoster()
	{
		var today = new Date()
		var month = today.getMonth() + 1
		var day = today.getDate()
		var year = today.getFullYear()
		var s = "/"

		return month + s + day + s + year
	}
	
	function onayDugmesi() {
			<!-- formdaki onay isimli hidden inputa "onaylandi" yaziliyor -->
			document.form1.onay.value = "onaylandi";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.form1.submit();
		}
		
	function redDugmesi() {
			<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
			document.form1.onay.value = "reddedildi";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.form1.submit();
		}
	
</SCRIPT>


<%
//------------security kodlar? buraya!!!
// eger asagidaki variable false yapilirsa, sign applet sayfada gozukmez
boolean securityEnabled = true;
//-----------security kodlar? bitti


//session'dan baktigimiz formun id'sini ve kullanicinin id'sini cekelim

String requestFormID =(String)session.getAttribute("requestFormID");
String userID = (String)session.getAttribute("userID");



DB db = new DB(true);


ResultSet fisBilgileri = db.executeQuery("call IstekFisiGoster_sp('"+requestFormID+"')");
ResultSet ayniyatBilgileri = db.executeQuery("call AyniyatBilgileriGoster_sp('"+requestFormID+"')");
ResultSet faturaKalemleri = db.executeQuery("call FaturaKalemleriGoster_sp('"+requestFormID+"')");



if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("onaylandi")){	
	
	System.out.println("onaylanmak uzere..");
	
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	String nextGroupID = "000004-GRP";	//satin almanin grup idsi	
	String nextPageCode = "../but/but1.jsp";	//satin almanin tesellumden sonraki sayfasi henuz hazirlanmadi
	
	String yorum = (String)session.getAttribute("yorum");
	
	//onay yapmadan once DB deki AyniyatBilgileri  update et
	Date tarih = new Date();
	String query1 = "call  AyniyatMakbuzuEkle_sp('"+requestFormID+"','"+tarih.toString()+"')";
	System.out.println(query1);
	ResultSet result1 = db.executeQuery(query1);	
		
	//satin almaya gonder
	db.executeSP("IstekAktar_sp", new Object [] {requestFormID, nextGroupID, nextPageCode, userID, yorum,"1"});
	
	
	//bu sp'nin hatal? dönmesi olas?l?g?n? kontrol et
	//basar?l? oldugunu varsayarsak
	
	//sessiondan aman requestFromID'yi remove et
	session.removeAttribute("requestFormID");
	db.closeConnection();
	response.sendRedirect("../../alerts/approve.jsp");
	return;

}else System.out.println("bakiliyor..");
%>

<html>
<head>
<title>Ayniyat Tesell&uuml;m Makbuzu</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../index/gui.css" rel="stylesheet" type="text/css">


</head>

<body>
<div id="toprightt"> </div>
<div id="topright2">

 
<%

System.out.println("cheking");
System.out.println(fisBilgileri.getRow());
System.out.println(ayniyatBilgileri.getRow());


if(fisBilgileri.next()&& ayniyatBilgileri.next() )
{  
	System.out.println("cheking ok");
	//satin almanin db'ye yazdiklarini cekip butce turunu ogren
	//eger butce turu Bilimsel Arastirma Projeleri Butcesi ise
	//buraya Proje No'sunu yaz
	String butceTipi = ayniyatBilgileri.getString("butceTipi");
	String butceTipiStr; //human readable
	String projeNoStr =" ";
	String projeNo    =" ";
	if(butceTipi.equals("bilimsel"))
	{
	  butceTipiStr = "Bilimsel Arastırma Projeleri";
	  projeNoStr = "Proje No:";
	  
	  //"get projeNo from where it is saved"; 
	  
	}else
	  butceTipiStr = "Katma De&#287er Bütçesi";
%>

<div align="center">
  <p align="center">T.C.</p>
  <p align="center">BOGAZİÇİ ÜNİVERSİTESİ</p>
  <p align="center"><%=butceTipiStr%></p>
  <p align="center" class="style1">AYNİYAT TESELLÜM MAKBUZU </p>
  <p align="center" class="style5">Eşyanın verildiği Müessese: 
  <%
  
  
   //bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz

 
  
  String olusturanGroupID = fisBilgileri.getString("GrupNo");
  System.out.println(olusturanGroupID);
  ResultSet olusturanGroup = db.executeQuery("call GrupGoster_sp('" + olusturanGroupID + "')");
  olusturanGroup.next();
  
  String olusturanGrupAdi = olusturanGroup.getString("GrupAdi");
  System.out.println(olusturanGrupAdi);
  
  %>
  <%=olusturanGrupAdi%></p>
   
  <form name="form1" method="post" action="sat15.jsp">
  <table width="760" border="1" align="center">
    <tr bordercolor="#000000">
      <td width="192">Eşyanın Alındığı Müesesse</td>
      <td width="672">
	  <%
	  //db'den firmayi cek - satin almacilarin yazmis olmasi lazim
	  String saticiFirma = fisBilgileri.getString("SaticiFirma");
	  %>
	  <%=saticiFirma%>
	  </td>
    </tr>
  </table>
  <table width="760" height="91" border="1" align="center">
    <tr bordercolor="#000000">
      <td width="192" height="26">Fatura Numarası </td>
      <td width="165">
	  <%//fatura noyu yaz
	  String faturaNo = fisBilgileri.getString("FaturaNo");
	  %>
	  <%=faturaNo%>
	  </td>
      <td width="334">Ayniyat Makbuzu Sıra No:</td>
      <td width="161"><%=ayniyatBilgileri.getString("MakbuzNo")%></td>
    </tr>
    <tr bordercolor="#000000">
      <td>Fatura Tarihi </td>
      <td>
	  <%//fatura tarihini yaz
	  String faturaTarihi = "xxxx";
	  %>
	  <%=faturaTarihi%>
	  </td>
      <td>Ayniyat Makbuzu Tarihi: </td>
      <td>
	  <%//tarih goster %>
	  <script> tarihGoster() </script>
	  <%//db ye Aynniyat_Bilgileri -> MakbuzDuzenlemeTarihi tarih olarak full date koy %>
	  </td>
    </tr>
    <tr bordercolor="#000000">
      <td>&nbsp; </td>
      <td>&nbsp;</td>
      <td>
	  <%=projeNoStr%>
	  </td>
      <td>
	  <%=projeNo%>	  
	  </td>
    </tr>
  </table>
  
  <% System.out.println("checking firma ok"); %>
  
  <table width="760" height="52" border="1" align="center">
    <tr bordercolor="#000000">
      <td width="31" height="46"><div align="center">Sıra No: </div></td>
      <td width="74"><div align="center">Ambar Defteri Sıra No: </div></td>
      <td width="74"><div align="center">Yevmiye Defteri Kayıt No: </div></td>
      <td width="74"><div align="center">Tüketim Malzeme No: </div></td>
      <td width="296"><div align="center">Malzeme Adı</div></td>
      <td width="56"><div align="center">Ölçü Birimi </div></td>
      <td width="62"><div align="center">Alınan Miktar </div></td>
      <td width="63"><div align="center">Birim Fiyatı </div></td>
      <td width="90"><div align="center">Toplam Fiyatı </div></td>
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
      <td width="31" height="26"><%=siraNo%></td>
      <td width="72"><%=faturaKalemleri.getString("AmbarDefteriSayfaNo")%></td>
      <td width="72"><%=faturaKalemleri.getString("YevmiyeDefteriSayfaNo")%></td>
      <td width="72"><%=faturaKalemleri.getString("TuketimMalzemeNo")%></td>
      <td width="298"><%=faturaKalemleri.getString("Nevi")%></td>
      <td width="59"><%=faturaKalemleri.getString("OlcuBirimi")%></td>
	  <%miktar = Integer.parseInt(faturaKalemleri.getString("Miktar"));%>
      <td width="64"><%=miktar%></td>
	  <%fiyat = Double.parseDouble(faturaKalemleri.getString("BirimFiyat"));%>
      <td width="63"><%=fiyat%></td>
	  <%malzemeToplam = miktar * fiyat;%>
      <td width="91"><%=malzemeToplam%></td>
    </tr>
	<%
	toplam += malzemeToplam;
	
	KDV = Double.parseDouble( faturaKalemleri.getString("KDVOrani"));
	KDVTutari = KDV * malzemeToplam ;
	KDVToplam += KDVTutari ;
		
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
      <td width="91"><div align="left"><%=toplam%></div></td>
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
      <td><div align="left"><%=KDVToplam%> </div></td>
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
	  
      <%double genelToplam = toplam + KDVToplam; %>
      <td><div align="left"><%=genelToplam %></div></td>
    </tr>
  </table>
  <p align="center" class="style6"> Ayniyat Saymanı </p>
  <p align="center">Adnan AYDIN </p>
  <p>&nbsp;</p>
  <p align="center">Yukarıda cinsi ve miktarı yazılı <%=genelToplam%> Lira tutarındaki <%=siraNo-1%> kalem eşya <%=saticiFirma%>'den teslim alınmıstır.</p>

  <p>&nbsp;</p>
  
<%}%>  
    <!-- yorum kutusu -->
    <div align="center">
        <label>
          <input name="yorum" type="text" id="yorum" value="Lütfen yorumunuzu giriniz.." size="40" maxlength="40">
        </label>
    </div>
  <br>
  <table width="100%"  border="0">
   <tr>
     <td><div align="center"> 
     	<input name="OnaylaButon" type="button" onClick="onayDugmesi()" value="Onayla">
     	
     </div>     </td>
     <td><div align="center"></div>     </td>
   </tr>
 </table>


 <p>
   <!-- hidden fieldlar -->
   <input type="hidden" name="onay" value="">
    <!-- hidden fieldlar -->
</p>


</div>

</div>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</body>
</html>
