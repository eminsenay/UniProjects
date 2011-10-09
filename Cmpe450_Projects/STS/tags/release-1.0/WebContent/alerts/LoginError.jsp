<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="global.DB"%>
<%@page import="java.sql.*"%>
  
<%
     // hata kontrolu icin kullaniruz
     String userName=(String) session.getAttribute("username");
     session.removeAttribute("username");
  
 	  //  DB db=new DB(true);
     String yorum="";
   	 // ResultSet rs=db.executeQuery("select * from KULLANICI where KullaniciAdi='"+userName+"'");
     yorum="Kullanıcı adini ve şifresini kontrol ediniz.<p>DİKKAT : Eğer 3'ten fazla yanlış giriş yaparanız, kullanıcınız bloke olur.</p>";
	
	//  if(rs.next()){
  	 // 	 yorum="Kullanıcı adı yada şifresi hatalı girilmiştir. Yanlış yazım , büyuk-kucuk harf olaylarina dikkat ediniz";
    	 
 	 //   }
     
 	   //db close da unutulmuş --bll
    
%>


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
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500" class="tablefont">

  <tr>
        <td width="50" height="350"><img src="../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
<form action="../index.jsp" method="post">
            <table bgcolor="#FFFFFF" width="400" border="0" cellspacing="0" cellpadding="0" class="tablefont">
             
              <tr>
                <td><img src="../images/spacer.gif" width="30"></td>
                <td><font size="2" font = "verdana" color="red">
                <B>Kullan&#305;c&#305; girişinde hata olu&#351;tu. </B> 
               
                </i> </font></td>
              </tr>
              <font size="1" font = "verdana" color="Indigo">
              <tr>
                <td><img src="../images/spacer.gif" width="30"></td>
                <td>
                <br>Login hatasının olas&#305; nedenleri :
                <ul>
                <li>
                    <%=yorum %>
                </li>
                </ul>
              
              
               </td>
              </tr>
               </font>
              <tr> 
                <td><img src="../images/spacer.gif" width="20"></td>
                <td> <font size="5" font = "verdana "color="Indigo"> 
                  <center>
                    <p>&nbsp;</p><p><input type="submit" name="Submit" value="  Ana Sayfaya Dön  ">
                  </p></center>
                  </font> </td>
              </tr>
            </table>
          </form>
		
		
		
		
		
		
		
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
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color:black">Bilgisayar 
      Mühendisliği &copy;2005</font></b></p>
	</div>
	
	
	
	</div>
</body>
</html>
