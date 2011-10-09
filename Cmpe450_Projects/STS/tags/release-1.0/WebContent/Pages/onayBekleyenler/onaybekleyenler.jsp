<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@page import="java.sql.ResultSet"%>


<%//@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
request.setCharacterEncoding("UTF-8");   
session.setAttribute("error",null);
%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğazi&ccedil;i &Uuml;niversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  <% 
//	if( session.getAttribute("Error").equals("No request is selected") ){
   %>

   <%
//	 	session.removeAttribute( "Error" );
//  	}
  %>
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
		
		<% 
		  
			User userInfo = (User)(session.getAttribute("userClass"));
	
			DB db=new DB(true);		        
        
        	ResultSet rs = db.executeQuery("call KullaniciIstekFisi_sp('" + userInfo.getUserid() + "')");

			int resultSetisEmpty = 0;
			if(rs.next()){
				resultSetisEmpty = 1;
				rs.beforeFirst();
			}

			if( resultSetisEmpty == 0 ){
				
				out.print("Sistemde bekleyen istek fişi bulunmamaktadır");

			}
			else{	
		%>
		
		
<form action="decidePage.jsp" method="post"> 		
<table bgcolor="#FFFFFF" width="500" border="2" bordercolor="#CCCCFF" cellspacing="0" cellpadding="0" align=left class="tablefont3">

     	  <tr>
	   				<td colspan="6" align="center">
	   				              
                <font size="2" ><label>Onay Bekleyen &#304;stekler</label><br><label>(Detay görmek i&ccedil;in t&#305;klay&#305;n&#305;z)</label></font></td>
      </tr>
	  <tr>
	   				<td></td>
	   				<td>
	   					<font size="2">Fi&#351; Kodu</font>
	   				</td>	   				
	   				<td>
	   					<font size="2">İsteği Yapan</font>
	   				</td>
	   				<td>
	   					<font size="2">İstek Fi&#351;i No</font>
	   				</td>
	   				<td>
	   					<font size="2">Tarih</font>
	   				</td>
	   				<td>
	   					<font size="2">Hangi Sayfada</font>
	   				</td>
		        </tr>
		        <% 
		       
//		        User userInfo = (User)(session.getAttribute("userClass"));
//eski
//		        if(userInfo==null){		     	   
//		     	   response.sendRedirect("../../logout.jsp");
//		     	   return;	   
//		        }
		        
//yeni				
		
				if(userInfo==null){		     	   

				   session.setAttribute("error","Kullanıcı adınız veya şifreniz yanlış");
				   response.sendRedirect("../../logout.jsp");
		     	   return;	   
		        }				

//		        DB db=new DB(true);		        
		        
//		        ResultSet rs = db.executeQuery("call KullaniciIstekFisi_sp('" + userInfo.getUserid() + "')");

//				int resultSetisEmpty = 0;
				
				
				while( rs.next() ){
		        %>
				<tr>
		        	<td style="FONT-WEIGHT : normal">
			        	<% 
			        	 if( !rs.isFirst() ){
			        	%>
			        	<input type="radio" name="requestID" value="<%=rs.getString("IstekFisiNo")%>">

						<% 
			        	 }
			        	 else{
			        		 resultSetisEmpty = 1;  //buraya aldım çünkü tekrar tekrar gereksiz yere yapmasını istemiyorum
						%>
						<input type="radio" name="requestID" value="<%=rs.getString("IstekFisiNo")%>" checked>			        	
		        		<% }%>
		        	</td>
		        	<td style="FONT-WEIGHT : normal">
		        		<%=rs.getString("IstekFisiKodu") %>
		        	</td>
		        	<td style="FONT-WEIGHT : normal">
		        		<%=rs.getString("Isteyen") %>			        		
		        	</td>
		        	<td style="FONT-WEIGHT : normal">
		        	 <%=rs.getString("IstekFisiNo") %>			        		
		        	</td>
		        	<td style="FONT-WEIGHT : normal">
		        	 <%=rs.getString("OlusturmaTarihi") %>			        		
		        	</td>
		        	<td style="FONT-WEIGHT : normal">
		        	 <%=rs.getString("SayfaAdi") %>			        		
		        	</td>
		        </tr>
		        <% 

		        }
		        %>
		        	<tr><td> </td> 
		        		<td> 
		        		
		        		<% 
		        		db.closeConnection();
		        		
		        		if( resultSetisEmpty == 0 ){
		        			out.print("Sistemde bekleyen istek fişi bulunmamaktadır");
		        		}
		        		else{
		        		%>
							<input type="submit" class="tablefont3" value="Detay G&#246;ster">
						<% 
		        		}
		        		%>
		        		</td>
		        	</tr> 

    </table>		
        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
</form>		
<%} //resultSetisEmpty == 0 kontolünün (en yukardaki) kapatıyor%>		
		
		
		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50"></td>
  </tr>
</table>
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
	
	
	
	</div>
</body>
</html>




