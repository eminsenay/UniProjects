<%@ include file="header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="bts.cmpe.budget.businessObj.TransferBusinessObj, 
bts.cmpe.budget.dal.transfer.TransferTO, 
bts.cmpe.budget.dal.transfer.DepartmentTO,
global.InputChecker, 
bts.cmpe.budget.dal.exception.NoSuchDepartmentException, 
java.sql.SQLException" %>

<%
	InputChecker inputChecker = new InputChecker();

	String alertMsg = "";  // uyari mesaji

	String pAction = "view"; // en kotu ihtimal goruntulemeyi deneyelim diye burada tanimli

	String pInst = ""; // kurumsal kod, goruntulenenin veya eklenenin
	String pFunc = ""; // fonksiyonel kod
	String pEco = ""; // ekonomik kod

	String pInst2 = ""; // kurumsal kod, dusulenin
	String pFunc2 = ""; // fonksiyonel kod
	String pEco2 = ""; // ekonomik kod

	String pDesc = ""; // transfer aciklamasi

	String pAmtLira = ""; // transfer miktari lira kismi
	String pAmtKurus = ""; // transfer miktari kurus kismi

	if(request.getSession().getAttribute("msg") != null) // aktarilan uyari mesajini ekrana bastir
	{
		alertMsg = request.getSession().getAttribute("msg").toString();

		%><h1><font color="#CC0000"><%=alertMsg %></font></h1><br /><br /><%
	}

	if(request.getSession().getAttribute("action") != null) // bir "action" tanimlanmissa, duzgun birsey olsun, yoksa view kalsin
	{
		pAction = request.getSession().getAttribute("action").toString();

		if(pAction.compareTo("add") != 0 && pAction.compareTo("subtract") != 0 && pAction.compareTo("transfer") != 0 && pAction.compareTo("confirm") != 0)
		{
			pAction = "view"; // add, subtract, transfer, confirm degilse view olmak zorunda
		}
	}

	if(request.getSession().getAttribute("kurumsal") == null || request.getSession().getAttribute("fonksiyonel") == null || request.getSession().getAttribute("ekonomik") == null)
	{
		// bunlarin hepsi olmadan, hicbiri ise yaramiyor: herhangi birini isleme sokmanin luzumu yok
		
		if(pAction.compareTo("transfer") != 0) // transfer olcaksa tanimsizlik olabilir, oda degilse hata versin
		{
			alertMsg = "Bir defter tanımlanmamış, Bütçe Takip Sistemi bir tanım yapmanızı zorunlu kılıyor.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}
	}

	else // defterlerden biri tanimli, o halde okuyalim, okurken kontrol edelim
	{
		pInst = request.getSession().getAttribute("kurumsal").toString();
		pFunc = request.getSession().getAttribute("fonksiyonel").toString();
		pEco = request.getSession().getAttribute("ekonomik").toString();

		if(!inputChecker.checkString(pInst))
		{
			alertMsg = "Kurumsal kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}

		else if(!inputChecker.checkString(pFunc))
		{
			alertMsg = "Fonksiyonel kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}

		else if(!inputChecker.checkString(pEco))
		{
			alertMsg = "Fonksiyonel kod işleme sokulamadı. Lütfen üstten tire (') karakterini kullanmayınız.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}
	}

	if(pAction.compareTo("view") == 0) // goruntuleme yapilacak, yaparken bolum olup olmadigi da kontrol edilsin
	{

		try
		{
			DepartmentTO dept = new DepartmentTO(pInst, pFunc, pEco);

			TransferBusinessObj trans = new TransferBusinessObj();

			TransferTO[] transfers = trans.getAllTransfers(dept);

			%>
			<h1>Eklenen (Transfer) Görüntüleme</h1><br /><br />

			<table width="760" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="80">Kurumsal</td>
					<td width="80">Fonksiyonel</td>
					<td width="80">Ekonomik</td>
					<td width="100">Birim Adı</td>
					<td width="120">Miktar</td>
					<td width="300">Açıklama</td>
				</tr>
			<%

			for(TransferTO t : transfers)
			{
				DepartmentTO d = t.getToWhom();

				String colorHex = "#000000"; // renkler siyah olsun once

				if(t.getQuantity() < 0.0)
				{
					colorHex = "#CC0000"; // transfer eksi ise, renk kirmizi olur
				}

				%>
				<tr>
					<td width="80"><font color="<%=colorHex %>"><%=d.getInstCode() %></font></td>
					<td width="80"><font color="<%=colorHex %>"><%=d.getFuncCode() %></font></td>
					<td width="80"><font color="<%=colorHex %>"><%=d.getEcoCode() %></font></td>
					<td width="100"><font color="<%=colorHex %>">BURADA BİRİM ADI OLACAK</font></td>
					<td width="120"><font color="<%=colorHex %>"><% System.out.printf("%.2lf", t.getQuantity() + " YTL"); %></font></td>
					<td width="200"><font color="<%=colorHex %>"><%=t.getDescription() %></font></td>
				</tr>
				<%
			}

			%>
				<tr>
					<td width="80">TOPLAM</td>
					<td width="80"></td>
					<td width="80"></td>
					<td width="200"></td>
					<td width="120"><% System.out.printf("%.2lf YTL", trans.getTransferTotal(dept)); %></td>
					<td width="200"></td>
				</tr>

			</table>
			<br />
			<br />
			<form name="defineTransfer" action="eklenen.jsp" method="get">
				<table width="760" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="360" align="left">
							<select name="action">
								<option value="subtract">Düşülen Olarak</option>
								<option value="add">Eklenen Olarak</option>
							</select>
							<input type="hidden" name="kurumsal" value="<%=pInst %>" />
							<input type="hidden" name="fonksiyonel" value="<%=pFunc %>" />
							<input type="hidden" name="ekonomik" value="<%=pEco %>" />
						</td>
						<td width="400" align="left">
							<input type="submit" name="transferOlustur" value="Transfer Oluştur" />
						</td>
					</tr>
				</table>
			</form>
			<%
		}

		catch(NoSuchDepartmentException e) // boyle bir bolum yok
		{
			alertMsg = "Kodu " + pInst + " : " + pFunc + " : " + pEco + " olan bir defter tanımlı değil. Lütfen kontrol ediniz.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}

		catch(SQLException e) // SQL patladi
		{
			alertMsg = "Veritabanında bir hata oluştu. Lütfen tekrar deneyiniz.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}

		catch(Exception e) // diger exception
		{
			alertMsg = "İşlem esnasında bir hata oluştu. Lütfen tekrar deneyiniz.";
			response.sendRedirect("error.jsp?msg=" + alertMsg);
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

			<form name="confirmTransfer" action="eklenen.jsp" method="get">
				<table width="760" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="160" align="left">Eklenen:</td>
						<td width="200" align="left"><input type="text" name="kurumsal"
							value="<% if((pAction.compareTo("add") == 0) || (pAction.compareTo("transfer") == 0)) { System.out.print(pInst); } %>" />
						</td>
						<td width="200" align="left"><input type="text" name="fonksiyonel"
							value="<% if((pAction.compareTo("add") == 0) || (pAction.compareTo("transfer") == 0)) { System.out.print(pFunc); } %>" />
						</td>
						<td width="200" align="left"><input type="text" name="ekonomik"
							value="<% if((pAction.compareTo("add") == 0) || (pAction.compareTo("transfer") == 0)) { System.out.print(pEco); } %>" />
						</td>				
					</tr>
					<tr>
						<td width="160" align="left"></td>
						<td width="200" align="left">Kurumsal</td>
						<td width="200" align="left">Fonksiyonel</td>
						<td width="200" align="left">Ekonomik</td>				
					</tr>
					<tr>
						<td width="160" align="left">Düşülen:</td>
						<td width="200" align="left"><input type="text" name="kurumsal2"
							value="<% if((pAction.compareTo("subtract") == 0) || (pAction.compareTo("transfer") == 0)) { System.out.print(pInst2); } %>" />
						</td>
						<td width="200" align="left"><input type="text" name="fonksiyonel2"
							value="<% if((pAction.compareTo("subtract") == 0) || (pAction.compareTo("transfer") == 0)) { System.out.print(pFunc2); } %>" />
						</td>
						<td width="200" align="left"><input type="text" name="ekonomik2"
							value="<% if((pAction.compareTo("subtract") == 0) || (pAction.compareTo("transfer") == 0)) { System.out.print(pEco2); } %>" />
						</td>				
					</tr>
				</table>
					
				<br />
				<br />
				
				<table width="760" border="0" cellspacing="0" cellpadding="0">
					<tr valign="top">
						<td width="300" align="left">
							Açıklama:<br />
							<textarea name="aciklama" value="<%=pDesc %>" cols="30" rows="5"></textarea>
						</td>
						<td width="260" align="left">
							Tutar:<br />
							<input name="miktarLira" type="text" size="14" maxlength="13" value="<%=pAmtLira %>" />,<input name="miktarKurus" type="text" size="3" maxlength="2" value="<%=pAmtKurus %>" />
						</td>
						<td width="200" align="left">
							<input type="hidden" name="action" value="confirm" />
							<input type="submit" name="transferOnayla" value="Transferi Kontrol Et" />
						</td>
					</tr>
				</table>
			</form>
			<%
			
		}
		
		catch(Exception e) // herhangi bir exception
		{
			alertMsg = "İşlem esnasında bir hata oluştu. Lütfen tekrar deneyiniz.";
			
			response.sendRedirect("error.jsp?msg=" + alertMsg);
		}
	}
		
	else // confirm ekrani ve transferin gerceklestirilmesi
	{		
		boolean confirmationFlag = true;
		
		Object[] confirmationObject = new Object[7];
		
		String[] confirmedString = new String[7];
		
		int confirmLira = 0;
		int confirmKurus = 0;
		
		double confirmAmt = 0.0;

		confirmationObject[0]	= request.getSession().getAttribute("kurumsal");
		confirmationObject[1]	= request.getSession().getAttribute("fonksiyonel");
		confirmationObject[2]	= request.getSession().getAttribute("ekonomik");
		confirmationObject[3]	= request.getSession().getAttribute("kurumsal2");
		confirmationObject[4]	= request.getSession().getAttribute("fonksiyonel2");
		confirmationObject[5]	= request.getSession().getAttribute("ekonomik2");
		confirmationObject[6]	= request.getSession().getAttribute("aciklama");
		
		for(int i = 0; i < confirmationObject.length; i++) // string parametre kontrollerini yap, hepsini dogrula
		{
			if(confirmationObject[i] != null)
			{
				confirmedString[i] = confirmationObject[i].toString();
			}
			
			else if(confirmationObject[i] == null || !inputChecker.checkString(confirmedString[i]))
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
		pAmtLira	= "";
		pAmtKurus	= "";
		
		if(	request.getSession().getAttribute("miktarLira") != null && // integer check yapilsin, ona gore devam
			request.getSession().getAttribute("miktarKurus") != null &&
			inputChecker.checkInt(request.getSession().getAttribute("miktarLira").toString()) &&
			inputChecker.checkInt(request.getSession().getAttribute("miktarKurus").toString()) )
		{
			pAmtLira	= request.getSession().getAttribute("miktarLira").toString();
			pAmtKurus	= request.getSession().getAttribute("miktarKurus").toString();
			
			confirmLira		= Integer.parseInt(pAmtLira);
			confirmKurus	= Integer.parseInt(pAmtKurus);
			
			if(confirmLira >= 0 || confirmKurus >= 0) // girdiler negatif degil ise, miktari olustur
			{
				try
				{
					confirmAmt = Double.parseDouble(	request.getSession().getAttribute("miktarLira").toString() +
														"," +
														request.getSession().getAttribute("miktarKurus").toString() );
				}
				
				catch(NumberFormatException e)
				{
					confirmationFlag = false;
					
					confirmLira		= 0;
					confirmKurus	= 0;
					confirmAmt		= 0.0;
				}
			}
			
			else
			{
				confirmationFlag = false;
				
				confirmLira		= 0;
				confirmKurus	= 0;
			}
		}
		
		else
		{
			confirmationFlag = false;
		}

		try
		{
			DepartmentTO to		= new DepartmentTO(pInst, pFunc, pEco);
			DepartmentTO from	= new DepartmentTO(pInst2, pFunc2, pEco2);
			
			TransferBusinessObj trans = new TransferBusinessObj();
			
			if(confirmationFlag) // tum veriler formatlari hatasiz bir sekilde geldi
			{
				if(trans.isTranferAvailable(to, from, confirmAmt))
				{
					if(	request.getSession().getAttribute("confirmed") != null && // onaylanmis ve transfer yapilacak
					request.getSession().getAttribute("confirmed").toString().compareTo("yes") == 0)
					{
						trans.makeTransfer(to, from, confirmAmt, pDesc);
						
						alertMsg = 	pInst2 + ":" + pFunc2 + ":" + pEco2 + " kodlu defterden " +
									pAmtLira + "," + pAmtKurus + " YTL başarılı bir şekilde " + 
									pInst + ":" + pFunc + ":" + pEco + " kodlu deftere aktarıldı.";
									
						response.sendRedirect("eklenen.jsp?action=transfer&msg=" + alertMsg);
					}
				
					
					else // para yok "transfer", sayfasina uyari ver
					{
						alertMsg = "Bu işlemi gerçekleştirecek miktar mevcut değil. Lütfen tekrar deneyiniz.";

						response.sendRedirect(	"eklenen.jsp?action=transfer" + 
												"&kurumsal=" + pInst + 
												"&fonksiyonel=" + pFunc + 
												"&ekonomik=" + pEco + 
												"&kurumsal2=" + pInst2 + 
												"&fonksiyonel2=" + pFunc2 + 
												"&ekonomik2=" + pEco2 + 
												"&aciklama=" + pDesc + 
												"&miktarLira=" + pAmtLira + 
												"&miktarKurus=" + pAmtKurus +
												"&msg=" + alertMsg);
					}
				}
			
				else // onay yapilmamis ama bilgilerin tamami dogru, ve transfer yapilabilir durumda
				{
					%>
					<h1>Transfer Onaylama</h1><br />
					
					<form name="makeTransfer" action="eklenen.jsp" method="get">
						<table width="760" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="160" align="left">Eklenen:</td>
								<td width="200" align="left">
									<%=pInst %><input type="hidden" name="kurumsal" value="<%=pInst %>" />
								</td>
								<td width="200" align="left">
									<%=pFunc %><input type="hidden" name="fonksiyonel" value="<%=pFunc %>" />
								</td>
								<td width="200" align="left">
									<%=pEco %><input type="hidden" name="ekonomik" value="<%=pEco %>" />
								</td>				
							</tr>
							<tr>
								<td width="160" align="left"></td>
								<td width="200" align="left">Kurumsal</td>
								<td width="200" align="left">Fonksiyonel</td>
								<td width="200" align="left">Ekonomik</td>				
							</tr>
							<tr>
								<td width="160" align="left">Düşülen:</td>
								<td width="200" align="left">
									<%=pInst2 %><input type="hidden" name="kurumsal2" value="<%=pInst2 %>" />
								</td>
								<td width="200" align="left">
									<%=pFunc2 %><input type="hidden" name="fonksiyonel2" value="<%=pFunc2 %>" />
								</td>
								<td width="200" align="left">
									<%=pEco2 %><input type="hidden" name="ekonomik2" value="<%=pEco2 %>" />
								</td>				
							</tr>
						</table>
							
						<br />
						<br />
						
						<table width="760" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td width="300" align="left">
									Açıklama:<br />
									<textarea name="aciklama" value="<%=pDesc %>" cols="30" rows="5" readonly="readonly"></textarea>
								</td>
								<td width="260" align="left">
									Tutar:<br />
									<%=pAmtLira %>,<%=pAmtKurus %> YTL
									<input type="hidden" name="miktarLira" value="<%=pAmtLira %>" />
									<input type="hidden" name="miktarKurus" value="<%=pAmtKurus %>" />
								</td>
								<td width="200" align="left">
									<input type="hidden" name="action" value="confirm" />
									<input type="hidden" name="confirmed" value="yes" />
									<input type="submit" name="transferYap" value="Transferi Onayla" />
								</td>
							</tr>
						</table>
					</form>
					<%
				}	
			}
			
			else // girilen veriler uygun degilse bosaltildi, "transfer" sayfasini mevcut dogru bilgilerle geri cagir
			{
				alertMsg = 	"Aşağıda boşaltılmış alanlara girdiğiniz bilgiler hatalı bulundu. " + 
							"Lütfen üstten tire (') sembolünü kullanmayınız. " + 
							"Lütfen Lira ve Kuruş hanelerine sadece rakam (0-9) giriniz. ";
			
				response.sendRedirect(	"eklenen.jsp?action=transfer" + 
										"&kurumsal=" + pInst + 
										"&fonksiyonel=" + pFunc + 
										"&ekonomik=" + pEco + 
										"&kurumsal2=" + pInst2 + 
										"&fonksiyonel2=" + pFunc2 + 
										"&ekonomik2=" + pEco2 + 
										"&aciklama=" + pDesc + 
										"&miktarLira=" + pAmtLira + 
										"&miktarKurus=" + pAmtKurus +
										"&msg=" + alertMsg);
			}
			
		}
			
		catch(NoSuchDepartmentException e) // boyle bir bolum yok, "transfer" sayfasini bilgilerle geri cagir
		{
			alertMsg = "Belirttiğiniz defter tanımlarında hata bulundu. Lütfen kontrol ediniz.";
			
			response.sendRedirect(	"eklenen.jsp?action=transfer" + 
									"&kurumsal=" + pInst + 
									"&fonksiyonel=" + pFunc + 
									"&ekonomik=" + pEco + 
									"&kurumsal2=" + pInst2 + 
									"&fonksiyonel2=" + pFunc2 + 
									"&ekonomik2=" + pEco2 + 
									"&aciklama=" + pDesc + 
									"&miktarLira=" + pAmtLira + 
									"&miktarKurus=" + pAmtKurus +
									"&msg=" + alertMsg);
		}
		
		catch(SQLException e) // SQL patladi, "transfer" sayfasini bilgilerle geri cagir
		{
			alertMsg = "Veritabanında bir hata oluştu. Lütfen tekrar deneyiniz.";
			
			response.sendRedirect(	"eklenen.jsp?action=transfer" + 
									"&kurumsal=" + pInst + 
									"&fonksiyonel=" + pFunc + 
									"&ekonomik=" + pEco + 
									"&kurumsal2=" + pInst2 + 
									"&fonksiyonel2=" + pFunc2 + 
									"&ekonomik2=" + pEco2 + 
									"&aciklama=" + pDesc + 
									"&miktarLira=" + pAmtLira + 
									"&miktarKurus=" + pAmtKurus +
									"&msg=" + alertMsg);
		}
		
		catch(Exception e) // diger exception, "transfer" sayfasini bilgilerle geri cagir
		{
			alertMsg = "İşlem esnasında bir hata oluştu. Lütfen tekrar deneyiniz.";

			response.sendRedirect(	"eklenen.jsp?action=transfer" + 
									"&kurumsal=" + pInst + 
									"&fonksiyonel=" + pFunc + 
									"&ekonomik=" + pEco + 
									"&kurumsal2=" + pInst2 + 
									"&fonksiyonel2=" + pFunc2 + 
									"&ekonomik2=" + pEco2 + 
									"&aciklama=" + pDesc + 
									"&miktarLira=" + pAmtLira + 
									"&miktarKurus=" + pAmtKurus +
									"&msg=" + alertMsg);
		}	
		
	}
	
%>

<%@ include file="footer.jsp" %>
