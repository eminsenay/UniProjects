<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>

<% 

if((session.getAttribute("userClass"))==null){	   
	   response.sendRedirect("../logout.jsp");
	   return;	   
}

DB db=new DB(true);

try{

 
   String requestFormID = (String)session.getAttribute("requestFormID");
   
   ResultSet ist = db.executeSP("IstekFisiGoster_sp",new Object []{requestFormID}).getResult();

   if(ist.next()) ;	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç

 //istek fisi gosterilemiyorsa bu bostur , burdan geri dönmeli adam --bll	
 //	patlamas&#305;n diye burdan redirect olur.
 else{ 
	session.setAttribute("error","Istek fisinde hata var . Detay gösterilemiyor");
	response.sendRedirect("../alerts/GeneralAlert.jsp");
	return;	   
 }
   String _NO = ist.getString("IstekFisiKodu");
  boolean _dahiliPiyasa;
  String dahili= ist.getString("Dahili");
 	if(dahili.equals("1"))
 		_dahiliPiyasa=true;
 	else
		_dahiliPiyasa=false;
 //dahili piyasa mi harici piyasami

  String _tarih = ist.getString("OlusturmaTarihi"); //fis tarihi

  String kurumsalKod = ist.getString("Kurumsalkod");
  if (kurumsalKod == null)
	  kurumsalKod="";

  String fonksiyonelKod = ist.getString("FonksiyonelKodu");
  if (fonksiyonelKod == null)
	  fonksiyonelKod="";  
  
  String finansalKod = ist.getString("KalemKodu");
  if (finansalKod == null)
	  finansalKod=""; 
  
  String ekonomikKod = ist.getString("AnaKalemKodu")+"."+ist.getString("KalemKodu");
  if (ekonomikKod == null)
	  ekonomikKod="";  
 
 	// String butceDagilimNo= ist.getString("ButceDagilimNo");
	//  ana kalem adi 
    //  String anaKalemAdi = ist.getString("AnaKalemAdi");
	//kalem adi
    //  String kalemAdi = ist.getString("KalemAdi");
    //mevcut tutar
    // String mevcutTutar= ist.getString("MevcutTutar");
    //String _yaziylaToplam="Dort YTL Yetmis Iki YKR";

  String _ITEAdiSoyadi=ist.getString("Isteyen");//Ihtiyaci Talep Eden(ITE)
  String olusturan=ist.getString("Olusturan");
  
  ResultSet kulpoz = db.executeSP("KullaniciGoster_sp",new Object []{olusturan}).getResult();

  if(kulpoz.next()) ;	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
  else{ 
 	session.setAttribute("error","Istek fisinde hata var . Detay gösterilemiyor");
 	response.sendRedirect("../alerts/GeneralAlert.jsp");
 	return;	   
  }
  String pozisyon = kulpoz.getString("PozisyonNo");  
  
  ResultSet unvan= db.executeSP("PozisyonGoster_sp",new Object []{pozisyon}).getResult();
  
  if(unvan.next()) ;	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
  else{ 
 	session.setAttribute("error","Istek fisinde hata var . Detay gösterilemiyor");
 	response.sendRedirect("../alerts/GeneralAlert.jsp");
 	return;	   
  }
  
  String _ITEGorevUnvan = unvan.getString("PozisyonAdi");
  
  ////////////////////////////////////////////
  ///////////////////////////////////////////
  
  String _BTVTarih="";//Butcede tahsisati vardir
  String _siraNO="";
  String _baglanan="";


  String _IUAAdiSoyadi=""; //Ilgili unite amiri
  String _IUAGorevUnvan=""; 


  String _uygundurAdiSoyadi=""; 
  String _uygundurGorevUnvan="";

  //////////////////////////////////////////////
  //////////////////////////////////////////////
  
db.closeConnection();



%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
</head>

<body>

<table border="0" width="100%">
	<tr>
		<td style="height: 256px">
		<table border="0" width="100%" style="font-size: 11.0pt; font-family: 'Times New Roman', serif; font-weight: 400; font-style: normal; vertical-align: bottom; white-space: nowrap;">
			<tr>
				<td align="center" style="white-space: nowrap;">
				T.C.<br>BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</td>
				<td valign="bottom"  align="center" colspan=2>
				<b>&#304;STEK&nbsp; F&#304;&#350;&#304;</b></td>
				<td valign="bottom" style="white-space: nowrap;">
				NO : </td>
				<td valign=bottom style="white-space: nowrap;" align="left" nowrap>
                    <%=_NO%></td>
							</tr>
			<tr>
				<td height="21" >&nbsp;</td>
				<td colspan=2 align="center" height="21" >
				(&#304;htiyaç Belgesi)</td>
				<td height="21" >
				&nbsp;</td>
				<td align="left" height="21" nowrap>&nbsp;</td>
							</tr>
			<tr>
				<td style="vertical-align: middle;">Dahili piyasa <input type="checkbox" name="C1" value="ON" <%if(_dahiliPiyasa) out.print("checked");%>></td>
				<td width=50%></td>
				<td width=50%>&nbsp;</td>
				<td  >Tarih : </td>
				<td align="left" nowrap><%=_tarih%></td>
			</tr>
			<tr>
				<td style="vertical-align: middle;">Harici piyasa <input type="checkbox" name="C2" value="ON" <%if(!_dahiliPiyasa) out.print("checked");%>></td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td>Kurumsal : </td>
				<td align="left" nowrap><%=kurumsalKod%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >Fonksiyonel : </td>
				<td align="left" nowrap><%=fonksiyonelKod%></td>
			</tr>
			<tr>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >Finansal : </td>
				<td align="left" nowrap><%=finansalKod%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >Ekonomik : </td>
				<td align="left" nowrap><%=ekonomikKod%></td>
			</tr>
			<!-- tr>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td style="white-space: nowrap;">Kalem Ad&#305; : </td>
				<td align="left" nowrap><%//=kalemAdi%></td>
			</tr>
			<tr>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >Mevcut Tutar</td>
				<td align="left" nowrap><%//=mevcutTutar%></td>
			</tr-->
			
		</table>
		*Her harcama kalemi için ayr&#305; istek fi&#351;i doldurulur.</td>
	</tr>
	<tr>
		<td>
		<table border="0" width="100%" style="font-size: 11.0pt; font-family: 'Times New Roman', serif; font-weight: 400; font-style: normal; vertical-align: bottom; white-space: nowrap;" cellpadding="0" cellspacing="0">
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan=2 align="center" style="border-right: black 1px solid; border-top: black 1px solid; border-bottom-width: 1px; border-bottom-color: black; border-left: black 1px solid">TAHM&#304;N&#304;</td>
							</tr>
			<tr>
				<td align=center valign=top style="border-top: black 1px solid; border-left: black 1px solid; height: 32px; border-bottom: black 1px solid;" width="10%">Miktar</td>
				<td align=center valign=top style="border-top: black 1px solid; border-left: black 1px solid; height: 32px; border-bottom: black 1px solid;" width="50%">AÇIKLAMA</td>
				<td align="center" valign=top style="border-top: black 1px solid; border-left: black 1px solid; height: 32px; border-bottom: black 1px solid;" width="20%">Birim Fiyat&#305;<br>YTL</td>
				<td align="center" valign=top style="border-right: black 1px solid; border-top: black 1px solid; border-left: black 1px solid; height: 32px; border-bottom: black 1px solid;" width="20%">Tutar&#305;<br>YTL</td>
			</tr>
			<%
	         		
			ist.previous();
			String toplam="0.0";
			  if(ist!=null)
    			   while(ist.next()) {
			                     
			                      String miktar = ist.getString("Miktar");
			                       
			                      String urun = ist.getString("UrunAdi");			               
			                     
			                      String birimFiyati = ist.getString("TahminiFiyat");
			                     
			                      String tutar="";
			                     	try{
			        				tutar=""+(Integer.parseInt(miktar) * Double.parseDouble(birimFiyati));
			            			}catch(Exception e){}
			            			
			                     // AnaKalemAdi=ist.getString("AnaKalemAdi");
			                     // KalemAdi=ist.getString("KalemAdi");
			                      //burda tahmini fiyatin girilip girilmedigi kontrol ediliyor

			                      // tahmini fiyat kontrolu
			                      
			                      try{
			                          toplam=""+(Double.parseDouble(tutar) + Double.parseDouble(toplam));
			                          
			                        }catch(Exception e){} %>
			                    

			<tr>
				<td style="border-left: black 1px solid; height: 17px;" align="center"><%=miktar%></td>
				<td style="border-left: black 1px solid; height: 17px;" align="left">
				<%=urun%></td>
				<td align="right" style="border-left: black 1px solid; height: 17px;">
				<%=birimFiyati%>
				</td>
				<td align="right" style="border-right: black 1px solid; border-left: black 1px solid; height: 17px;">
				<%=tutar%></td>
			</tr>
			<%    }%>
		<% 	String _KDV=""+(((int)(Double.parseDouble(toplam)*18))/100.0);
            String _genelToplam=""+(Double.parseDouble(toplam) + (Double.parseDouble(_KDV)));
           							%>   
           							
			<tr style="height: 40.5pt">
								<td align=right valign=bottom style="border-left: black 1px solid">&nbsp;</td>
								<td align=right valign=bottom style="border-left: black 1px solid">&nbsp;</td>
								<td align=right valign=bottom style="border-top-width: 1px; border-bottom-width: 1px; border-bottom-color: black; border-left: black 1px solid; border-top-color: black; border-right-width: 1px; border-right-color: black">&nbsp;</td>
								<td align=right valign=bottom style="border-right: black 1px solid; border-left: black 1px solid">&nbsp;</td>
			</tr>
			<tr style="height: 40.5pt">
								<td align=right valign=bottom style="border-left: black 1px solid; border-bottom: black 1px solid">&nbsp;</td>
								<td align=right valign=bottom style="border-left: black 1px solid; border-bottom: black 1px solid">&nbsp;</td>
								<td align=right valign=bottom style="border-left: black 1px solid; border-bottom: black 1px solid">&nbsp;</td>
								<td align=right valign=bottom style="border-top-width: 1px; border-right: black 1px solid; border-left: black 1px solid; border-top-color: black; border-bottom: black 1px solid">&nbsp;</td>
			</tr>
			<tr>
								<td colspan=2 align=right valign=bottom style="border-left: black 1px solid;">Toplam:</td>
								<td align=right colspan=2 style="border-left: black 1px solid; border-right: black 1px solid; border-bottom: black 1px solid;"><%=toplam+" YTL"%></td>
			</tr>
			<tr>
								<td colspan=2 align=right valign=bottom style="border-left: black 1px solid;">%18 KDV:</td>
								<td align=right colspan=2 style="border-left: black 1px solid; border-right: black 1px solid; border-bottom: black 1px solid;"><%=_KDV+" YTL"%></td>
			</tr>
			<tr>
								<td colspan=2 align=right valign=bottom style="border-left: black 1px solid; border-bottom: black 1px solid;">Genel Toplam:</td>
								<td align=right colspan=2 style="border-left: black 1px solid; border-right: black 1px solid; border-bottom: black 1px solid;"><%=_genelToplam+" YTL"%></td>
			</tr>
			<!-- tr>
				<td colspan="4" align="center" valign=bottom style="border-left: black 1px solid; border-right: black 1px solid; border-bottom: black 1px solid;">Yaln&#305;z <%//=_yaziylaToplam%></td>
			</tr -->
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table border="0" width="100%" style="font-size: 11.0pt; font-family: 'Times New Roman', serif; font-weight: 400; font-style: normal; vertical-align: bottom; white-space: nowrap;">
			<tr style="height: 48.75pt">
								<td colspan=2 valign="bottom" width=50% style="font-size: 12.0pt; font-weight: 700; font-family: 'Times New Roman', serif; color: windowtext; font-style: normal;  white-space: nowrap;">&#304;htiyac&#305; Talep Eden</td>
				<td colspan=2 valign="bottom" width=50% style="font-size: 12.0pt; font-weight: 700; font-family: 'Times New Roman', serif; color: windowtext; font-style: normal;  white-space: nowrap;">Bütçede tahsisat&#305; vard&#305;r</td>
			</tr>
			<tr>
				<td nowrap>Ad&#305; Soyad&#305; :</td>
				<td width="50%">
                    <%=_ITEAdiSoyadi%></td>
				<td nowrap>Tarih :</td>
				<td width="50%">
                    <%=_BTVTarih%></td>
			</tr>
			<tr>
				<td nowrap>Görev Unvan&#305; :</td>
				<td width="50%"><%=_ITEGorevUnvan%></td>
				<td nowrap>S&#305;ra No :</td>
				<td width="50%"><%=_siraNO%></td>
			</tr>
			<tr>
				<td nowrap>&#304;mzas&#305; : </td>
				<td width="50%">&nbsp;</td>
				<td nowrap>Ba&#287;lanan :</td>
				<td width="50%"><%=_baglanan%></td>
			</tr>
			<tr>
				<td valign=bottom colspan=2 style="height: 48.75pt; font-size: 12.0pt; font-weight: 700; font-family: 'Times New Roman', serif; color: windowtext; font-style: normal;  white-space: nowrap;">&#304;lgili Ünite Amiri</td>
				<td colspan=2 valign=bottom style="font-size: 12.0pt; font-weight: 700; font-family: 'Times New Roman', serif; color: windowtext; font-style: normal;  white-space: nowrap;">Uygundur</td>
											</tr>
			<tr>
				<td nowrap>Ad&#305; Soyad&#305; :</td>
				<td width="50%"><%=_IUAAdiSoyadi%></td>
				<td nowrap>Ad&#305; Soyad&#305; :</td>
				<td width="50%"><%=_uygundurAdiSoyadi%></td>
			</tr>
			<tr>
				<td nowrap>Görev Unvan&#305; :</td>
				<td width="50%"><%=_IUAGorevUnvan%></td>
				<td nowrap>Görev Unvan&#305; :</td>
				<td width="50%"><%=_uygundurGorevUnvan%></td>
			</tr>
			<tr>
				<td nowrap>&#304;mzas&#305; : </td>
				<td width="50%">&nbsp;</td>
				<td nowrap>&#304;mzas&#305; : </td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td nowrap>&nbsp;</td>
				<td width="50%">&nbsp;</td>
				<td nowrap>&nbsp;</td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td nowrap>&nbsp;</td>
				<td width="50%">&nbsp;</td>
				<td nowrap>&nbsp;</td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td nowrap colspan="4">Not1: KATMA BÜTÇE: 1 Nüsha Di&#287;erleri 4'er nüsha düzenlenecek
</td>
			</tr>
			<!-- tr>
				<td nowrap>Yaln&#305;z</td>
				<td  colspan=3 width="100%"><%//=_yaziylaToplam%></td>
				</tr-->
			<tr>
				<td nowrap>&nbsp;</td>
				<td width="50%">&nbsp;</td>
				<td nowrap>&nbsp;</td>
				<td width="50%">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<script lang=javascript>
window.print();
</script>
   

<% }catch(Exception e){
	e.printStackTrace();
	db.closeConnection();
	session.setAttribute("error","sup1 : "+e);
	response.sendRedirect("../alerts/GeneralAlert.jsp");
	return;
} %>

</body>

</html>