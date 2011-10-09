<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="global.*"%>

 <% request.setCharacterEncoding("UTF-8"); %>
<%DB db=new DB(true);
//SessionXX
String ihaleNo=(String)request.getParameter("IHALENO");

System.out.println("IHALENO:" +ihaleNo);

if(request.getParameter("onay") != null 
		&&request.getParameter("onay").equals("evet"))
{
	   System.out.println("Eklendi-----------------------");
	   String tt2 = (String)request.getParameter( "T2" );
	   String tt3 = (String)request.getParameter( "T3" );
	   String tt4 = (String)request.getParameter( "T4" );
	   String tt5 = (String)request.getParameter( "T5" );
	   String tt6 = (String)request.getParameter("T6").replace(',','.');
	   
	   
	   System.out.println("FirmaAd&#305:"+tt2+"\nFirmaAdres:"+tt3+"\nFirmaTan&#305m&#305:"+tt4+"\nFirmaTan&#305m&#305:"+tt5+"\nTeklifFiyat&#305:"+tt6);


       db.execute("call TeklifEkle_sp('"+ihaleNo+"','"+tt2+"','"+tt3+"','"+tt4+"','"+tt5+"',"+Double.valueOf(tt6)+")");	   

	  db.closeConnection();
	  response.sendRedirect("sat8.jsp?ihaleNo="+ihaleNo);
	  return;

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
	
  function Integer(varible){
   var Input = document.getElementById(varible);
  
    var inputStr = Input.value.toString();
    for (var i = 0; i < inputStr.length; i++){
         var Char = inputStr.charAt(i);
         if ((Char < "0") || (Char > "9") && Char!=" "){
             return false;
      }
    }
    return true;
    }
		function ekle() {
		   
			if (myForm.T2.value.length > 0){
			   if (Integer("T3")) {
			      if (myForm.T3.value.length > 0) {
			    
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
					else {
					   alert ("Lütfen telefon numarasini girin");
					}		
				}
				else {
				   alert ("Lütfen geçerli bir telefon numarasi girin");
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
        <td width="100%" height="56" align=center>T.C.<br>
        <strong>BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</strong><p>
		&nbsp;</td>
      </tr>
    		</table>
	
  </div>



<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="myForm" action="sat7.jsp" method="post">
 <div align=center>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
 <!-- onay ve red dugmeleri -->
<tr>
	<td align="left" nowrap width="20%"> 
	İhale No :</td> 
	<td align="left" nowrap> 
	<input type="text" name="T1" size="30" value=<%out.print(ihaleNo);%> readonly ></td> 
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Firma Adı :&nbsp;</td> 
	<td align="left" nowrap> 
	<input type="text" name="T2" size="30"></td> 
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Firma Telefonu&nbsp;:&nbsp;</td> 
	<td align="left" nowrap> 
	<input type="text" name="T3" size="30" ></td> 
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Firma Adresi:</td> 
	<td align="left" nowrap> 
	<input type="text" name="T4" size="30"></td> 
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Firma Tanımı&nbsp;&nbsp;&nbsp; :</td> 
	<td align="left" nowrap> 
	<input type="text" name="T5" size="30"></td> 
</tr>
<tr>
	<td align="left" nowrap width="20%"> 
	Teklif Fiyatı:</td> 
	<td align="left" nowrap> 
	<input type="text" style="text-align: right;" name="T6" size="30" validator="YTL">YTL</td> 
</tr>
</table>
<table width=79%>
<tr>
<td width=50% align=center>
  	&nbsp;</td>
  	
</tr>
<tr>
<td width=50% align=center>
  	<input class="tablefont3"  type="button" value="Teklif Olu&#351tur" onClick="ekle()" language="JavaScript" >
  	<input type="hidden" name="onay" value=""> 
<input type="hidden" name="IHALENO" value="<%=ihaleNo %>">
</td>
  	
</tr>
</table>

</div>
 
 
</form>
</div>
<%db.closeConnection(); %>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">
	Bilgisayar Mühendisliği ©2005</font></b></p>
	</div>
	

</body>
</html>