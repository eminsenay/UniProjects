<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<%
DB db=new DB(true);
//SECURITY CODE BEGIN

int securityIndex=2;  //Burasi javasecurity index parametresi
//Checked By Nuri for security codes

//SECURITY CODE END

%>

<SCRIPT language="JavaScript">
	
	<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->
	function onayDugmesi() {
			<!-- formdaki onay isimli hidden inputa "onaylandi" yaziliyor -->
			document.detayFormu.onay.value = "onaylandi";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.detayFormu.submit();
		}
		
		function redDugmesi() {
			<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
			document.detayFormu.onay.value = "reddedildi";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.detayFormu.submit();
		}
		
		function detayGor1() {
			<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
			document.detayFormu.onay.value = "detaygor1";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.detayFormu.submit();
		}
		
		function detayGor2() {
			<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
			document.detayFormu.onay.value = "detaygor2";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.detayFormu.submit();
		}
		
		function ilgiliFisler() {
			
			
			<!-- fieldinin icerigini toggle edecek -->
			if(document.detayFormu.fisGoster.value == 'evet')
				document.detayFormu.fisGoster.value = "hayir";
			else
				document.detayFormu.fisGoster.value = "evet";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			alert(document.detayFormu.fisGoster.value+'');
			document.detayFormu.submit();
		}
		function geri_onclick(){
			document.detayFormu.onay.value="geri";
			document.detayFormu.submit();
		}	
	
</SCRIPT>



<%

String ihaleNo=(String)request.getParameter("ihaleNo");
String redirect=request.getParameter("redirect");
String teklifno=request.getParameter("TEKLIFNo");
System.out.println("sat13 ihale no"+ihaleNo);


if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("detaygor1")) {
	
	
	session.setAttribute("requestFormID",(String)request.getParameter("Istek_Fisi_No"));
	
	db.closeConnection();
	response.sendRedirect("../../Pages/sat/satistektakip.jsp?ihaleNo="+ihaleNo+"&redirectPage=../../Pages/sat/sat17.jsp&redirect="+redirect);
	return;
}
else if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("detaygor2")) {
	
	
	session.setAttribute("requestFormID",(String)request.getParameter("Teklif_No"));
	
	db.closeConnection();
	response.sendRedirect("../../Pages/sat/sattekliftakip.jsp?ihaleNo="+ihaleNo+"&redirectPage=../../Pages/sat/sat17.jsp&redirect="+redirect);
	return;
}

else if(request.getParameter("onay") != null && request.getParameter("onay").equals("geri")) {
	
	db.closeConnection();
	response.sendRedirect(redirect+"?ihaleNo="+ihaleNo+"&TEKLIFNo="+teklifno);
	return;
}


String fisGosterFlag="";
System.out.println(request.getParameter("fisGoster"));
if(request.getParameter("fisGoster") != null)
			fisGosterFlag = request.getParameter("fisGoster");
else
			fisGosterFlag = "hayir";


String IhaleAdi = "detay mevcut de&#287;il";
String IhaleAltTipi = "detay mevcut de&#287;il";
String IhaleTarihi = "detay mevcut de&#287;il";
String IhaleUrunTipi = "detay mevcut de&#287;il";
String KazananTeklifNo = "detay mevcut de&#287;il";
String BeklenenMaliyet = "detay mevcut de&#287;il";
String YatirimProjeNo="detay mevcut de&#287;il";
String ButceTertibi="detay mevcut de&#287;il";
String AvansSartlari="detay mevcut de&#287;il";
String IlanSekliAdedi="detay mevcut de&#287;il";
String OyidSatisBedeli="detay mevcut de&#287;il";
String BakanlarKuruluKarari="detay mevcut de&#287;il";

