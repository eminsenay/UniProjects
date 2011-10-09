<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="bts.cmpe.budget.businessObj.AppropriationBusinessObj, 
bts.cmpe.budget.transfer.AppropriationTO, 
bts.cmpe.budget.transfer.BudgetTO, 
bts.cmpe.budget.exception.NoSuchBudgetException, 
java.sql.SQLException" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
	<%	
	final string MSG 		= "msg";
	final string ACTION 	= "action";
	final string KURUMSAL	= "kurumsal";
	final string FONKSIYONEL= "fonksiyonel";
	final string EKONOMIK	= "ekonomik";
	
	InputChecker inputChecker = new InputChecker();

	String alertMsg = "";  // uyari mesaji

	String pAction = "view"; // en kotu ihtimal goruntulemeyi deneyelim diye burada tanimli

	String pInst = ""; // kurumsal kod, goruntulenenin veya eklenenin
	String pFunc = ""; // fonksiyonel kod
	String pEco = ""; // ekonomik kod

	String pInst2 = ""; // kurumsal kod, dusulenin
	String pFunc2 = ""; // fonksiyonel kod
	String pEco2 = ""; // ekonomik kod

	String pDesc = ""; // transfer aciklamasi

	String pAmtLira = ""; // transfer miktari lira kismi
	String pAmtKurus = ""; // transfer miktari kurus kismi

	if(request.getSession().getAttribute(MSG) != null) // aktarilan uyari mesajini ekrana bastir
	{
		alertMsg = request.getSession().getAttribute(MSG).toString();
		%><h1><font color="#CC0000"><%=alertMsg %></font></h1><br /><br /><%
	}
	
	if(request.getSession().getAttribute(ACTION) != null)
	{
		pAction = request.getSession().getAttribute(ACTION).toString();

		if(pAction.compareTo("kaydet") != 0 && pAction.compareTo("ekle") != 0 && pAction.compareTo("duzenle") != 0 && pAction.compareTo("onayla") != 0)
		{
			if(request.getSession().getAttribute(KURUMSAL) != null && request.getSession().getAttribute(FONKSIYONEL) != null && request.getSession().getAttribute(EKONOMIK) != null)
			{
				pAction = "view"; // onayla, ekle, duzenle, confirm degilse view olmak zorunda
			}
		}
	}	
	
	if(request.getSession().getAttribute(KURUMSAL) == null || request.getSession().getAttribute(FONKSIYONEL) == null || request.getSession().getAttribute(EKONOMIK) == null)
	{	
		pAction = "view";
		// aşağıdaki hata sayfasına (error.jsp) gidiyor.. burada kullanılmayacak sanırım..
//		if(pAction.compareTo("transfer") != 0)
//		{
//			alertMsg = "Bir defter tanımlanmamış, Bütçe Takip Sistemi bir tanım yapmanızı zorunlu kılıyor.";
//			response.sendRedirect("error.jsp?msg=" + alertMsg);
//		}
	}

	else // defterlerden biri tanimli, o halde okuyalim, okurken kontrol edelim
	{
		pInst = request.getSession().getAttribute(KURUMSAL).toString();
		pFunc = request.getSession().getAttribute(FONKSIYONEL).toString();
		pEco = request.getSession().getAttribute(EKONOMIK).toString();

		if(!inputChecker.checkString(pInst))
		{
			alertMsg = "Kurumsal kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}

		else if(!inputChecker.checkString(pFunc))
		{
			alertMsg = "Fonksiyonel kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}

		else if(!inputChecker.checkString(pEco))
		{
			alertMsg = "Ekonomik kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}
	}

	if(pAction.compareTo("view") == 0)
	{
	%>
<head>
<title>Untitled Document</title>
</head>

<body>
<form id="form1" name="form1" method="get" action="odenekekle.jsp">
  <table width="303" height="143" border="0">
    <tr>
      <td width="101" height="42"><strong>Kurumsal:</strong></td>
      <td width="192"><input type="text" name="kurumsal" /></td>
    </tr>
    <tr>
      <td><strong>Fonksiyonel:</strong></td>
      <td><input type="text" name="fonksiyonel" /></td>
    </tr>
    <tr>
      <td><strong>Ekonomik:</strong></td>
      <td><input type="text" name="ekonomik" /></td>
    </tr>	  
  </table>
  <input type="submit" name="Submit" value="kaydet" />
</form>
</body>
	<%	
	}
	
	else if((pAction.compareTo("kaydet") == 0) || (pAction.compareTo("ekle") == 0) || (pAction.compareTo("duzenle") == 0))
	{
		if(pAction.compareTo("kaydet") == 0) // 1 nolu HTML'deki onaylaya basılmış..
		{
			try
			{
			// 2 nolu HTML sayfası dinamik olarak açılacak.. Sayfanın 3 aylık ya da 6 aylık dönemlerden oluşması alınacak obje parametresine göre belirlenecek..
			// Radio butonları da yakalanacak..
			}
			
			catch(SQLException e) // SQL patladi
			{
				alertMsg = "Veritabanında bir hata oluştu. Lütfen tekrar deneyiniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}

			catch(Exception e) // diger exception
			{
				alertMsg = "İşlem esnasında bir hata oluştu. Lütfen tekrar deneyiniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}
			
		}
		
		else if(pAction.compareTo("ekle") == 0) // 3a nolu HTML sayfasına gider..
		{
			try
			{
%>
<head>
<title>Untitled Document</title>
</head>
<body>
<form id="form1" name="form1" method="get" action="odenekekle.jsp">
  <table width="294" border="1">
    <tr>
      <td width="85"><strong>D&ouml;nem:</strong></td>
      <td width="193" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td><strong>Miktar:</strong></td>
      <td><input type="text" name="textfield" /></td>
    </tr>
    <tr>
      <td><strong>A&ccedil;&#305;klama:</strong></td>
      <td><textarea name="textfield2"></textarea></td>
    </tr>
  </table>
  <input type="submit" name="Submit" value="onayla" />
</form>
</body>
<%
					//dönem yazacak .. "miktar" ve "açıklama" boş gelecek..
			}
			
			catch(NoSuchBudgetException e) // boyle bir butce yok
			{
				alertMsg = "Kodu " + pInst + " : " + pFunc + " : " + pEco + " olan bir defter tanımlı değil. Lütfen kontrol ediniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}

			catch(SQLException e) // SQL patladi
			{
				alertMsg = "Veritabanında bir hata oluştu. Lütfen tekrar deneyiniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}

			catch(Exception e) // diger exception
			{
				alertMsg = "İşlem esnasında bir hata oluştu. Lütfen tekrar deneyiniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}
		}
		
		
		else if(pAction.compareTo("duzenle") == 0) // 3b nolu HTML sayfasına gider..
		{
			try
			{
%>
<head>
<title>Untitled Document</title>
</head>
<body>
<form id="form1" name="form1" method="get" action="odenekekle.jsp">
  <table width="294" border="1">
    <tr>
      <td width="85"><strong>D&ouml;nem:</strong></td>
      <td width="193" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td><strong>Miktar:</strong></td>
      <td><input type="text" name="textfield" /></td>
    </tr>
    <tr>
      <td><strong>A&ccedil;&#305;klama:</strong></td>
      <td><textarea name="textfield2"></textarea></td>
    </tr>
  </table>
  <input type="submit" name="Submit" value="onayla" />
</form>
</body>
<%
					//dönem yazacak .. "miktar" ve "açıklama" dolu gelecek..
			}
			
			catch(NoSuchBudgetException e) // boyle bir butce yok
			{
				alertMsg = "Kodu " + pInst + " : " + pFunc + " : " + pEco + " olan bir defter tanımlı değil. Lütfen kontrol ediniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}

			catch(SQLException e) // SQL patladi
			{
				alertMsg = "Veritabanında bir hata oluştu. Lütfen tekrar deneyiniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}

			catch(Exception e) // diger exception
			{
				alertMsg = "İşlem esnasında bir hata oluştu. Lütfen tekrar deneyiniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}
		}
		
		else if(pAction.compareTo("onayla") == 0)
		{
			try
			{
			// confirm (onayla) sayfası yazılacak.. eklenen ödenek veri tabanına kaydedilecek, düzenlenen ödenek veri tabanında değiştirilecek.
			}

			catch(NoSuchBudgetException e) // boyle bir butce yok
			{
				alertMsg = "Kodu " + pInst + " : " + pFunc + " : " + pEco + " olan bir defter tanımlı değil. Lütfen kontrol ediniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}

			catch(SQLException e) // SQL patladi
			{
				alertMsg = "Veritabanında bir hata oluştu. Lütfen tekrar deneyiniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}

			catch(Exception e) // diger exception
			{
				alertMsg = "İşlem esnasında bir hata oluştu. Lütfen tekrar deneyiniz.";
				response.sendRedirect("error.jsp?msg=" + alertMsg);
			}
		}
			
			
			
%>
		
		
		
		
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
