<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">

</head>


<%
DB db=null;
try{
String status=request.getParameter("i_status");
String UstBirimNo=request.getParameter("i_UstBirimKod");
String KurumsaNo=request.getParameter("i_KurumsalKod");
String FNo=request.getParameter("i_FonksiyonelKod");
String tanim=request.getParameter("i_tanimlama");
String message="";
String error="";
boolean alert=false;
UstBirimNo=(UstBirimNo==null)?"nill":UstBirimNo;
KurumsaNo=(KurumsaNo==null)?"nill":KurumsaNo;
FNo=(FNo==null)?"nill":FNo;
tanim=(tanim==null)?"L&#252;tfen Bir Tan&#305;mlama Yaz&#305;n&#305;z.":tanim;
if(status!=null)
{
	if(status.equals("iptal"))	
		response.sendRedirect("butukfs.jsp?i_status=change&i_UstBirimKod="+UstBirimNo);		
}
db=new DB(true);
if(status!=null){	
	if(status.equals("onayla"))
	{
		try{
			ResultSet rsx=db.executeSP("UstBirimButceEkle_sp",new Object[]{KurumsaNo,FNo,tanim}).getResult();
			if(rsx.next())
			{
				String result=rsx.getString("result");
				if(result.equals("1"))
				{
					db.closeConnection();
					response.sendRedirect("butukfs.jsp?i_status=change&i_message=Yeni Butce Tipi Basari ile olusturuldu...&i_UstBirimKod="+UstBirimNo);
					return;
				}
				if(result.equals("0"))
				{
					message="Atamak Istediginiz Butce Tipi Zaten Var.";	
					alert=true;				
				}
				else
				{
					message="Butce Tipi Bir Hatadan Dolayi Olusturulamadi.";
					error="Hata Kodu: "+result+" (Unidentified).";					
					alert=true;		
				}
			}
			else
			{
				message="Butce Tipi Bir Hatadan Dolayi Olusturulamadi.";
				error="Hata Kodu: Serverdan Yanit Yok.";
				alert=true;		
			}
		}catch(Exception exc)
		{
			exc.printStackTrace(System.out);			
			message="Butce Tipi Olusturulamadi. Bir Hata Oluştu.";
			error="Hata Kodu: Exception.";
			alert=true;				
		}
	}
}	
%>


<body>
<div id="toprightt"> </div>
<div id="topright2">

 <div align="center">
    <table width="79%"  border="0"  id="baslik" class="tablefont">
            <tr>
        <td width="100%" height="56" align=center>T.C.<br>
        <strong>BO&#286;AZ&#304;&#199;&#304; &Uuml;N&#304;VERS&#304;TES&#304;<br></strong>

    <strong>
        B&#252;t&ccedil;e Y&#246;netimi
        <br>
        Fak&#252;ltelere Kurumsal Kod-Fonksiyonel Kod Baz&#305;nda B&#252;t&ccedil;e Tipi Atanmas&#305;</strong><p>&nbsp;</td>
      </tr>
    		</table>
	
  </div>
<br>


<div align=center>
<form name="formx" method="post" action=butukf.jsp style="text-align: center">
<input id="i_UstBirimKod" name="i_UstBirimKod" type="hidden" value="<%=UstBirimNo%>"/>
<input id="i_KurumsalKod" name="i_KurumsalKod" type="hidden" value="<%=KurumsaNo%>" />
<input id="i_FonksiyonelKod" name="i_FonksiyonelKod" type="hidden" value="<%=FNo%>" />
<input id="i_tanimlama" name="i_tanimlama" type="hidden" value="<%=tanim%>" />
<input name="i_status" type="hidden" value="nill">
<script language=javascript>
function sel_UstBirim_Change(){
    if(document.formx.sel_UstBirim.value=="nill"){
        document.formx.sel_KurumsalKod.disabled=true;
    }
    else{
        document.formx.i_UstBirimKod.value=document.formx.sel_UstBirim.value; 
        document.formx.submit();       
    }

}
function Onayla_onclick() {
    if(document.formx.sel_UstBirim.value=="nill")
    {    alert("L&#252;tfen Bir Fak&#252;lte(&Uuml;st Birim) Se&#231;iniz...");     return; }
    if(document.formx.sel_KurumsalKod.value=="nill")
    {    alert("L&#252;tfen Bir Kurumsal Kod Se&#231;iniz...");   return; }
    if(document.formx.sel_FonksiyonelKod.value=="nill")
    {   alert("L&#252;tfen Bir Fonksiyonel Kod Se&#231;iniz...");  return; }
    if(document.formx.t_tanimlama.value=="")
    {    alert("L&#252;tfen Bir Tanim Giriniz...");     return; }
    
    document.formx.i_UstBirimKod.value=document.formx.sel_UstBirim.value;
    document.formx.i_KurumsalKod.value=document.formx.sel_KurumsalKod.value;
    document.formx.i_FonksiyonelKod.value=document.formx.sel_FonksiyonelKod.value;
    document.formx.i_tanimlama.value=document.formx.t_tanimlama.value;  
    document.formx.i_status.value="onayla";
    document.formx.submit();
}

function Iptal_onclick() {
	document.formx.i_status.value="iptal";
	document.formx.submit();  
}
function t_blank(item)
{
    item.value="";
}
</script>






<table width="70%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
            <td align=left width=30%>
                <strong>Fak&#252;lte (&Uuml;st Birim)</strong></td>
            <td align=center>
                <p align="left">
                <select id="sel_UstBirim" name="sel_UstBirim" onchange="sel_UstBirim_Change()" style="width: 100%">
                    <option value="nill" selected>L&#252;tfen Bir Fak&#252;lte Se&ccedil;iniz</option>
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

            <td align=left>
                <strong>Kurumsal &nbsp;Kod</strong></td>

            <td align=center>
                <p align="left">
                <select id="sel_KurumsalKod" style="width: 100%" name="sel_KurumsalKod">
                    <option value="nill" selected>L&#252;tfen Bir Kurumsal Kod 
					Se&ccedil;iniz</option>
                    <% //ResultSet rs2=db.executeQuery("select * from ust_birim_kurumsal U where U.UstBirimNo='"+UstBirimNo+"'");
                    ResultSet rs2=db.executeSP("UstBirimKurumsalGoster_sp",new Object[]{UstBirimNo}).getResult();
                    while(rs2.next())
                     	{
                     		out.println("<option value='"+rs2.getString("UstBirimKurumsalNo")+"'>"+rs2.getString("KurumsalKod")+"</option>");
                     	}                     
                     %>
                </select></td></tr>

 <tr>
           <td align="left">
                <strong>Fonksiyonel Kod</strong></td>
           <td align="center">
                <p align="left">
                <select id="sel_FonksiyonelKod" style="width: 100%" name="sel_FonksiyonelKod">
                    <option value="nill" selected>L&#252;tfen Bir Fonksiyonel Kod 
					Se&ccedil;iniz</option>
                    <%  ResultSet rs3=db.executeSP("FonksiyonelGoster_sp", new Object[]{null}).getResult();
                     	while(rs3.next())
                     	{
                     		out.println("<option value='"+rs3.getString("FonksiyonelNo")+"'>"+rs3.getString("FonksiyonelKodu")+"</option>");
                     	}                     
                     %>
                </select></td>
        </tr>


 <tr>
           <td align="left">
                <strong>Tan&#305;mlama</strong></td>
           <td align="center">
                <input id="t_tanimlama" style="width: 100%; float:left" maxlength="100" name="t_tanimlama" onfocus="t_blank(this)"></td>
        </tr>

</table>
<table width=70%>
<tr>
<td width="100%" >
<input type=text name="errmsg" value="<%=message %>" style="text-align: left; border-right: white thin solid; border-top: white thin solid; border-left: white thin solid; border-bottom: white thin solid; width:100%; color:red; font-size: 12px;" readonly="" />
</td>
</tr>
<tr>
<td width="100%" align="center">
                <input id="Onayla" name="Onayla" type="submit" value="B&#252;t&ccedil;e Olu&#351;tur" onclick="Onayla_onclick()" style="cursor: hand;"/> 
                <input id="Iptal" name="Iptal" type="button" value="    &#304;ptal      " onclick="Iptal_onclick()"style="cursor: hand;"/>
</td>
</tr>
</table>


</div>


</form>

</div>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar M&#252;hendisligi ©2005</font></p>
	</div>


</body>
<script language=javascript>

document.formx.sel_UstBirim.value=document.formx.i_UstBirimKod.value;
document.formx.sel_KurumsalKod.value=document.formx.i_KurumsalKod.value;
if(document.formx.sel_UstBirim.value=="nill"){
    document.formx.sel_KurumsalKod.disabled=true; 
}
document.formx.sel_FonksiyonelKod.value=document.formx.i_FonksiyonelKod.value;
document.formx.t_tanimlama.value=document.formx.i_tanimlama.value;

</script>
<%
if(alert){
	out.println("<script language=javascript> alert('"+message+"');</script>");
	System.out.println("Pages/butukfs.jsp: "+message+error);
}
db.closeConnection(); 
%>
<%
}catch(Exception e){
	e.printStackTrace();
	db.closeConnection();
	session.setAttribute("error","butukf.jsp : "+e);
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
%>
</html>