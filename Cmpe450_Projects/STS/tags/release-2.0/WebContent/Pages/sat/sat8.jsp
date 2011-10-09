<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- Bu sayfa Bölüm Başanını yeni yarat?lan bir fi?i onaylad??? sayfad?r. -->
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
System.out.println("&#304HALENO:" +ihaleNo);

String ihaleAdi="";
ResultSet rsNew = db.executeQuery("select * from IHALE WHERE IhaleNo='"+ihaleNo+"'");
while(rsNew.next()){ 
	ihaleAdi = rsNew.getString("IhaleAdi");
}

//security kodlar? buraya!!!
// eger asagidaki variable false yapilirsa, sign applet sayfada gozukmez
boolean securityEnabled = false;
//security kodlar? bitti

//bu sayfa belli bir fi? için çal???yor, bu fi?in id'si en önemli bilgilerden birisi

//sayfa ilk aç?ld???nda onay field?ndaki bilgiye göre ne yapaca??n? belirleyecek
//e?er sayfa ilk olarak aç?l?yorsa, onay field?n?n null olmas? gerekiyor
//onay null degilse ve value'su "eklendi"ya e?itse, kullan?c? sayfay? onaylamak
//istedi?i anlam?na geliyor. imzay? verify et ve onay i?lemi için db'den
//IstekAktar_sp'yi çag?r

	
		
if(request.getParameter("onay") != null 
&& request.getParameter("onay").equals("çıkarıldı")) {
	System.out.println("Çıkarıldı-----------------------");
	
	String TeklifNo=(String)request.getParameter("TeklifNo");
	ResultSet rscikarilcak = db.executeQuery("select * from IHALE_TEKLIF WHERE TeklifNo='"+TeklifNo+"'");
	
	if (rscikarilcak != null)
		db.execute("delete from IHALE_TEKLIF  where TeklifNo='"+TeklifNo+"'");

	System.out.println("update IHALE_TEKLIF set TeklifNo=Null where TeklifNo='"+TeklifNo+"'");
}
else if (request.getParameter("onay") != null&& request.getParameter("onay").equals("onaylandi"))
{
	System.out.println("onaya gönderiliyor");
	
	String Teklif_No=(String)request.getParameter("TeklifNo2");
	if (Teklif_No != null){
		String gun = (String)request.getParameter("gun");
		
		if (gun.length()==1)
			gun = "0" + gun;
		String ay = (String)request.getParameter("ay");
	
		if (ay.length()==1)
			ay = "0" + ay;
		String yil =(String)request.getParameter("yil");
		
		String i1 = request.getParameter("i1");
		String i2 = request.getParameter("i2");
		String i3 = request.getParameter("i3");
	
		
		String sp="update IHALE set IhaleTarihi=\"" + yil +"/" + ay + "/" + gun +"\",IhaleKayitNo='"+ i1+"',IhaleUrunTipi='"+i2+"',IhaleAltTipi='"+i3+"',KazananTeklifNo='"+Teklif_No+"',Durum='4' where IhaleNo='"+ihaleNo+"'";
		System.out.println(sp);
		db.execute(sp);
		db.closeConnection();
		response.sendRedirect("../../alerts/approve2.jsp");
		return;
	}	
}

else if(request.getParameter("onay") != null 
		&& request.getParameter("onay").equals("ihaleDetay")) {
			
			
			String detayFisID=(String)request.getParameter("cikarilacakFisID");

			
			session.setAttribute("requestFormID",detayFisID);
			
			db.closeConnection();
			response.sendRedirect("../../Pages/sat/sat17.jsp?ihaleNo="+ihaleNo+"&redirect=sat8.jsp");
			return;
			
}

else if (request.getParameter("onay") != null&& request.getParameter("onay").equals("yeniteklif"))
{
	
	db.closeConnection();
	response.sendRedirect("sat7.jsp?IHALENO="+ihaleNo);
	return;
}

else if (request.getParameter("onay") != null&& request.getParameter("onay").equals("miktardegistir"))
{
	String TeklifNo=(String)request.getParameter("TeklifNo");
	
	db.closeConnection();
	response.sendRedirect("sat9.jsp?TEKLIFNO="+TeklifNo+"&IHALENO="+ihaleNo);
	return;
}
boolean enable=true;
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript">
			
		
        function teklifSecildi()
        {
        	
           var selected=document.getElementById("TeklifNo2");
           var value=selected.options[selected.selectedIndex].value;
           if (value=="tek12")
           {
              return false;
           } 
           return true;
        }
        function teklifSecildi2(variable)
	     {
           var selected=document.getElementById(variable);
           var value=selected.options[selected.selectedIndex].value;
           if (value=="-")
           {
              return false;
           } 
           return true;
	     }
	     function bosmu(variable)
	     {
	      
           var v=document.getElementById(variable);
            var value=v.value;
           
           if (value=="")
           {
              return false;
           } 
           return true;
	     }
		function fiscikar() {

			document.myForm.onay.value = "çıkarıldı";

			document.myForm.submit();
		}
		
		function rectorOnayi(){
		   
		   if (teklifSecildi()) {
		   	
		       if (teklifSecildi2("gun")) {
		           if (teklifSecildi2("ay")){
		              if (teklifSecildi2("yil")) {
		              	if(bosmu("i1")){
		              		if(bosmu("i2")){
		              			if(bosmu("i3")){
					                  document.myForm.onay.value = "onaylandi";
					                  document.myForm.submit();
				                  }
				                  else{
				                  	alert ("Lütfen Ihale Alt Tipi giriniz");
				                  }
			                  }
			                  else{
			                  	alert ("Lütfen Ihale Ürün Tipi giriniz");
			                  
			                  }
		                  }
		                else{
		                	alert ("Lütfen Ihale Kayit No giriniz");
		                }  
		              }
		              else {
		                alert ("Lütfen yil seçiniz");
		              }
		           }
		           else {
		              alert ("Lütfen ay seçiniz");
		           }
		       }
		       else {
		          alert ("Lütfen gün seçiniz");
		       }
		    
		   
		   }
		   else
		     alert("Lütfen teklif seçiniz");  	    
		    
		}
		
		function ihaleDetay() {

			document.myForm.onay.value = "ihaleDetay";

			document.myForm.submit();
		}

        function yeniTeklifEkle() {

			document.myForm.onay.value = "yeniteklif";

			document.myForm.submit();
		}
		
        function miktarDegistir() {

			document.myForm.onay.value = "miktardegistir";

			document.myForm.submit();
		}
	
	