ResultSet rs = db.executeQuery("call IhaleGoster_sp('"+ ihaleNo + "')");
if(rs.next())
{
	if (rs.getString("IhaleAdi") != null)
       IhaleAdi = rs.getString("IhaleAdi");
	if (rs.getString("IhaleAltTipi") != null)
       IhaleAltTipi = rs.getString("IhaleAltTipi");
	if (rs.getString("IhaleTarihi") != null)
       IhaleTarihi = rs.getString("IhaleTarihi");
	if (rs.getString("IhaleUrunTipi") != null)
       IhaleUrunTipi = rs.getString("IhaleUrunTipi");
	if (rs.getString("KazananTeklifNo") != null)
       KazananTeklifNo = rs.getString("KazananTeklifNo");
	if (rs.getString("BeklenenMaliyet") != null)
       BeklenenMaliyet = rs.getString("BeklenenMaliyet");
	if (rs.getString("YatirimProjeNo") != null)
       YatirimProjeNo= rs.getString("YatirimProjeNo");
	if (rs.getString("ButceTertibi") != null)
       ButceTertibi=rs.getString("ButceTertibi");
	if (rs.getString("AvansSartlari") != null)
       AvansSartlari=rs.getString("AvansSartlari");
	if (rs.getString("IlanSekliAdedi") != null)
       IlanSekliAdedi=rs.getString("IlanSekliAdedi");
	if (rs.getString("OyidSatisBedeli") != null)
       OyidSatisBedeli=rs.getString("OyidSatisBedeli");
	if (rs.getString("BakanlarKuruluKarari") != null)
       BakanlarKuruluKarari=rs.getString("BakanlarKuruluKarari");
 
}

%>
<script language="javascript">

</script>
<body>

<form name="detayFormu" method="post" action="sat17.jsp">
<input type="hidden" name="redirect" value="<%=redirect%>">
<input type="hidden" name="TEKLIFNo" value="<%=teklifno%>">
<div id="toprightt"> </div>
<div id="topright2">

 <table border="0" cellspacing="0" cellpadding="0" width="600" height="500" >
  
  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->


  <div align="left">
<table width="450"  border="0" id="baslik" class="tablefont3">
  <tr>
    <td width="121" height="56"><p align="center"><strong> &#304;HALE DETAY </strong> </p></td>
    <td width="171"><p align="center"><strong> T.C. </strong></p>
        <p align="center"><strong>BO&#286;AZ&#304;&Ccedil;&#304; &Uuml;N&#304;VERS&#304;TES&#304;</strong></p><br><br><br>
      <p align="center">&nbsp;</p></td>
    <%
        //fis no
		
        %>
    <td width="158">
      <p align="center"><strong>İHALE NO:</strong><strong>
        <label><span id='security<%=securityIndex++ %>'><%=ihaleNo%></span></label>
    </strong></p></td>
  </tr>
</table>



<table width="450" border="1"  class="tablefont2">
  <tr>
    <td width="225">&#304;HALE ADI </td>
    <td width="225"><span id='security<%=securityIndex++ %>'><%=IhaleAdi %></td>
  </tr>
  <tr>
    <td>&#304;HALE ÜRÜN T&#304;P&#304;</td>
    <td><span id='security<%=securityIndex++ %>'><%=IhaleUrunTipi %></span></td>
  </tr>
  <tr>
    <td>&#304;HALE ALT T&#304;P&#304; </td>
    <td><span id='security<%=securityIndex++ %>'><%=IhaleAltTipi %></span></td>
  </tr>
  <tr>
    <td>&#304;HALE TAR&#304;H&#304; </td>
    <td><span id='security<%=securityIndex++ %>'><%=IhaleTarihi %></span></td>
  </tr>
  <tr>
    <td>KAZANAN TEKL&#304;F NO </td>
    <td><span id='security<%=securityIndex++ %>'><%=KazananTeklifNo %></span></td>
  </tr>
  <tr>
    <td>BEKLENEN MAL&#304;YET</td>
    <td><span id='security<%=securityIndex++ %>'><%=BeklenenMaliyet %></span></td>
  </tr>
  <tr>
    <td>YATIRIM PROJE NO </td>
    <td><span id='security<%=securityIndex++ %>'><%=YatirimProjeNo %></span></td>
  </tr>
  <tr>
    <td>BÜTÇE TERT&#304;B&#304;</td>
    <td><span id='security<%=securityIndex++ %>'><%=ButceTertibi %></span></td>
  </tr>
  <tr>
    <td>AVANS ŞARTLARI</td>
    <td><span id='security<%=securityIndex++ %>'><%=AvansSartlari %></span></td>
  </tr>
  <tr>
    <td>&#304;LANIN ŞEKL&#304; VE ADED&#304;</td>
    <td><span id='security<%=securityIndex++ %>'><%=IlanSekliAdedi %></span></td>
  </tr>
  <tr>
    <td>ON YETERL&#304;L&#304;K/&#304;HALE DÖKÜMANI SATIŞ BEDEL&#304;</td>
    <td><span id='security<%=securityIndex++ %>'><%=OyidSatisBedeli %></span></td>
  </tr>
  <tr>
    <td>F&#304;YAT FARKI ÖDENECEKSE DAYANAĞI BAKANLAR KURULU KARARI </td>
    <td><span id='security<%=securityIndex++ %>'><%=BakanlarKuruluKarari %></span></td>
  </tr>
  
