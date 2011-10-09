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

<form name="onayFormu" action="but1.jsp" method="post">
<%
DB db=null;
try{
db=new DB(true);

//SECURITY CODE BEGIN
int securityIndex=2;  //Burası javasecurity index parametresi

//SECURITY CODE END

//String requestFormID = "000015-RFM";
String requestFormID = (String)session.getAttribute("requestFormID");
String status=request.getParameter("onay");
String BirimNo=request.getParameter("i_BirimNo");
String BDNo=request.getParameter("i_BDNo");
String BSiraNo=request.getParameter("i_BSiraNo");
String yorum=request.getParameter("i_yorum");
String farks=request.getParameter("i_fark");
String ButceUBNo="000000-UBR";
String message="";
String error="";
boolean alert=false;
BirimNo=(BirimNo==null)?"nill":BirimNo;
BDNo=(BDNo==null)?"nill":BDNo;
BSiraNo=(BSiraNo==null)?"000":BSiraNo;

if(status!=null){
	if(status.equals("onay")) {	
		db.beginTransaction();
		try{
			ResultSet rsx=db.executeSP("GercekFiyatOnayla_sp" ,new Object []{requestFormID}).getResult();
			if(rsx.next())
			{
				String res=rsx.getString("result");
				if(res.equals("-1"))
				{
					message="Bu Fisin Butce Dagilimi Belli Degil.";
					alert=true;
				}
				else if(res.equals("-2"))
				{
					message="Bu Fisin Gercek Satinalinan Fiyati Girilmemis.";
					alert=true;
				}
			}
			else{
				message="Fis Onaylamasi Bir Hatadan Dolayi Yapilamadi.";
				error="Hata Kodu: Serverdan Yanit Yok.";
				alert=true;		
			}
		}catch(Exception exc)
		{
			exc.printStackTrace(System.out);			
			message="Fis Onaylamasi Yapilamadi. Bir Hata Oluştu.";
			error="Hata Kodu: Exception.";
			alert=true;				
		}				
		String nextGroupID = "000004-GRP";
		String nextPageCode = "../but/but1.jsp";
		String userID = ((User)session.getAttribute("userClass")).getUserid();
		
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
		
		if(db.executeSP("IstekFisiTamamla_sp",new Object[]{requestFormID,nextGroupID,nextPageCode,userID,Integer.valueOf(1)})!=null)
		{
			ResultSet result3 = db.getResult();
			if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
				//SECURITY CODE BEGINS
				String historyID = result3.getString(1);
				String security_signature = request.getParameter("imza");
				String security_documentContent = request.getParameter("document_content");
				String security_date = request.getParameter("securityDate");
				Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID, Security.SIGN_FORMAT_BUT1);
				//SECURITY CODE ENDS
			}
	
			
			session.removeAttribute("requestFormID");
			db.commitTransaction();
			db.closeConnection();
			response.sendRedirect("../../alerts/approve.jsp");
			return;
		}else{
			db.rollbackTransaction();
			message="Fis Onaylamasi Yapilamadi. Bir Hata Oluştu.";
			error="Hata Kodu: Istek Fişi Tamamlanamadı.";
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

<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->	
function onayDugmesi()
{
	document.onayFormu.onay.value="onay";
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
</script>
<input id="i_status" name="i_status" type="hidden" value="nill" />
<input id="i_fark" name="i_fark" type="hidden" value="nill" />
<div align="center">
  <table width="750"  border="0"  id="baslik" class="tablefont">
         <tr>
      <td width="27%" height="56"><p align="center"><strong> T.C. </strong></p>
      <p align="center"><strong>BO&#286;AZ&#304;&Ccedil;&#304; &Uuml;N&#304;VERS&#304;TES&#304;</strong> </p></td>
      <td width="38%"><p align="center"><strong> &#304;STEK F&#304;&#350;&#304; </strong></p>
      
   
      <p align="center">Harcama Onay Sayfası</p></td>
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
		String gercekFiyat= rs.getString("GercekFiyat");
		//ekonomik kodu
		BSiraNo=rs.getString("ButceSiraNo");
		String ekonomikKod = rs.getString("KalemKodu");
		//String ekonomikKod = "06.1.2.01";
		ResultSet rst=db.executeSP("AyniyatBilgileriGoster_sp",new Object[]{requestFormID}).getResult();
		String blokelitutar="0.00";
		double fark=0.00;
		if(rst.next())
			gercekFiyat=rst.getString("ToplamFaturaTutari");
		else{
			throw new Exception("Toplam Satinalinan Fiyat Girilmemis.");
		}
		if(gercekFiyat==null)
			throw new Exception("Toplam Satinalinan Fiyat Girilmemis.");
			
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
         <td width="33%"><label style="font-weight: bold">Bütçe Sıra No</label></td>
          <td width="67%"><label><span id='security<%=securityIndex++ %>'><%=BSiraNo%></span></label></td>
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
      <td colspan="3"><div align="center">Al&#305;nan</div></td>
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
    //String MevcutTutar="22000.34";
    if(MevcutTutar==null)
    {	
		session.setAttribute("error","İstek fişinde hata var . Detay gösterilemiyor");
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
    }else    	
    	MevcutTutar=MevcutTutar.replace('.',',');
    double toplamtutar=0.00;
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
		
			double tutar=Double.parseDouble(miktar)*Double.parseDouble(birimFiyat.replace(',','.'));
			toplamtutar+=tutar;
	      %>
	      <tr align="center">
	        <td><label><span id='security<%=securityIndex++ %>'><%=miktar%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=urun%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=aciklama%></span></label></td>
	        <td><label><span id='security<%=securityIndex++ %>'><%=birimFiyat%></span></label></td>
	        <td><label><span ><%=tutar%></span></label></td>	       	 	
	      </tr>
    <%
    }
    fark=(Double.parseDouble(gercekFiyat)-toplamtutar)*-1.00;
    %>
    <tr>
    	<td colspan=3 align="left">Toplam Tutar:</td>
    	<td colspan=2 align="left"><%=toplamtutar %></td>
    </tr>
    <tr>
    	<td colspan=3 align="left">Blokeli Bütçe Miktarı</td>
    	<td colspan=2 align="left"><%=(toplamtutar+"").replace('.',',') %></td>
    </tr>
    <tr>
    	<td colspan=3 align="left">Gerçek Fiş Tutarı</td>
    	<td colspan=2 align="left"><span id='security<%=securityIndex++ %>'><%=gercekFiyat.replace('.',',') %></span></td>
    </tr>
    <tr>
    	<td colspan=3 align="left">Kalan Bütçe Farkı:</td>
    	<td colspan=2 align="left"><%=(String.valueOf(fark)).replace('.',',')%></td>
    </tr>
    <script language="JavaScript">
		document.onayFormu.i_fark.value=<%=fark%>;
</script>
  </table>
 <table width="79%">
 <tr>
 <td>
<input type=text name="errmsg" value="<%=message %>" style="border:thin solid white; color:red; width: 100%; font-size: 11px;" readonly="" /></td>
 
 </tr>
 </table>

<!-- yorum kutusu -->
<br><div align="center">
	<input type="textarea" name="yorum" value="Lütfen bir yorum giriniz." height="4" onblur="yorum_onblur(this)">
</div>

<!-- onay ve red dugmeleri -->
<br><div align="center">
	<input class="tablefont3"   type="button" value="Onayla" onClick="parent.leftFrame.securityOnayDugmesi()" language="JavaScript">
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
	</div>
</form>
</div>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color:black>Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</body>
<%
if(alert){
	out.println("<script language=javascript> alert('"+message+"');</script>");
	System.out.println("Pages/but1.jsp: "+message+error);
}
db.closeConnection(); 
}catch(Exception e){
	e.printStackTrace();
	db.closeConnection();
	db.rollbackTransaction();
	session.setAttribute("error","but1.jsp : "+e);
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
%>
</html>