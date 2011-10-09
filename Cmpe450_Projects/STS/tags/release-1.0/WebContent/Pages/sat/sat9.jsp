<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="global.*"%>
<%@page import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%DB db=new DB(true);

//SECURITY CODE BEGIN

int securityIndex=2;  //Buras&#305; javasecurity index parametresi

//SECURITY CODE END


String ihaleNo=(String)request.getParameter("IHALENO");
String teklifNo=(String)request.getParameter("TEKLIFNO");

System.out.println("IHALENO:" +ihaleNo);
System.out.println("TEKLIFnO:" +teklifNo);


String IhaleNoVal;
String FirmaAdiVal;
String FirmaTelVal;
String FirmaAdresVal;
String FirmaTanimiVal;
String Teklif;



if(request.getParameter("onay") != null 
		&&request.getParameter("onay").equals("evet"))
{
	   System.out.println("Eklendi-----------------------");
	   String tt2 = (String)request.getParameter( "T2" );
	   String tt3 = (String)request.getParameter( "T3" );
	   String tt4 = (String)request.getParameter( "T4" );
	   String tt5 = (String)request.getParameter( "T5" );
	   String tt6 = (String)request.getParameter("T6").replace(',','.');;
	  
	   System.out.println("FirmaAd&#305:"+tt2+"\nFirmaAdres:"+tt3+"\nFirmaTan&#305m&#305:"+tt4+"\nFirmaTan&#305m&#305:"+tt5+"\nTeklifFiyat&#305:"+Double.valueOf(tt6)+"\nTeklifNo:"+teklifNo);
	   db.execute("UPDATE IHALE_TEKLIF set TeklifFiyati = '"+Double.valueOf(tt6)+"' where TeklifNo = '"+teklifNo+"'");
	   db.closeConnection();
	   response.sendRedirect("sat8.jsp?ihaleNo="+ihaleNo);
       return;
 

} 
if(request.getParameter("onay") != null 
		&&request.getParameter("onay").equals("geri"))
{
	   
	   db.closeConnection();
	   response.sendRedirect("sat8.jsp?ihaleNo="+ihaleNo);
       return;
 

} 
else {
	ResultSet rsvalue = db.executeQuery("select * from IHALE_TEKLIF WHERE TeklifNo='"+teklifNo+"'");
	rsvalue.next();
		 IhaleNoVal = rsvalue.getString ("IhaleNo");
		 FirmaAdiVal = rsvalue.getString ("FirmaAdi");
		 FirmaTelVal = rsvalue.getString ("FirmaTel");
		 FirmaAdresVal = rsvalue.getString ("FirmaAdres");
		 FirmaTanimiVal = rsvalue.getString ("FirmaTanimi");
		 Teklif = rsvalue.getString ("TeklifFiyati").replace('.',',');
		
		
		
	
	
}
%>   



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">

</head>
<body>
<script language=javascript src="../validator.js"></script>
<SCRIPT language="JavaScript">

		<!--SECURITY applet calls this method and it calls the ekle method.-->
		function onayDugmesi() {
			ekle();
		}
		
		function geridon() {
			document.myForm.onay.value = "geri";
			document.myForm.submit();
		}
	
	
		function ekle() {
		   
			if (myForm.T2.value.length > 0){
				if(myForm.T3.value.length > 0){
					if(myForm.T4.value.length > 0){
						if(myForm.T5.value.length > 0){
							if(myForm.T6.value.length > 0){
								if (validateElement(document.myForm.T6,true)){
									document.myForm.onay.value = "evet";
									document.myForm.submit();
								}
							}					
							else{					
								alert("Lütfen Teklif fiyatini girin");
							}
						}					
						else{					
							alert("Lütfen Firma tanimini girin");
						}
					}					
					else{					
						alert("Lütfen Firma adresini girin");
					}				
				}				
				else{				
					alert("Lütfen Firma telefonunu girin");
				}
			
			}
			else{
			
				alert("Lütfen firma adini girin");
			
			}
			
	
		}


	
	
</SCRIPT>

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
<form name="myForm" action="sat9.jsp" method="post">
<div align=center>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
 <!-- onay ve red dugmeleri -->
<tr>
	<td align="left" nowrap width="20%"> 
	Firma Ad&#305; :</td> 
	<td align="left" nowrap> 
<input readonly type="text" name="T2" size="30" id='security<%=securityIndex++ %>' value="<%=FirmaAdiVal%>"></td>
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Firma Telefonu&nbsp;:</td> 
	<td align="left" nowrap> 
<input readonly type="text" name="T3" size="30" id='security<%=securityIndex++ %>' value="<%=FirmaTelVal%>"></td>
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Firma Adresi :</td> 
	<td align="left" nowrap> 
<input readonly type="text" name="T4" size="30" id='security<%=securityIndex++ %>' value="<%=FirmaAdresVal%>"></td>
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Firma Tan&#305;m&#305; :</td> 
	<td align="left" nowrap> 
<input readonly type="text" name="T5" size="30" id='security<%=securityIndex++ %>' value="<%=FirmaTanimiVal%>"></td>
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Teklif Fiyat&#305; :</td> 
	<td align="left" nowrap> 
<input type="text" style="text-align: right;" name="T6" size="30" validator="YTL" id='security<%=securityIndex++ %>' value="<%=Teklif%>">YTL</td>
</tr>
</table>
<table width=79%>
<tr>
<td width=100% align=center>&nbsp;</td>

</tr>

<tr>
<td width=100% align=center> 	
  	<input class="tablefont3"  type="button" value="Geri" onClick="geridon()" language="JavaScript" >
  	<input class="tablefont3"  type="button" value="Teklif Güncelle" onClick="parent.leftFrame.securityOnayDugmesi()" language="JavaScript" > 
  	
  	<input type="hidden" name="onay" value=""> 
	<input type="hidden" name="TEKLIFNO" value="<%=teklifNo %>">
	<input type="hidden" name="IHALENO" value="<%=ihaleNo %>">

  	
  	</td>

</tr>

</table>
</div>


</div>
</form>
<%db.closeConnection(); %>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
	</div>



</body>
</html>