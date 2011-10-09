
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="bts.cmpe.budget.dal.transfer.*" %>
    <%@ page import="bts.cmpe.budget.businessObj.*" %>
    <%@ page import="global.InputChecker" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>idari birim düzenle 2</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>

<body>

<% String value = (String) request.getSession().getAttribute("search"); 
	
%>
<div id="Layer1" style="position:absolute; left:33px; top:233px; width:548px; height:35px; z-index:1">
  <table width="100%" border="0">
    <tr>
    <td>38.08.</td>
      <td width="35%"><form name="form2" method="post" action="">
          <input type="text" name="textfield">
        </form></td>
      <td width="35%"><form name="form3" method="post" action="">
          <input type="text" name="textfield2">
        </form></td>
      <td width="10%">&nbsp;</td>
      <td width="35%"><form name="form4" method="post" action="">
          <input type="text" name="textfield3">
        </form></td>
    </tr>
  </table>
</div>
<div id="Layer2" style="position:absolute; left:634px; top:236px; width:62px; height:39px; z-index:2">
  <form name="form1" method="post" action="">
    <input type="submit" name="Submit2" value="ARA">
  </form>
</div>

<%
try{
	String update = (String) request.getSession().getAttribute("update"); 
	if(update.compareTo("1")==0)
		{
			%>
			<p> Idari birim guncellendi.</p>
			<%		}
	
}catch (Exception e){}
	session.setAttribute("search","1");
	try{
				if(value.compareTo("1")==0)
				{
					
				String kurumsal=request.getAttribute("textfield").toString();
				String fonksiyonel=request.getAttribute("textfield2").toString();
				String ekonomik=request.getAttribute("textfield3").toString();
				DepartmentTO olddepartment=new DepartmentTO(kurumsal,fonksiyonel,ekonomik);
				boolean inputcheck1=false;
			boolean inputcheck2=false;
			boolean inputcheck3=false;
		
		InputChecker inputcheck=new InputChecker();
		
			inputcheck1=inputcheck.checkString(kurumsal);
			inputcheck2=inputcheck.checkString(fonksiyonel);
			inputcheck3=inputcheck.checkString(ekonomik);
			
				%>
	<div id="Layer3" style="position:absolute; left:473px; top:205px; width:69px; height:22px; z-index:3">Ekonomik</div>
	<div id="Layer4" style="position:absolute; left:85px; top:205px; width:63px; height:22px; z-index:4">Kurumsal</div>
	<div id="Layer5" style="position:absolute; left:262px; top:205px; width:82px; height:22px; z-index:5">Fonksiyonel</div>
	<div id="Layer11" style="position:absolute; left:83px; top:1px; width:524px; height:88px; z-index:6"><img src="header.gif" width="700" height="100"></div>
	<p>&nbsp;</p><p>&nbsp;</p>
	<P>  
	<P>
	<div id="Layer6" style="position:absolute; left:33px; top:383px; width:548px; height:35px; z-index:1">
	  <table width="100%" border="0">
	    <tr>
	      <td width="35%"><form name="form2" method="post" action="">
	          <input type="text" name="text" value= <%= kurumsal %>>
	        </form></td>
	      <td width="35%"><form name="form3" method="post" action="">
	          <input tye="text" name="text2" value=<%= fonksiyonel %>>
	        </form></td>
	      <td width="10%">&nbsp;</td>
	      <td width="35%"><form name="form4" method="post" action="">
	          <input type="text" name="text3" value=<%= ekonomik %>>
	        </form></td>
	    </tr>
	  </table>
	</div>
	<div id="Layer7" style="position:absolute; left:617px; top:387px; width:62px; height:39px; z-index:2">
	  <form name="form1" method="post" action="">
	    <input type="submit" name="Submit" value="DÜZENLE">
	  </form>
	</div>
	<div id="Layer8" style="position:absolute; left:423px; top:355px; width:69px; height:22px; z-index:3">Ekonomik</div>
	<div id="Layer9" style="position:absolute; left:35px; top:355px; width:63px; height:22px; z-index:4">Kurumsal</div>
	<div id="Layer10" style="position:absolute; left:212px; top:355px; width:82px; height:22px; z-index:5">Fonksiyonel</div>
	<%
		session.setAttribute("inserted","1");
		String insert= (String) request.getSession().getAttribute("insert");
			
		try{
			if(insert.compareTo("1")==0)
			{
				try{
			String kurumsalyeni=request.getAttribute("text").toString();
			String fonksiyonelyeni=request.getAttribute("text2").toString();
			String ekonomikyeni=request.getAttribute("text3").toString();
			
				DepartmentTO newdept=new DepartmentTO(kurumsalyeni,fonksiyonelyeni,ekonomikyeni);
				
				BudgetBusinessObj busobj=new BudgetBusinessObj();
				
				busobj.updateDepartment(olddepartment,newdept);
				session.setAttribute("updated","1");
				 response.sendRedirect("idaribirimduzenle.jsp");
			
				}catch(Exception e){
			session.setAttribute("msg",e);
			response.sendRedirect ("error.jsp");
				}
			}
		}catch(Exception e){}
			}
		}catch(Exception e){}
	%>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

</body>
</html>