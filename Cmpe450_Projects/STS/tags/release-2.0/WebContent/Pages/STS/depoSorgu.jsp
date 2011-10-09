<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@page import="java.sql.*"%>
<%@page import="system.*"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.ListIterator"%>
<%@ page import="sts.stockFollowUp.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
<script type="text/JavaScript">
<!--
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_validateForm() { //v4.0
  var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='Geçersiz karakter girdiniz. Lütfen bir e-posta adresi giriniz.\n';
      } else if (test!='R') { num = parseFloat(val);
        if (isNaN(val)) errors+='- Geçersiz karakter girdiniz. Lütfen sayı giriniz.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (num<min || max<num) errors+='Geçersiz karakter girdiniz. Lütfen '+min+' ile '+max+' arasında bir sayı giriniz.\n';
    } } } else if (test.charAt(0) == 'R') errors += '- Eksik veri girdiniz.\n'; }
  } if (errors) alert('Hata oluştu:\n'+errors);
  document.MM_returnValue = (errors == '');
}
//-->
</script>
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
    
    <%
ArrayList<String> urunNames = new ArrayList<String>();
ArrayList<String> depNames = new ArrayList<String>();


User userInfo = (User)(session.getAttribute("userClass"));

/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/
boolean GDC = false, DDC =false, RektorYrd = false, DDM = false;

if(userInfo.positionID.endsWith("1G-POS"))
	GDC = true;
if(userInfo.positionID.endsWith("14-POS"))
	DDC = true;
if(userInfo.positionID.endsWith("17-POS"))
	RektorYrd = true;
if (userInfo.positionID.endsWith("15-POS"))
	DDM = true;


if (!GDC && !DDC && !RektorYrd && !DDM) { 
	session.setAttribute("error","Depo Sorgu sayfasına girme hakkınız yok.");
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
}
else {
	StockManagement sm = new StockManagement();
   	urunNames = sm.getUrunNames();
   	depNames = sm.getDepNames();
}

String fromRector = request.getParameter("rektorMu");
  if (fromRector == null)
	  fromRector = "dummy";
%>

		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
		
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><form id="depoSorgu" name="depoSorgu" method="post" action="depoSorguAction.jsp">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <%//ABI BURDA fromRector DE TUTTUGUM SEY BU SAYFAYA REKTORDEN MI GELINMIS  %>
      <%//VE REKTOR NE OLARAK GIRMIS. BOYLE OLMASI MI GEREKIYOR BILMIYORUM AMA SIMDILIK BOYLE YAPTIM %>
        <% if (GDC || fromRector.equals("Genel_Depo")){ %>
        <tr>
         <td width="52%" height="22"><div align="left">Ürün hangi birime verildi:</div>           </td>
        </tr>
        <tr>
          <td><select name="bolumAdi" id="bolumAdi">
            <option value="">Bütün Birimler</option>
            <%ListIterator li = depNames.listIterator();
            String depName;
          	while(li.hasNext()){ 
          		depName = (String)li.next();%>
            <option value="<%=depName%>"> <%=depName%> </option>
            <%
          	} %>
          </select></td>
        </tr>
        
        <%} %>
        <tr>
          <td height="23"><div align="left">Ürün Adı : </div></td>
          </tr>
        <tr>
          <td><select name="urunAdi" id="urunAdi">
              <%ListIterator li = urunNames.listIterator();
              String urunName;
          	  while(li.hasNext()){ 
          	    urunName = (String)li.next();%>
            <option value="<%=urunName%>"> <%=urunName%> </option>
            <%} %>
                    </select></td>
          </tr>
        <tr>
          <td height="24"><div align="left">Satın Alma Tarihi : </div></td>
          </tr>
        <tr>
          <td height="30"><input name="arrFromDay" type="text" id="label1" value="01" size="4" maxlength="2" />
            <input name="arrFromMonth" type="text" id="label2" value="01" size="4" maxlength="2" />
            <input name="arrFromYear" type="text" id="label3" value="1999" size="6" maxlength="4" />
            ile
            <input name="arrToDay" type="text" id="label4" value="01" size="4" maxlength="2" />
            <input name="arrToMonth" type="text" id="label5" value="01" size="4" maxlength="2" />
            <input name="arrToYear" type="text" id="label6" value="2006" size="6" maxlength="4" />
            tarihleri arasında </td>
          </tr>
        <tr>
          <td height="22"><div align="left">Depodan Çıkış Tarihi : </div></td>
          </tr>
        <tr>
          <td height="30"><input name="depFromDay" type="text" id="label7" value="01" size="4" maxlength="2" />
            <input name="depFromMonth" type="text" id="label8" value="01" size="4" maxlength="2" />
            <input name="depFromYear" type="text" id="label9" value="1999" size="6" maxlength="4" />
            ile
            <input name="depToDay" type="text" id="label10" value="01" size="4" maxlength="2" />
            <input name="depToMonth" type="text" id="label11" value="01" size="4" maxlength="2" />
            <input name="depToYear" type="text" id="label12" value="2006" size="6" maxlength="4" />
tarihleri arasında </td>
          </tr>
        <tr>
          <td colspan="2"><div align="center">
            <input type="hidden" name="rektorMu" id="rektorMu" value=<%=fromRector%>>
            </input>
            <input name="Listele" type="submit" id="Listele" onclick="MM_validateForm('label1','','RinRange1:31','label2','','RinRange1:12','label3','','RisNum','label4','','RinRange1:31','label5','','RinRange1:12','label6','','RisNum','label7','','RinRange1:31','label8','','RinRange1:12','label9','','RisNum','label10','','RinRange1:31','label11','','RinRange1:12','label12','','RisNum');return document.MM_returnValue" value="Listele" />
          </div></td>
          </tr>
      </table>
        </form>
    </td>
  </tr>
</table>
				

        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
		
		
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




