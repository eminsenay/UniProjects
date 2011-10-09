<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>



<%@page import="java.sql.*"%>

<%@page import="system.*"%>

<%@page import="java.util.Calendar"%>

<%@page import="java.sql.Date"%>

<%@page import="java.util.ArrayList"%>

<%@page import="java.util.ListIterator"%>

<%@page import="sts.stockFollowUp.*"%>







<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/css/gui.css" rel="stylesheet" type="text/css">
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

        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';

      } else if (test!='R') { num = parseFloat(val);

        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';

        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');

          min=test.substring(8,p); max=test.substring(p+1);

          if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';

    } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }

  } if (errors) alert('The following error(s) occurred:\n'+errors);

  document.MM_returnValue = (errors == '');

}

//-->

</script>

</head>

<%
	String fromRector = request.getParameter("rektorMu");
	if (fromRector == null)
		fromRector = "dummy";

	String fromDean = request.getParameter("dekanMi");
	if (fromDean == null)
		fromDean = "dummy";
%>



<body bgcolor="#FFFFFF">

<div align="left"> <div id="toprightt"> </div> <div id="topright2">
<table border="0" cellspacing="0" cellpadding="0" width="600">
	<tr>
		<td width="50"><img src="../../images/spacer.gif"width="50"></td>
		<td valign="top">
		<%
			ArrayList<String> urunNames = new ArrayList<String>();

			ArrayList<String> groupNoAndGroupNames = new ArrayList<String>();

			ArrayList<String> urunIDs = new ArrayList<String>();

			ArrayList<String> groups = new ArrayList<String>();

			//calistir

			//System.out.println("user classi onces");

			User userInfo = (User) (session.getAttribute("userClass"));

			/*Pozisyon Kodlarindan Giris Yapmis Kullaniciyi Incele*/

			boolean GDC = false, DDC = false, RektorYrd = false, DDM = false, dean = false;

			//System.out.println("user class sonrasi");

			if (userInfo.positionID.equals("00000F-POS")) {
				GDC = true;
			} else if (userInfo.positionID.equals("000004-POS")
					|| userInfo.positionID.equals("000007-POS")) {
				DDC = true;
			} else if (userInfo.positionID.equals("00000I-POS")) {
				RektorYrd = true;
			} else if (userInfo.positionID.equals("000003-POS")) {
				DDM = true;
			} else if (userInfo.positionID.equals("000005-POS")) {
				dean = true;
			}

			StockManagement sm = new StockManagement();

			if (!GDC && !DDC && !RektorYrd && !DDM && !dean) {

				session.setAttribute("error",
				"Depo Sorgu sayfasına girme hakkınız yok.");

				response.sendRedirect("../../alerts/GeneralAlert.jsp");

			}

			else {

				urunNames = sm.getUrunNames();
				//  	groups = sm.getGroups();
				groupNoAndGroupNames = sm.getGroupNoAndGroupNames();
				urunIDs = sm.getUrunIDs();

			}
		%> <%
 //-----------------------------------------------------
 %> <%
 //DYNAMIC PAGE HERE BELOW!!!!
 %>
		<table width="100%" border="0">

			<tr>

				<td>
				<form id="depoSorgu" name="depoSorgu" method="post"
					action="depoSorguAction.jsp">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">

					<%
					//ABI BURDA fromRector DE TUTTUGUM SEY BU SAYFAYA REKTORDEN MI GELINMIS
					%>

					<%
					//VE REKTOR NE OLARAK GIRMIS. BOYLE OLMASI MI GEREKIYOR BILMIYORUM AMA SIMDILIK BOYLE YAPTIM
					%>

					<%
					if (GDC || fromRector.equals("Genel_Depo")) {
					%>
					<tr>
						<td width="52%" height="22" class="generalFormCell"><div align="left">Ürün
						hangi birime verildi:</div></td>
					</tr>
					<tr>
						<td class="generalFormCell_Input">
							<select name="bolumID" id="generalFormTextBox" class="generalComboBox">
							<option value="-111111111">Bütün Birimler</option>
							<%
									ListIterator li = groupNoAndGroupNames.listIterator();

									//ListIterator li1 = groups.listIterator();

									String depName;

									String grupNo;

									//System.out.println("CARE " + fromRector);

									while (li.hasNext()) {	

										grupNo = (String)li.next();//(String)li1.next();

										depName = (String) li.next();										

										//System.out.println(grupNo);
							%>
							<option value="<%=grupNo%>"> <%=depName%> </option>
							<%
							}
							%>
						</select></td>
					</tr>
					<%
					}
					%>

					<tr>
						<td height="23" class="generalFormCell"><div align="left">Ürün Adı : </div></td>
					</tr>
					<tr>
						<td class="generalFormCell_Input">
							<select name="urunID" id="generalFormTextBox" class="generalComboBox">
							<option value="-111111111">Bütün Ürünler</option>

							<%
								ListIterator li = urunNames.listIterator();
								ListIterator li1 = urunIDs.listIterator();
								String urunName;
								String urunID;
								while (li.hasNext()) {
									urunName = (String) li.next();
									urunID = (String) li1.next();
							%>

							<option value="<%=urunID%>"> <%=urunName%> </option>

							<%
							}
							%>

						</select></td>

					</tr>

					<tr>

						<td height="24" class="generalFormCell"><div align="left">Satın Alma Tarihi : </div></td>

					</tr>

					<tr>

						<td height="30" class="generalFormCell_Input">
							<input name="arrFromDay" type="text" id="label1" value="01" size="4" maxlength="2" /> 
							<input name="arrFromMonth" type="text" id="label2" value="01" size="4" maxlength="2" />
							<input name="arrFromYear" type="text"
							id="label3" value="1990" size="6" maxlength="4" /> 
							 ile
							<input
							name="arrToDay" type="text" id="label4" value="01" size="4"
							maxlength="2" /> 
							<input name="arrToMonth" type="text"
							id="label5" value="01" size="4" maxlength="2" />
							<input
							name="arrToYear" type="text" id="label6" value="2010" size="6"
							maxlength="4" />
							 tarihleri arasında
						</td>

					</tr>
					<tr>

						<td height="22" class="generalFormCell"><div align="left">Depodan Çıkış Tarihi
						: </div></td>

					</tr>
					<tr>
						<td height="30" class="generalFormCell_Input"><input name="depFromDay" type="text"
							id="label7" size="4" maxlength="2" /> <input name="depFromMonth"
							type="text" id="label8" size="4" maxlength="2" /> <input
							name="depFromYear" type="text" id="label9" size="6" maxlength="4" />

						ile <input name="depToDay" type="text" id="label10" size="4"
							maxlength="2" /> <input name="depToMonth" type="text"
							id="label11" size="4" maxlength="2" /> <input name="depToYear"
							type="text" id="label12" size="6" maxlength="4" /> tarihleri
						arasında</td>
					</tr>
					<tr>
						<td colspan="2" class="generalFormCell_Input">
							<div align="center">
								<input type="hidden" name="rektorMu" id="rektorMu" value=<%=fromRector %>></input> 
								<input type="hidden" name="dekanMi" id="dekanMi" value=<%=fromDean%>></input> 
								<input name="Listele" type="image" id="Listele"
									onclick="MM_validateForm('label1','','RinRange1:31','label2','','RinRange1:12','label3','','RisNum','label4','','RinRange1:31','label5','','RinRange1:12','label6','','RisNum');return document.MM_returnValue"
									value="Listele" src="../../index/images/listele.jpg" tabindex="8"/>
							</div>
						</td>						
					</tr>
					<tr><td colspan="2" class="generalFormCell">&nbsp;</td></tr>
				</table>
				</form>
				</td>
			</tr>
		</table>
		<%
		//DYNAMIC PAGE HERE ABOVE!!!!
		%> <%
 //-----------------------------------------------------
 %>
		</td>
	</tr>
</table>

</div> <div id="footer2">

<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black">Bilgisayar

Mühendisliği &copy;2006</font></b></p>

</div> </div>

</body>

</html>

