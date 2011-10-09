<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğazi&ccedil;i &Uuml;niversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<%
//türkçe karakter çözümü
request.setCharacterEncoding("UTF-8");

System.out.println("?hale no: "+request.getParameter("IhaleNo") );

User userInfo = (User)(session.getAttribute("userClass"));

DB dbcon = new DB(true);
ResultSet rs = dbcon.executeSP("IhaleGosterDurumaGore_sp", new Object[]{new Integer(4)}).getResult();
//executeQuery("select * from IHALE where DURUM = '4' and Statu = '1'");



if(request.getParameter("IhaleNo") != null ){
//	 herhangi bir ihale secildi.
	System.out.println("herhangi bir ihale secildi ");
	session.setAttribute("IhaleNo",(String)request.getParameter("IhaleNo"));
	dbcon.closeConnection();
	response.sendRedirect("../rek/ihaleDetay2.jsp");
	return;
	//response.sendRedirect("../../alerts/approve.jsp");
}
else 
{
	System.out.println("Default Page: rek5.jsp ");
}

%>
<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
	
	  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
<form action="rek5.jsp" method="post">
	
		 
		 
		 <table bgcolor="#FFFFFF" width="420" border="2" bordercolor="#CCCCFF" cellspacing="0" cellpadding="0" class="tablefont3">
           
           <tr>
	   				<td colspan="3"><font size="2">Teklif Almış &#304;haleler </font></td>

           </tr>     
		  <tr>
	   				<td></td>
	   				<td>
	   					&#304;HALE ADI</td>
	   				<td>
	   					&#304;HALE NO </td>
           </tr>
		        <% 
		        // databaseden ihale bilgilerinin al?nmas?
				
				int resultSetisEmpty = 0;
		        while( rs.next() ){
		        %>
				<tr>
		        	<td>
			        	<% 
			        	 if( !rs.isFirst() ){
			        	%>
			        	<input type="radio" name="IhaleNo" value="<%=rs.getString("IhaleNo")%>">

						<% 
			        	 }
			        	 else{
			        		 resultSetisEmpty = 1;  //buraya ald?m çünkü tekrar tekrar gereksiz yere yapmas?n? istemiyorum
						%>
						<input type="radio" name="IhaleNo" value="<%=rs.getString("IhaleNo")%>"   checked>			        	
		        		<% } %>
		        	</td>
		        	<td>
		        		<%=rs.getString("IhaleAdi") %>
		        	</td>
		        	<td>
		        		<%=rs.getString("IhaleNo") %>			        		
		        	</td>
		        </tr>
		        <% 
		        }
		        %>
		        <tr>
					<td>
				    </td> 
		        	<td> 
		       		    <% 
		        		if( resultSetisEmpty == 0 ){
		        			out.print("Sistemde Teklif almiş ihale bulunmamaktadir");
		        		}
		        		else{
		        		%>
							<input type="submit" value="Detay Göster">
						<% 
		        		}
		        		%>
		        	</td>
										<td>
				    </td> 
		        </tr>
	  
	  


    </table>		
  

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
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color:black>Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
	
	<%dbcon.closeConnection(); %>
	
	</div>
</body>
</html>