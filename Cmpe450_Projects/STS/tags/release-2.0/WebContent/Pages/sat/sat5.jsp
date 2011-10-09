<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- Bu sayfa Bölüm Ba&#351;kan&#305;'n&#305;n yeni yarat?lan bir fi?i onaylad??? sayfad?r. -->
<!-- Bu sayfada onaylanan bir fi?, Rektöre gönderilmektedir, -->
<!-- bunun için de nextGroupID "00001D-GRP"ye -->
<!-- nextPageCode ise "../dek/dek1.jsp"ye set edilmektedir. -->
<!-- Bölüm Ba?kan? bir fi?i reddederse o fi? silinmektedir, -->
<!-- bunun için de nextGroupID bölüm ba?kan?n?n groupID'sine, -->
<!-- nextPageID ise "silindi.jsp"ye set edilmektedir. -->
<%
DB db= new DB(true);
%>
<%


String ihaleNo=request.getParameter("ihaleNo");
System.out.println("IHALENO:" +ihaleNo+"X");
String ihaleAdi="";
ResultSet rsNew = db.executeQuery("select * from IHALE WHERE IhaleNo='"+ihaleNo+"'");
while(rsNew.next()){ 
	ihaleAdi = rsNew.getString("IhaleAdi");
}
//security kodlar? buraya!!!
// eger asagidaki variable false yapilirsa, sign applet sayfada gozukmez
boolean securityEnabled = true;
//security kodlar? bitti

//bu sayfa belli bir fi? için çal???yor, bu fi?in id'si en önemli bilgilerden birisi
//String requestFormID = (String)session.getAttribute("requestFormID");

//sayfa ilk aç?ld???nda onay field?ndaki bilgiye göre ne yapaca??n? belirleyecek
//e?er sayfa ilk olarak aç?l?yorsa, onay field?n?n null olmas? gerekiyor
//onay null degilse ve value'su "eklendi"ya e?itse, kullan?c? sayfay? onaylamak
//istedi?i anlam?na geliyor. imzay? verify et ve onay i?lemi için db'den
//IstekAktar_sp'yi çag?r
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("eklendi")) {
		System.out.println("Eklendi-----------------------");
	

		
	String eklenenFis=(String)request.getParameter("eklenecekFisID");
	
	
	ResultSet rseklenecek = db.executeQuery("select * from ISTEK_FISI WHERE IstekFisiNo='"+eklenenFis+"'");
	
	if (rseklenecek != null)
		db.execute("update ISTEK_FISI set IhaleNo='"+ihaleNo+"' where IstekFisiNo='"+eklenenFis+"'");
		
	System.out.println("update ISTEK_FISI set IhaleNo='"+ihaleNo+"' where IstekFisiNo='"+eklenenFis+"'");

	
}else if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("cikarildi")) {
	System.out.println("Cikarildi-----------------------");
	
	String cikarilacakFisID=(String)request.getParameter("cikarilacakFisID");
	ResultSet rscikarilcak = db.executeQuery("select * from ISTEK_FISI WHERE IstekFisiNo='"+cikarilacakFisID+"'");
	
	if (rscikarilcak != null)
		db.execute("update ISTEK_FISI set IhaleNo=Null where IstekFisiNo='"+cikarilacakFisID+"'");

	System.out.println("update ISTEK_FISI set IhaleNo=Null where IstekFisiNo='"+cikarilacakFisID+"'");
}

else if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("fisdetay1")) {
			
			
			String detayFisID=(String)request.getParameter("eklenecekFisID");

			
			session.setAttribute("requestFormID",detayFisID);
			
			String redirect="../../Pages/sat/sat5.jsp";
			db.closeConnection();
			response.sendRedirect("../../Pages/sat/satistektakip.jsp?ihaleNo="+ihaleNo+"&redirectPage="+redirect);
			return;
			
}
else if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("fisdetay2")) {
			
			
			String detayFisID=(String)request.getParameter("cikarilacakFisID");

			
			session.setAttribute("requestFormID",detayFisID);
			
			String redirect="../../Pages/sat/sat5.jsp";
			db.closeConnection();
			response.sendRedirect("../../Pages/sat/satistektakip.jsp?ihaleNo="+ihaleNo+"&redirectPage="+redirect);
			return;
}


