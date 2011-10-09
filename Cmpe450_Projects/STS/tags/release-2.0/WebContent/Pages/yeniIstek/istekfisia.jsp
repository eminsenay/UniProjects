<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>

<%//@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<% 
request.setCharacterEncoding("UTF-8"); 
   User userInfo=(User) session.getAttribute("userClass");
	if(userInfo==null){
		response.sendRedirect("../../logout.jsp");
		return;
	}
	
	
    
	
	 //session&#305; temizle :  --bll
	 if(session.getAttribute("_butceTertibi")!=null){		 
	    session.removeAttribute("_butceTertibi");
	    session.removeAttribute("_butceTertibiAlt");
        session.removeAttribute("_NO");
        session.removeAttribute("_piyasa");  
	    session.removeAttribute("istekler");
	   // System.out.println("Session dan eklenen urunler temizlendi");
    }
    //session&#305; temizle :
    	
	

   DB db=new DB(true);
	//String _anaKalem= null;	    
	
	String _grupAdi=null;
    if((_grupAdi=(String)session.getAttribute("_grupAdi"))==null){
    	ResultSet result_grupAdi=db.executeSP("GrupGoster_sp",new Object[]{userInfo.getgroupID()}).getResult();
    	if(result_grupAdi.next()){
    		_grupAdi=result_grupAdi.getString("GrupAdi");   		
    	}
    	else{
    		session.setAttribute("error","Departman adi hatali. \n &#304;stek fi&#351;i eklenemiyor.");
    		response.sendRedirect("../../alerts/GeneralAlert");
    		return;   		
    	}      	
    }    		
	
	int capacity_anaKalem=0;	
	
	ResultSet anaKalemler=db.executeSP("AnaKalemGoster_sp",new Object[]{""}).getResult();

	if(anaKalemler.next()){
		anaKalemler.last();
		capacity_anaKalem=anaKalemler.getRow();
		anaKalemler.beforeFirst();   
	}
	else{
		
		db.closeConnection();
		session.setAttribute("error","Anakalem yok veya hatali girilmi&#351;. \n &#304;stek fi&#351;i eklenemiyor.");
		response.sendRedirect("../../alerts/GeneralAlert");
		//out.println("Ana kalaem yok ki db de hic");
		return;
		
	}	
		
	String[] _anaKalem_id=new String[capacity_anaKalem]; //anakalemlerin idleri
	String[] _anaKalem_isim=new String[capacity_anaKalem]; //databaseden gelen anakalem isimleriyle dolacak
	
	for(int i=0;i<capacity_anaKalem && anaKalemler.next();i++)  {
		 _anaKalem_isim[i]=anaKalemler.getString("AnaKalemAdi");               
		 _anaKalem_id[i]=	anaKalemler.getString("AnaKalemNo");
	 }


	String _anaKalemNoSelected = _anaKalem_id[0];

	if( request.getParameter( "anaKalem" ) != null ){
		_anaKalemNoSelected = request.getParameter( "anaKalem" );		
	}


  ResultSet result=db.executeSP("AnaKaleminKalemleriniGoster_sp",new Object[]{ _anaKalemNoSelected }).getResult();
  
  int capacity=0;
   if(result.next()){
        result.last();
        capacity=result.getRow();
        result.beforeFirst();   
   }
   
   String[] _butceTertibi_id=new String[capacity]; //kalemlerin idleri
   String[] _butceTertibi=new String[capacity]; //databaseden gelen kalemlerle dolacak
   for(int i=0;i<capacity && result.next();i++)  {
	   _butceTertibi[i]=result.getString("KalemAdi");               
	   _butceTertibi_id[i]=	result.getString("KalemNo");
   }

	
    java.util.Date _tarih=new java.util.Date();
    String istekYili="2005";
    {
    	java.util.StringTokenizer token=new java.util.StringTokenizer(""+_tarih);
    	if(token.countTokens() >5){
    		istekYili="";
    		token.nextToken();
    		istekYili+=token.nextToken();
    		token.nextToken();
    		token.nextToken();
    		token.nextToken();
    		istekYili+="-"+token.nextToken();	
    		
    	}
    }
	  
    String _NO=_grupAdi+"/"+istekYili+"/";
   
    db.closeConnection();   
    

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
        <strong>BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</strong><br><br>
		<strong> &#304;STEK F&#304;&#350;&#304; </strong><br><br></td>
      </tr>
    		</table>
	
  </div>
  <br>