</table>
  <!-- hidden fieldlar -->
  		
  		<!-- SECURITY ICIN HIDDEN FIELDLAR BEGIN -->
		    <input type="hidden" id='security_field_no' value="<%=securityIndex-1%>">
			<input type="hidden" name="imza" value="">
			<input type="hidden" name="document_content" value="">
			<input id="security1" type="hidden" name="securityDate" value="<%=System.currentTimeMillis()%>">
		<!-- SECURITY ICIN HIDDEN FIELDLAR END -->
		
		
			<input type="hidden" name="ihaleNo" value="<%out.print(ihaleNo);%>">
			<input type="hidden" name="onay" value="">
			<input type="hidden" name="fisGoster" value="hayir">
			
	<!-- hidden fieldlar -->
 <br><br>
 
 <table width="450"  border="0" class="tablefont3">
  <tr>
    
  </tr>
    <tr>
   
  </tr>
</table>
 
 <!-- onay red dugmesi -->


	<%
	
	//fisGoster boolean variable?n?n degerine gore ilgili fisleri goster
	if(true)	{					
	%>
        <br><div align="left">
		<table bgcolor="#FFFFFF" width="438" border="0" cellspacing="0" cellpadding="0" class="tablefont">
			<tr> 
               		 <td width="437">İHALE İLE İLGİLİ FİŞLER:<a name="Gecmis"></a></td>
            </tr>
			<%
ResultSet resulttest=db.executeQuery("SELECT * FROM ISTEK_FISI WHERE IhaleNo='"+ihaleNo+"'");
if(resulttest.next()){
%>			
			<tr><td><p>&nbsp;</p>			
				<table bgcolor="#FFFFFF" width="438" border="3" cellspacing="0" cellpadding="0" class="tablefont">
              		<tr>
              		    <td width="174">Seçilen Fiş</td>	
						<td width="174">İstek Fişi No:</td>
						<td width="174">Oluşturulma Tarihi:</td>
						<td width="174">İstekte Bulunan</td>
					</tr>

					<%
					ResultSet result3=db.executeQuery("SELECT * FROM ISTEK_FISI WHERE IhaleNo='"+ihaleNo+"'");
					while(result3.next()){
					%>
					<tr> 
					    <td><input type="radio" checked name="Istek_Fisi_No" value="<%=result3.getString("IstekFisiNo")%>"></td>
						<td width="174"><% 
						String t1=result3.getString("IstekFisiNo");
						out.print("<span id='security"+(securityIndex++)+"'>"+t1+"</span>");
						%></td>
						<td width="174"><% 
						String t2=result3.getString("OlusturmaTarihi");
						out.print("<span id='security"+(securityIndex++)+"'>"+t2+"</span>");
						%></td>
						<td width="174"><%
						String t3=result3.getString("Isteyen");
						out.print("<span id='security"+(securityIndex++)+"'>"+t3+"</span>");
						%></td>
					</tr>
					<%
					}
					%>
					
				</table>
			</td></tr>
<%
	}
else {
	%>
	<tr>
	   <td>
	    <p>&nbsp;&nbsp;İhale ile ilgili herhangi bir istek fişi bulunamadı!</p>
	  </td>
	</tr>
	<%
}
	%>		
		</table>
		</div>
<%
ResultSet resulttest2=db.executeQuery("SELECT * FROM ISTEK_FISI WHERE IhaleNo='"+ihaleNo+"'");
if(resulttest2.next()){
%>
<div align="center">
<input type="button"  value="Detay Gör" onClick="detayGor1()" language="JavaScript">
</div>
<%
	}
%>
<%
		}

	
	
	//fisGoster boolean variable?n?n degerine gore ilgili fisleri goster
	if(true)	{
	%>
        <br><div align="left">
		<table bgcolor="#FFFFFF" width="438" border="0" cellspacing="0" cellpadding="0" class="tablefont">
			<tr> 
               		 <td width="437">İHALE İÇİN VERİLEN TEKLİFLER:<a name="Gecmis"></a></td>
            </tr>
<%
ResultSet resulttest=db.executeQuery("SELECT * FROM IHALE_TEKLIF WHERE IhaleNo='"+ihaleNo+"'");
if(resulttest.next()){
%>					
			<tr><td><p>&nbsp;</p>			
				<table bgcolor="#FFFFFF" width="438" border="3" cellspacing="0" cellpadding="0" class="tablefont">
              		<tr>
              		    <td width="174">Seçilen Fiş</td>	
						<td width="174">Teklif No:</td>
						<td width="174">Teklif_Fiyati:</td>
						<td width="174">İstekte Bulunan Firma</td>
					</tr>
					<% 
					ResultSet result3=db.executeQuery("SELECT * FROM IHALE_TEKLIF WHERE IhaleNo='"+ihaleNo+"'");
					while(result3.next()){
					%>
					<tr> 
					    <td><input type="radio" checked name="Teklif_No" value="<%=result3.getString("TeklifNo")%>"></td>
						<td width="174"><% 
						String t1=result3.getString("TeklifNo");
						out.print("<span id='security"+(securityIndex++)+"'>"+t1+"</span>");
						%></td>
						<td width="174"><% 
						String t2=result3.getString("TeklifFiyati");
						out.print("<span id='security"+(securityIndex++)+"'>"+t2+"</span>");
						%></td>
						<td width="174"><%
						String t3=result3.getString("FirmaAdi");
						out.print("<span id='security"+(securityIndex++)+"'>"+t3+"</span>");
						%></td>
					</tr>
					<%
					}
					%>
					
				</table>
			</td></tr>
<%
	}
else {
	%>
	<tr>
	   <td>
	    <p>&nbsp;&nbsp;İhale için verilmiş herhangi bir teklif  bulunamadı!</p>
	  </td>
	</tr>
	<%
}
	%>					
		</table>
		</div>
	<%
	}
	
	%>			
</div>
<%
ResultSet resulttest=db.executeQuery("SELECT * FROM IHALE_TEKLIF WHERE IhaleNo='"+ihaleNo+"'");
if(resulttest.next()){
%>
<div align=center>
  	<input type="button"  value="Detay Gör" onClick="detayGor2()" language="JavaScript">
</div>
<%
	}
db.closeConnection();
%>
<br>
<div align=center>
  	<input type="button" name="geri" value="Geri" onClick="geri_onclick()" language="JavaScript">
  	</div>
  

		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50"></td>
  </tr>
</table>
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisli&#287;i &copy;2005</font></b></p>
	</div>
	
	
	
</form>
</body>
</html>

