<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

  <% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
Boğaziçi Üniversitesi Satın Alma Sistemi
</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>




<body>
<div id="toprightt"> </div>
<div id="topright2">

<div align="center">
<table width="79%" border="0" id="baslik" class="tablefont">
	
	<tr>
		<td width="100%" height="56" align=center>T.C.<br>
		<strong>BO&#286;AZ&#304;&#199;&#304; &Uuml;N&#304;VERS&#304;TES&#304;<br>
		</strong> <strong> B&#252;t&ccedil;e Yönetimi <br>
		Fak&#252;ltelere Da&#287;&#305;t&#305;lm&#305;&#351; Mevcut B&#252;t&ccedil;eler</strong>
		<p>&nbsp;
		</td>
	</tr>
</table>

</div>
<div align=center>
<form name="formx" action=butbds.jsp method="post">
<%
DB db=null;
try{
String status = request.getParameter("i_status");
String UstBirimNo = request.getParameter("i_UstBirimKod");
String UBBDNo = request.getParameter("i_UBBDNo");
String tutar = request.getParameter("i_tutar");
String message = "";
String error="";
boolean alert=false;
if (status != null) {
	if (status.equals("iptal"))
		response.sendRedirect("../onayBekleyenler/onaybekleyenler.jsp");
	if (status.equals("yeni"))
		response.sendRedirect("butbd.jsp?i_status=yeni&i_UstBirimKod="+UstBirimNo);
}

db = new DB(true);
if (status != null) {
	if (status.equals("add") || status.equals("sub")) {		
		String factor=status.equals("add")?"":"-";
		try{
			ResultSet rsx=db.executeSP("UstBirimButceDagilimGuncelle_sp",new Object[] {UBBDNo, Double.valueOf(factor+tutar) }).getResult();
			if(rsx.next())
			{
				String result=rsx.getString("result");
				if(result.equals("1"))
				{
					message="Butce Dagilimi Basari ile Guncellendi.";
				}
				else if(result.equals("0"))
				{
					message="Mevcut Miktar Yetersiz Oldugu icin Buce Dagilimi Guncellenemedi.";
					alert=true;
				}
				else
				{
					message="Butce Dagilimi Guncellemesi Bir Hatadan Dolayi Yapilamadi.";
					error="Hata Kodu: "+result+" (Unidentified).";					
					alert=true;		
				}								
			}
			else
			{
				message="Butce Dagilimi Guncellemesi Bir Hatadan Dolayi Yapilamadi.";
				error="Hata Kodu: Serverdan Yanit Yok.";
				alert=true;		
			}
		}catch(Exception exc)
		{
			exc.printStackTrace(System.out);			
			message="Butce Dagilimi Guncellenemedi. Bir Hata Oluştu.";
			error="Hata Kodu: Exception.";
			alert=true;				
		}
	}
	
	if (status.equals("sil")) {
		try{
			ResultSet rsx=db.executeSP("UstBirimButceDagilimStatuDegistir_sp",new Object[] { UBBDNo, Integer.valueOf(0)}).getResult();
			if(rsx.next())
			{
				String result=rsx.getString("result");
				if(result.equals("1"))
				{
					message="Butce Dagilimi Basari ile Silindi.";
				}
				else if(result.equals("0"))
				{
					message="Bu Dagilima Ait blokeli Fisler Oldugu icin Butce Dagilimi Silinemedi.";
					alert=true;
				}
				else
				{
					message="Butce Dagilimi Silinmesi Bir Hatadan Dolayi Yapilamadi.";
					error="Hata Kodu: "+result+" (Unidentified).";					
					alert=true;		
				}								
			}
			else
			{
				message="Butce Dagilimi Silinmesi Bir Hatadan Dolayi Yapilamadi.";
				error="Hata Kodu: Serverdan Yanit Yok.";
				alert=true;		
			}
		}catch(Exception exc)
		{
			exc.printStackTrace(System.out);			
			message="Butce Dagilimi Silinemedi. Bir Hata Oluştu.";
			error="Hata Kodu: Exception.";
			alert=true;				
		}
	}
	if (status.equals("statActivate")|| status.equals("statDisactivate")) {
		int atanmis=status.equals("statActivate")?1:2;
		try{
			ResultSet rsx=db.executeSP("UstBirimButceDagilimStatuDegistir_sp",new Object[] {UBBDNo,Integer.valueOf(atanmis)}).getResult();
			if(rsx.next())
			{
				String result=rsx.getString("result");
				if(result.equals("1"))
				{
					message="Ust Birim Butce Dagilimi Basari ile "+((atanmis==1)?"Aktiflestirildi.":"Donduruldu.");
				}
				else if(result.equals("0"))
				{
					message="Mevcut Miktar Blokeli Oldugu icin Buce Dagilimi "+((atanmis==1)?"Aktiflestirilemedi.":"Dondurulamadi.");
					alert=true;
				}
				else
				{
					message="Ust Birim Butce Dagilimi Bir Hatadan Dolayi "+((atanmis==1)?"Aktiflestirilemedi.":"Dondurulamadi.");;
					error="Hata Kodu: "+result+" (Unidentified).";					
					alert=true;		
				}								
			}
			else
			{
				message="Butce Dagilimi Bir Hatadan Dolayi "+((atanmis==1)?"Aktiflestirilemedi.":"Dondurulamadi.");;
				error="Hata Kodu: Serverdan Yanit Yok.";
				alert=true;		
			}
		}catch(Exception exc)
		{
			exc.printStackTrace(System.out);			
			message="Butce Dagilimi "+((atanmis==1)?"Aktiflestirilemedi.":"Dondurulamadi.")+". Bir Hata Oluştu.";
			error="Hata Kodu: Exception.";
			alert=true;				
		}			
	}
}
UstBirimNo=(UstBirimNo==null)?"nill":UstBirimNo;
%>
<script language=javascript src="../validator.js"></script> 
<script	language=javascript>
var message="";
function sel_UstBirim_onchange(sel)
{
    document.formx.i_UstBirimKod.value=sel.value;
    document.formx.i_status.value="change";
    document.formx.submit();    
}
function badd_onclick(tut,UBBDNo,eskitutar)
{    
    var ttut=document.formx.elements[tut]; 
    if(!validateElement(ttut,true))
        return;
    document.formx.i_status.value="add";
    document.formx.i_tutar.value=parseYTLtoFloat(ttut.value);
    document.formx.i_UBBDNo.value=UBBDNo;
    document.formx.submit();      
}
function bsub_onclick(tut,UBBDNo,eskitutar)
{
    document.formx.i_status.value="sub";
    var ttut=document.formx.elements[tut];
    document.formx.i_tutar.value=ttut.value;
    document.formx.i_UBBDNo.value=UBBDNo;
    if(!validateElement(ttut,true))
        return;
         
    if(eskitutar<parseYTLtoFloat(ttut.value))
    {
        alert("Yazd&#305;&#287;&#305;n&#305;zn&#305;z de&#287;er &#351;u anki mevcut bÃ¼tÃ§eden bÃ¼yÃ¼k, lÃ¼tfen kÃ¼Ã§Ã¼k bir miktar giriniz...");
        ttut.select();
        ttut.focus();
        return;
    }
    document.formx.submit();     
}
function bdel_onclick(UBBDNo)
{
	var cvp=window.confirm("Bu Butceyi Silmek &#304;stedi&#287;inizden Emin misiniz? ");
	if(cvp==false)
		return;
	document.formx.i_status.value="sil";
	document.formx.i_UBBDNo.value=UBBDNo;
	document.formx.submit(); 
}
function bstatActivate_onclick(UBBDNo)
{
	var cvp=window.confirm("Bu Butceyi Aktiflestirmek istediginizden Emin misiniz? ");
	if(cvp==false)
		return;
    document.formx.i_UBBDNo.value=UBBDNo;
    document.formx.i_status.value="statActivate";
    document.formx.submit();  	
}
function bstatDisactivate_onclick(UBBDNo)
{
	var cvp=window.confirm("Bu Butceyi Dondurmak istediginizden Emin misiniz? ");
	if(cvp==false)
		return;
    document.formx.i_UBBDNo.value=UBBDNo;
    document.formx.i_status.value="statDisactivate";
    document.formx.submit();  	
}
function tas_onblur(ttut)
{
    message=validateElement(ttut,false);
    document.formx.errmsg.value=message;  
}
function yeni_onclick(){
	document.formx.i_status.value="yeni";
	document.formx.submit(); 
}
function iptal_onclick(){
	document.formx.i_status.value="iptal";
	document.formx.submit(); 
}
</script>
<input id="i_status" name="i_status" type="hidden"
	value="nill" /> <input id="i_UstBirimKod" name="i_UstBirimKod"
	type="hidden" value="<%=UstBirimNo%>" /> <input id="i_UBBDNo"
	name="i_UBBDNo" type="hidden" value="nill" /> <input id="i_eskitutar"
	name="i_eskitutar" type="hidden" value="" /> <input id="i_tutar"
	name="i_tutar" type="hidden" value="" />
<table width="80%" border="1" bordercolor="#CCCCFF" class="tablefont">
	<tr>
		<td align="left">Fakülte (Üst Birim):</td>
		<td align="left"><select id="sel_UstBirim" name="sel_UstBirim"
			onchange="sel_UstBirim_onchange(this)" style="width: 263px">
			<option value="nill">
			L&#252;tfen Bir Fak&#252;lte Se&ccedil;iniz.
			</option>
			<%ResultSet rs1 = db.executeSP("UstBirimleriGoster_sp",
					new Object[] { null }).getResult();
			while (rs1.next()) {
				out.println("<option value='" + rs1.getString("UstBirimNo")
						+ "'>" + rs1.getString("UstBirimAdi") + "</option>");
			}

			%>
		</select></td>
	</tr>
</table>
<br>
<table width="100%" border="1" bordercolor="#CCCCFF" class="tablefont">
	<tr align="center">
		<td>B&#252;t&ccedil;e Tipi</td>
		<td>Ana Kalem</td>
		<td>Mevcut B&#252;t&ccedil;e</td>
		<td>Blokeli B&#252;t&ccedil;e</td>
		<td>B&#252;t&ccedil;e <br>Ekle/&Ccedil;&#305;kar</td>
		<td></td>


	</tr>

	<%ResultSet res2 = db.executeSP("UstBirimButceDagilimGoster_sp",new Object[] { UstBirimNo }).getResult();
		boolean stat=false;
		while (res2.next()) {
		stat=res2.getBoolean("Statu");
		%>
	<tr style="font-size: 11px ;font-weight: normal;">
		<td align="center"><%=res2.getString("KurumsalKod") + "-"
						+ res2.getString("FonksiyonelKodu")%>
		<br>
		<%=res2.getString("Tanimlama")%></td>
		<td align=center><%=res2.getString("AnaKalemKodu") + "<br>"
						+ res2.getString("AnaKalemAdi")%></td>
		<td align=right><%=res2.getString("ToplamButce").replace('.', ',')%></td>
		<td align="center">0</td>
		<td align="center">
			<input size=10
				id="t<%=res2.getString("UstBirimButceDagilimNo")%>"
				name="t<%=res2.getString("UstBirimButceDagilimNo")%>"
				style="text-align: right; margin: 0px;" type="text" maxlength="15" value="0"
				validator="YTL" onblur="tas_onblur(this)" <%if(!stat) out.println("disabled=''");%> />
			<br>		 
			<input id="badd<%=res2.getString("UstBirimButceDagilimNo") %>" type="button"
				value=" Ekle " name="badd1" size=10
				onclick="badd_onclick('t<%=res2.getString("UstBirimButceDagilimNo")%>','<%=res2.getString("UstBirimButceDagilimNo")%>',<%=res2.getString("ToplamButce") %>)"
				style="cursor: hand;font-size: 11px;margin: 0px;" <%if(!stat) out.println("disabled=''");%>/> 
			<input id="bsub<%=res2.getString("UstBirimButceDagilimNo") %>" type="button"
				value="Ã‡&#305;kar" name="bsub1" size=10
				onclick="bsub_onclick('t<%=res2.getString("UstBirimButceDagilimNo")%>','<%=res2.getString("UstBirimButceDagilimNo")%>',<%=res2.getString("ToplamButce") %>)"
				style="cursor: hand;font-size: 11px;margin: 0px;" <%if(!stat) out.println("disabled=''");%>/>
		</td>
		<td align="left"><%if (stat) {

					%> <input id="bstatDisactivate"
			style=" width: 60px; cursor: hand; color: Darkred; text-decoration: underline"
			type="button" value="Dondur" name="bstatDisactivate"
			onclick="bstatDisactivate_onclick('<%=res2.getString("UstBirimButceDagilimNo")%>')" />
		<%} else {

					%> <input id="bstatDisactivate"
			style="width: 60px; cursor: hand; color: Darkblue; text-decoration: underline"
			type="button" value="Aktifle&#351;tir" name="bstatActivate"
			onclick="bstatActivate_onclick('<%=res2.getString("UstBirimButceDagilimNo")%>')" />
		<%}

			%></td>
		<td align="center"><input id="bdel1"
			style="width:60px; font-size: 11px; color: red; cursor: hand; text-decoration: underline"
			type="button" value="B&#252;t&ccedil;eyi Sil" name="bdel1"
			onclick="bdel_onclick('<%=res2.getString("UstBirimButceDagilimNo")%>')" /></td>


	</tr>
	<%}%>
</table>
<table width=79%>
	<tr>
		<td><input type=text name="errmsg" value="<%=message %>"
			style="color:red; border-right: white thin solid; border-top: white thin solid; border-left: white thin solid; border-bottom: white thin solid; width: 100%; font-size: 12px;"
			readonly="" /></td>
	</tr>

	<tr>
		<td>
		<p align="center"><input id="yeni" style="cursor: hand;"
			type="button" value="Yeni B&#252;t&ccedil;e Da&#287;&#305;l&#305;m&#305; Gir"
			name="yeni" onclick="yeni_onclick()"> <input id="iptal"
			style="cursor: hand;" type="button"
			value="Ana Sayfaya Dön" name="iptal" onclick="iptal_onclick()" />
		</td>




	</tr>

</table>


</form>


</div>




</div>












<script language=javascript>
document.formx.sel_UstBirim.value=document.formx.i_UstBirimKod.value;
</script>

<div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif" color="white"> Bilgisayar
Mühendisligi ©2005</font></b></p>
</div>

</body>
<%
if(alert){
	out.println("<script language=javascript> alert('"+message+"');</script>");
	System.out.println("Pages/butbds.jsp: "+message+error);
}
db.closeConnection(); 
%>
<%
}catch(Exception e){
	e.printStackTrace();
	db.closeConnection();
	session.setAttribute("error","butbds.jsp : "+e);
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
%>
</html>
