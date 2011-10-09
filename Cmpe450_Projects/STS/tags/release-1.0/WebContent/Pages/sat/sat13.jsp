<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
</head>
<% request.setCharacterEncoding("UTF-8"); %>
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
		
		function detayGor() {
			<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
			document.onayFormu.onay.value = "detaygor";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			document.onayFormu.submit();
		}
		
		function ilgiliFisler() {
			
			
			<!-- fieldinin icerigini toggle edecek -->
			if(document.onayFormu.fisGoster.value == 'evet')
				document.onayFormu.fisGoster.value = "hayir";
			else
				document.onayFormu.fisGoster.value = "evet";
			<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
			alert(document.onayFormu.fisGoster.value+'');
			document.onayFormu.submit();
		}
	
	
</SCRIPT>



<%

String ihaleNo=(String)request.getParameter("ihaleNo");
System.out.println("sat13 ihale no"+ihaleNo);
System.out.println("onay: "+request.getParameter("onay"));



if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("detaygor")) {
	
	session.setAttribute("requestFormID",(String)request.getParameter("Istek_Fisi_No"));
	
	db.closeConnection();
	response.sendRedirect("../../Pages/sat/satistektakip.jsp?ihaleNo="+ihaleNo+"&redirectPage=../../Pages/sat/sat13.jsp");
	return;
	
	
}

if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("onaylandi")) {
	
	String userID = ((User)session.getAttribute("userClass")).getUserid();
	
	
	//SECURIY CODE BEGINS
	//ilk olarak imzayi verify etmemiz gerekiyor. bunun iÃ§in request'ten
	//imza fieldini Ã§ekip, security'nin verify fonksiyonuna yolluyoruz
	
	
	//not: eger bu sayfada fise yeni bir bilgi ekleniyorsa (sÃ¼rekli 
	//kullandigimiz Ã¶rnek "ihale fiyat?" gibi) once request'ten ilgili
	//fielddaki datay? oku ve sonra db'nin bu field? update etmekle 
	//ilgili sp'sini Ã§ag?r?p bu bilgiyi db'ye yaz
	
	
	
	//	eger hersey yolunda giderse, IstekAktar_sp'yi cagir
	String yorum = "yorum";
	//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
	//Dekanliga gonerilmesi icin group idyi set ediyoruz
    String nextGroupID = "000003-GRP";
	String nextPageCode = "../ayn/ayn1.jsp"; 
	
//	SECURITY CODE BEGIN
	boolean verification = true;
	if (session.getAttribute("securityEnabled").equals("true")) {
		String security_signature = request.getParameter("imza");
		String security_documentContent = request.getParameter("document_content");
		String security_date = request.getParameter("securityDate");
		session.setAttribute("securityDocument", security_documentContent);
		verification = global.Security.verifySignature(userID, security_documentContent, security_signature,security_date);
	}
	//SECURITY CODE END
	
	String query;
	ResultSet result4;
	ResultSet result5=db.executeQuery("SELECT * FROM ISTEK_FISI WHERE IhaleNo='"+ihaleNo+"'");
	while(result5.next()){

	
		String t1=result5.getString("IstekFisiNo");
		out.print(t1);
		
		//MODIFIED BY SECURITY
		String requestFormID = t1;
		db.executeSP("IstekAktar_sp", new Object [] {requestFormID, nextGroupID, nextPageCode, userID, yorum,"1"});
		//following result3 is used by SECURITY
		ResultSet result3 = db.getResult();
		if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
			//SECURITY CODE BEGINS
			String historyID = result3.getString(1);
			String security_signature = request.getParameter("imza");
			String security_documentContent = request.getParameter("document_content");
			String security_date = request.getParameter("securityDate");
			Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_SAT13);
			//SECURITY CODE ENDS
		}

	}
	
	String sp="update IHALE set Durum='6' where IhaleNo='"+ihaleNo+"'";
	System.out.println(sp);
	db.execute(sp);
	
	//istegi aktardik
	
	//bu sp'nin hatali dönmesi olasiligini kontrol et
	//basarili oldugunu varsayarsak
	//sessiondan aman requestFromID'yi remove et
	// ?lgili ihalenin DURUM field i 3 e set edilecek		
	
	db.closeConnection();
	response.sendRedirect("../../alerts/approve5.jsp");
	return;
}


String fisGosterFlag="";
System.out.println(request.getParameter("fisGoster"));
if(request.getParameter("fisGoster") != null)
			fisGosterFlag = request.getParameter("fisGoster");
else
			fisGosterFlag = "hayir";


String IhaleAdi = "detaya ulasilamadi";
String IhaleAltTipi = "detaya ulasilamadi";
String IhaleTarihi = "detaya ulasilamadi";
String IhaleUrunTipi = "detaya ulasilamadi";
String KazananTeklifNo = "detaya ulasilamadi";
String BeklenenMaliyet = "detaya ulasilamadi";

ResultSet rs = db.executeQuery("call IhaleGoster_sp('"+ ihaleNo + "')");
if(rs.next())
{
 IhaleAdi = rs.getString("IhaleAdi");
 IhaleAltTipi = rs.getString("IhaleAltTipi");
 IhaleTarihi = rs.getString("IhaleTarihi");
 IhaleUrunTipi = rs.getString("IhaleUrunTipi");
 KazananTeklifNo = rs.getString("KazananTeklifNo");
 BeklenenMaliyet = rs.getString("BeklenenMaliyet");
}

%>
<body>
<div id="toprightt"> </div>

<div id="topright2">

 <table border="0" cellspacing="0" cellpadding="0" width="600" height="500" class="tablefont">
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->

<form name="onayFormu" method="post" action="sat13.jsp">
  <div align="left">
<table width="450"  border="0" id="baslik" bordercolor="#CCCCFF" class="tablefont">
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



<table width="450" border="1"  bordercolor="#CCCCFF" class="tablefont">
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
 
 <table width="450"  border="0" bordercolor="#CCCCFF" class="tablefont">
  <tr>
    <td width="450" height="36">	
    <div align="center">
  	<input type="button" class="tablefont"   value="Ürünler firmadan talep edildi" onClick="parent.leftFrame.securityOnayDugmesi()" language="JavaScript">
  	</div>
  	</td>
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
		<table bgcolor="#FFFFFF" bordercolor="#CCCCFF" width="438" border="0" cellspacing="0" cellpadding="0" class="tablefont">
			<tr> 
               		 <td width="437">İHALE İLE İLGİLİ FİŞLER:<a name="Gecmis"></a></td>
            </tr>
			<%
ResultSet resulttest=db.executeQuery("SELECT * FROM ISTEK_FISI WHERE IhaleNo='"+ihaleNo+"'");
if(resulttest.next()){
%>
			<tr><td><p>&nbsp;</p>			
				<table bgcolor="#FFFFFF" bordercolor="#CCCCFF" width="438" border="3" cellspacing="0" cellpadding="0" class="tablefont">
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
	}
	%>			
</div>
<%
ResultSet resulttest=db.executeQuery("SELECT * FROM ISTEK_FISI WHERE IhaleNo='"+ihaleNo+"'");
if(resulttest.next()){
%>
<div align="center">
  	<input type="button" class="tablefont"   value="Detay Gör" onClick="detayGor()" language="JavaScript">
  	</div>
<%
	}
%>  
</form>
		
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
      Mühendisliği &copy;2005</font></b></p>
	</div>
	
	
	<% db.closeConnection(); %>

</body>
</html>

