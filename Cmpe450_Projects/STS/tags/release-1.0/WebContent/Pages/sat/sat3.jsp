<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="global.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%DB db=new DB(true);
request.setCharacterEncoding("UTF-8");
//response.setCharacterEncoding("UTF-8");

if(request.getParameter("onay") != null 
		&&request.getParameter("onay").equals("evet"))
{
	   System.out.println("Eklendi-----------------------");
	   String tt0 = (String)request.getParameter( "T0" );
	   String tt1 = (String)request.getParameter( "T1" );
	   String tt2 = (String)request.getParameter( "T2" );
	   String tt3 = (String)request.getParameter( "T3" );
	   String tt4 = (String)request.getParameter( "T4" );
	   String tt5 = (String)request.getParameter( "T5" );
	   String tt6 = (String)request.getParameter( "T6" );
	   String tt7 = (String)request.getParameter( "T7" );
	   
	 String sp="call IhaleEkle_sp('"+tt0+"','00DUMY-PAG"+"','"+tt1+"','"+tt2+"','"+tt3+"','"+tt4+"','"+tt5+"','"+tt6+"','"+tt7+"')";
	  db.execute(sp);   
	  System.out.println(sp); 
	  
	  db.closeConnection();
	   response.sendRedirect("../../alerts/approve3.jsp");
	   return;

}  
else 
	System.out.println("New");
%>   



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript">
	
		function ekle() {
		   
		  if (myForm.T0.value.length > 0){ 
			   if (myForm.T1.value.length > 0){
				   if (myForm.T2.value.length > 0){
						if (myForm.T3.value.length > 0){
							if(myForm.T4.value.length > 0){
								if(myForm.T5.value.length > 0){
									if(myForm.T6.value.length > 0){
										if(myForm.T7.value.length > 0){
											document.myForm.onay.value = "evet";
											document.myForm.submit();
										}					
										else{					
											alert("Lütfen Bakanlar kurulu karari giriniz");
										}
									}					
									else{					
										alert("Lütfen Satis bedeli giriniz");
									}
								}					
								else{					
									alert("Lütfen ilan sekli ve adedi giriniz");
								}				
							}				
							else{				
								alert("Lütfen ihale usulü giriniz");
							}
						
						}
						else{
						
							alert("Lütfen Avans sartlari giriniz");
						
						}
					}
					else{
					
						alert("Lütfen Bütçe tertipi giriniz");
					
					}
				}
				else{
				
					alert("Lütfen Yatirim proje numarasi giriniz");
				
				}
			}
				else{
				
					alert("Lütfen ihale adi giriniz");
				
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




<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
<form name="myForm" action="sat3.jsp" method="post">
<div align=center>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
	<td align="left" nowrap width="19%"> 
	&#304;hale Ad&#305;:&nbsp;</td> 
	<td align="left" width="49%"> 
	<input type="text" name="T0" size="20"></td> </tr>
<tr>
	<td align="left" nowrap width="19%"> 
	Yat&#305;r&#305;m Proje Numaras&#305; :</td> 
	<td align="left" width="49%"> 
	<input type="text" name="T1" size="20"></td> </tr>
<tr>
	<td align="left" nowrap width="19%"> 
	Bütçe Tertibi:</td> 
	<td align="left" width="49%"> 
	<input type="text" name="T2" size="20"></td> </tr>
<tr>
	<td align="left" nowrap width="19%"> 
	Avans &#350;artlar&#305;:</td> 
	<td align="left" width="49%"> 
	<input type="text" name="T3" size="20"></td> </tr>
<tr>
	<td align="left" nowrap width="19%"> 
	&#304;hale Usulü:</td> 
	<td align="left" width="49%"> 
	<input type="text" name="T4" size="20"></td> </tr>
<tr>
	<td align="left" nowrap width="19%"> 
	&#304;lan &#350;ekli ve Adedi:</td> 
	<td align="left" width="49%"> 
	<input type="text" name="T5" size="20"></td> </tr>
<tr>
	<td align="left" nowrap width="19%"> 
	 Ön Yeterlilik / &#304;hale Döküman&#305; Sat&#305;&#351; Bedeli: </td> 
	<td align="left" width="49%"> 
	<input type="text" name="T6" size="20"></td> </tr>
<tr>
	<td align="left" nowrap width="19%"> 
	 Fiyat Fark&#305; Ödenecekse Dayana&#287;&#305; Bakanlar Kurulu Karar&#305;: </td> 
	<td align="left" width="49%"> 
	<input type="text" name="T7" size="20"></td> </tr>
</table>
	<table width=100%>
	<tr>
	<td width=100% align=center>&nbsp;</td>
	</tr>
	<tr>
	<td width=100% align=center> 	
  	<input class="tablefont3"  type="button" value="&#304;haleyi Olu&#351;tur" onClick="ekle()" language="JavaScript" ></td>
	</tr>
	</table><input type="hidden" name="onay" value="">

</div>

</div>

 
</form>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
	</div>


<%db.closeConnection(); %>
</body>
</html>