<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="	java.util.Vector, 
					bts.cmpe.budget.businessObj.TransferBusinessObj, 
					bts.cmpe.budget.transfer.TransferTO,
					bts.cmpe.budget.transfer.BudgetTO, 
					global.InputChecker" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
		<link href="css/gui.css" rel="stylesheet" type="text/css" />
	</head>

	<body bgcolor="#FFFFFF">
		<div align="left">
			<div id="toprightt"></div>
			<div id="topright2">
				<table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
			  		<tr>
			  			<td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350" /></td>
						<td valign="top">
		
<%//-----------------------------------------------------%>	
<%//DYNAMIC PAGE HERE BELOW!!!!%>


<%
	final String ACTION		= "action";			// sayfanin calisacagi action modu
	final String MSG		= "errorMessage";	// gelen uyari mesaji
	final String INST_CODE	= "inst";			// kurumsal kod
	final String FUNC_CODE	= "func";			// fonksiyonel kod
	final String ECO_CODE	= "eco";			// ekonomik kod
	final String INST_CODE2	= "inst2";			// kurumsal kod, dusulen (var ise)
	final String FUNC_CODE2	= "func2";			// fonksiyonel kod, dusulen (var ise)
	final String ECO_CODE2	= "eco2";			// ekonomik kod, dusulen (var ise)
	final String AMTLIRA	= "miktarLira";		// lira miktari
	final String AMTKURUS	= "miktarKurus";	// kurus miktari
	final String DESC		= "aciklama";		// transfer aciklamasi
	final String CONFIRMED	= "confirmed";		// transfer kontrol edilip onaylanmis?
	final String ERRORPAGE	= "error.jsp";		// hata sayfasi dosya adi
	final String SELFPAGE	= "transfer.jsp";	// bu sayfanin dosya adi
	
	
	String alertMsg = "";			// uyari mesaji

	String pAction = "transfer";	// sayfayi acma modu

	String pInst = "";				// kurumsal kod, goruntulenenin veya eklenenin
	String pFunc = "";				// fonksiyonel kod
	String pEco = "";				// ekonomik kod

	String pInst2 = "";				// kurumsal kod, dusulenin
	String pFunc2 = "";				// fonksiyonel kod
	String pEco2 = "";				// ekonomik kod

	String pDesc = "";				// transfer aciklamasi

	String pAmtLira = "";			// transfer miktari lira kismi
	String pAmtKurus = "";			// transfer miktari kurus kismi

	if(session.getAttribute(MSG) != null) {
		
		alertMsg = (String) session.getAttribute(MSG);
		session.removeAttribute(MSG);
		
		%><ul><li><font color="#CC0000"><%=alertMsg%></font></li></ul><br /><br /><%
	}
	
	if(request.getParameter(ACTION) != null) // bir "action" tanimlanmissa, duzgun birsey olsun
	{
		pAction = request.getParameter(ACTION).toString();

		if(request.getParameter(INST_CODE) == null || request.getParameter(FUNC_CODE) == null || request.getParameter(ECO_CODE) == null)
		{
			// bunlarin hepsi olmadan, hicbiri ise yaramiyor: herhangi birini isleme sokmanin luzumu yok
			// add, subtract, view, confirm yapilamaz!
		
			if(pAction.compareTo("add") != 0 && pAction.compareTo("subtract") != 0 && pAction.compareTo("view") != 0 && pAction.compareTo("confirm") != 0)
			{
				pAction = "transfer"; // add, subtract, view, confirm degilse transfer olmak zorunda
			}
			
			else
			{
				alertMsg = "Bir defter tanımlanmamış, Bütçe Takip Sistemi bu işlemi gerçekleştirmeniz için bir tanım yapmanızı zorunlu kılıyor.";
				session.setAttribute(MSG, alertMsg);
				response.sendRedirect(ERRORPAGE);
				return;
			}
		}
		
		else // defter tanimli, action tanimli degil
		{
			if(pAction.compareTo("add") != 0 && pAction.compareTo("subtract") != 0 && pAction.compareTo("transfer") != 0 && pAction.compareTo("confirm") != 0)
			{
				pAction = "view"; // add, subtract, transfer, confirm degilse view olmak zorunda
			}
		}
	}

	if(request.getParameter(INST_CODE) != null) // kurumsal kod okumasi
	{
		pInst = request.getParameter(INST_CODE).toString();
		
		if(!InputChecker.checkStringCanEmpty(pInst))
		{
			alertMsg = "Kurumsal kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}
	
	if(request.getParameter(FUNC_CODE) != null) // fonksiyonel kod okumasi
	{
		pFunc = request.getParameter(FUNC_CODE).toString();
		
		if(!InputChecker.checkStringCanEmpty(pFunc))
		{
			alertMsg = "Fonksiyonel kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}
	
	if(request.getParameter(ECO_CODE) != null) // ekonomik kod okumasi
	{
		pEco = request.getParameter(ECO_CODE).toString();
		
		if(!InputChecker.checkStringCanEmpty(pEco))
		{
			alertMsg = "Ekonomik kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}
	
	if(request.getParameter(INST_CODE2) != null) // kurumsal kod 2 okumasi
	{
		pInst2 = request.getParameter(INST_CODE2).toString();
		
		if(!InputChecker.checkStringCanEmpty(pInst2))
		{
			alertMsg = "Kurumsal kod 2 işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}

	if(request.getParameter(FUNC_CODE2) != null) // fonksiyonel kod okumasi
	{
		pFunc2 = request.getParameter(FUNC_CODE2).toString();
		
		if(!InputChecker.checkStringCanEmpty(pFunc2))
		{
			alertMsg = "Fonksiyonel kod 2 işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}

	if(request.getParameter(ECO_CODE2) != null) // ekonomik kod 2 okumasi
	{
		pEco2 = request.getParameter(ECO_CODE2).toString();
		
		if(!InputChecker.checkStringCanEmpty(pEco2))
		{
			alertMsg = "Ekonomik kod 2 işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}
	
	if(request.getParameter(AMTLIRA) != null) // lira miktari okumasi
	{
		pAmtLira = request.getParameter(AMTLIRA).toString();
		
		if(!InputChecker.checkStringCanEmpty(pAmtLira))
		{
			alertMsg = "Lira miktarı işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}
	
	if(request.getParameter(AMTKURUS) != null) // kurus miktari okumasi
	{
		pAmtKurus = request.getParameter(AMTKURUS).toString();
		
		if(!InputChecker.checkStringCanEmpty(pAmtKurus))
		{
			alertMsg = "Kuruş miktarı işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}
	
	if(request.getParameter(DESC) != null) // aciklama hanesi okumasi
	{
		pDesc = request.getParameter(DESC).toString();
		
		if(!InputChecker.checkStringCanEmpty(pDesc))
		{
			alertMsg = "Açıklama hanesi işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			session.setAttribute(MSG, alertMsg);
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}

	if(pAction.compareTo("view") == 0) // goruntuleme yapilacak, yaparken bolum olup olmadigi da kontrol edilsin
	{

		try
		{
			BudgetTO dept = new BudgetTO(pInst, pFunc, pEco);

			TransferBusinessObj trans = new TransferBusinessObj();

			Vector<TransferTO> transfers = trans.getAllTransfers(dept);

			%>
			<h1>Eklenen (Transfer) Görüntüleme [<%=pInst %>:<%=pFunc %>:<%=pEco %>]</h1><br /><br />

			<table width="560" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="80">Kurumsal</td>
					<td width="80">Fonksiyonel</td>
					<td width="80">Ekonomik</td>
					<td width="120">Miktar</td>
					<td width="200">Açıklama</td>
				</tr>
			<%

			for(TransferTO t : transfers)
			{
				BudgetTO d = t.getFrom();
				
				String colorHex = "#000000"; // renkler siyah olsun once

				if(t.getQuantity() < 0.0)
				{
					colorHex = "#CC0000"; // transfer eksi ise, renk kirmizi olur
					d = t.getTo();
				}

				%>
				<tr>
					<td width="80"><font color="<%=colorHex %>"><%=d.getInstCode() %></font></td>
					<td width="80"><font color="<%=colorHex %>"><%=d.getFuncCode() %></font></td>
					<td width="80"><font color="<%=colorHex %>"><%=d.getEcoCode() %></font></td>
					<td width="120"><font color="<%=colorHex %>"><%=t.getQuantity() %></font></td>
					<td width="200"><font color="<%=colorHex %>"><%=t.getDescription() %></font></td>
				</tr>
				<%
			}

			%>
				<tr>
					<td width="80">TOPLAM</td>
					<td width="80"></td>
					<td width="80"></td>
					<td width="120"><% System.out.println( trans.getTransferTotal(dept)); %></td>
					<td width="200"></td>
				</tr>

			</table>
			<br />
			<br />
			<form name="defineTransfer" action="<%=SELFPAGE %>" method="get">
				<table width="560" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="260" align="left">
							<select class="inputCell" name="<%=ACTION %>">
								<option value="add">Eklenen Olarak</option>
								<option value="subtract">Düşülen Olarak</option>
							</select>
							<input type="hidden" name="<%=INST_CODE %>" value="<%=pInst %>" />
							<input type="hidden" name="<%=FUNC_CODE %>" value="<%=pFunc %>" />
							<input type="hidden" name="<%=ECO_CODE %>" value="<%=pEco %>" />
						</td>
						<td width="300" align="left">
							<input class="mybutton" type="submit" value="Transfer Oluştur" />
						</td>
					</tr>
				</table>
			</form>
			<%
		}
		catch(Exception ex) {
			session.setAttribute(MSG, ex.getMessage());
			response.sendRedirect(ERRORPAGE);
			return;
		}

	}

	else if((pAction.compareTo("add") == 0) || (pAction.compareTo("subtract") == 0) || (pAction.compareTo("transfer") == 0)) // transfer yapilacak
	{
		try
		{
			if(pAction.compareTo("subtract") == 0) // eger "subtract" ise, "confirm" den gelen "transfer" ile ayni degisken isimleri kullanilsin
			{
				pInst2	= pInst;
				pFunc2	= pFunc;
				pEco2	= pEco;
			}

			%>
			<h1>Transfer Tanımlama</h1><br />

			<form name="confirmTransfer" action="<%=SELFPAGE %>" method="get">
				<table width="560" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="110" align="left">Eklenen:</td>
						<td width="150" align="left"><input class="inputCell" type="text" name="<%=INST_CODE %>"
							value="<% if((pAction.compareTo("add") == 0) || (pAction.compareTo("transfer") == 0)) {%><%=pInst %><%} %>" />
						</td>
						<td width="150" align="left"><input class="inputCell" type="text" name="<%=FUNC_CODE %>"
							value="<% if((pAction.compareTo("add") == 0) || (pAction.compareTo("transfer") == 0)) {%><%=pFunc %><%} %>" />
						</td>
						<td width="150" align="left"><input class="inputCell" type="text" name="<%=ECO_CODE %>"
							value="<% if((pAction.compareTo("add") == 0) || (pAction.compareTo("transfer") == 0)) {%><%=pEco %><%} %>" />
						</td>				
					</tr>
					<tr>
						<td width="110" align="left"></td>
						<td width="150" align="left">Kurumsal</td>
						<td width="150" align="left">Fonksiyonel</td>
						<td width="150" align="left">Ekonomik</td>				
					</tr>
					<tr>
						<td width="110" align="left">Düşülen:</td>
						<td width="150" align="left"><input class="inputCell" type="text" name="<%=INST_CODE2 %>"
							value="<% if((pAction.compareTo("subtract") == 0) || (pAction.compareTo("transfer") == 0)) {%><%=pInst2 %><%} %>" />
						</td>
						<td width="150" align="left"><input class="inputCell" type="text" name="<%=FUNC_CODE2 %>"
							value="<% if((pAction.compareTo("subtract") == 0) || (pAction.compareTo("transfer") == 0)) {%><%=pFunc2 %><%} %>" />
						</td>
						<td width="150" align="left"><input class="inputCell" type="text" name="<%=ECO_CODE2 %>"
							value="<% if((pAction.compareTo("subtract") == 0) || (pAction.compareTo("transfer") == 0)) {%><%=pEco2 %><%} %>" />
						</td>				
					</tr>
				</table>
					
				<br />
				<br />
				
				<table width="560" border="0" cellspacing="0" cellpadding="0">
					<tr valign="top">
						<td width="200" align="left">
							Açıklama:<br />
							<textarea class="inputCell" name="<%=DESC %>" cols="30" rows="5"><%=pDesc %></textarea>
						</td>
						<td width="260" align="left">
							Tutar:<br />
							<input class="inputCell" name="<%=AMTLIRA %>" type="text" size="14" maxlength="13" value="<%=pAmtLira %>" />,<input class="inputCell" name="<%=AMTKURUS %>" type="text" size="3" maxlength="2" value="<%=pAmtKurus %>" />
						</td>
						<td width="100" align="left">
							<input type="hidden" name="<%=ACTION %>" value="confirm" />
							<input class="mybutton" type="submit" value="Transferi Kontrol Et" />
						</td>
					</tr>
				</table>
			</form>
			<%
			
		}
		
		catch(Exception ex) {
			session.setAttribute(MSG, ex.getMessage());
			response.sendRedirect(ERRORPAGE);
			return;
		}
	}
		
	else // confirm ekrani ve transferin gerceklestirilmesi
	{		
		boolean confirmationFlag = true;
		
		String[] confirmedString = new String[9];
		
		int confirmLira = 0;
		int confirmKurus = 0;
		
		double confirmAmt = 0.0;

		confirmedString[0]	= (String)request.getParameter(INST_CODE);
		confirmedString[1]	= (String)request.getParameter(FUNC_CODE);
		confirmedString[2]	= (String)request.getParameter(ECO_CODE);
		confirmedString[3]	= (String)request.getParameter(INST_CODE2);
		confirmedString[4]	= (String)request.getParameter(FUNC_CODE2);
		confirmedString[5]	= (String)request.getParameter(ECO_CODE2);
		confirmedString[6]	= (String)request.getParameter(DESC);
		confirmedString[7]	= (String)request.getParameter(AMTLIRA);
		confirmedString[8]	= (String)request.getParameter(AMTKURUS);
		
		for(int i = 0; i < confirmedString.length; i++) // string parametre kontrollerini yap, hepsini dogrula
		{
			if( ! InputChecker.checkString(confirmedString[i]))
			{
				confirmationFlag = false;
				confirmedString[i] = "";
			}
		}
		
		pInst		= confirmedString[0];
		pFunc		= confirmedString[1];
		pEco		= confirmedString[2];
		pInst2		= confirmedString[3];
		pFunc2		= confirmedString[4];
		pEco2		= confirmedString[5];
		pDesc		= confirmedString[6];
		pAmtLira	= confirmedString[7];
		pAmtKurus	= confirmedString[8];
		
		if(confirmationFlag && InputChecker.checkInt(pAmtLira) && InputChecker.checkInt(pAmtKurus)) // halen temiz gidiyoruz
		{
			confirmLira		= Integer.parseInt(pAmtLira);
			confirmKurus	= Integer.parseInt(pAmtKurus);
			
			if(confirmLira >= 0 && confirmKurus >= 0) // girdiler negatif degil ise, miktari olustur
			{
				confirmAmt = confirmLira + ((double)confirmKurus / 100);
			}
			
			else
			{
				confirmationFlag = false;
				
				confirmLira		= 0;
				confirmKurus	= 0;
				pAmtLira        = "";
				pAmtKurus 		= "";
			}
		}
		
		else
		{
			confirmationFlag = false;
		}

		try
		{
			if(confirmationFlag) // tum veriler formatlari hatasiz bir sekilde geldi
			{
				BudgetTO to		= new BudgetTO(pInst, pFunc, pEco);
				BudgetTO from	= new BudgetTO(pInst2, pFunc2, pEco2);
				
				TransferBusinessObj trans = new TransferBusinessObj();
			
				if(trans.isTranferAvailable(from, confirmAmt))
				{
					if(	request.getParameter(CONFIRMED) != null && // onaylanmis ve transfer yapilacak
						request.getParameter(CONFIRMED).toString().compareTo("yes") == 0)
					{
						trans.makeTransfer(to, from, confirmAmt, pDesc);
						
						alertMsg = 	pInst2 + ":" + pFunc2 + ":" + pEco2 + " kodlu defterden " +
									pAmtLira + "," + pAmtKurus + " başarılı bir şekilde " + 
									pInst + ":" + pFunc + ":" + pEco + " kodlu deftere aktarıldı.";
									
						session.setAttribute(MSG, alertMsg);
						response.sendRedirect(SELFPAGE + "?" + ACTION + "=transfer");
						return;
					}
			
					else // onay yapilmamis ama bilgilerin tamami dogru, ve transfer yapilabilir durumda
					{
						%>
						<h1>Transfer Onaylama</h1><br />
						
						<form name="makeTransfer" action="<%=SELFPAGE %>" method="get">
							<table width="560" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="110" align="left">Eklenen:</td>
									<td width="150" align="left">
										<%=pInst %><input type="hidden" name="<%=INST_CODE %>" value="<%=pInst %>" />
									</td>
									<td width="150" align="left">
										<%=pFunc %><input type="hidden" name="<%=FUNC_CODE %>" value="<%=pFunc %>" />
									</td>
									<td width="150" align="left">
										<%=pEco %><input type="hidden" name="<%=ECO_CODE %>" value="<%=pEco %>" />
									</td>				
								</tr>
								<tr>
									<td width="110" align="left"></td>
									<td width="150" align="left">Kurumsal</td>
									<td width="150" align="left">Fonksiyonel</td>
									<td width="150" align="left">Ekonomik</td>				
								</tr>
								<tr>
									<td width="110" align="left">Düşülen:</td>
									<td width="150" align="left">
										<%=pInst2 %><input type="hidden" name="<%=INST_CODE2 %>" value="<%=pInst2 %>" />
									</td>
									<td width="150" align="left">
										<%=pFunc2 %><input type="hidden" name="<%=FUNC_CODE2 %>" value="<%=pFunc2 %>" />
									</td>
									<td width="150" align="left">
										<%=pEco2 %><input type="hidden" name="<%=ECO_CODE2 %>" value="<%=pEco2 %>" />
									</td>				
								</tr>
							</table>
								
							<br />
							<br />
							
							<table width="560" border="0" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td width="200" align="left">
										Açıklama:<br />
										<%=pDesc %>
										<input type="hidden" name="<%=DESC %>" value="<%=pDesc %>" />
									</td>
									<td width="260" align="left">
										Tutar:<br />
										<%=pAmtLira %>,<%=pAmtKurus %>
										<input type="hidden" name="<%=AMTLIRA %>" value="<%=pAmtLira %>" />
										<input type="hidden" name="<%=AMTKURUS %>" value="<%=pAmtKurus %>" />
									</td>
									<td width="100" align="left">
										<input type="hidden" name="<%=ACTION %>" value="confirm" />
										<input type="hidden" name="<%=CONFIRMED %>" value="yes" />
										<input class="mybutton" type="submit" value="Transferi Onayla" />
									</td>
								</tr>
							</table>
						</form>
						<%
					}	
				}
				else // para yok "transfer", sayfasina uyari ver
				{
					alertMsg = "Bu işlemi gerçekleştirecek miktar mevcut değil. Lütfen tekrar deneyiniz.";
					
					session.setAttribute(MSG, alertMsg);

					response.sendRedirect(SELFPAGE +	"?" + ACTION + 		"=" + "transfer" + 
														"&" + INST_CODE + 	"=" + pInst + 
														"&" + FUNC_CODE + 	"=" + pFunc + 
														"&" + ECO_CODE + 	"=" + pEco + 
														"&" + INST_CODE2 + 	"=" + pInst2 + 
														"&" + FUNC_CODE2 + 	"=" + pFunc2 + 
														"&" + ECO_CODE2 + 	"=" + pEco2 + 
														"&" + DESC + 		"=" + pDesc + 
														"&" + AMTLIRA + 	"=" + pAmtLira + 
														"&" + AMTKURUS + 	"=" + pAmtKurus);
					return;
				}
			}
			
			else // girilen veriler uygun degilse bosaltildi, "transfer" sayfasini mevcut dogru bilgilerle geri cagir
			{
				alertMsg = 	"Aşağıda boşaltılmış alanlara girdiğiniz bilgiler hatalı bulundu. " + 
							"Lütfen üstten tire (') sembolünü kullanmayınız. " + 
							"Lütfen Lira ve Kuruş hanelerine sadece rakam (0-9) giriniz. ";
				
				session.setAttribute(MSG, alertMsg);
			
				response.sendRedirect(SELFPAGE +	"?" + ACTION + 		"=" + "transfer" + 
													"&" + INST_CODE + 	"=" + pInst + 
													"&" + FUNC_CODE + 	"=" + pFunc + 
													"&" + ECO_CODE + 	"=" + pEco + 
													"&" + INST_CODE2 + 	"=" + pInst2 + 
													"&" + FUNC_CODE2 + 	"=" + pFunc2 + 
													"&" + ECO_CODE2 + 	"=" + pEco2 + 
													"&" + DESC + 		"=" + pDesc + 
													"&" + AMTLIRA + 	"=" + pAmtLira + 
													"&" + AMTKURUS + 	"=" + pAmtKurus);
				return;
			}
			
		}
		
		catch(Exception e) // diger exception, "transfer" sayfasini bilgilerle geri cagir
		{
			alertMsg = "İşlem esnasında bir hata oluştu. Lütfen tekrar deneyiniz.";

			session.setAttribute(MSG, alertMsg);
		
			response.sendRedirect(SELFPAGE +	"?" + ACTION + 		"=" + "transfer" + 
												"&" + INST_CODE + 	"=" + pInst + 
												"&" + FUNC_CODE + 	"=" + pFunc + 
												"&" + ECO_CODE + 	"=" + pEco + 
												"&" + INST_CODE2 + 	"=" + pInst2 + 
												"&" + FUNC_CODE2 + 	"=" + pFunc2 + 
												"&" + ECO_CODE2 + 	"=" + pEco2 + 
												"&" + DESC + 		"=" + pDesc + 
												"&" + AMTLIRA + 	"=" + pAmtLira + 
												"&" + AMTKURUS + 	"=" + pAmtKurus);
			return;
		}	
		
	}
	
%>

<%//DYNAMIC PAGE HERE ABOVE!!!!%>
<%//-----------------------------------------------------%>
		
						</td>
			  		</tr>
			    	<tr>
			    		<td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50" /></td>
			    		<td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50" /></td>
			  		</tr>
				</table>
			</div>
	
			<div id="footer3">	  
			</div>
		</div>
	</body>
</html>

