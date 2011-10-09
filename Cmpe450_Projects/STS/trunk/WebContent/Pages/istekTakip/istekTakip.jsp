<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<%@page import="java.sql.ResultSet"%>


<%//@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

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
  request.setCharacterEncoding("UTF-8"); 
	
   User userInfo = (User)(session.getAttribute("userClass"));
   if(userInfo==null){
	   session.setAttribute("error","İstek takip sayfasına girme hakkınız yok.");
	   response.sendRedirect("../../alerts/GeneralAlert.jsp");
	   return;	   
   }
   
   
   DB db=new DB(true);
   //ResultSet kullaniciFisleriRs=db.executeQuery("call KullaniciIstekFisi_sp('"+userInfo.getUserid()+"')");

   ResultSet kullaniciFisleriRs=db.executeSP("KullaniciIstekTakip_sp",new Object []{userInfo.getUserid()}).getResult();

   final String ACTIVE_COLOR="#CCCCFF";
   final String INACTIVE_COLOR="#FF9FAF";

   int capacity=0;
	if(kullaniciFisleriRs.next()){
		kullaniciFisleriRs.last();
		capacity=kullaniciFisleriRs.getRow();
		kullaniciFisleriRs.beforeFirst();   
	}
	
	//// ya hic istek yoksa 
	boolean istekYok = false;
	if(capacity < 1){
		out.println("Lutfen bir istek seciniz");
		
		istekYok = true;
		
		return;	
	}
   
	
	
	  
	//	 databaseden gelen kalemlerle dolacak
	String[][] kullaniciFisleri=null;
	kullaniciFisleri=new String[capacity][3];
	
	for(int i=0;i<capacity && kullaniciFisleriRs.next();i++)
	{  
		kullaniciFisleri[i][0]=kullaniciFisleriRs.getString("IstekFisiNo");     
		kullaniciFisleri[i][1]=kullaniciFisleriRs.getString("IstekFisiKodu"); 	
		kullaniciFisleri[i][2]=""+kullaniciFisleriRs.getBoolean("Statu"); 	 //true -false
		
	}   		  
   
//  String istekFisiNo = "000015-RFM";
	String istekFisiNo;

	if( request.getParameter("fis") != null ){

		istekFisiNo = request.getParameter("fis");
	}
	else{
//		istekFisiNo = kullaniciFisleri[0][0];
		istekFisiNo = null;
	}
	
  %>
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" 
height="500">
  
  
  
  
  <tr>
        <td width="50" ><img src="../../images/spacer.gif" width="50" 
></td>
	    <td valign="top">
	    	<form action="istekTakip.jsp" method="post">
	    	<select size="1" name="fis">
			<%
			boolean isActive=true;
			
			for(int i=0;i<kullaniciFisleri.length;i++)
			{

				if(istekFisiNo == null || !istekFisiNo.equals(kullaniciFisleri[i][0]) ){	
				%>
				<option value="<%=kullaniciFisleri[i][0]%>"><%=kullaniciFisleri[i][1]%></option>
				<%
				}else{
					if(kullaniciFisleri[i][2].equalsIgnoreCase("false")) //fis silin mis yani --bll
						isActive=false;
				%>
				<option value="<%=kullaniciFisleri[i][0]%>" selected><%=kullaniciFisleri[i][1]%></option>	
				<%
				}

			}%>
			</select>
			<input type="submit" value="Göster">
			</form> <% 
				if(! isActive)			
					out.println("<font color="+INACTIVE_COLOR+" size=3> Fiş İptal Edilmiş <br>  </font>" );	%>
			<%if(istekFisiNo != null){ %>
			İstek Fişi No:&nbsp;&nbsp; <%=istekFisiNo%>
			<%} %>
	    </td>
  </tr> 
  
  
  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" 
width="50" height="350"></td>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>

