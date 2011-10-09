<%@page import="java.sql.ResultSet"%>
<%@page import="global.*"%>

<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Boğazi&ccedil;i &Uuml;niversitesi Sat&#305;n Alma Sistemi</title>
</head>
<body>

	<%
	request.setCharacterEncoding("UTF-8"); 
		String requestFormId = request.getParameter("requestID");
	
		DB db=new DB(true);
//		ResultSet rs = db.executeQuery("select SAYFA.SayfaKodu From ISTEK_FISI , SAYFA where ISTEK_FISI.IstekFisiNo='"+requestFormId+"' and SAYFA.SayfaNo =ISTEK_FISI.SayfaNo				");
  
		ResultSet rs = db.executeSP("IstekFisiGoster_sp",new Object []{requestFormId}).getResult();
		
	//	Burda hata olustu gecen , result set bos dondu . ???
	//	Ben de bu hata kontrol satirini koydum. --bilal
		if(! rs.next() ){ 	
//			out.println("IstekFisiGoster_sp si hatali calisti."+requestFormId);			

			session.setAttribute("error","Kullanıcı adınız veya şifreniz yanlış");
		   	response.sendRedirect("../../alerts/GeneralAlert.jsp");
		   	db.closeConnection();
			return;
		}  
        
		session.setAttribute("requestFormID", requestFormId);
		String pageCode = rs.getString("SayfaKodu");
        db.closeConnection();
        
		//out.println( "requestFormId: " + requestFormId);
		
		//response.sendRedirect("details.jsp");
	
		response.sendRedirect(  pageCode );
	%>
	
</body>
</html>