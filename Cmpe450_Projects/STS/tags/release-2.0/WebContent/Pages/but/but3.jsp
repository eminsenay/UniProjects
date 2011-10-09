<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <% request.setCharacterEncoding("UTF-8");%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="toprightt"> </div>
<div id="topright2">

<form name="onayFormu" action="but3.jsp" method="post">
<%
DB db=null;
try{
	
//	SECURITY CODE BEGIN
	int securityIndex=2;  //Burası javasecurity index parametresi

//	SECURITY CODE END
	
db=new DB(true);
//String requestFormID = "000015-RFM";
String requestFormID = (String)session.getAttribute("requestFormID");
String status=request.getParameter("onay");
String isteks=request.getParameter("i_isteks");
String BirimNo=request.getParameter("i_BirimNo");
String BDNo=request.getParameter("i_BDNo");
String BSiraNo=request.getParameter("i_BSiraNo");
String yorum=request.getParameter("i_yorum");
String toplam=request.getParameter("i_toplam");
String next=request.getParameter("i_next");
String ButceUBNo="000000-UBR";
String message="";
String error="";
boolean alert=false;
BirimNo=(BirimNo==null)?"nill":BirimNo;
BDNo=(BDNo==null)?"nill":BDNo;
BSiraNo=(BSiraNo==null)?"000":BSiraNo;

if(status!=null){
	if(status.equals("onay")) {
	
		String [] tokens=isteks.split("@");
		db.beginTransaction();		
		System.out.println(tokens[0]);
		for(int i=1;i<tokens.length;i++)
		{
			try{
				ResultSet rsx=db.executeSP("IstekButceTahminiFiyatGuncelle_sp", new Object[]{tokens[i++],Double.valueOf(tokens[i])}).getResult();
				if(rsx.next())
				{
					if(rsx.getString("result").equals("-1"))
					{
						message="Fis Onaylamasi Bir Hatadan Dolayi Yapilamadi.";
						error="Hata Kodu: ButceTahminiFiyat Guncellenemedi.";
						db.rollbackTransaction();
						alert=true;
						break;
					}
				}
			}catch(Exception exc){
				exc.printStackTrace(System.out);
				message="Fis Onaylamasi Bir Hatadan Dolayi Yapilamadi.";
				error="Hata Kodu: Exception: ButceTahminiFiyat Guncellenemedi.";
				db.rollbackTransaction();
				alert=true;
				break;
			}			
		}
		if(!alert){
			if(db.executeSP("ButceSiraNoGuncelle_sp",new Object[]{requestFormID,BSiraNo})==null)
			{
				message="Fis Onaylamasi Bir Hatadan Dolayi Yapilamadi.";
				error="Hata Kodu: Butce Sira No Guncellenemedi.";
				db.rollbackTransaction();
				alert=true;		
			}else{
			}
		}
		if(!alert)
		{
			try{		
				ResultSet rsx=db.executeSP("IstekFisinButceDagiliminiDegistir_sp",new Object[]{BDNo,requestFormID,Double.valueOf(toplam.replace(',','.'))}).getResult();
				if(rsx.next())
				{
					if(!rsx.getString("result").equals("1"))
					{
						message="Fis Onaylamasi Bir Hatadan Dolayi Yapilamadi.";
						error="Hata Kodu: Butce Bloke Fiyati Degistirilemedi.";
						db.rollbackTransaction();
						alert=true;
					}
				}
			}catch(Exception exc){			
			exc.printStackTrace(System.out);
			message="Fis Onaylamasi Bir Hatadan Dolayi Yapilamadi.";
			error="Hata Kodu: Exception: ButeceBloke Fiyati Degistirilemedi.";
			db.rollbackTransaction();
			alert=true;
			}
		}
			
		
		message="GUNCELLE  fid:"+requestFormID+"toplam:"+toplam+" birimno:"+BirimNo+" BDNo:"+BDNo+" BSiraNo:"+BSiraNo+" yorum:"+yorum+" isteks:"+isteks;
		String nextGroupID = "000005-GRP";
		String nextPageCode = "../sat/sat1.jsp";
		if(next.equals("r"))
		{
			nextGroupID = "000007-GRP";
			nextPageCode = "../rek/rek1.jsp";						
		}
		String userID = ((User)session.getAttribute("userClass")).getUserid();
		if(!alert){
			
//			SECURITY CODE BEGIN
			boolean verification = true;
			if (session.getAttribute("securityEnabled").equals("true")) {
				String security_signature = request.getParameter("imza");
				String security_documentContent = request.getParameter("document_content");
				String security_date = request.getParameter("securityDate");
				session.setAttribute("securityDocument", security_documentContent);
				verification = global.Security.verifySignature(userID, security_documentContent, security_signature,security_date);
			}
			//SECURITY CODE END
			
			if(db.executeSP("IstekAktar_sp",new Object[]{requestFormID,nextGroupID,nextPageCode,userID,yorum,Integer.valueOf(1)})!=null)
			{
				ResultSet result3 = db.getResult();
				if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
					//SECURITY CODE BEGINS
					String historyID = result3.getString(1);
					
					String security_signature = request.getParameter("imza");
					String security_documentContent = request.getParameter("document_content");
					String security_date = request.getParameter("securityDate");
					Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_BUT3);
					//SECURITY CODE ENDS
				}
				session.removeAttribute("requestFormID");
				db.commitTransaction();
				db.closeConnection();
				response.sendRedirect("../../alerts/approve.jsp");	
				return;
			}else{
				db.rollbackTransaction();
				message="Bir Hatadan Dolayı Onaylanamadı.";
				error="Hata Kodu: Istek Aktarilamadi.";
				alert=true;
			}
		}
	}
	if(status.equals("red")) {
		
		String nextGroupID = "000004-GRP";
		String nextPageCode = "../but/but2.jsp";
		String userID = ((User)session.getAttribute("userClass")).getUserid();
		if(yorum==null)
			yorum="Butce Baskani yorum girmemistir";
		if(db.executeSP("IstekAktar_sp",new Object[]{requestFormID,nextGroupID,nextPageCode,userID,yorum,Integer.valueOf(0)})!=null)
		{
			session.removeAttribute("requestFormID");
			db.commitTransaction();
			db.closeConnection();
			response.sendRedirect("../../alerts/reject.jsp");	
			return;
		}else{
			db.rollbackTransaction();
			message="Bir Hatadan Dolayı Reddelimedi.";
			error="Hata Kodu: Istek Reddedilemedi.";
			alert=true;
		}
	}
}
boolean tarihGoster = false;
if(request.getParameter("tarihGoster") != null&& ((String)request.getParameter("tarihGoster")).equals("evet"))
	tarihGoster = true;

