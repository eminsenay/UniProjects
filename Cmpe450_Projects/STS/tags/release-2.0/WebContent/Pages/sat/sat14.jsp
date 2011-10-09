<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@page import="java.util.*" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- Bu sayfa Bölüm Başkanı'nın yeni yarat?lan bir fi?i onaylad??? sayfad?r. -->
<!-- Bu sayfada onaylanan bir fi?, Rektöre gönderilmektedir, -->
<!-- bunun için de nextGroupID "00001D-GRP"ye -->
<!-- nextPageCode ise "../dek/dek1.jsp"ye set edilmektedir. -->
<!-- Bölüm Ba?kan? bir fi?i reddederse o fi? silinmektedir, -->
<!-- bunun için de nextGroupID bölüm ba?kan?n?n groupID'sine, -->
<!-- nextPageID ise "silindi.jsp"ye set edilmektedir. -->
<% request.setCharacterEncoding("UTF-8"); %>
<%
DB db= new DB(true);

//kullanıcı kac ay oncesine bakmak istiyor
//bu gunun tarihi ne

//bu gunun tarihini oku
Calendar cal=new GregorianCalendar();

int yiln = cal.get(cal.YEAR);
int ayn = cal.get(cal.MONTH);
int gunn = cal.get(cal.DAY_OF_MONTH);


%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>
<body>