else if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("dogrudan")) {
	
	        String dogrudanFisID=(String)request.getParameter("eklenecekFisID");
	        
	        String nextGroupID = "000005-GRP";
    	  	String nextPageCode = "../sat/sat10.jsp";
	     	String userID = ((User)session.getAttribute("userClass")).getUserid();
	     	System.out.println("gokhaaaaan");
    	  	String query = "call IstekAktar_sp('"+dogrudanFisID+"','"+nextGroupID+"','"+nextPageCode+"','"+userID+"','&#304;haleden do&#287;rudan al&#305;ma aktar&#305;ld&#305;','1')";
    	  	db.executeQuery(query);
	
}
else if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("sil")) {
			
			System.out.println("delete from IHALE where IhaleNo='"+ihaleNo+"'");
			db.execute("delete from IHALE where IhaleNo='"+ihaleNo+"'");
			db.closeConnection();
			response.sendRedirect("../../Pages/sat/sat2.jsp");
			return;
			
}
else if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("ihaleDetay")) {
			
			
			
			db.closeConnection();
			response.sendRedirect("../../Pages/sat/sat17.jsp?ihaleNo="+ihaleNo+"&redirect=sat5.jsp");
			return;
}

else if (request.getParameter("onay") != null&& request.getParameter("onay").equals("onaylandi"))
{
	System.out.println("onaya gönderiliyor");
	
	db.execute("update IHALE set Durum='2' where IhaleNo='"+ihaleNo+"'");
	
		
	String tf=request.getParameter("T1").replace(',','.');
	
	db.execute("update IHALE set  BeklenenMaliyet="+Double.valueOf(tf)+" where IhaleNo='" + ihaleNo + "'");
	
	System.out.println("update IHALE set  BeklenenMaliyet="+Double.valueOf(tf)+" where IhaleNo='" + ihaleNo + "'");
	db.closeConnection();
	response.sendRedirect("../../alerts/approve2.jsp");
	return;
	
}

boolean enable=true;
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<script language=javascript src="../validator.js"></script>
<SCRIPT language="JavaScript">

	
		function fisekle() {
		   

			document.myForm.onay.value = "eklendi";
			

			document.myForm.submit();
	
		}
		
		function fisdetay1() {
		   

			document.myForm.onay.value = "fisdetay1";
			

			document.myForm.submit();
	
		}
		function fisdetay2() {
		   

			document.myForm.onay.value = "fisdetay2";
			

			document.myForm.submit();
	
		}
		
		function fiscikar() {

			document.myForm.onay.value = "cikarildi";

			document.myForm.submit();
		}
		
		function dogrudan() {

			document.myForm.onay.value = "dogrudan";

			document.myForm.submit();
		}
		
		function ihaleDetay() {

			document.myForm.onay.value = "ihaleDetay";

			document.myForm.submit();
		}
		function ihalesl() {

			document.myForm.onay.value = "sil";

			document.myForm.submit();
		}
				
		 function teklifSecildi(variable)
        {
           var selected=document.getElementById(variable);
           var value=selected.options[selected.selectedIndex].value;
           if (value=="-")
           {
              return false;
           } 
           return true;
        }
        
		function rectorOnayi(){
		
		    if (validateElement(document.myForm.T1,true)){
		       
		                  document.myForm.onay.value = "onaylandi";
		                  document.myForm.submit();
		     
		    }
		 	    
		    
		}

	
	
</SCRIPT>
</head>
<body>


<div id="toprightt"> </div>

<div id="topright2">

<div align="center">
    <table width="79%"  border="0"  id="baslik" class="tablefont">
            <tr>
        <td width="100%" height="56" align=center>T.C.<br>
        <strong>BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</strong><p>
		&nbsp;</td>
      </tr>
    		</table>
	
  </div>
<div align=center>
<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="myForm" action="sat5.jsp" method="post">
 
	
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
	<!-- Piyasa fiyat? -->