//bu noktada db'den requestForm ile ilgili bilgileri ÃƒÂ§ekiyoruz
ResultSet rs = db.executeSP("IstekFisiGoster_sp",new Object[]{requestFormID}).getResult();
rs.next();	//genel form bilgilerinin hemen okunabilmesi iÃƒÂ§in ilk rowa geÃƒÂ§
%>
<script language=javascript src="../validator.js"></script>
<script language="JavaScript">
var tutars=new Array();
var elems=new Array();
var elemst=new Array();
var elemsb=new Array();

	
function f_onblur(e){
	var toplam=0;
	for(var i=0; i<elems.length;i++)
	{
		if(!validateElement(elems[i],true))
			return;
		elems[i].value=convertFloattoYTL(parseYTLtoFloat((elems[i].value)));		
		elemst[i].value=convertFloattoYTL(elemsb[i]*parseYTLtoFloat((elems[i].value)));		
		toplam=toplam+elemsb[i]*parseYTLtoFloat((elems[i].value));
	}

	var kln=parseYTLtoFloat(document.onayFormu.mevcut.value)-toplam;
	document.onayFormu.kalan.value=convertFloattoYTL(kln);
	if(kln<0)
		document.onayFormu.errmsg.value="Mevcut Butce Miktari bu odeme icin yetersiz.";
	document.onayFormu.toplam.value=convertFloattoYTL(toplam);
		
}	
function onay_onclick(next)
{
	if(!validateForm(onayFormu))
		return;
	document.onayFormu.i_next.value=next;
	if(0>parseYTLtoFloat(document.onayFormu.kalan.value))
	{
		document.onayFormu.errmsg.value="Mevcut Butce Miktari bu odeme icin yetersiz."
		alert(document.onayFormu.errmsg.value);
		return
	}
	for(var i=0; i<elems.length;i++)
	{
		document.onayFormu.i_isteks.value=document.onayFormu.i_isteks.value+'@'+elems[i].bid+'@'+parseYTLtoFloat(elems[i].value);
	}
	document.onayFormu.i_toplam.value=document.onayFormu.toplam.value;
	parent.leftFrame.securityOnayDugmesi();
}

function onayDugmesi() {
	document.onayFormu.onay.value="onay";
	document.onayFormu.submit();
}