<SCRIPT language="JavaScript" >

	function goruntule()
	{  
     	if (myForm.firmaAdi.value.length > 0)
     	{
     	   if (teklifSecildi ("yil")) {
     	       if (teklifSecildi ("ay")){
     	          if (teklifSecildi("gun")) {
	                 document.myForm.onay.value = "goruntule";
	                 document.myForm.submit();
	              }
	              else
	                 alert ("Lütfen gün seciniz");
	           }
	          else
	             alert ("Lütfen ay seçiniz");
	       }
	       else
	         alert ("Yil seciniz")
	    }
	    else
	    {
	        alert ("Lütfen şirket ismini giriniz");
	    }   

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
     
      function geri_onclick(){
			document.myForm.onay.value="geri";
			document.detayFormu.submit();
		}
	
</SCRIPT>


<div id="toprightt"> </div>
<div id="topright2">

<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="myForm" action="sat14.jsp" method="post">
 
 <table width="750"  border="0" id="baslik" class="tablefont" align="center">
 <tr>
 <td><img src="../../images/spacer.gif" height="150">
	<tr >
	 <td> 	
	 
<!--<form action="http://www.cs.tut.fi/cgi-bin/run/~jkorpela/checkcombo.pl">-->
Tarih&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
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
 <%for(int i=1990;i<=yiln;i++){ %> 
 <option value="<%=i%>"><%out.print(i);%></option>
 <%} %>
 </select>
</td>
<td>
&nbsp;&nbsp;&nbsp;&nbsp;Şirket İsmi&nbsp;&nbsp;&nbsp;:<input type="text" name="firmaAdi" size="20">
 </td> </tr>
 <tr >
  <td></td>
 <td >
  <!-- onay ve red dugmeleri -->
  <br>
  <input type="button" value="Görüntüle" onClick="goruntule()" language="JavaScript">
  	
  </td >
  </tr>
 </table>

	<!-- hidden fieldlar -->
		<input type="hidden" name="onay" value="">
		

	<!-- hidden fieldlar -->



<%

//bu sayfa belli bir fi? için çal???yor, bu fi?in id'si en önemli bilgilerden birisi


//sayfa ilk aç?ld???nda onay field?ndaki bilgiye göre ne yapaca??n? belirleyecek
//e?er sayfa ilk olarak aç?l?yorsa, onay field?n?n null olmas? gerekiyor
//onay null degilse ve value'su "eklendi"ya e?itse, kullan?c? sayfay? onaylamak
//istedi?i anlam?na geliyor. imzay? verify et ve onay i?lemi için db'den
//IstekAktar_sp'yi çag?r

 if (request.getParameter("onay") != null&& request.getParameter("onay").equals("goruntule"))
{
	System.out.println("görüntüleniyor");
	String firmaAdi = (String)request.getParameter("firmaAdi");
	
	String yilS = (String)request.getParameter("yil");
	String gunS = (String)request.getParameter("gun");
	String ayS = (String)request.getParameter("ay");
	
	int yil=Integer.parseInt(yilS);
	int ay=Integer.parseInt(ayS);
	int gun=Integer.parseInt(gunS);
	
	System.out.println("gun"+gun+"ay"+ay+"yıl"+yil);
	System.out.println("gun"+gun+"ay"+ay+"yıl"+yil);

	
	ResultSet rsgoster = db.executeQuery
	("select ih.FirmaAdi,ih.FirmaTanimi,ih.TeklifNo," +
			"ih.TeklifFiyati,i.IhaleTarihi from IHALE_TEKLIF ih inner join IHALE i  WHERE ih.FirmaAdi  LIKE '%" + 
			firmaAdi + "%' and ih.IhaleNo = i.IhaleNo and i.Durum='5' and i.KazananTeklifNo=ih.TeklifNo and (i.IhaleTarihi > \"" +""+yil +"/"+""+ay+"/"+""+gun +"\" )");

	if (rsgoster.next()){

  %>
	  <table width="750"  border="1" class="tablefont2" align="center">
      <tr>
         <td><div align="center"><b>Firma Ad&#305;</b></div></td>
        <td><div align="center"><b>Firma Tan&#305;m&#305;</b></div></td>
        <td><div align="center"><b>İhale Tarihi</b></div></td>
        <td><div align="center"><b>Teklif Fiyat&#305;</b></div></td>
        </tr>
	<% 
	
	double toplamTeklif=0;
	int resultSetisEmpty = 0;
	ResultSet rsgosterilecek = db.executeQuery
	("select ih.FirmaAdi,ih.FirmaTanimi,ih.TeklifNo," +
			"ih.TeklifFiyati,i.IhaleTarihi from IHALE_TEKLIF ih inner join IHALE i  WHERE ih.FirmaAdi  LIKE '%" + 
			firmaAdi + "%' and ih.IhaleNo = i.IhaleNo and i.Durum='5' and i.KazananTeklifNo=ih.TeklifNo and (i.IhaleTarihi > \"" +""+yil +"/"+""+ay+"/"+""+gun +"\" )");
	 while(rsgosterilecek.next()){ 
			// firma adı
			String firmaAd = rsgosterilecek.getString("FirmaAdi");
			//firma telefonu
			String firmaTanimi = rsgosterilecek.getString("FirmaTanimi");	
			// firma adresi
			String ihaleTarihi = rsgosterilecek.getString("IhaleTarihi");
			//firma tanımı
			// teklif fiyatı
			String teklifFiyati=rsgosterilecek.getString("TeklifFiyati");
			
			String teklifNo=rsgosterilecek.getString("TeklifNo");
			
			toplamTeklif += Double.parseDouble(teklifFiyati);
			
			%>
	  	      <tr>
	  	      <%if (! rsgosterilecek.isFirst()) {%>
	        <td><input type="radio" name="TeklifNo" value="<%=teklifNo%>"><label><%=firmaAd%></label></td>
	         <%}else {
        		 resultSetisEmpty = 1;  //buraya ald?m çünkü tekrar tekrar gereksiz yere yapmas?n? istemiyorum
					%>
				<td><input type="radio" name="TeklifNo" value="<%=teklifNo%>"   checked>	<label><%=firmaAd%></label></td>	        	
	         <% } %> 
	        <td><label><%=firmaTanimi%></label></td>
	        <td><label><%=ihaleTarihi%></label></td>
	        <td><label><%=teklifFiyati%></label></td>
	      </tr>
	    
	<%} %> 
	 <tr >	
	    <td> 
		    <% 
		      if( resultSetisEmpty == 0 ){
		        out.print("Sistemde böyle firma yok");
		      }
		      else{
		      %>
			  <input type="submit" value="Firma Detayı Goster" >
		      <% 
		      }
		      %>
		 </td>
	    <td></td>
	    <td >Toplam</td>
	    <td ><%=toplamTeklif%></td>
     </tr>
	</table>
	
	<%
	
}
	else
	{
		%>
		<br><div align="left">
	<table bgcolor="#FFFFFF" width="438" border="0" cellspacing="0" cellpadding="0" class="tablefont">
		<tr> 
           		 <td width="437" ><font size="3" font = "verdana "color="Indigo"><P >BU ŞİRKETİN KAZANDIĞI İHALE YOK</P></td>
        </tr>
        </table>
        </div>
		<%
	}
}
 else if(request.getParameter("TeklifNo") != null ){
//	 herhangi bir ihale secildi.
	System.out.println("teklif no:"+request.getParameter("TeklifNo"));
	

	String teklifno = request.getParameter("TeklifNo");
	db.closeConnection();
	response.sendRedirect("sat16.jsp?TEKLIFNo="+teklifno);
	return;
}
else
{
	System.out.println("Firma secilmedi ");
}


%>
</form>
 </div>
<%db.closeConnection(); %>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</body>
</html>