<!-- VALIDATION SCRIPTS -->
<!-- Import validation script -->
<script language=javascript src="../validator.js"></script>

<!-- Script for limiting kod length ------------------>  
<script language=javascript  >
function task_onblur(str_item)
{
	//get value of the input
	str=str_item.value;
	//check boundaries
	if(str.length > 26) {
		//crop the string
    	str=str.substr(0,26);
    	//update the input
    	document.formx.NO.value=str;
    }
}
</script>
<!-- ------------------------------------------------ --> 

<!-- end of VALIDATION SCRIPTS---------------------------------------- -->
  
 
  
  
  <div align=center> 
  
  <form name="istekfisia.jsp" method="post">
  <table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont3">
          
            <tr>
              <td  nowrap>Ana Kalem:						 </td>
              <td width="34%" align="left">
           <select size="1" name="anaKalem" onChange="submit()">
							<%
							for(int i=0;i<capacity_anaKalem;i++)
							{
								if( _anaKalemNoSelected.equals(_anaKalem_id[i]) ){
							%>
									<option selected value="<%=_anaKalem_id[i]%>"><%= _anaKalem_isim[i]%></option>
							<%
								}else{
							%>	
									<option value="<%=_anaKalem_id[i]%>"><%=_anaKalem_isim[i]%></option>
																
							<% 									}
							}
							%>
						</select>   
              
          </td>
              <td width="10"><input type=submit value="Bütçe Tertibi göster"></td>
            </tr> 
            </table>
            
                     
    </form>

     <form name="formx" action="istekfisib.jsp"  onsubmit="return validateForm(this)" method=post > 
     
          <tr>
              <td width="12%" nowrap>
              Bütçe Tertibi :&nbsp;
              </td>
              <td width="34%" align="left">
              <select onchange="" size="1" name="butcetertibi">
							<%
							for(int i=0;i<_butceTertibi.length;i++){
							%>
								<option selected value="<%=_butceTertibi_id[i]%>"><%=_butceTertibi[i]%></option>
							<%
							}
							%>	
								
						</select></td>
            </tr>
            
            
          </table>
		  
  
  <br>
  <br>

 
<table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont">
      <tr>
      
        <td width="28%" height="132" valign=top><div align="justify">
          <table width="98%"  border="1" bordercolor="#CCCCFF" class="tablefont">
            
            <tr height="20" >
              <td width="5%"><input type="radio" value="1" checked name="piyasa"></td>
              <td width="95%">Dahili Piyasa</td>
            </tr>
            <tr height="20" >
              <td width="5%" ><input type="radio" value="0"  name="piyasa"></td>
              <td width="95%" >Harici Piyasa</td>
            </tr>
          </table>
        </div></td>
        
        <td width="70%" valign=top><table width="100%"  border="1" bordercolor="#CCCCFF" class="tablefont">
         
          <tr>
            <td width="27%"><label>Kod</label></td>
            <td width="70%" height="20" align="left"><input type="text" name="NO" value=<%= _NO %> size="35" validator="isim" onblur="task_onblur(this)"></td>
          </tr>
          <tr>
            <td width="27%"><label>Tarih</label></td>
            <td width="70%" height="20" align="left" ><label  onFocus=""><%=_tarih%></label></td>
          </tr>
          
          
          </table>
       <table width=100%>
    	 <tr>
            <td width="27%">&nbsp;</td>
            <td width="71%">&nbsp;</td>
          </tr>   
    	 <tr>
            <td width="27%">&nbsp;</td>
            <td width="71%"><input type=submit value="       Devam   >>    " size=30 src="a.jpg"></td>
          </tr>   
       </table>   
          </td>
      </tr>
    </table>
   

			
</form>
  
   </div>
  
  
   
  
	</div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
	</div>
	
</body>
</html>