<tr>
<%ResultSet rs = db.executeQuery("select * from ISTEK_FISI WHERE SayfaNo='00DUMY-PAG' and ISNULL(IhaleNo)");  %>

	<td align="left" nowrap width="15%"> &#304;hale Ad&#305;:</td>
	<td align="left" width="32%">&nbsp;<%out.print(ihaleAdi); %> </td>
	<td align="left" nowrap width=53%><input type="button" value="&#304;hale Detaylar&#305;" onClick="ihaleDetay()" language="JavaScript">
<input type="button" name="sil" value="&#304;haleyi Sil" onclick="ihalesl()" language="JavaScript">
</td></tr>
</table>
<br>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">


<tr>

	<td align="left" nowrap width="15%"> Eklenebilir Fi&#351;ler:&nbsp;</td>
	<td align="left" nowrap width="32%">
	<select name="eklenecekFisID">
<% 
enable=false;
while(rs.next()){ %>
<option value="<%=rs.getString("IstekFisiNo")%>" selected><%out.print(rs.getString("IstekFisiNo")); %></option>
<%
enable=true;
} %>
</select></td>
	<td align="left" nowrap width=53%>
<input type="button" name="ekle" value="&#304;haleye Ekle" onClick="fisekle()" language="JavaScript"> <input type="button" name="goster1" value="Fi&#351; Detay&#305; Göster" onClick="fisdetay1()" language="JavaScript"> <input type="button" name="dogrudann" value="Do&#287;rudan Al&#305;ma Aktar" onClick="dogrudan()" language="JavaScript">
<script language=javascript>
document.myForm.ekle.disabled=<%=!enable%>;
document.myForm.goster1.disabled=<%=!enable%>;
document.myForm.dogrudann.disabled=<%=!enable%>;
</script>



</td></tr>
</table>
<br>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">



<%

ResultSet rs2 = db.executeQuery("select * from ISTEK_FISI WHERE IhaleNo='"+ihaleNo+"' and SayfaNo='00DUMY-PAG'");  %>







<tr>

	<td align="left" nowrap width="15%"> Ç&#305;kar&#305;labilir Fi&#351;ler:</td>
	<td align="left" nowrap width="32%"><select name="cikarilacakFisID">
<%
enable=false;
while(rs2.next()){ %>
<option value="<%=rs2.getString("IstekFisiNo")%>" selected><%out.print(rs2.getString("IstekFisiNo")); %></option>
<%
enable=true;
} %>
</select></td>
	<td align="left" nowrap width=53%>
<input type="button" name="cikar" value="&#304;haleden Ç&#305;kar" onClick="fiscikar()"language="JavaScript"><input type="button" name="goster2" value="Fi&#351; Detay&#305; Göster" onClick="fisdetay2()" language="JavaScript">
<script language=javascript>
document.myForm.sil.disabled=<%=enable%>;
document.myForm.cikar.disabled=<%=!enable%>;
document.myForm.goster2.disabled=<%=!enable%>;
</script>



</td></tr>
</table>
<br>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">


<tr>

	<td align="left" nowrap width="15%"> Tahmini Fiyat:</td>
	<td align="left" nowrap width="85%" colspan=2><input type="text" name="T1" size="20" style="text-align: right;" value="Lütfen fiyat giriniz      " validator="YTL">YTL</td>
	</tr>
	
	</table>
<br>
<table width="79%"  class="tablefont">






<tr>

	<td align="center" nowrap colspan="3" width=100%> 
  	<input type="button" name="okay" value="Rektörlük Onay&#305;na Yolla" onClick="rectorOnayi()" language="JavaScript">
  	 <!-- onay ve red dugmeleri -->
    <script language=javascript>
document.myForm.okay.disabled=<%=!enable%>;
</script>
 

	<!-- hidden fieldlar -->
		<input type="hidden" name="ihaleNo" value="<%out.print(ihaleNo);%>">
		<input type="hidden" name="onay" value="">
		

	<!-- hidden fieldlar -->
  	<%db.closeConnection(); %>

  	</td>
	</tr>




</table>
	
	</form>
	</div>



 
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
	</div>
	
	
	

</body>
</html>