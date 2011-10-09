<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%
    String error=(String)session.getAttribute("error");
   
   // tüm session ı temizle
    Enumeration a=session.getAttributeNames();
    while(a.hasMoreElements()){
    	String str=(String) a.nextElement();
    	session.removeAttribute(str);
    }
   
    session.invalidate();
    
%>

<html>



<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğazi&ccedil;i &Uuml;niversitesi Sat&#305;n Alma Sistemi</title>
<link href="./index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div id="toprightt"> </div>
  <div id="topright2"> 
  <table border="0" cellspacing="0" cellpadding="0" width="600" class="tablefont">
  <tr>
        <td width="50"><img src="images/spacer.gif" width="50"></td>
    	<td valign="top">


            <table bgcolor="#FFFFFF" width="300" border="0" cellspacing="0" cellpadding="0" class="tablefont">
              <%
                 if(error!=null)
                 {
              %>
			<tr>
                <td><img src="images/spacer.gif" width="40"></td>
                <td><center><h2><strong><font color="#23024A"><%=error %></font></strong></h2></center>
				</td>
			</tr>
			<tr>
				<td><img src="images/spacer.gif" width="40"></td>
				<td><center><font color="#23024A">Sistemden Çıktınız</font></center></td>
			</tr>
              
              <%
              }
              else
              {
              %>
              <tr>
                <td><img src="images/spacer.gif" width="40"></td>
                <td><center><h2><strong><font color="#23024A">Sistemden Başarıyla Çıktınız</font></strong></h2></center>
				</td>
              </tr>
              <%} %>
			
				<tr>
					<td>&nbsp;</td>
					<td align="center">	<a href="./index.jsp" target="_parent" >  Giriş Sayfasına Dön</a> </td>
				</tr>
            </table>

		
		
</td>
  </tr>
</table>
	</div>

<div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black"> Bilgisayar
M&#252;hendisliği ©2005</font></b></p>
</div>
</body>
</html>


	