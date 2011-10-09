<%@ page language="java" contentType="text/html; charset=iso-8859-9"
    pageEncoding="UTF-8"%>
    <%@page import="system.*"%>
    <%@page import="global.*"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.util.ArrayList"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; 
charset=UTF-8">
<link href="gui.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
<div id=top2>
<table width="200" cellpadding="0" cellspacing="0">
 <% 

User userInfo=(User)session.getAttribute("userClass");

// Emin Senay 15.12.2006 
// SASLinks, STSLinks ve BTSLinks alanlari menude bu alanlara ait sayfalarin ayri menulerde 
// goruntulenmesi icin
ArrayList SASLinks = new ArrayList();
ArrayList STSLinks = new ArrayList();
ArrayList BTSLinks = new ArrayList();

//System.out.println("Length of rights: "+userInfo);
if(userInfo!=null){
	//System.out.println("Length of rights: "+userInfo.rights.length);
	for(int i =0;i<userInfo.rights.length;i++){
		//System.out.println("Rights Names: "+userInfo.rightsNames[i]);
		//System.out.println("Right: ../Pages"+userInfo.rights[i].substring(2));
		// Emin Senay 15.15.2006
		//System.out.println("Page Code: " + userInfo.pageCodes[i]);

		if(userInfo.link[i]==1){
			if (userInfo.pageCodes[i].startsWith("STS")) { // Stok takip sistemi sayfasi
				STSLinks.add("../Pages"+userInfo.rights[i].substring(2));
				STSLinks.add(userInfo.rightsNames[i]);
			} else if (userInfo.pageCodes[i].startsWith("BTS")) { // Butce takip sistemi sayfasi
				BTSLinks.add("../Pages"+userInfo.rights[i].substring(2));
				BTSLinks.add(userInfo.rightsNames[i]);
			} else { // Stok takip sistemi sayfasi
				SASLinks.add("../Pages"+userInfo.rights[i].substring(2));
				SASLinks.add(userInfo.rightsNames[i]);				
			}
		}
	}
	// SAS i yazdir
%>
<%
	if (SASLinks.size() > 0) {
%>
	<tr>
		<td class="menuItemParent" >
			
			<font face="Verdana, Arial, Helvetica, sans-serif" color="white"><font class="Arrow">&gt;&gt;Satın Alma Sistemi</font>
		</td>
	<tr>
<%
		for (int i = 0; i < SASLinks.size(); i++)
		{
%>
    <tr>
        <td class="menuItemChild" onMouseOver="this.className='menuItemChild_over';" onMouseOut="this.className='menuItemChild_out';">
        	
        	<a href="<%=SASLinks.get(i++)%>" target="mainFrame" class="menuLinkChild">&gt;&gt;<%=SASLinks.get(i)%></a>
        </td>
  	</tr>
<%
		}
	}
	if (BTSLinks.size() > 0) {
%>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			
			<font face="Verdana, Arial, Helvetica, sans-serif" color="white">&gt;&gt;Bütçe Takip Sistemi</font>
		</td>
	<tr>
<%
		for (int i = 0; i < BTSLinks.size(); i++)
		{
%>
    <tr>
        <td>
        	
        	<a href="<%=BTSLinks.get(i++)%>" target="mainFrame">-&gt;<%=BTSLinks.get(i)%></a>
        </td>
  	</tr>
<%
		}	
	}
	if (STSLinks.size() > 0) {
%>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<font face="Verdana, Arial, Helvetica, sans-serif" color="white">&gt;&gt;Stok Takip Sistemi</font>
		</td>
	</tr>
<%
		for (int i = 0; i < STSLinks.size(); i++)
		{
%>
    <tr>
        <td>
        	
        	<a href="<%=STSLinks.get(i++)%>" target="mainFrame">-&gt;<%=STSLinks.get(i)%></a>
        </td>
  	</tr>
  	
<%
		}
	}
%>
 </table> 
	 
  
	<%
  }

    %>
    
    
   
  <p align="left">
	  
<br>
<br>
		  <table border="0" cellspacing="0" cellpadding="0" width="210">
			  <tr><td class="menuItemChild2" onMouseOver="this.className='menuItemChild_over2';" onMouseOut="this.className='menuItemChild_out2';">
			  	 <a href="../Pages/onayBekleyenler/onaybekleyenler.jsp" class="menuLinkChild" target="mainFrame"> -&gt;Ana Menü</a>
			  </td></tr>
			  <tr><td class="menuItemChild2" onMouseOver="this.className='menuItemChild_over2';" onMouseOut="this.className='menuItemChild_out2';">
			  	 <a href="sifredegistir.jsp" class="menuLinkChild" target="mainFrame"> -&gt;Şifre Değiştir</a>
			  </td></tr>
			  	<tr><td class="menuItemChild2" onMouseOver="this.className='menuItemChild_over2';" onMouseOut="this.className='menuItemChild_out2';">
			  	 <a href="../logoutPage.jsp" class="menuLinkChild" target="_top"> -&gt;Çıkış</a>
			  </td></tr>
  		  </table>
  	</p>  
  	<p align="left">
  	<br>
          <br>
		  <table border="0" cellspacing="0" cellpadding="0">  
		  
       <tr>
        <td> 
<a href="../help/index.html" target="_blank"> -&gt;Yardım</a></td>
  </tr>
  
  <tr>
        <td><a href="http://www.boun.edu.tr/calendar/index_tur.html" 
target="_blank"> -&gt;Akademik 
          Takvim</a></td>
  </tr>
  <tr>
        <td><a href="http://www.boun.edu.tr/" target="_blank"> -&gt;Boğaziçi 
          Üniversitesi</a></td>
  </tr>
    
   
</table>
</p>
</div>
</body>
</html>