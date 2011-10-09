<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="system.*"%>
    <%@page import="global.*"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; 
charset=UTF-8">
<link href="gui.css" rel="stylesheet" type="text/css">
<%
//security kodlar? buraya!!!
		User userInfoSecurity=(User)session.getAttribute("userClass");

		boolean securityEnabled;
		String publicKey = new String();
		int ozelAnahtarKul = 0;
		
		if (userInfoSecurity == null) {
			ozelAnahtarKul = 0;
		} else {
		
			DB db = new DB(true);
			DB tempDB = db.executeSP("ImzaAnahtariBilgileriniGoster_sp", new Object [] { userInfoSecurity.getUserid() } );
			
			if (tempDB != null) {
				ResultSet result = tempDB.getResult();
				result.next();
			//	result.get - public key
				publicKey = result.getString(1);
			//	- ozel anahtar kullanıyor
				ozelAnahtarKul = result.getInt(2);
			//	- aciklama goster
			}
			db.closeConnection();
		}
		
		if (ozelAnahtarKul == 1) {
			// eger asagidaki variable false yapilirsa, sign applet sayfada gozukmez
			securityEnabled = Security.SECURITY_ENABLED;
			//security kodlar? bitti
		} else {
			securityEnabled = false;
		}
		session.setAttribute("securityEnabled",""+securityEnabled);
%>

<% if (securityEnabled) { %>
<script language="JavaScript">

		var signSuccessFinished = 0;
		
		var public_keyValue = '<%=publicKey%>';
		
		function securityOnayDugmesi() {
			CreateDocumentString();
			document.sign_applet.startToSign(parent.mainFrame.document.onayFormu.document_content.value, public_keyValue);
			if ( signSuccessFinished == 1) {
				parent.mainFrame.onayDugmesi();
			}
		}
		
		function signSuccess(signature) {
			parent.mainFrame.document.onayFormu.imza.value = signature;
			signSuccessFinished = 1;
		}
		
		function CreateDocumentString () {
				    var document_text='';
				    
				    var n_total_fields = parent.mainFrame.document.getElementById('security_field_no').value;
				    
				    var i = 0;
				    for ( i = 1; i <= n_total_fields; i++) {
				    	document_text = document_text + getValue_security('security'+i);
				    }
				    
				    parent.mainFrame.document.onayFormu.document_content.value = document_text;
		}
		
		function getValue_security(id){
        	if (parent.mainFrame.document.getElementById && parent.mainFrame.document.createElement) {
                if (parent.mainFrame.document.getElementById(id) != null) {
					tagName = parent.mainFrame.document.getElementById(id).tagName;
                	if (tagName == 'INPUT' || tagName == 'SELECT') {
						return parent.mainFrame.document.getElementById(id).value;
					} else {
                        return parent.mainFrame.document.getElementById(id).firstChild.nodeValue;
					}
                } else {
                	return '';
                }
        	}
		}

</script>
<% } else {%>

<script language="JavaScript">
		function securityOnayDugmesi() {
			parent.mainFrame.onayDugmesi();
		}
</script>		
<%} %>

</head>

<body  bgcolor="#FFFFFF"> <div  align="center">
	<div id="top">	  
	<br>
	
<!-- SECURITY APPLET TAG -->
<%
	if (securityEnabled) { %>
	<APPLET NAME="sign_applet" CODE=HtmlAccessApplet.class ARCHIVE="../applets/SSignedApplet.jar" WIDTH=0 HEIGHT=0 MAYSCRIPT></APPLET>
<%  } %>
<!-- SECURITY APPLET TAG -->

<object classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000
codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,2,0

width=215
height=140>
<param name=movie value=connection.swf>
<param name=quality value=high>
<param name=BGCOLOR value=#23024A>
<param name=SCALE value=showall>
<embed src=connection.swf
quality=high
pluginspage=http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash 
type=application/x-shockwave-flash
width=215
height=140
bgcolor=#23024A
scale= showall>
</embed>
</object>
	
	    <p align="center"><b><font size="+1" face="Verdana, Arial, 
Helvetica, sans-serif color:black">SAS</font></b></p>
	    <p align="center"><b><font size="-2" face="Verdana, Arial, 
Helvetica, sans-serif color:black">Bogaziçi Üniversitesi<br>Satin Alma 
Sistemi<br><br></font></b></p>

	</div>
		<div id="top2">	  
    <p align="left">&nbsp;
    <p align="left"><br>
    <table border="0" cellspacing="0" cellpadding="0">



 <% 

User userInfo=(User)session.getAttribute("userClass");
 

System.out.println("Length of rights: "+userInfo);
if(userInfo!=null){
	System.out.println("Length of rights: "+userInfo.rights.length);
	for(int i =0;i<userInfo.rights.length;i++){
		System.out.println("Rights Names: "+userInfo.rightsNames[i]);
		System.out.println("Right: ../Pages"+userInfo.rights[i].substring(2));
	
		if(userInfo.link[i]==1){
%>

 
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
src="../images/arrow.gif"><a 
href="<%out.println("../Pages"+userInfo.rights[i].substring(2));%>" target="mainFrame"><%out.println(userInfo.rightsNames[i]);%>
          </a></td>
  </tr>
  
  <% 
		}
	}
	%>

	 <tr>
        <td>&nbsp;</td>
  </tr>
   <tr>
        <td>&nbsp;</td>
  </tr>
   <tr>
        <td>&nbsp;</td>
  </tr> 
	<tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
src="../images/arrow.gif"><a href="../Pages/onayBekleyenler/onaybekleyenler.jsp" target="mainFrame"><font size="-1" face="Verdana, Arial, 
Helvetica, sans-serif" color="yellow">Ana Menü</font>
          </a></td>
   </tr>
	 <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
src="../images/arrow.gif"><a href="sifredegistir.jsp" target="mainFrame"><font size="-1" face="Verdana, Arial, 
Helvetica, sans-serif" color="yellow">&#350;ifre de&#287;i&#351;tir</font></a></td>
  </tr>
	<tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
src="../images/arrow.gif"><a href="../logoutPage.jsp" target="_parent"><font size="3" face="Verdana, Arial, 
Helvetica, sans-serif" color="yellow">Sistemden Ç&#305;k&#305;&#351;</font>
          </a></td>
   </tr>
   
   <tr>
        <td>&nbsp;</td>
  </tr>
	<%
  }

    %>
    
       <tr>
        <td>&nbsp;</td>
  </tr>       <tr>
        <td>&nbsp;</td>
  </tr>
   
  
      
       <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
src="../images/arrow.gif"><a href="../help/index.html" target="_blank">Yardım</a></td>
  </tr>
  
  
  

  
  <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
src="../images/arrow.gif"><a href="http://www.boun.edu.tr/calendar/index_tur.html" 
target="_blank">Akademik 
          Takvim</a></td>
  </tr>
  <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
src="../images/arrow.gif"><a href="http://www.boun.edu.tr/" target="_blank">Boğaziçi 
          Üniversitesi</a></td>
  </tr>
    
   
</table>

	</div>
	
	<div id="footer">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, 
Helvetica, sans-serif" color="white" >Boğaziçi 
      Üniversitesi</font></b></p>
	</div>
	
	
	</div> 
</body>
</html>