function red_onclick(){
	document.onayFormu.onay.value="red";
	document.onayFormu.submit();
}
function bsirano_onblur(t){
	document.onayFormu.i_BSiraNo.value=t.value;
}
function yorum_onblur(y){
	document.onayFormu.i_yorum.value=y.value;
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
</script>
<input id="i_status" name="i_status" type="hidden" value="nill" />
<input id="i_isteks" name="i_isteks" type="hidden" value="" />
<input id="i_BirimNo" name="i_BirimNo" type="hidden" value="<%=BirimNo %>" />
<input id="i_BDNo" name="i_BDNo" type="hidden" value="<%=BDNo%>" />
<input id="i_BSiraNo" name="i_BSiraNo" type="hidden" value="<%=BSiraNo%>" />
<input id="i_yorum" name="i_yorum" type="hidden" value="<%=yorum%>" />
<input id="i_next" name="i_next" type="hidden" value="<%=next%>" />
<input id="i_toplam" name="i_toplam" type="hidden" value="" />
<div align="center">
  <table width="79%"  border="0"  id="baslik" class="tablefont">
          <tr>
      <td width="27%" height="56"><p align="center"><strong> T.C. </strong></p>
      <p align="center"><strong>BO&#286;AZ&#304;&Ccedil;&#304; &Uuml;N&#304;VERS&#304;TES&#304;</strong> </p></td>
      <td width="38%"><p align="center"><strong> &#304;STEK F&#304;&#350;&#304; </strong></p>
      <%
      String sayfaAdi = rs.getString("SayfaAdi");
      %>
      <p align="center"><%=sayfaAdi%></p></td>
      <%
      //fis no
		String fisKodu = rs.getString("IstekFisiKodu");
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
    	String dahili= rs.getString("Dahili");
    	String piyasa="";
    	if(dahili.equals("1"))
    		piyasa="Dahili Piyasa";
    	else
    		piyasa = "Harici Piyasa";
    	%>
      <td width="46%" height="132"><div align="justify">
        <table width="98%"  border="1" bordercolor="#CCCCFF" class="tablefont">
          <tr>
            <td width="49%">Seçilen Piyasa Seçeneği</td>
            <td width="51%"><span id='security<%=securityIndex++ %>'><%=piyasa%></span></td>
          </tr>
        </table>
      </div></td>
      <%
		//tarih
		String theDate = rs.getString("OlusturmaTarihi");
		//String finansalKod = rs.getString("...........");
		//kurumsal kod 
		String kurumsalKod = rs.getString("KurumsalKod");
		//String kurumsalKod = "97.08.02.04";
		//fonksiyonel kod
		String fonksiyonelKod = rs.getString("FonksiyonelKodu");
		//String fonksiyonelKod = "09.4.1.00";
		String finansalKod = "2";
		//ekonomik kodu
		String ekonomikKod = rs.getString("KalemKodu");
		//String ekonomikKod = "06.1.2.01";
		//proje no
		BDNo=rs.getString("ButceDagilimNo");
		out.println("<script language=javascript>document.onayFormu.i_BDNo.value='"+BDNo+"';</script>");
		BSiraNo=rs.getString("ButceSiraNo");
		//String projeNo = rs.getString("...........");
		String projeNo = "5";
      %>
      <td width="60%"><table width="100%"  border="1" bordercolor="#CCCCFF" class="tablefont" style="font-weight: normal;">
        <tr>
          <td width="33%"><label style="font-weight: bold">Tarih</label></td>
          <td width="67%"><label  onFocus=""><span id='security<%=securityIndex++ %>'><%=theDate%></span></label></td>
        </tr>
        <tr>
         <td width="33%"><label style="font-weight: bold">Kurumsal</label></td>
          <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=kurumsalKod%></span></label></td>
        </tr>
        <tr>
          <td width="33%"><label style="font-weight: bold">Fonksiyonel</label></td>
          <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=fonksiyonelKod%></span></label></td>
        </tr>        
        <tr>
        
          <td width="33%"><label style="font-weight: bold">Finansal</label></td>
          <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=finansalKod%></span></label></td>
        </tr>
        <tr>
         <td width="33%"><label style="font-weight: bold">Ekonomik</label></td>
          <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=ekonomikKod%></span></label></td>
        </tr>
        <tr>
            <td width="40%" height="19"><label style="font-weight: bold">Butce Sıra No</label></td>
          <td width="60%"><input id='security<%=securityIndex++ %>' type="text" name="bsirano" value="<%=BSiraNo %>" onblur="bsirano_onblur(this)"></td>
        </tr>        	        
      </table></td>
    </tr>
  </table>
	<br>
	
  <table width="79%"  border=" bordercolor="#CCCCFF" class="tablefont2">
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
    <%
    
    int j=0;
    String MevcutTutar= rs.getString("MevcutTutar");
    if(MevcutTutar==null)
    {	
		session.setAttribute("error","İstek fişinde hata var . Detay gösterilemiyor");
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
    }else    	
    	MevcutTutar=MevcutTutar.replace('.',',');
    rs.previous();
    while(rs.next()) {
			//miktar
			String miktar = rs.getString("Miktar");
			//urun
			String urun = rs.getString("UrunAdi");
			//aciklama
			String aciklama = rs.getString("Aciklama");
			//birimfiyat?
			String birimFiyat = rs.getString("TahminiFiyat").replace('.',',');
			//String birimFiyat = "birimFiyat?";	
	      %>
	      <tr align="center">
	        <td><label><span id='security<%=securityIndex++ %>'><%=miktar%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=urun%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=aciklama%></span></label></td>
	        <td>
	       	 	<input id='security<%=securityIndex++ %>' name="f<%=j%>" bid="<%=rs.getString("IstekNo")%>" size=10 type=text validator=YTL value="<%=birimFiyat%>" 
	        			onblur="f_onblur(this)" style="width: 100%; text-align: right;">
	       </td>
	        <td>
	        	<input id="fg<%=j%>" name="t<%=++j%>" size=10 value="0" disabled=""
	        			style="width: 100%; text-align: right;">
	        </td>
	      </tr>
	      <script language=javascript>
	        elems[elems.length]=document.onayFormu.elements["f<%=--j%>"];
	        elemsb[elemsb.length]=<%=miktar%>;
	        elemst[elemst.length]=document.onayFormu.elements["t<%=++j%>"];
	      </script>
    <%
    }
    %>
    <tr>
    	<td colspan=3 align="left">Toplam Tutar:</td>
    	<td colspan=2 align="left"><input id='security<%=securityIndex++ %>' type="text" name="toplam" value="0" style="width: 100%; text-align: right;" disabled=""></td>
    </tr>
    <tr>
    	<td colspan=3 align="left">Kullanılabilir Bütçe Miktarı:</td>
    	<td colspan=2 align="left"><input id="mevcut" type="text" name="mevcut" value="<%=MevcutTutar%>" style="width: 100%; text-align: right;" disabled=""></td>
    </tr>
    <tr>
    	<td colspan=3 align="left">Kalan Bütçe Miktarı:</td>
    	<td colspan=2 align="left"><input id="kalan" type="text" name="kalan" value="0" style="width: 100%; text-align: right;" disabled=""></td>
    </tr>
  </table>
 <table width="79%">
 <tr>
 <td>
<input type=text name="errmsg" value="<%=message %>" style="border:thin solid white; color:red; width: 100%; font-size: 11px;" readonly="" /></td>
 
 </tr>
 </table>
 </div>
<script language=javascript>
f_onblur(elems[elems.length-1]);
</script>

<!-- yorum kutusu -->
<br><div align="center">
	<input type="textarea" name="yorum" value="Lütfen bir yorum giriniz." height="4" onblur="yorum_onblur(this)">
</div>

<!-- onay ve red dugmeleri -->
<br><div align="center">
	<input class="tablefont3"  type="button" value="Onayla ve Rektöre Yolla" onClick="onay_onclick('r')" language="JavaScript">
	<input class="tablefont3"  type="button" value="Onayla ve Satınalmaya Yolla" onClick="onay_onclick('s')" language="JavaScript">
	<input class="tablefont3"   type="button" value="Reddet" onClick="red_onclick()" language="JavaScript">
</div>

<!-- tarih goster dugmesi -->
<br><div align="center">
	<input class="tablefont3"   type="button" value="Tarihçe Göster" onClick="tarihDugmesi()" language="JavaScript">
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
	//tarihÃƒÂ§e muhabbeti, sayfanin basindaki kod bÃƒÂ¶lÃƒÂ¼mÃƒÂ¼nde set edilen
	//tarihGoster boolean variable?n?n degerine gore tarihÃƒÂ§eyi goster
	if(tarihGoster)	{
	%>
      <%@ include file="../../security/istekTarihce.jsp_" %>
	<%
	}
	%>



</form>
</div>
<script language=javascript >

</script>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</body>
<%
if(alert){
	out.println("<script language=javascript> alert('"+message+"');</script>");
	System.out.println("Pages/but3.jsp: "+message+error);
}
db.closeConnection(); 
}catch(Exception e){
	e.printStackTrace();
	db.rollbackTransaction();
	db.closeConnection();
	session.setAttribute("error","but3.jsp : "+e);
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
%>
</html>