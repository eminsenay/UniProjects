<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" >

  function ihalleriGoster()
  {
       document.myForm.onay.value = "goster";
	   document.myForm.submit();
  }
    function geri_onclick(){
			document.myForm.onay.value="geri";
			document.myForm.submit();
   }
	
</SCRIPT>
</head>

<%
DB db= new DB(true);
String firmaAdi="";
//SessionXX
String teklifNo=(String)request.getParameter("TEKLIFNo");
System.out.println("teklif no:"+teklifNo);

%>

<body  bgcolor="#FFFFFF">

<div id="toprightt"> </div>

<div id="topright2">
<form name="myForm" method="post" action="sat16.jsp">
 <table border="0" cellspacing="0" cellpadding="0" width="600" height="500" >
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->


  <div align="left">
  <%
  
  ResultSet rsihale = db.executeQuery("select * from IHALE_TEKLIF where IHALE_TEKLIF.`TeklifNo`='"+teklifNo+"'");
  while (rsihale.next()) {
  firmaAdi=rsihale.getString("FirmaAdi");
  String firmaTelefonu=rsihale.getString("FirmaTel");
  String firmaAdresi=rsihale.getString("FirmaAdres");
  String firmaTanimi=rsihale.getString("FirmaTanimi");
  String teklifFiyati=rsihale.getString("TeklifFiyati");
  String ihaleNo=rsihale.getString("IhaleNo");
  
  %>
  <table width="450" border="1"  class="tablefont2">
  <tr>
    <td width="225">F&#304;RMA ADI</td>
    <td width="225"><input type="hidden" name="firmaAdi" value=<%=firmaAdi %>><%=firmaAdi %></td>
  </tr>
  <tr>
    <td>F&#304;RMA TELEFONU</td>
    <td><%=firmaTelefonu %></td>
  </tr>
  <tr>
    <td>F&#304;RMA ADRES&#304; </td>
    <td><%=firmaAdresi %></td>
  </tr>
  <tr>
    <td>F&#304;RMA TANIMI </td>
    <td><%=firmaTanimi %></td>
  </tr>
  <tr>
    <td>TEKL&#304;F F&#304;YATI </td>
    <td><%=teklifFiyati %></td>
  </tr>
  <tr>
    <td>&#304;HALE NO </td>
    <td><%=ihaleNo %></td>
  </tr>
  
</table>
<%} %>

 <table width="450"  border="0" class="tablefont3">
  <tr>
    <td width="450" height="36">	
    <div align="center">
  	<input type="button" class="tablefont3"  value="Firmanın Girdigi Tüm İhaleleri Göster" onClick="ihalleriGoster()" language="JavaScript">
  	
  	<input type="hidden" name="onay" value="">
  	<input type="hidden" name="TEKLIFNo" value="<%=teklifNo %>">
  	</div>
  	</td>
  </tr>
    <tr>
   
  </tr>
</table>
	<%
	
	//fisGoster boolean variable?n?n degerine gore ilgili fisleri goster
	if(request.getParameter("onay") != null && 
			request.getParameter("onay").equals("goster"))	{
	
		%>
        <br><div align="left">
		<table bgcolor="#FFFFFF" width="688" border="0" cellspacing="0" cellpadding="0" class="tablefont">
			<tr> 
               		 <td width="687">Firmanın Katıldığı İhaleler:<a name="Gecmis"></a></td>
            </tr>
			
			<tr><td><p>&nbsp;</p>			
				<table bgcolor="#FFFFFF" width="688" border="3" cellspacing="0" cellpadding="0" class="tablefont">
              		<tr>
              		    <td width="174">İhale No:</td>	
						<td width="174">İhale Adı:</td>
						<td width="174">İhale Tarihi:</td>	
						<td width="204">Kazanan Firma Adı:</td>
						<td width="174">Kazanan Teklif</td>
						<td width="204">Bu Firmanın Teklifi</td>
					</tr>
					<% 
					String firma=(String)request.getParameter("firmaAdi");
					
					ResultSet result3=db.executeQuery("call FirmaninGirdigiIhalelerDokumu_sp('"+firma+"')");
					
					while(result3.next()){
					%>
					<tr> 	  	   
					    <td width="174"><% 
					    String t0=result3.getString("IhaleNo");
					    if (! result3.isFirst()) { %>
					    <input type="radio" name="IhaleNO" value="<%=t0%>">
					    <%}
					    else { %>
					    <input type="radio" name="IhaleNO" value="<%=t0%>"   checked>
					    <%
					    }
						out.print(t0);
						%></td>
						<td width="174"><% 
						String t2=result3.getString("IhaleAdi");
						out.print(t2);
						%></td>
					    <td width="174"><%
						String t5=result3.getString("IhaleTarihi");
						out.print(t5);
						%></td>
			            <td width="204"><%
						String t6=result3.getString("KazananFirma");
						out.print(t6);
						%></td>
	                    <td width="174"><%
						String t7=result3.getString("KazananTeklifFiyati");
						out.print(t7);
						%></td>
				       <td width="204"><%
						String t8=result3.getString("TeklifFiyati");
						out.print(t8);
						%></td>
					</tr>
					<%
					}
					%>
					
				</table>
			</td></tr>
		</table>
		</div>

	 <table width="450"  border="0" class="tablefont3">
  <tr>
    <td width="450" height="36">	
    <div align="center">
  	<input type="submit" value="İhale Detayı Goster">
  	
  	</div>
  	</td>
  </tr>
    <tr>
   
  </tr>
</table>
	<%
	}
	 else if(request.getParameter("IhaleNO") != null ){
//		 herhangi bir ihale secildi.
		

		
        db.closeConnection();
		response.sendRedirect("sat17.jsp?ihaleNo="+request.getParameter("IhaleNO")+"&redirect=sat16.jsp&TEKLIFNo="+teklifNo);
		return;
	}

	
	
	%>	

	
</div>


		
</td>
  </tr>
</table>
</form>
<%db.closeConnection(); %>
</div>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
</BODY>
</html>