<%if(istekFisiNo != null){ %>		
<form action="decidePage.jsp" method="post"> 		
<table bgcolor="#FFFFFF" width="420" border="2" bordercolor=<% if(isActive) out.print(ACTIVE_COLOR); else out.print(INACTIVE_COLOR); %> 
cellspacing="0" cellpadding="0" align=left class="tablefont3">

     	  	<tr>
	   				<td colspan="5">
	   				              
                <font size="2">&#304;steğinizin Ge&ccedil;mi&#351;i</font></td>
			</tr>      
  			<tr>
   				<td>
   					<font size="2">Fi&#351; Kodu</font>
   				</td>
   				<td>
   					<font size="2">&#304;&#351;lemi yapan</font>
   				</td>
   				<td>
   					<font size="2">Tarih</font>
   				</td>
   				<td>
   					<font size="2">Onay/Ret</font>
   				</td>
   				<td>
   					<font size="2">A&ccedil;&#305;klama</font>
   				</td>   				
	        </tr>
		        <% 
		        
		        
		        
//		        ResultSet rs = db.executeQuery("call KullaniciIstekFisi_sp('" + userInfo.getUserid() + "')");
				ResultSet rs = db.executeSP("GecmisGoster_sp",new Object []{istekFisiNo}).getResult();	
			
				int resultSetisEmpty = 0;
		        while( rs.next() ){
		        		
		        	
		        %>
				<tr style="FONT-WEIGHT : normal">  
		        	<!--td-->
			        	<% 
			        	 if( !rs.isFirst() ){
			        	%>
	  					<!--input type="radio" name="requestID" value="<%=rs.getString("IstekFisiNo")%>"-->

						<% 
			        	 }
			        	 else{
			        		 resultSetisEmpty = 1;  //buraya aldim çünkü tekrar tekrar gereksiz yere yapmasini istemiyorum
						%>
						<!--input type="radio" name="requestID"  value="<%=rs.getString("IstekFisiNo")%>" checked-->			        	
		        		<% }%>
		        	<!--/td-->
		        	<td style="FONT-WEIGHT : normal">
		        		<%=rs.getString("IstekFisiKodu") %>			        		
		        	</td>
		        	<td style="FONT-WEIGHT : normal">
		        		<%=rs.getString("Ad") %>
		        		&nbsp;&nbsp;			        		
		        		<%=rs.getString("Soyad") %>		        		
		        	</td>
		        	<td style="FONT-WEIGHT : normal">
		        		<%=rs.getString("OlusturmaTarihi") %>			        		
		        	</td>
		        	<td>&nbsp;</td>
		        	<td style="FONT-WEIGHT : normal">
		        		<% String str=rs.getString("Aciklama");
		        		if(str!=null) out.println(str);
		        		else out.println("Açıklama bulunmamaktadır.");
		        		%>			        		
		        	</td>
		        	
		        </tr>
		        <% 
		        }
		        %>
		        	<tr style="FONT-WEIGHT : normal"><td> </td> 
		        		<td> 
		        		
		        		<% 
		        		db.closeConnection();
		        		
		        		if( resultSetisEmpty == 0 ){
		        			out.print("Bu fiş ile ilgili geçmiş bilgisi bulunmamaktadır");
		        		}
		        		else{
		        		%>
							<!--input type="submit" class="tablefont3" value="Detay Göster"-->
						<% 
		        		}
		        		%>
		        		</td>
		        	</tr> 

    </table>		
        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
</form>		
<%}
else{
%>	
	<table bgcolor="#FFFFFF" width="420" border="2" bordercolor=<% if(isActive) out.print(ACTIVE_COLOR); else out.print(INACTIVE_COLOR); %> 
cellspacing="0" cellpadding="0" align=left class="tablefont3">

     	  	<tr>
	   				<td colspan="4">
                <font size="2">L&#252;tfen bir istek se&ccedil;iniz</font></td>
			</tr>      
    </table>	
	
<% 	
}
%>		
		
		
		
</td>
  </tr>
  <tr>
  	<td width="50" ><img src="../../images/spacer.gif" width="50" 
height="50"></td>
    <td width="550"><a 
href="../onayBekleyenler/onaybekleyenler.jsp"><u>&lt&ltGeri D&#246;n</u></a></td>
  </tr>

  
</table>
	</div>
	

	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, 
Helvetica, sans-serif" color=white>Bilgisayar 
      M&#252;hendisliği &copy;2005</font></b></p>
	</div>	
	
	</div>
	
	

</body>
</html>