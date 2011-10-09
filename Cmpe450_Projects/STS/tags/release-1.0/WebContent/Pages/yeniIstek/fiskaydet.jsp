<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="system.*"%>
<%@page import="global.*"%>
<%@page import="java.sql.ResultSet"%>

<%//@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<% 
request.setCharacterEncoding("UTF-8"); 
    //fis onaylandiysa db ye kaydet yoksa kaydet me. 
	boolean ONAYLANDI_MI=false;
	if((request.getParameter("kaydet"))!=null)
		//if((request.getParameter("kaydet")).equals("Kaydet"))  //resul öle yapti --bll
			ONAYLANDI_MI=true;
	
	

%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">

	<div id="toprightt"> </div>
  <div id="topright2">
  <div align="center">
    <table width="79%"  border="0"  id="baslik" class="tablefont">
            <tr>
        <td width="100%" height="56" align=center>T.C.<br>
        <strong>BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</strong><p>
		&nbsp;</td>
      </tr>
    		</table>
	
  </div>
<div align=center>

<table width=79% cellspacing="0" cellpadding="0" height="500" class="tablefont">
<tr>
    <td valign="top">
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
        <form action="../onayBekleyenler/onaybekleyenler.jsp"   method="post">

            <table bgcolor="#FFFFFF" width="100%" border="0" cellspacing="0" cellpadding="0" class="tablefont">
               
              <tr>
                
                <%--if(ONAYLANDI_MI){ %>
                <td align=center width=100%><font size="5" font = "verdana "color="Indigo"><i>
				Fi&#351; onayland&#305;</i> </font></td>
                 <%}else { %>
                   <td align=center width=100%>
					<font size="5" font = "verdana "color="Indigo"><i>&nbsp;Fi&#351; reddedildi</i> </font></td>
                   <%} --%>
                   
                   
              </tr>
       
              <%  
              if(ONAYLANDI_MI){  // FIS ONAYLANDI  --bll
	              IstekParca []istekler=(IstekParca[])session.getAttribute("istekler");
	              
              
              DB db=new DB(true);
              try{
	            
	              db.beginTransaction();    
              
              
	              //burdan sonras&#305; bizim------------------------------
	              //oynad&#305;k
	              String adSoyad=request.getParameter("adi");
	              //String unvani=request.getParameter("unvani");
	              User userInfo = (User)(session.getAttribute("userClass"));
	              String grupNo = userInfo.getgroupID();
	              String userID = userInfo.getUserid();              
		              
	              String piyasa=(String)session.getAttribute("_piyasa");
		           
	              String kalemNo=(String)session.getAttribute("_butceTertibi");
	             
	                           
	              String sayfaKodu="";
	             
	         
	              ResultSet resultGrupType=db.executeSP("GrupGoster_sp",new Object[]{grupNo}).getResult();
	              if(resultGrupType.next()){
	            	  String grupType=resultGrupType.getString("GrupTipi");
	            	  if(grupType.equals("Destek")){
	              
		            	 sayfaKodu="../support/sup1.jsp";
		            	// System.out.println("Support:"+sayfaKodu);
		            	 
		             }
		              else if (grupType.equals("Bolum")){
		            	  sayfaKodu="../bol/sekreter.jsp";
		            	 // System.out.println("Bolum:"+sayfaKodu);
		            	 
		              }
		              else if (grupType.equals("Fakulte")){
		            	  sayfaKodu="../dek/sekreter.jsp";
		            	//  System.out.println("Dekan:"+sayfaKodu);
		            	 
		              }
	              }
	              
	           
	            	  
	              
	            //  System.out.println("Grup kodu:"+grupNo);
	            //  System.out.println("Sayfa kodu:"+sayfaKodu);
	              String IstekFisiKoduIn=(String)session.getAttribute("_NO");
	              String KullaniciNoIn=userID;
		             
	             
	              
	              String istekFisiSayac="";
	              String istekFisiNo = null;
	              
	              ResultSet istekFisiNoRS = db.executeSP("IstekFisiEkle_sp",new Object[]{adSoyad , piyasa , kalemNo ,grupNo,sayfaKodu,IstekFisiKoduIn , KullaniciNoIn }).getResult();
				 
	              
	              if(istekFisiNoRS.next()){           	 	            	
	            	  istekFisiSayac=istekFisiNoRS.getString(1);
	            	  istekFisiNo=istekFisiNoRS.getString(2);
	            	 // System.out.println(" >>>>>> "+istekFisiSayac);   
	            	 // System.out.println(" >>>>>> "+istekFisiNo);   
	              }	              
	              
	              else{ //db mant&#305;kl&#305; bi&#351;ey dönmez se
	            	  out.println("<p><h2>Fis kodu olusturulamadi lutfen tekrar deneyiniz.</h2></p>");
					  db.rollbackTransaction();
					  db.closeConnection();  		             
	              return;	            	  
	              }	  
	              	             	        
	              for(int i=0;i<istekler.length;i++){
	            	  //String istekNo="istekNo";
	            	  String urunNo=(String)istekler[i].urunNo;	            	  
	            	//  System.out.println("fiskaydet-  urunNo:"+urunNo);
	            	  
	            	  String miktar=istekler[i].miktar;
	            	  String tahminiFiyat=istekler[i].birimFiyati;
	            	  String aciklama=istekler[i].aciklama;
	            	  db.executeSP("IstekEkle_sp",new Object[]{istekFisiNo ,urunNo ,miktar ,tahminiFiyat,aciklama});
	
	              }            
	              
	              out.println("<p></p><font size=4>Sat&#305;n alma isteğiniz sisteme kaydedilmi&#351;tir.<br><br> </font><font size=3>Fis Kodu  :<br> '"+istekFisiSayac+"' </font>");
	              
	              db.commitTransaction();
	              db.closeConnection(); //db ile i&#351;miz bitti.
	              
              }catch(Exception e){
            	  e.printStackTrace();
            	  db.rollbackTransaction();
            	  db.closeConnection();
            	  out.println("<p><h2>Hata olu&#351;tu...</h2>");
            	  return;
            	  
            	  
              }
             }     // FIS ONAYLANDI  --bll
             
             else{  // FIS REDDEDILDI (vazgetçti falan) --bll            	 
            	 //bur da ne yapmak gerekiyorsa art&#305;k.                  	 
             }
              
            //session&#305; temizle :  --bll
            session.removeAttribute("_butceTertibi");
            session.removeAttribute("_butceTertibiAlt");
            session.removeAttribute("_NO");
            session.removeAttribute("_piyasa");           
            session.removeAttribute("istekler");
            //session&#305; temizle :            
            	%>
           
              
              <tr> 
                <td> <font size="5" font = "verdana "color="Indigo"> 
                  <center>
                    <p>&nbsp;</p><p><input type="submit" name="Submit" value="Ana Sayfaya Dön">
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
    <td width="100%"><a 
href="../../logout.jsp"><u><font size="-1">Ç&#305;k&#305;&#351;</font></u></a></td>
  </tr>
  
</table>

</div>
</div>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
	</div>
 

			</body>
</html>
