<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="system.*"%>
<%@page import="global.*"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
	
  <div id="topright"> 
  <table border="0" cellspacing="0" cellpadding="0" width="650" height="516" class=tablefont3>
  <tr>
    <td width="50" height="170"><img src="../images/spacer.gif" width="50" height="170"></td>
    <td width="600" height="170"><img src="../images/spacer.gif" width="600" height="170"></td>
  </tr>
  <tr>
        <td width="50" height="346"><img src="../images/spacer.gif" width="50" height="346"></td>
    <td valign="top">

<form METHOD=POST ACTION="sifredegistir.jsp" target="_self">

<table width="300" border="0" cellspacing="0" cellpadding="0">

		<%
		//Get user class from session
		User userInfo = (User)(session.getAttribute("userClass"));
		if (userInfo == null)
		{
			out.println("Şifrenizi değiştirmek için lütfen önce giriş yapınız.");
		}
		else
		{
		
		//Create database object
		DB db=new DB(true);
		
		//Check whether the form calls itself
		if(request.getParameter("oldpassword1")!= null) {
			//get the oldpassword1
			String oldp1=request.getParameter("oldpassword1");
			//get the oldpassword2
		//	String oldp2=request.getParameter("oldpassword2");
			
			//Get user id from user class in the session
			String userID = userInfo.getUserid();
			
			//Get user password from the database
			try{
	            //Start the database transaction
	            //db.beginTransaction(); 
	            
				//Execute the stored procedure to change password
				ResultSet userPsw=db.executeSP("KullaniciGoster_sp",new Object []{userID}).getResult();
              	String userPassword="";
				if(userPsw.next()){
					userPassword=userPsw.getString("KullaniciSifresi");
          		}
				//out.println("userpassword:"+userPassword);
				
	            //db.closeConnection(); //db ile işmiz bitti.
			
			
				//Check whether the two passwords do not match
								
			//	else //Check whether the entered old password is real password
				if (!userPassword.equals(oldp1)) {%>
						<tr><td><img src="../images/spacer.gif" width="30"></td>
		        		<td><b><font size="-1" face="Verdana, Arial, Helvetica, sans-serif color:black">Girdi&#287;iniz eski &#351;ifre ile sisteme kay&#305;tl&#305; &#351;ifreniz birbirini tutmamaktad&#305;r. <br>Bu nedenle &#351;ifre de&#287;i&#351;tirme i&#351;lemini gerçekle&#351;tiremiyoruz. </font></b></td>
		        
		      			</tr>
				<%}
				//else if the passwords are same
				else{
					//Get new password from the form
					String newPass1=request.getParameter("newpassword1");
					String newPass2=request.getParameter("newpassword2");
					if(!newPass1.equals(newPass2)){
						%>
							<tr><td><img src="../images/spacer.gif" width="30"></td>
				        	<td><b><font size="-1" face="Verdana, Arial, Helvetica, sans-serif color:black">Girdi&#287;iniz yeni &#351;ifreler birbirini tutmamaktad&#305;r. <br>Bu nedenle &#351;ifre de&#287;i&#351;tirme i&#351;lemini gerçekle&#351;tiremiyoruz. </font></b></td>
				        
				      		</tr>
						<%}
					else{
		            //Start the database transaction
		            db.beginTransaction(); 
		            
					//Execute the stored procedure to change password
					ResultSet passChange=db.executeSP("KullaniciSifreGuncelle_sp",new Object []{userID,newPass1}).getResult();
	              
					//Commit the database transaction
					db.commitTransaction();
					%>
					<tr><td><img src="../images/spacer.gif" width="30"></td>
				    <td><b><font size="-1" face="Verdana, Arial, Helvetica, sans-serif color:black">&#350;ifreniz ba&#351;ar&#305;yla de&#287;i&#351;tirilmi&#351;tir.</font></b></td>
				        
				    </tr>
					<% 
					}
				}
				
				//close connection
				db.closeConnection();
				
			}catch(Exception e){
      	  		e.printStackTrace();
      	  		db.rollbackTransaction();
      	  		
      	  		out.println("<p><h2>Hata oluştu...</h2>");
      	  		return;
        	}
		}
		else {%>
		
      <tr><td><img src="../images/spacer.gif" width="30"></td>
        <td><b><font size="-1" face="Verdana, Arial, Helvetica, sans-serif color:black">Eski &#350;ifre: </font></b></td>
        <td><input name="oldpassword1" type="password" size="20"></td>
      </tr>
      
      <tr><td><img src="../images/spacer.gif" width="30"></td>
          <td><b><font size="-1" face="Verdana, Arial, Helvetica, sans-serif color="black">Yeni &#350;ifre: 
            </font></b></td>
        <td><input name="newpassword1" type="password" size="22"></td>
      </tr>
       <tr><td><img src="../images/spacer.gif" width="30"></td>
          <td><b><font size="-1" face="Verdana, Arial, Helvetica, sans-serif color="black">Yeni &#350;ifre Tekrar: 
            </font></b></td>
        <td><input name="newpassword2" type="password" size="22"></td>
      </tr>
	        <tr><td><img src="../images/spacer.gif" width="30"></td>
          <td></td>
          <td><input type="submit" value="&#350;ifre de&#287;i&#351;tir">
          </form>
          <% }
		} %>
          </td>
      </tr>
    </table></td>
  </tr>
</table>
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar 
      Mühendisligi &copy;2005</font></b></p>
	</div>
	
	
	</div>
        
       </body>
</html>
