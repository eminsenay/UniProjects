<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

  <% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>









<body>
<div id="toprightt"> </div>
<div id="topright2">

<div align="center">
    <table width="79%"  border="0"  id="baslik" class="tablefont">
            <tr>
        <td width="100%" height="56" align=center>T.C.<br>
        <strong>BO&#286;AZ&#304;&#199;&#304; &Uuml;N&#304;VERS&#304;TES&#304;<br></strong>

    <strong>
        B&#252;t&ccedil;e Yönetimi
        <br> 
        Fak&#252;ltelere
        B&#252;t&ccedil;e Atanmas&#305;</strong><p>&nbsp;</td>
      </tr>
    		</table>
	
  </div>
<div align=center>
<form name="formx" action=butbd.jsp method="post">
<%
DB db=null;
try{
String status=request.getParameter("i_status");
String UstBirimNo=request.getParameter("i_UstBirimKod");
String UBBNo=request.getParameter("i_UBBNo");
String AnaKalem=request.getParameter("i_AnaKalem");
String tutar=request.getParameter("i_tutar");
String exp=request.getParameter("i_exp");
String message="";
String error="";
if(status!=null)
	if(status.equals("iptal"))
		response.sendRedirect("butbds.jsp?i_status=change&i_UstBirimKod="+UstBirimNo);
db=new DB(true);
boolean alert=false;
if(status!=null){
	if(status.equals("onayla"))	
	{
		try{
			ResultSet rsx=db.executeSP("UstBirimButceDagilimaEkle_sp",new Object[]{UBBNo,AnaKalem,Double.valueOf(tutar)}).getResult();
			if(rsx.next())
			{
				String result=rsx.getString("result");
				if(result.equals("1"))
				{
					db.closeConnection();
					response.sendRedirect("butbds.jsp?i_status=change&message=Butce Dagilimi Basari ile Gerceklestirildi.&i_UstBirimKod="+UstBirimNo);
					return;
				}
				else if(result.equals("0"))
				{
					message="Bu Ust Birime Onceden Boyle Bir Butce Dagilimi Yapilmis.";
					alert=true;
				}
				else
				{
					message="Butce Dagilimi Bir Hatadan Dolayi Yapilamadi.";
					error="Hata Kodu: "+result+" (Unidentified).";					
					alert=true;		
				}								
			}
			else
			{
				message="Butce Dagilimi Bir Hatadan Dolayi Yapilamadi.";
				error="Hata Kodu: Serverdan Yanit Yok.";
				alert=true;		
			}
		}catch(Exception exc)
		{
			exc.printStackTrace(System.out);			
			message="Butce Dagilimi Yapilamadi. Bir Hata Oluştu.";
			error="Hata Kodu: Exception.";
			alert=true;				
		}
	}
}
UstBirimNo=(UstBirimNo==null)?"nill":UstBirimNo;
UBBNo=(UBBNo==null)?"nill":UBBNo;
AnaKalem=(AnaKalem==null)?"nill":AnaKalem;
tutar=(tutar==null)?"0":tutar;
exp=(exp==null)?"":exp;
%>
<script language=javascript src="../validator.js"></script>
<script language=javascript>
function sel_UstBirim_onchange(sel)
{
    document.formx.i_UstBirimKod.value=sel.value;
    document.formx.i_status.value="change";
    document.formx.sel_UBB.disabled=false;
    document.formx.i_UBBNo.value="nill";
    document.formx.submit();    
}

function sel_AnaKalem_onchange(sel)
{
    document.formx.i_AnaKalem.value=sel.value;    
}
function t1_onblur(t)
{ 
    message=validateElement(t,false);
    document.formx.i_tutar.value=parseYTLtoFloat(t.value);
    document.formx.errmsg.value=message; 
}
function onayla_onclick() {
    if(!validateElement(document.formx.t1,true))
        return;
    if(document.formx.i_UstBirimKod.value=="nill")
    {    alert("Lutfen Bir Fakulte Seciniz.");  return; }
    if(document.formx.i_UBBNo.value=="nill")
    {    alert("Lutfen Bir Butce Tipi Seciniz.");  return; }
    if(document.formx.i_AnaKalem.value=="nill")
    {    alert("Lutfen Bir AnaKalem Seciniz.");  return; }
    if(document.formx.i_tutar.value=="")
    {    alert("Lutfen Bir Tutar Yaziniz.");    return; }
    document.formx.i_status.value="onayla";
    document.formx.submit();    
}
function sel_UBB_onchange(sel)
{
        document.formx.i_UBBNo.value=sel.value;  
}
function iptal_onclick()
{
	document.formx.i_status.value="iptal";
	document.formx.submit();		
}
function tas_onblur(ttut)
{
 
}
</script>
<input id="i_status" name="i_status" type="hidden" value="nill" />
<input id="i_UstBirimKod" name="i_UstBirimKod"  type="hidden" value="<%=UstBirimNo %>" />
<input id="i_UBBNo" name="i_UBBNo" type="hidden" value="<%=UBBNo %>" />
<input id="i_AnaKalem" name="i_AnaKalem"  type="hidden" value="<%=AnaKalem %>" />
<input id="i_tutar" name="i_tutar"  type="hidden" value="<%=tutar %>" />
<input id="i_exp" name="i_exp"  type="hidden" value="<%=exp %>" />
<table width="80%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
<td align="left"  style="width: 40%">Fak&#252;lte (Üst Birim):</td>
<td align="left"><select id="sel_UstBirim" name="sel_UstBirim" onchange="sel_UstBirim_onchange(this)" style="width: 100%">
                    <option value="nill" selected>L&#252;tfen Bir Fak&#252;lte Se&ccedil;iniz.</option>
                    <% ResultSet rs1=db.executeSP("UstBirimleriGoster_sp", new Object[]{null}).getResult();
                     	while(rs1.next())
                     	{
                     		out.println("<option value='"+rs1.getString("UstBirimNo")+"'>"+rs1.getString("UstBirimAdi")+"</option>");
                     	}                     
                     %>
                </select>
</td>
</tr>
<tr>
<td align="left" >Atanabilecek Bütçe Tipleri :</td>
<td align="left"><select id="sel_UBB" name="sel_UBB" disabled="" onchange="sel_UBB_onchange(this)" style="width: 100%">
                    <option value="nill" selected>L&#252;tfen Bir B&#252;t&ccedil;e Tipi Se&ccedil;iniz.</option>
                    <% ResultSet rs2=db.executeSP("UstBirimButceGoster_sp",new Object[]{UstBirimNo}).getResult();
                     	while(rs2.next())
                     	{
                     		out.println("<option value='"+rs2.getString("UstBirimButceNo")+"'>"+rs2.getString("KurumsalKod")+" - "+rs2.getString("FonksiyonelKodu")+"-"+rs2.getString("Tanimlama")+"</option>");
                     	}                     
                     %>
                </select></td>
</tr>

<tr>
<td align="left" >Ana Kalem :</td>
<td align="left"><select id="sel_AnaKalem" name="sel_AnaKalem" onchange="sel_AnaKalem_onchange(this)" style="width: 100%">
                    <option value="nill" selected>L&#252;tfen Bir AnaKalem Se&ccedil;iniz.</option>
                     <% ResultSet rs3=db.executeSP("AnaKalemGoster_sp", new Object[]{null}).getResult();
                     	while(rs3.next())
                     	{
                     		out.println("<option value='"+rs3.getString("AnaKalemNo")+"'>"+rs3.getString("AnaKalemKodu")+" - "+rs3.getString("AnaKalemAdi")+"</option>");
                     	}                     
                     %>
                </select></td>
</tr>
<tr>
<td align="left" >&#304;lk B&#252;t&ccedil;e Miktar&#305;:</td>
<td align="left"><input id="t1" name="t1" style="width: 100%; text-align: right;" type="text" onblur="t1_onblur(this)" value="0" validator="YTL" /></td>
</tr>




</table>
<table width=79%>
<tr>
<td>
<input type=text name="errmsg" value="<%=message %>" style="border:thin solid white; color:red; width: 100%; font-size: 11px;" readonly="" /></td>

</tr>

<tr>
<td>
<p align="center">
<input id="onayla" name="onayla" type="button" style="cursor: hand;" value="B&#252;t&ccedil;e olu&#351;tur" onclick="return onayla_onclick()">
<input id="iptal" name="iptal" type="button" style="cursor: hand;" value="Geri D&#246;n" onclick="iptal_onclick()"/>
</td>              
    
       
       
   
     </tr>

</table>




</form>




</div>


</div> 
<script language=javascript>
document.formx.sel_UstBirim.value=document.formx.i_UstBirimKod.value;
if(document.formx.i_UstBirimKod.value!="nill")
    document.formx.sel_UBB.disabled=false;
document.formx.sel_UBB.value=document.formx.i_UBBNo.value;
document.formx.sel_AnaKalem.value=document.formx.i_AnaKalem.value;
document.formx.t1.value=document.formx.i_tutar.value;
</script> 

<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar Mühendisliği ©2005</font></b></p>
	</div>
   
<%
if(alert){
	out.println("<script language=javascript> alert('"+message+"');</script>");
	System.out.println("Pages/butbd.jsp: "+message+error);
}
db.closeConnection(); 
%>
<%
}catch(Exception e){
	e.printStackTrace();
	db.closeConnection();
	session.setAttribute("error","butbd.jsp : "+e);
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
%>
</body>
</html>