</SCRIPT>
</head>
<body>




<div id="toprightt"> </div>
<div id="topright2">
<div align="center">
    <table width="79%"  border="0"  id="baslik" class="tablefont">
            <tr>
        <td width="100%" height="56" align=center><strong>T.C.<br>
        BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</strong><p>
		&nbsp;</td>
      </tr>
    		</table>
	
  </div>
<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="myForm" action="sat8.jsp" method="post">
 

<div align=center>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
 <!-- onay ve red dugmeleri -->
 <!-- Piyasa fiyat? -->
  
<%
ResultSet rs2 = db.executeQuery("select * from IHALE_TEKLIF WHERE IhaleNo='"+ihaleNo+"'");  %>
<tr>
	<td align="left" nowrap width="15%"> 
	İhale Adı:</td> 
	<td align="left" width="32%"> 
	&nbsp;<%out.print(ihaleAdi); %></td> 
	<td align="left" nowrap width="53%"> 
	<input type="button" value="&#304hale Detaylar&#305" onClick="ihaleDetay()" language="JavaScript"></td> 
</tr>
</table>
<input name="redirect" type="hidden" value="sat8.jsp">  
<br>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">


<tr>
<td align="left" nowrap width="15%"> 

Verilen Teklifler:</td>
<td align="left" width="32%"> 

<select name="TeklifNo" > 
<%
enable=false;
while(rs2.next()){ %>
<option value="<%=rs2.getString("TeklifNo")%>" selected><%out.print(rs2.getString("TeklifNo")); %></option>
<%
enable=true;
} %>
</select></td>
<td align="left" nowrap width="53%"> 

<input type="button" name="ekle" value="&#304haleden Ç&#305kar" onClick="fiscikar()"language="JavaScript"><input type="button" name="goster1" value="Teklif Gör/Güncelle" onClick="miktarDegistir()" language="JavaScript"><input type="button" value="Yeni Teklif Gir" onClick="yeniTeklifEkle()" language="JavaScript">
<script language=javascript>
document.myForm.ekle.disabled=<%=!enable%>;
document.myForm.goster1.disabled=<%=!enable%>;
</script>

</td>
</tr>


</table>

<br>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
<td align="left" nowrap width="15%"> 

İhale Kayıt No:</td>
<td align="left" width="85%"> 

<input type="text" name="i1" value="" size="30"></td>
</tr>


<tr>
<td align="left" nowrap width="15%"> 

İhale Ürün Tipi:</td>
<td align="left" width="85%"> 

<input type="text" name="i2" value="" size="30"></td>
</tr>


<tr>
<td align="left" nowrap width="15%"> 

İhale Alt Tipi: 

</td>
<td align="left" width="85%"> 

<input type="text" name="i3" value="" size="30"></td>
</tr>


</table>
<br>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
<td align="left" nowrap width="15%"> 

İhale Tarihi:</td>
<td align="left" width="85%" colspan=2> 
<select name="gun">
<option   value="-" >-</option>
<%for(int i=1;i<=31;i++){ %> 
<option value="<%=i%>"><%out.print(i);%></option>
<%} %>
</select>
<select name="ay">
<option   value="-" >-</option>
<%for(int i=1;i<=12;i++){ %> 
<option value="<%=i%>"><%out.print(i);%></option>
<%} %>
</select>
<select name="yil">
<option   value="-" >-</option>
<%for(int i=2005;i<=2050;i++){ %> 
<option value="<%=i%>"><%out.print(i);%></option>
<%} %>
</select></td>
</tr>
</table>
<br>
<%
ResultSet rs3 = db.executeQuery("select * from IHALE_TEKLIF WHERE IhaleNo='"+ihaleNo+"'");  %>

<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
<td align="left" nowrap width="15%"> 

Kazanan Teklif:&nbsp;</td>
<td align="left" width="32%"> 

<select name="TeklifNo2"> 
<option  value="tek12">teklif seçiniz</option>
<%
enable=false;
while(rs3.next()){ %>
<option  value="<%=rs3.getString("TeklifNo")%>" ><%out.print(rs3.getString("TeklifNo")); %></option>
<%
enable=true;
} %>
</select></td>
<td align="left" nowrap width="53%"> 

<input type="button" name="okay" value="Onaya Yolla" onClick="rectorOnayi()"language="JavaScript"> <script language=javascript>
document.myForm.okay.disabled=<%=!enable%>;
</script>
<!-- hidden fieldlar -->
		<input type="hidden" name="ihaleNo" value="<%out.print(ihaleNo);%>">
		<input type="hidden" name="onay" value="">
		

	<!-- hidden fieldlar -->
</td>
</tr>

</table>

</div>

<%db.closeConnection(); %>
</form>
</div>


	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">
	Bilgisayar Mühendisligi ©2005</font></b></p>
	</div>
</body>
</html>