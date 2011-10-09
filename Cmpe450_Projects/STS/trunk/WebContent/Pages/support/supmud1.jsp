<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- Bu sayfa Daire Baskaninin destek birimleri tarafından gonderilen fisi onayladigi sayfadir. -->
<!-- Bu sayfada onaylanan bir fis, Butceye gönderilmektedir, -->
<!-- bunun için de nextGroupID "00001E-GRP"ye -->
<!-- Daire baskanı fişi reddederse o fis ilgili destek birimine gonderilmektedir -->


<%
request.setCharacterEncoding("UTF-8"); 
	//eger login olmadan acmaya calisirsa.  --bll
	if((session.getAttribute("userClass"))==null){	   
		   response.sendRedirect("../../logout.jsp");
		   return;	   
	}
	
	DB db=new DB(true);

try{//sistemin en genel try catch bloc&#287;u  --bll


	//security kodlar? buraya!!!
	//eger asagidaki variable false yapilirsa, sign applet sayfada gozukmez

	//SECURITY CODE BEGIN
	int securityIndex=2;  //Buras&#305; javasecurity index parametresi

	//SECURITY CODE END

	//bu sayfa belli bir fis için çalisiyor, bu fisin id'si en önemli bilgilerden birisi
	String requestFormID = (String)session.getAttribute("requestFormID");

	//sayfa ilk açildiginda onay fieldindaki bilgiye göre ne yapacagini belirleyecek
	//eger sayfa ilk olarak açiliyorsa, onay fieldinin null olmasi gerekiyor
	//onay null degilse ve value'su "onaylandi"ya esitse, kullanici sayfayi onaylamak
	//istedigi anlamina geliyor. imzayi verify et ve onay islemi için db'den
	//IstekAktar_sp'yi çagir

	if(request.getParameter("onay") != null 
	&& request.getParameter("onay").equals("onaylandi")) {
		

		
		String userID = ((User)session.getAttribute("userClass")).getUserid();
		//ilk olarak imzayi verify etmemiz gerekiyor. bunun için request'ten
		//imza fieldini çekip, security'nin verify fonksiyonuna yolluyoruz
		//if(request.getParameter("imza") == null
		//|| !verify(request.getParameter("imza")))
		//	response.sendRedirect("hata");
		
		//not: eger bu sayfada fise yeni bir bilgi ekleniyorsa (sürekli 
		//kullandigimiz örnek "ihale fiyat?" gibi) once request'ten ilgili
		//fielddaki datay? oku ve sonra db'nin bu field? update etmekle 
		//ilgili sp'sini çag?r?p bu bilgiyi db'ye yaz
		
	     String groupId = ((User)session.getAttribute("userClass")).getgroupID();
	     ResultSet gr = db.executeSP("GrupGoster_sp",new Object []{groupId}).getResult();
	     String BirimNo=null;     
		if(gr.next()){
	       BirimNo =gr.getString("BirimNo");
		}
		else{ 
			session.setAttribute("error","Istek fisinde hata var . Veri çakilemiyor.");
			response.sendRedirect("../../alerts/GeneralAlert.jsp");
			return;	   
		}
	     String istekFisiNo=request.getParameter("fis_kodu");
	     String toplamTutar="0";
	     System.out.println("toplamTutar:"+toplamTutar);
	       
	     ResultSet butno= db.executeSP("DefaultButceGoster_sp",new Object []{BirimNo}).getResult();
	     String butceDagilimNo=null;
	     

	     if(butno.next()){

	    	 butceDagilimNo = butno.getString("ButceDagilimNo");
	         System.out.println("butceDagilimNo:"+butceDagilimNo+"istekFisiNo"+requestFormID+"tutar"+toplamTutar);
	    	 
	  //   }
	  // 	else{ 
	  //		session.setAttribute("error","Istek fisinde hata var . Veri çakilemiyor.");
	  //		response.sendRedirect("../../alerts/GeneralAlert.jsp");
	  //		return;	   
	  //	}  
	    // String butceDagilimNo = butno.getString("ButceDagilimNo");
	     //System.out.println("butceDagilimNo:"+butceDagilimNo+"istekFisiNo"+istekFisiNo+"tutar"+toplamTutar);
	       
	     ResultSet myResult= db.executeSP("ButceBlokeEkle_sp",new Object []{requestFormID,butceDagilimNo,toplamTutar}).getResult();
	   //////////////////////////////////////////////////////////////////////////

		   if(myResult.next()){  //anil
		     //  BirimNo =gr.getString("BirimNo");

		   }
			else{ 

				session.setAttribute("error","Istek fisinde hata var . Veri çakilemiyor.");
				response.sendRedirect("../../alerts/GeneralAlert.jsp");
				return;	   
			}
	}
	else{
		

	}
	   //////////////////////////////////////////////////////////////////////////
		//eger hersey yolunda giderse, IstekAktar_sp'yi cagir
		String yorum = request.getParameter("yorum");
		//databasede yorum girilmedigini tutmak istiyoruz.
		if(yorum.equals("Lutfen bir yorum giriniz."))
			yorum="Yorum girilmedi.";
			
		String nextGroupID = Standarts.BUTCE_KOORDINATORLUGU_GRUPNO; 
		//Ayni sekilde next pagei de dekan sayfasi olarak ayarliyoruz
		String nextPageCode = "../but/but2.jsp";
		
	//	SECURITY CODE BEGIN
		boolean verification = true;
		if (session.getAttribute("securityEnabled").equals("true")) {
			String security_signature = request.getParameter("imza");
			String security_documentContent = request.getParameter("document_content");
			String security_date = request.getParameter("securityDate");
			session.setAttribute("securityDocument", security_documentContent);
			verification = global.Security.verifySignature(userID, security_documentContent, security_signature,security_date);
		}
		//SECURITY CODE END
		
		//MODIFIED BY SECURITY
		db.executeSP("IstekAktar_sp", new Object [] {requestFormID, nextGroupID, nextPageCode, userID, yorum,"1"});
		//following result3 is used by SECURITY
		ResultSet result3 = db.getResult();
		if (session.getAttribute("securityEnabled").equals("true") && result3.next()) {
			//SECURITY CODE BEGINS
			String historyID = result3.getString(1);
			String security_signature = request.getParameter("imza");
			String security_documentContent = request.getParameter("document_content");
			String security_date = request.getParameter("securityDate");
			Security.addSignature(userID, requestFormID,security_date,security_signature,security_documentContent, historyID,Security.SIGN_FORMAT_SUPMUD1);
			//SECURITY CODE ENDS
		}
		
		//bu sp'nin hatali dönmesi olasiligini kontrol et
		//basarili oldugunu varsayarsak
		//sessiondan aman requestFromID'yi remove et
		
		session.removeAttribute("requestFormID");
		response.sendRedirect("../../alerts/approve.jsp");
		return;	
	}
	else if(request.getParameter("onay") != null 
		 && request.getParameter("onay").equals("reddedildi")) {
		
		//burada imza verification'? olmayacak san?r?m
		//db'ye yeni field update etmek de söz konusu degil
		//sadece comment al?n?p, IstekAktar_sp cagrilacak,
		//ama bu kez nextPageCode ve nextGroupID fi?in geri
		//dönmesi gereken sayfaya göre set edilecek
	
		String yorum = request.getParameter("yorum");
		//transferRequestin parametreleri: reqID (formun id'si), groupID (gittigi grubun id'si), pageID (gittigi sayfan?n ID'si), userID (onaylayan user'?n ID'si), yorum (onaylayan?n yorumu)
		String nextGroupID = null;  // bu aslinda previous group idsi, cunku reddediyor
		
		//gereken sp:
		//BEGIN
		//DECLARE userId char(20);
		//SET userId = (select `ISTEK_FISI`.`Olusturan` FROM `ISTEK_FISI` WHERE `ISTEK_FISI`.`IstekFisiNo`=istekFisiNo);
		//SELECT KULLANICI.GrupNo FROM KULLANICI WHERE KULLANICI.`KullaniciNo` = userId;
		//END	
		
		ResultSet result_olusturanGrup=db.executeSP("IstekFisiOlusturaniGoster_sp",new Object[]{requestFormID}).getResult();
		result_olusturanGrup.next();
		String olusturanUserID = result_olusturanGrup.getString("GrupNo"); //bu sekilde olmaliydi --bll
		
		String nextPageCode = "../support/sup1.jsp"; 
		String userID = ((User)session.getAttribute("userClass")).getUserid(); //su anda reddeden kisinin useri
		ResultSet result3 = db.executeSP("IstekAktar_sp",new Object []{requestFormID,olusturanUserID,nextPageCode,userID,yorum,"0"}).getResult();
		//bu sp'nin hatal? dönmesi olas?l?g?n? kontrol et
		//basar?l? oldugunu varsayarsak
		//sessiondan aman requestFromID'yi remove et
		session.removeAttribute("requestFormID");
		response.sendRedirect("../../alerts/reject.jsp");
		return;	
	}
	
	boolean tarihGoster = false;
	if(request.getParameter("tarihGoster") != null
	&& ((String)request.getParameter("tarihGoster")).equals("evet"))
		tarihGoster = true;
	
	//bu noktada db'den requestForm ile ilgili bilgileri çekiyoruz
		ResultSet _request = db.executeSP("IstekFisiGoster_sp",new Object []{requestFormID}).getResult();
	//System.err.println(">>>>>>>>>>>>>>>>call IstekFisiGoster_sp('"+requestFormID+"')");
		if(_request.next()) ;	//genel form bilgilerinin hemen okunabilmesi için ilk rowa geç
		
		
		//istek fisi gosterilemiyorsa bu bostur , burdan geri dönmeli adam --bll	
		//	patlamas&#305;n diye burdan redirect olur.
		else{ 
			session.setAttribute("error","Istek fisinde hata var . Detay gösterilemiyor");
			response.sendRedirect("../../alerts/GeneralAlert.jsp");
			return;	   
		}
	
	%>
	
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Bo&#287;aziçi Üniversitesi Sat&#305;n Alma Sistemi</title>
	<link href="../../index/gui.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<SCRIPT>
		<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->
		
			function onayDugmesi() {
				<!-- formdaki onay isimli hidden inputa "onaylandi" yaziliyor -->
				document.onayFormu.onay.value = "onaylandi";
				<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
				document.onayFormu.submit();
			}
			
			function redDugmesi() {
				<!-- formdaki onay isimli hidden inputa "reddedildi" yaziliyor -->
				document.onayFormu.onay.value = "reddedildi";
				<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
				document.onayFormu.submit();
			}
			
			function tarihDugmesi() {
				<!-- bu fonksiyon, tarih goster dugmesine basildikca, tarihGoster -->
				<!-- fieldinin icerigini toggle edecek -->
				if(document.onayFormu.tarihGoster.value == "evet")
					document.onayFormu.tarihGoster.value = "hayir";
				else
					document.onayFormu.tarihGoster.value = "evet";
				<!-- formun submiti cagrilarak sayfa kendisini cagiriyor -->
				document.onayFormu.submit();
			}
		
		<!-- SECURITY ONAY ICIN BU JAVASCRIPT FONK. CAGIRACAK -->
	</SCRIPT>
	
	
	<div id="toprightt"> </div>
	
	<div id="topright2">
	
	<!-- bu form sayfadaki tek form olmal? ve action'? sayfan?n kendisi olmal? -->
	<form name="onayFormu" action="supmud1.jsp" method="post">
	<div align="center">
	  <table width="79%"  border="0"  id="baslik" class="tablefont">
	          <tr><td><img src="../../images/spacer.gif" height="120"></td>
	    </tr><tr>
	      <td width="27%" height="56"><p align="center"><strong> T.C. </strong></p>
	      <p align="center"><strong>BO&#286;AZ&#304;Ç&#304; ÜN&#304;VERS&#304;TES&#304;</strong> </p></td>
	      <td width="38%"><p align="center"><strong> &#304;STEK F&#304;&#350;&#304; </strong></p>
	      <%
	      String sayfaAdi = _request.getString("SayfaAdi");
	      %>
	      <p align="center"><%=sayfaAdi%></p></td>
	      <%
	      //fis no
			String fisKodu = _request.getString("IstekFisiKodu");
	      %>
	      <td width="35%"><p align="center"><strong> Kod:</strong><strong>
	        <label><span id='security<%=securityIndex++ %>'><%=fisKodu%></span></label>
	      </strong></p></td>
	    </tr>
	  </table>
		<br>
	</div>
	<div align="center">
	  <table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont">
	    <tr>
	    	<%
			//secilen piyasa secenegi. dahili 1 gelirse dahili piyasad?r de?ilse harici piyasad?r
	    	String dahili= _request.getString("Dahili");
	    	String piyasa="";
	    	if(dahili.equals("1"))
	    		piyasa="Dahili Piyasa";
	    	else
	    		piyasa = "Harici Piyasa";
	    	%>
	      <td width="46%" height="132"><div align="justify">
	        <table width="98%"  border="1" bordercolor="#CCCCFF" class="tablefont">
	          <tr>
	            <td width="49%">
				<p align="left">Seçilen Piyasa Seçene&#287;i</td>
	            <td width="51%"><span id='security<%=securityIndex++ %>'><%=piyasa%></span></td>
	          </tr>
	        </table>
	      </div></td>
	      <%
			//tarih
			String theDate = _request.getString("OlusturmaTarihi");
			//kurumsal kod 
			//String kurumsalKod = _request.getString("..............");
			//String kurumsalKod = "97.08.02.04";
			//fonksiyonel kod
			//String fonksiyonelKod = _request.getString("................");
		    //String fonksiyonelKod = "09.4.1.00";
			//finansal kod
			//String finansalKod = _request.getString("...........");
	        //String finansalKod = "2";
			//ekonomik kodu
			 String ekonomikKod = _request.getString("AnaKalemKodu")+"."+_request.getString("KalemKodu");
			//proje no
			//String projeNo = _request.getString("...........");

	      %>
	      <td width="54%">
	      <table width="100%"  border="1" bordercolor="#CCCCFF" class="tablefont">
	        <tr>
	          <td width="33%" align="left"><label>Tarih</label></td>
	          <td width="67%" align="left"><label  onFocus=""><span id='security<%=securityIndex++ %>'><%=theDate%></span></label></td>
	        </tr>
	        <!-- tr>
	         <td width="33%"><label>Kurumsal</label></td>
	          <td width="67%"><label><span id='security<%//=securityIndex++ %>'><%//=kurumsalKod%></span></label></td>
	        </tr -->
	        <!-- tr>
	          <td width="33%"><label>Fonksiyonel</label></td>
	          <td width="67%"><label><span id='security<%//=securityIndex++ %>'><%//=fonksiyonelKod%></span></label></td>
	        </tr -->
	        <!-- tr>
	          <td width="33%"><label>Finansal</label></td>
	          <td width="67%"><label><span id='security<%//=securityIndex++ %>'><%//=finansalKod%></span></label></td>
	        </tr -->
	        <tr>
	         <td width="33%" align="left"><label>Ekonomik</label></td>
	          <td width="67%" align="left"><label><span id='security<%=securityIndex++ %>'><%=ekonomikKod%></span></label></td>
	        </tr>
	        <!-- tr>
	          <td width="33%" height="19"><label>Proje No</label></td>
	          <td width="67%"><label><span id='security<%//=securityIndex++ %>'><%//=projeNo%></span></label></td>
	        </tr -->
	      </table>
	      </td>
	    </tr>
	  </table>
		<br>
		
	  <table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont2">
	    <tr>
	      <td width="19%">&nbsp;</td>
	      <td width="15%">&nbsp;</td>
	      <td width="20%">&nbsp;</td>
	      <td colspan="3"><div align="center">Tahmini</div></td>
	    </tr>
	    <tr>
	      <td><div align="center">Miktar</div></td>
	      <td><div align="center">Ürün</div></td>
	      <td><div align="center">Aç&#305;klama</div></td>
	      <td width="17%"><div align="center">Birim Fiyat&#305; (YTL)</div></td>
	      <td width="13%"><div align="center">Tutar&#305; (YTL)</div></td>
	    </tr>
	    <%
	    _request.previous();
	    while(_request.next()) {
				//miktar
				String miktar = _request.getString("Miktar");
				//urun
				String urun = _request.getString("UrunAdi");
				//aciklama
				String aciklama = _request.getString("Aciklama");
				//birimfiyat?
				String birimFiyat = _request.getString("TahminiFiyat");
				//String birimFiyat = "birimFiyat?";	
				//tutari
				
				String tutar = "" ;
				try{
					tutar=""+(Integer.parseInt(miktar) * Double.parseDouble(birimFiyat)) ;				
				}catch(Exception e){}
		      %>
		      <tr align="center">
		        <td><label><span id='security<%=securityIndex++ %>'><%=miktar%></span></label></td>
		        <td><label><span id='security<%=securityIndex++ %>'><%=urun%></span></label></td>
		        <td><label><span id='security<%=securityIndex++ %>'><%=aciklama%></span></label></td>
		        <td><label><span id='security<%=securityIndex++ %>'><%=birimFiyat%></span></label></td>
		        <td><label><%=tutar%></label></td>
		      </tr>
	    <%
	    }
	    %>
	  </table>
	</div>
	
	<!-- yorum kutusu -->
	<br><div align="center">
		<input type="textarea" name="yorum" value="Lutfen bir yorum giriniz." height="4">
	</div>
	
	<!-- onay ve red dugmeleri -->
	<br><div align="center">
		<input class="tablefont3"   type="button" value="Onayla" onClick="parent.leftFrame.securityOnayDugmesi()" language="JavaScript">
		<input class="tablefont3"   type="button" value="Reddet" onClick="redDugmesi()" language="JavaScript">
	</div>
	
	<!-- tarih goster dugmesi -->
	<br><div align="center">
		<input class="tablefont3"   type="button" value="Tarihce Goster" onClick="tarihDugmesi()" language="JavaScript">
	</div>
	
		<!-- hidden fieldlar -->
			<!-- SECURITY ICIN HIDDEN FIELDLAR BEGIN -->
			    <input type="hidden" id='security_field_no' value="<%=securityIndex-1%>">
				<input type="hidden" name="imza" value="">
				<input type="hidden" name="document_content" value="">
				<input id="security1" type="hidden" name="securityDate" value="<%=System.currentTimeMillis()%>">
			<!-- SECURITY ICIN HIDDEN FIELDLAR END -->
			<input type="hidden" name="onay" value="">
			<% if(tarihGoster){%>
			<input type="hidden" name="tarihGoster" value="evet">
			<% }else{%>
			<input type="hidden" name="tarihGoster" value="hayir">
			<%}%>
		<!-- hidden fieldlar -->
	
		<%
		//tarihçe muhabbeti, sayfanin basindaki kod bölümünde set edilen
		//tarihGoster boolean variable?n?n degerine gore tarihçeyi goster
		if(tarihGoster)	{
		
			%>
	        <%@ include file="../../security/istekTarihce.jsp_" %>
		<%
		}
		
		db.closeConnection();
		
		
	//	hata olu&#351;ursa adam&#305; korkutma kendin hallet  --bll
	}catch(Exception e){
		
		System.out.println("hata burda");
		e.printStackTrace();
		db.closeConnection();
		session.setAttribute("error","submud1.jsp : "+e);
		response.sendRedirect("../../alerts/GeneralAlert.jsp");
		return;
	}
	%>
</form>
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif" color="black">
	Bilgisayar Mühendisli&#287;i ©2005</font></b></p>
	</div>
</body>
</html>