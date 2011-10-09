
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
request.setCharacterEncoding("UTF-8"); 

System.out.println("İhale no: "+request.getParameter("IhaleNo") );
if(request.getParameter("IhaleNo") != null ){
//	 herhangi bir ihale secildi.
	System.out.println("herhangi bir ihale secildi ");
	session.setAttribute("IhaleNo",(String)request.getParameter("IhaleNo"));
	response.sendRedirect("rek4.jsp");
	//response.sendRedirect("../../alerts/approve.jsp");
}
else
{
	System.out.println("Default Page: onaybekleyenihaleler.jsp ");
}

%>
<body>
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
	
	  <table border="0" cellspacing="0" cellpadding="0" width="650" height="500">
  
 
  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="100" height="350"></td>
    <td valign="top">

	
		 <div align="left"><font size="3"><strong>Onay Bekleyen &#304;haleler </strong></font> </div>
	<form action="rek4.jsp" method="post">	
		 <table bgcolor="#FFFFFF" width="300" border="2" bordercolor="#CCCCFF" cellspacing="0" cellpadding="0" align=left class="tablefont">
     
		  <tr>
	   				<td></td>
	   				<td>
	   					&#304;HALE ADI</td>
	   				<td>
	   					&#304;HALE NO </td>
           </tr>
		        <% 
		        // databaseden ihale bilgilerinin alinmasi
				
				
				
				User userInfo = (User)(session.getAttribute("userClass"));
		        ResultSet rs = DatabaseConnection.executeQuery("select * from IHALE where DURUM=0");

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
			        		 resultSetisEmpty = 1;  //buraya aldim çünkü tekrar tekrar gereksiz yere yapmasini istemiyorum
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
		        			out.print("Sistemde onay bekleyen ihale bulunmamaktadır");
		        		}
		        		else{
		        		%>
							<input type="submit" value="Detay G&#246;ster" >
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
	  
	  


    </table>
</div>

<div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black"> Bilgisayar
M&#252;hendisliği ©2005</font></b></p>
</div>
</div>
</body>
</html>