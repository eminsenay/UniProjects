<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
	<div id="toprightt"> </div>
  <div id="topright2"> 
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500" class="tablefont3">

  <tr>
        <td width="50" height="350"><img src="../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>

            <table align="" bgcolor="#FFFFFF" width="600" border="0" cellspacing="0" cellpadding="0" >
             
              <tr>
                <td><img src="../images/spacer.gif" width="30"></td>
                <td><font size="5" font = "verdana" color="red">
                <%String errorMessage=(String)session.getAttribute("error");
                if(errorMessage == null ){
                	out.println("<center>Sistemde hata olu&#351;tu </center><p><center>Sistem y&#246;neticisi ile g&#246;rü&#351;&#252;n&#252;z.</center></p>");                	
                }
                else{
                  	out.println( ""+errorMessage); 
                  	session.removeAttribute("error");
                 }
                  %>  
                </font></td>
              </tr >
                            <tr align="left" > 
                <td><img src="../images/spacer.gif" width="10"></td>
                <td align="left"> <font size="15" font = "verdana "color="Indigo"> 
                 
                    <p>&nbsp;</p><p><!--input type="submit" width=300 size=20 name="Submit" value="  Sistemden &#231;ık  "-->

                 
                  </p></center>
                  </font> </td>
              </tr>
            </table>
		 <br> <br>
		 <font size="4" font = "verdana "color="Indigo">
	     <a href="../Pages/onayBekleyenler/onaybekleyenler.jsp" target="mainFrame" >Ana Sayfaya Dön        </a>	
          <br>  <br>
           <a href="../logout.jsp" target="mainFrame" >  Sistemden &#199;&#305;k           </a>	 
		
        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../images/spacer.gif" width="550" height="50"></td>
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
