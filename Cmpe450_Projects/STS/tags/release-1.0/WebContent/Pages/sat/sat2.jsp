<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>

<% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">



</head>
<body>

<script language=javascript>
	function yeniihalac(){
		document.onayFormu.choice.value="sat3.jsp";
		document.onayFormu.submit();
	
	}
	function yeniihaleyonet(val){
		document.onayFormu.choice.value="sat5.jsp";
		document.onayFormu.ihaleNo.value=document.onayFormu.ihaleNo1.value;
		document.onayFormu.submit();
	}
	function teklifyonetimi(val){
		document.onayFormu.choice.value="sat8.jsp";
		document.onayFormu.ihaleNo.value=document.onayFormu.ihaleNo2.value;
		document.onayFormu.submit();
	
	}
	function maltalepet(val){
		document.onayFormu.choice.value="sat13.jsp";
		document.onayFormu.ihaleNo.value=document.onayFormu.ihaleNo3.value;
		document.onayFormu.submit();
	}
		
</script>

<% DB db= new DB(true); 
String incomingIhalno= request.getParameter("ihaleNo");
String choice= request.getParameter("choice");
System.out.println("incoming ihale no  "+incomingIhalno);
System.out.println("choice "+ choice);

if(choice!=null&&!choice.equals("")){
	
	db.closeConnection();
	response.sendRedirect(choice+"?ihaleNo="+incomingIhalno);	
	return ;
}
boolean enable=true;
%>
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
<form name="onayFormu" post="sat2.jsp" method="post">

<div align=center>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
<td nowrap width="25%" align="left">
Yeni ihale olu&#351tur:</td>
<td align="left" width="40%"> 	
  	&nbsp;</td>
<td width="35%" align="left"> 	
  	<input class="tablefont3" onclick="yeniihalac()" type="button" value="Yarat"  ></td>
</tr>
<tr>
<td nowrap width="25%" align="left"><%
ResultSet rs = db.executeQuery("select distinct IhaleAdi,IhaleNo from IHALE where Durum=1");%>Yeni aç&#305;lm&#305;&#351; ihaleler:</td>
<td align="left" width="40%"> 	
  	<select name="ihaleNo1">
	<%
	enable=false;
	while(rs.next()){ %>
	<option value="<%=rs.getString("IhaleNo")%>" selected><%out.print(rs.getString("IhaleAdi"));%></option>
	<%
	enable=true;
	} %> 
	</td>
<td width="35%" align="left"> 	
  	<input class="tablefont3" name="onay1" onclick="yeniihaleyonet()" type="button" value="Yönetim"></td>
  	<script language=javascript>
		document.onayFormu.onay1.disabled=<%=!enable%>;
	</script>
</tr>

 <% rs = db.executeQuery("select distinct IhaleAdi,IhaleNo from IHALE where Durum=3");%>

<tr>
<td nowrap width="25%" align="left">Teklif al&#305;nacak ihaleler:&nbsp;</td>
<td align="left" width="40%"> 	
  	<select name="ihaleNo2">
	<%
	enable=false;	
	while(rs.next()){ %>
	<option value="<%=rs.getString("IhaleNo")%>" selected><%out.print(rs.getString("IhaleAdi"));%></option>
	<%
	enable=true;
	} %> 
	</td>
<td width="35%" align="left"> 	
  	<input class="tablefont3"  name="onay2" onclick="teklifyonetimi()" type="button" value="Yönetim"  ></td>
  	<script language=javascript>
		document.onayFormu.onay2.disabled=<%=!enable%>;
	</script> 
</tr>
<tr>
<td nowrap width="25%" align="left"><% rs = db.executeQuery("select distinct IhaleAdi,IhaleNo from IHALE where Durum=5");%>Sonuçlanm&#305;&#351; &#304;haleler:</td>
<td align="left" width="40%"> 	
  	<select name="ihaleNo3">
	<%
	enable=false;
	while(rs.next()){ %>
	<option value="<%=rs.getString("IhaleNo")%>" selected><%out.print(rs.getString("IhaleAdi"));%></option>
	<%
	enable=true;
	} %> 
	</td>
<td width="35%" align="left"> 	
  	<input class="tablefont3" name="onay3" onclick="maltalepet()"  type="button" value="Yönetim"  ></td><script language=javascript>
		document.onayFormu.onay3.disabled=<%=!enable%>;
	</script>  
</tr>
<%db.closeConnection(); %>
</table>


<input type="hidden" name="choice">
 <input type="hidden" name="ihaleNo" value="<%out.println(incomingIhalno);%>">
</div>

 </div>
 
</form>
</div>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="white">Bilgisayar 
      Mühendisli&#287i &copy;2005</font></b></p>
	</div>
</body>
</html>