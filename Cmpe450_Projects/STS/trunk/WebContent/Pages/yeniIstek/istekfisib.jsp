<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="global.*"%>
<%@page import="system.*"%>

<%   
request.setCharacterEncoding("UTF-8"); 
    DB db=new DB(true);
	User userInfo=(User)session.getAttribute("userClass");
	if(userInfo==null) {
	        response.sendRedirect("../../logout.jsp");
			return;
	}
	
	///butce tertibini session a al
	String _butceTertibi=null;
	String _NO=null;
	String _piyasa=null;
	if(session.getAttribute("_butceTertibi")==null){		
		_butceTertibi =request.getParameter("butcetertibi");  
		session.setAttribute("_butceTertibi",_butceTertibi);
		
		_NO=request.getParameter("NO");
		session.setAttribute("_NO",_NO);		
		
		_piyasa=request.getParameter("piyasa"); //default deger
		session.setAttribute("_piyasa",_piyasa);				
	}
	else{
		_butceTertibi =(String) session.getAttribute("_butceTertibi");
		_NO =(String) session.getAttribute("_NO");
		_piyasa =(String) session.getAttribute("_piyasa");		
	}
	
	
	
	
	double genelTutar=0;
	
	
	String[] _butceTertibiAlt=null; //butce tertibi alt kategorileri
	String[] _butceTertibiAlt_id=null; //butce tertibi alt kategorileri
	if(session.getAttribute("_butceTertibiAlt")==null){ // sayfa ilk kez yükleniyor db den al değerleri
		
		
		
		String kalemNo=_butceTertibi;	
		
		//artık kategori id yi biliyoz
		ResultSet result=db.executeSP("KalemUrunleriniGoster_sp",new Object[]{kalemNo}).getResult();
		int capacity=0;
		if(result.next()){
			result.last();
			capacity=result.getRow();
			result.beforeFirst();   
		}	
		
		if(capacity<1) //secebilecek istek yok
		{
			session.setAttribute("error","</h3><h5>Seçili Kalemde istek yapabilecek bir öge bulunmamaktadir.<br>Sistem yöneticisi ,bu kaleme öge koymalıdır.</h5><h3>");
			response.sendRedirect("../../alerts/GeneralAlert.jsp");
			db.closeConnection();
			return;
		}
		
		//	 databaseden gelen kalemlerle dolacak
		
		_butceTertibiAlt=new String[capacity];
		_butceTertibiAlt_id= new String[capacity];
		
		for(int i=0;i<capacity && result.next();i++)
		{  
			_butceTertibiAlt[i]=result.getString("UrunAdi");
			_butceTertibiAlt_id[i]=result.getString("UrunNo");				
		}   		   
		
		session.setAttribute("_butceTertibiAlt",_butceTertibiAlt);		
		session.setAttribute("_butceTertibiAlt_id",_butceTertibiAlt_id);	
	
	}else //sayfa kendini cagiriyor hizli yap su isleri  
	{		  
		_butceTertibiAlt=(String[])session.getAttribute("_butceTertibiAlt");	
		_butceTertibiAlt_id=(String[])session.getAttribute("_butceTertibiAlt_id");			
	}	  
		

	java.util.Date _tarih=new java.util.Date();
	
	
	IstekParca []istekler=null;
	try{          
       istekler=(IstekParca[])session.getAttribute("istekler");
            
     //  System.out.println("try 1  ");
       
//     yeni bir istek parcasi girilirse buraya gir ve o parçayı da sessiona ekle
        IstekParca istekParca=new IstekParca();
        istekParca.miktar=request.getParameter("miktar");         
        if(istekParca.miktar!=null){
        	
        	//System.out.println("try 1.1  ");
        	
        	//istekParca.birim=request.getParameter("birim");  <<
        	int urunNoSayisi=Integer.parseInt(request.getParameter("urunNoSayisi")); 
        	
        	//System.out.println("try 1.2  ");
        	
        	istekParca.urun=_butceTertibiAlt[urunNoSayisi];
        	istekParca.urunNo=_butceTertibiAlt_id[urunNoSayisi];	
        	istekParca.aciklama=request.getParameter("urunaciklama");  
        	istekParca.birimFiyati=request.getParameter("birimfiyati"); 
        	
        	//System.out.println("try 1.3  ");
        	istekParca.setTutari();  
        	
            if(istekler==null){  //ilk istek oluşu yorsa burda oluşsun
            	//System.out.println("try 1.6  ");
                istekler=new IstekParca[1]; 
                istekler[0]=istekParca;           
            }
            else{
            	//System.out.println("try 1.7  ");
            	IstekParca[] tempStr=new IstekParca[istekler.length+1];   
                for(int i=0;i<istekler.length;i++)
                    tempStr[i]=istekler[i];
                tempStr[istekler.length]=istekParca;  
                istekler=tempStr;           
            }
        }     
        
       // System.out.println("try 2  ");
        
		//      isteklerden eleman silinecek
        if(istekler!=null){ 
            boolean[] silinecekMi=new boolean[istekler.length];
            int kacTaneSilinecek=0;
            for(int i=0; i<istekler.length;i++){
                if(request.getParameter("ers"+i)!=null){
                	
                	//javax.swing.JOptionPane.showMessageDialog(null,"silinecek buldu "+i);
                    silinecekMi[i]=true;
                    kacTaneSilinecek++;
                   
                }
                else
                    silinecekMi[i]=false;
            }
        
            IstekParca[] tempStr=new IstekParca[istekler.length-kacTaneSilinecek];  
            int tempCount=0;
            for(int j=0;j<istekler.length;j++)
                if(! silinecekMi[j])
                        tempStr[tempCount++]=istekler[j];
                
            istekler=tempStr;          
       }               
        
      //  System.out.println("try 3  ");
       session.setAttribute("istekler",istekler);
}catch(Exception e){
    out.println(""+e);	
	e.printStackTrace();
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="../../index/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">

<!-- VALIDATION SCRIPTS ---------------------------------------------- -->
<!-- Import validation script -->
<script language=javascript src="../validator.js"></script>

<!-- Script for limiting length ------------------>  
<script language=javascript  >
//Function limiting AD-SOYAD
function task_onblur2(str_item)
{
	//get value of the input
	str=str_item.value;
	//check boundaries
	if(str.length > 50) {
		//crop the string
    	str=str.substr(0,50);
    	//update the input
    	document.formy.adi.value=str;
    }
}

function checkmiktar(num_item)
{
  //miktar sıfır mı ona bakar
  var num=num_item.value; 
  if( num == "0")
   {
     alert("Miktar Değeri Sıfırdan Büyük Olmalıdır!");
   }
  return true;
}

</script>
<!-- ------------------------------------------------ --> 

<!-- end of VALIDATION SCRIPTS---------------------------------------- -->
<div id="toprightt"> </div>
<div id="topright2">

<div align="center">
    
           
        <p align="center"><strong> T.C. </strong></p>
        <p align="center"><strong>BOĞAZİÇİ ÜNİVERSİTESİ</strong>  </p>
   
     <p align="center"><font size=4 ><strong> İSTEK FİŞİ </strong> </font></p>
               <p align="center"></p>
              
	<br>
  </div>


<div align=center>

<table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont">
      <tr>
      	        <td width="46%" height="132" valign=top><div align="justify">
          <table width="98%"  border="0" bordercolor="#CCCCFF" class="tablefont">
            <tr>
              <td width="70">Seçilen Piyasa Seçeneği:</td>
              <td width="51%" style="FONT-WEIGHT : normal">
              <%
				if(_piyasa.equals("1"))
					out.println("Dahili Piyasa");
				else
					out.println("Harici Piyasa");
						%>
              </td>
            </tr>
             <%
            // System.out.println("3 kalem goster  "+_butceTertibi);
                 ResultSet rs=db.executeSP("KalemGoster_sp",new Object[]{_butceTertibi}).getResult();
              //	System.out.println("4 kalem goster  "+_butceTertibi);
				 String kalemAdi="";
                 if(rs.next())
                 {
                	// System.out.println("4.1 rs next var");
                	 kalemAdi=(String)rs.getString("KalemAdi");
                 }
                 else{
                	// System.out.println("4.2 rs next yok");
                	 
                	 
                 }
                 
                 db.closeConnection();
             %>
            <tr>
              <td width="49%">Bütçe Tertibi: </td>
              <td width="51%" style="FONT-WEIGHT : normal">
             <%=kalemAdi%>              </td>
            </tr>

            
          </table>
        </div></td>
                <td width="54%" valign="top"><table width="100%"  border="0" bordercolor="#CCCCFF" class="tablefont">
          <tr>
            <td width="33%"><label>Kod:</label></td>
            <td width="67%" align="left" style="FONT-WEIGHT : normal"><%=_NO%></td>
          </tr>
          <tr>
            <td width="33%"><label>Tarih</label></td>
            <td width="67%" align="left" style="FONT-WEIGHT : normal"><label  onFocus=""><%=_tarih%></label></td>
          </tr>
                                                          </table></td>
      </tr>
    </table>


</div>


<%
	if(istekler!=null) 
	if(istekler.length>0){  //secili istek yoksa bisey gosterme  
	
%>




<div align="center">
<form method="post" action="istekfisib.jsp" >


<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont2">
      <tr>
      <td width="6%">&nbsp;</td>
        <td width="13%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td colspan="3"><div align="center">Tahmini</div></td>
      </tr>
      <tr>
      	 <td><div align="center">Sil</div></td>

        <td><div align="center">Miktar</div></td>
        <td><div align="center">Ürün</div></td>
        <td><div align="center">Açıklama</div></td>
        <td width="17%"><div align="center">Birim Fiyatı (YTL)</div></td>
        <td width="13%"><div align="center">Tutarı (YTL)</div></td>
      </tr>

<%
	for(int i=0;i<istekler.length;i++)
                {
		genelTutar += istekler[i].tutari;
    %>

      	  <tr align="center">
      	   <td align="center" valign="top">
			<input type="checkbox" name=<%out.println("ers"+i);%> value=<%out.println(""+i);%>></td>

	        <td style="FONT-WEIGHT : normal"><label><%=istekler[i].miktar%></label></td>
	        <td style="FONT-WEIGHT : normal"><label><%=istekler[i].urun%></label></td>
	        <td style="FONT-WEIGHT : normal"><label><%=istekler[i].aciklama%></label></td>
	        <td style="FONT-WEIGHT : normal"><label><%=istekler[i].birimFiyati%></label></td>
	        <td style="FONT-WEIGHT : normal"><label><%=istekler[i].tutari%></label></td>
	      </tr> 
       

<%
}
%>

<tr align="center">
      	   <td valign="top" colspan=6 align=left>
			<input type=submit value="    Sil    " name="B1"></td>

	       </tr>






 </table>
 
 </form>
 </div>

<%
}//secili istek yoksa bisey gosterme
%>


<div align=center>
<form action=istekfisib.jsp  onsubmit="return validateForm(this)" method="post">	
<table width="79%"  border="1" bordercolor="#CCCCFF" class="tablefont2">

      <tr>
      	 
        <td><div align="center">Miktar</div></td>
        <td><div align="center">Ürün</div></td>
        <td><div align="center">Açıklama</div></td>
        <td width="21%"><div align="center">Tahmini Birim Fiyatı (YTL)</div></td>
        <td width="8%"><div align="center">&nbsp;</div></td>
      </tr>
      
      
      
      <tr>
      	 
        <td valign=top><div align="center"><input type="text" name="miktar" size="10" validator="number" ></div></td>
        <td valign=top><div align="center"><select size="1" name="urunNoSayisi">
<%
for(int i=0;i<_butceTertibiAlt.length;i++)
{
%>
<option value="<%=i%>"><%=_butceTertibiAlt[i]%></option>
<%
}
%>

</select></div></td>
        <td valign=top><div align="center"><textarea rows="2" name="urunaciklama" cols="27" validator="isim"></textarea></div></td>
        <td width="21%" valign=top><div align="center"><input type="text" name="birimfiyati" size="8" validator="YTL"></div></td>
        <td width="8%" valign=top><div align="center"><input type=submit value="Ekle" name="  Ekle  "></div></td>
      </tr>

      
      
      
</table>

</form>
</div>






<div align=center>
<form name="formy" action=fiskaydet.jsp onsubmit="return validateForm(this)" method=post>

<table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont">
      <tr>
      	        <td width="46%" height="132" valign=top><div align="justify">
          <table width="98%"  border="0" bordercolor="#CCCCFF" class="tablefont">
            <tr>
              <td width="100%" colspan="2"><label>İhtiyacı Talep Eden</label></td>
            </tr>
            
            <tr>
              <td width="36%"><label>Adı Soyadı:</label></td>
              <td width="59%">
                           <input type="text" name="adi" size="30" validator="isim" onblur="task_onblur2(this)"></td>
            </tr>
            
            <tr>
              <td width="36%"><label>Görev-Ünvanı</label></td>
              <td width="59%">
                          <input type="text" name="unvani" size="30" ></td>
            </tr>
           
            
          </table>        
          
          
          
          
        </div>
                
        
               
        </td>
                <td width="54%" valign="top"><table width="100%"  border="0" bordercolor="#CCCCFF" class="tablefont">
          <tr>
            <td width="33%"><label>Toplam:</label></td>
            <td width="67%" style="FONT-WEIGHT : normal"> <label><%=genelTutar %></label></td> 
          </tr>
          <tr>
            <td width="33%"><label>%18 KDV</label></td>
            <td width="67%" style="FONT-WEIGHT : normal"><label><%=( ((int)(genelTutar*18))/100.0) %></label></td>
          </tr>
          <tr>
            <td width="33%"><label>Genel Toplam</label></td>
            <td width="67%" style="FONT-WEIGHT : normal"><label  onFocus=""> <%=( ((int)(genelTutar*118))/100.0) %>  </label></td>
          </tr>
                                                          </table></td>
      </tr>
    </table>

<table width="79%"  border="0" bordercolor="#CCCCFF" class="tablefont">
         
             <tr>
              <td width="36%"></td>
              <td width="59%">
                <% 		
		if( istekler != null)
			if(istekler.length>0)
			{ %>
              <input type=submit value="     Kaydet     " name="kaydet" size=15>
           <%}%>
              
              




</form>

<form name="formz" action=fiskaydet.jsp  method=post>

	<input type=submit value="    İptal et    " size=15 name ="iptal">
                         </td>
            </tr>
</form>
</table>
</div>
  </div>
<div  align="left">
	
  </div>
	
	<div id="footer2">	  
    <p align="center"><b><font size="-2" face="Verdana, Arial, Helvetica, sans-serif color:black">
	Bilgisayar Mühendisligi ©2005</font></b></p>
	</div>
	
	
	
	
</body>
</html>