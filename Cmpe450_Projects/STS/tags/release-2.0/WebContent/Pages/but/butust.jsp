<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>
Boğaziçi Üniversitesi Satın Alma Sistemi
</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>


<body style="font-family: Times New Roman">
<div id="toprightt"> </div>
<div id=topright2>
<div align="center">
<table width="79%" border="0" id="baslik" class="tablefont">
	
	<tr>
		<td width="100%" height="56" align=center>T.C.<br>
		<strong>BO&#286;AZ&#304;&#199;&#304; &Uuml;N&#304;VERS&#304;TES&#304;<br>
		</strong> <strong> B&#252;t&ccedil;e Y&#246;netimi<br>
		Birimlere B&#252;t&ccedil;e Atamas&#305;</strong>
		<p>&nbsp;
		</td>
	</tr>
</table>

</div>

<div align=center>
<form name="formx" action=butust.jsp method="get">
<%
DB db=null;
try{
String status = request.getParameter("i_status");
String UstBirimNo = request.getParameter("i_UstBirimKod");
String BirimNo = request.getParameter("i_BirimKod");
String ButceDagilimNo = request.getParameter("i_ButceDagilimKod");
String eskitutar = request.getParameter("i_eskitutar");
String tutar = request.getParameter("i_tutar");
String message = "";
String error="";
boolean alert=false;
if (status != null) {
	if (status.equals("iptal"))
		response
				.sendRedirect("../onayBekleyenler/onaybekleyenler.jsp");
}

BirimNo = (BirimNo == null) ? "nill" : BirimNo;
UstBirimNo = (UstBirimNo == null) ? "nill" : UstBirimNo;
tutar = (tutar == null) ? "0" : tutar;

db = new DB(true);
ResultSet rsb=db.executeSP("GrupGoster_sp",new Object[]{((User)session.getAttribute("userClass")).getgroupID()}).getResult();
if(rsb.next())
	UstBirimNo=rsb.getString("UstBirimNo");
System.out.println(UstBirimNo);
if (status != null) {
	if (status.equals("add") || status.equals("sub")) {		
		String factor=status.equals("add")?"":"-";
		try{
			ResultSet rsx=db.executeSP("ButceDagilimGuncelle_sp",new Object[] {ButceDagilimNo, Double.valueOf(factor+tutar),Integer.valueOf(1)}).getResult();
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
	if (status.equals("statActivate")|| status.equals("statDisactivate")) {
		int atanmis=status.equals("statActivate")?1:0;
		try{
			ResultSet rsx=db.executeSP("ButceDagilimGuncelle_sp",new Object[] {ButceDagilimNo, Double.valueOf(0),Integer.valueOf(atanmis)}).getResult();
			if(rsx.next())
			{
				String result=rsx.getString("result");
				if(result.equals("1"))
				{
					message="Butce Dagilimi Basari ile "+((atanmis==1)?"Aktiflestirildi.":"Donduruldu.");
				}
				else if(result.equals("0"))
				{
					message="Mevcut Miktar Blokeli Oldugu icin Buce Dagilimi "+((atanmis==1)?"Aktiflestirilemedi.":"Dondurulamadi.");
					alert=true;
				}
				else
				{
					message="Butce Dagilimi Bir Hatadan Dolayi "+((atanmis==1)?"Aktiflestirilemedi.":"Dondurulamadi.");;
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
%>
 <script type="text/javascript" src="../validator.js"></script> 
 <script language=javascript type="text/javascript">
var message="";
function sel_Birim_onchange(sel)
{
    document.formx.i_BirimKod.value=sel.value;
    document.formx.i_status.value="change";
    document.formx.submit();    
}
function badd_onclick(tut,BDNo,atanabilir)
{
    document.formx.i_status.value="add";
    var ttut=document.formx.elements[tut];
    document.formx.i_ButceDagilimKod.value=BDNo;
    document.formx.i_tutar.value=ttut.value;
    if(!validateElement(ttut,true))
        return;
    if(atanabilir<parseYTLtoFloat(ttut.value))
    {
        alert("Atamak istediginiz degeri karsilayacak kadar butceniz yok. Lutfen baska bir butce seciniz...");
    	return;
    }
    document.formx.submit();      
}
function bsub_onclick(tut,BDNo,eskitutar)
{

    document.formx.i_status.value="sub";
    var ttut=document.formx.elements[tut];
    document.formx.i_tutar.value=ttut.value;
	document.formx.i_ButceDagilimKod.value=BDNo;
	if(!validateElement(ttut,true))
        return;
    if(eskitutar<parseYTLtoFloat(ttut.value))
    {
        alert("Yazdiginiz deger Su anki mevcut butceden buyuk, lutfen kucuk bir miktar giriniz...");
    	return;
    }
    document.formx.submit();     
}
function bstatActivate_onclick(BDNo)
{
	var cvp=window.confirm("Bu Butceyi Aktiflestirmek istediginizden Emin misiniz? ");
	if(cvp==false)
		return;
    document.formx.i_ButceDagilimKod.value=BDNo;
    document.formx.i_status.value="statActivate";
    document.formx.submit();  	
}
function bstatDisactivate_onclick(BDNo)
{
	var cvp=window.confirm("Bu Butceyi Dondurmak istediginizden Emin misiniz? ");
	if(cvp==false)
		return;
    document.formx.i_ButceDagilimKod.value=BDNo;
    document.formx.i_status.value="statDisactivate";
    document.formx.submit();  	
}
function tas_onblur(ttut)
{
    message=validateElement(ttut,false);
    document.formx.errmsg.value=message;  
}
function iptal_onclick(){
	document.formx.i_status.value="iptal";
	document.formx.submit(); 
}
</script>
 <input id="i_status" name="i_status" type="hidden"
	value="nill" /> <input id="i_UstBirimKod" name="i_UstBirimKod"
	type="hidden" value="<%=UstBirimNo%>" /> <input id="i_BirimKod"
	name="i_BirimKod" type="hidden" value="<%=BirimNo%>" /> <input
	id="i_ButceDagilimKod" name="i_ButceDagilimKod" type="hidden"
	value="<%=ButceDagilimNo%>" /> <input id="i_eskitutar"
	name="i_eskitutar" type="hidden" value="0" /> <input id="i_tutar"
	name="i_tutar" type="hidden" value="<%=tutar%>" />
<table width="80%" border="1" bordercolor="#CCCCFF" class="tablefont">
	<tr>
		<td align="left">Birim:</td>
		<td align="left"><select id="sel_Birim" name="sel_Birim"
			onchange="sel_Birim_onchange(this)" style="width: 200px">
			<option value="nill">
			L&#252;tfen Bir Birim Se&#231;iniz.
			</option>
			<%ResultSet rs1 = db.executeSP("UstBiriminBirimleriniGoster_sp",
					new Object[] { UstBirimNo }).getResult();
			while (rs1.next()) {
				out.println("<option value='" + rs1.getString("BirimNo") + "'>"
						+ rs1.getString("BirimAdi") + "</option>");
			}

			%>
		</select></td>
	</tr>
</table>

<br>
<table width="100%" border="1" bordercolor="#CCCCFF" class="tablefont">
	<tr>
		<td align="center">B&#252;t&ccedil;e Tipi</td>
		<td align="center">Ana Kalem</td>
		<td align="center">Mevcut B&#252;t&ccedil;e</td>
		<td align="center">Blokeli B&#252;t&ccedil;e</td>
		<td align="center">Atanmam&#305;&#351; B.</td>
		<td align="center">B&#252;t&ccedil;e Ekle/&Ccedil;&#305;kar</td>
		<td align="center">&nbsp;</td>
	</tr>
	<%ResultSet rs2 = db.executeSP("ButceDagilimGoster_sp",
					new Object[] { BirimNo }).getResult();
			boolean stat;
			while (rs2.next()) {
				stat = rs2.getBoolean("ButceAtanmis");

				%>
	<tr style="font-size: 11px ;font-weight: normal;">
		<td align="center"><%=rs2.getString("KurumsalKod")+"-"+rs2.getString("FonksiyonelKodu")%><br><%=rs2.getString("Tanimlama")%></td>
		<td align="center"><%=rs2.getString("AnaKalemKodu")%><br><%=rs2.getString("AnaKalemAdi")%></td>
		<td align="right"><%=rs2.getString("MevcutTutar").replace('.', ',')%></td>
		<td align="right"><%=rs2.getString("BlokeliTutar").replace('.', ',')%></td>
		<td align="right" width="73"><%=rs2.getString("ToplamTutar").replace('.', ',')%></td>
		<td align="left">
			<input id="t<%=rs2.getString("ButceDagilimNo")%>"
				name="t<%=rs2.getString("ButceDagilimNo")%>"
				style="text-align: right;" type="text" size=10 maxlength="15" value="0"
				validator="YTL" onblur="tas_onblur(this)"
				<%if(!stat) out.println("disabled=''");%>> <br>
		<input id="badd1" type="button" value="Ekle "
			name="badd1" style="cursor: hand;"
			onclick="badd_onclick('t<%=rs2.getString("ButceDagilimNo")%>','<%=rs2.getString("ButceDagilimNo")%>',<%=rs2.getString("ToplamTutar")%>)"
			<%if(!stat) out.println("disabled=''");%>> 
		<input id="bsub1" type="button" value="&Ccedil;&#305;kar" name="bsub1"
			style="cursor: hand;"
			onclick="bsub_onclick('t<%=rs2.getString("ButceDagilimNo")%>','<%=rs2.getString("ButceDagilimNo")%>',<%=rs2.getString("MevcutTutar") %>)"
			<%if(!stat) out.println("disabled=''");%> /></td>
		<td align="left"><%if (stat) {

					%> <input id="bstatDisactivate"
			style=" width: 60px; cursor: hand; color: Darkred; text-decoration: underline"
			type="button" value="Dondur" name="bstatDisactivate"
			onclick="bstatDisactivate_onclick('<%=rs2.getString("ButceDagilimNo")%>')" />
		<%} else {

					%> <input id="bstatDisactivate"
			style="width: 60px; cursor: hand; color: Darkblue; text-decoration: underline"
			type="button" value="Aktifle&#351;tir" name="bstatActivate"
			onclick="bstatActivate_onclick('<%=rs2.getString("ButceDagilimNo")%>')" />
		<%}

			%></td>
	</tr>

	<%}%>

</table>
<table width=90%>
	<tr>
		<td><input type=text name="errmsg" value="<%=message %>"
			style="color:red; border-right: font-size:11px; white thin solid; border-top: white thin solid; border-left: white thin solid; border-bottom: white thin solid; width: 100%; font-size: 12px;"
			readonly="" /></td>
	</tr>

	<tr>
		<td align="center"><input id="iptal" style="width: 138px; cursor: hand;"
			type="button" value="Ana Sayfaya D&#246;n" name="iptal" onclick="iptal_onclick()" /></td>




	</tr>

</table>


</form>


</div>
</div>
<script language=javascript>
document.formx.sel_Birim.value=document.formx.i_BirimKod.value;
</script>

<div id="footer2">
<p align="center"><b><font size="-2"
	face="Verdana, Arial, Helvetica, sans-serif color:black"> Bilgisayar
M&#252;hendisliği ©2005</font></b></p>
</div>
</body>
<%
if(alert){
	out.println("<script language=javascript> alert('"+message+"');</script>");
	System.out.println("Pages/butust.jsp: "+message+error);
}
db.closeConnection(); 
%>
<%
}catch(Exception e){
	e.printStackTrace();
	db.closeConnection();
	session.setAttribute("error","butust.jsp : "+e);
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
%>
</html>
