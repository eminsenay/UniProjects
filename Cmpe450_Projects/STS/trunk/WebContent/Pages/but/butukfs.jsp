<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>
<%
DB db=null;
try{
String status=request.getParameter("i_status");
String UstBirimNo=request.getParameter("i_UstBirimKod");
String UBBNo=request.getParameter("i_UBBNo");
String message="";
String error="";
boolean alert=false;
if(UstBirimNo==null)
	UstBirimNo="nill";
if(status!=null)
{
	if(status.equals("iptal"))
		response.sendRedirect("../onayBekleyenler/onaybekleyenler.jsp");
	if(status.equals("yeni"))
		response.sendRedirect("butukf.jsp?i_status=yeni&i_UstBirimKod="+UstBirimNo);
}
db=new DB(true);
if(status!=null)
{
	if(status.equals("sil")&&(UBBNo!=null))
	{
		try{
			ResultSet rsx=db.executeSP("UstBirimButceSil_sp",new Object[]{UBBNo}).getResult();
			if(rsx.next())
			{
				String result=rsx.getString("result");
				if(result.equals("1"))
					message="Butce Tipi Basari ile Silindi.";
				else if(result.equals("0"))
				{
					message="Bu Butce Tipine Bagli Dagilimlar Oldugu icin Bu Kaydi Silemezsiniz.";
					alert=true;
				}
				else
				{
					message="Butce Tipi Bir Hatadan Dolayi Silinemedi.";
					error="Hata Kodu: "+result+" (Unidentified).";					
					alert=true;		
				}
			}
		}catch(Exception exc)
		{
			exc.printStackTrace(System.out);			
			message="Butce Tipi Silinemedi. Bir Hata Oluştu.";
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
        Fak&#252;ltelere Ait Mevcut B&#252;t&ccedil;e Tipleri</strong><p>&nbsp;</td>
      </tr>
    		</table>
	
  </div>


<div align=center>

<form name="formx" method="post" action=butukfs.jsp >
<script language=javascript>
function buttondelete_onclick(ubbno)
{
    document.formx.i_UBBNo.value=ubbno.name;
    document.formx.i_status.value="sil";
    document.formx.submit();
}
function sel_UstBirim_onchange(sel)
{
    document.formx.i_UstBirimKod.value=sel.value;
    document.formx.i_status.value="change";
    document.formx.submit();
}
function iptal_onclick(){
	document.formx.i_status.value="iptal";
    document.formx.submit();
}
function yeni_onclick(){
	document.formx.i_status.value="yeni";
    document.formx.submit();
}

</script>
<input id="i_status" name="i_status" type="hidden" value="nill" />
<input id="i_UBBNo" name="i_UBBNo" type="hidden" value="nill" />
<input id="i_UstBirimKod" name="i_UstBirimKod"  type="hidden" value="<%=UstBirimNo%>" />
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">
<tr>
<td align="left" >Fak&#252;lte (&Uuml;st Birim):</td>
<td align="left">
<select id="sel_UstBirim" name="sel_UstBirim" onchange="sel_UstBirim_onchange(this)" style="width: 263px">
                    <option value="nill">L&#252;tfen Bir Fak&#252;lte Se&ccedil;iniz</option>
                    <% ResultSet rs1=db.executeSP("UstBirimleriGoster_sp", new Object[]{null}).getResult();
                     	while(rs1.next())
                     	{
                     		out.println("<option value='"+rs1.getString("UstBirimNo")+"'>"+rs1.getString("UstBirimAdi")+"</option>");
                     	}                     
                     %>
                </select></td>
</tr>
</table> 
<table>
<tr><td>&nbsp;</td></tr>
</table>
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont">




<tr>
<td align="center">Kurumsal Kod</td>


<td align="center">Fonksiyonel Kod</td>


<td align="center">B&#252;t&ccedil;e Tan&#305;mlamas&#305;</td>


<td align="center"></td>


</tr>

 <%ResultSet rs2=db.executeSP("UstBirimButceGoster_sp",new Object[]{UstBirimNo}).getResult();
    	while(rs2.next()){%> 

<tr>
<td align="center"> <%=rs2.getString("KurumsalKod") %></td>


<td align="center"><%=rs2.getString("FonksiyonelKodu") %></td>


<td align="center"><%=rs2.getString("Tanimlama") %></td>


<td align="center"><input id="<%=rs2.getString("UstBirimButceNo") %>" type="button" value="Sil" name="<%=rs2.getString("UstBirimButceNo") %>" onclick="buttondelete_onclick(this)" style="width: 45px; cursor: hand; color: red; text-decoration: underline" /></td>


</tr>
<%}%>

</table>

<table width=79%>
<tr>
<td width="100%" >
<input type=text name="errmsg" value="<%=message %>" style="text-align: left; border-right: white thin solid; border-top: white thin solid; border-left: white thin solid; border-bottom: white thin solid; width:100%; color:red; font-size: 12px;" readonly="" />
</td>
</tr>

<tr>
<td>
<p align="center">   
    	<input id="yeni" style="width: 150px; cursor: hand;" type="button" value="Yeni B&#252;t&ccedil;e Tipi Tan&#305;mla" name="yeni" onclick="yeni_onclick()" />    
        <input id="iptal" style="width: 150px;cursor: hand;" type="button" value="Ana Sayfaya D&#246;n" name="iptal" onclick="iptal_onclick()"/></td>

</tr>
</table>
</form>
</div>
</div>

<script language=javascript>
document.formx.sel_UstBirim.value=document.formx.i_UstBirimKod.value;
</script>
<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar M&#252;hendisligi ©2005</font></b></p>
	</div>

</body>
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
	session.setAttribute("error","butukfs.jsp : "+e);
	response.sendRedirect("../../alerts/GeneralAlert.jsp");
	return;
}
%>
</html>