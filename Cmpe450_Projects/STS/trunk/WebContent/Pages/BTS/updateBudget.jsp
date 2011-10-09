<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="system.*"%>	
<%@ page import="bts.cmpe.budget.businessObj.*"%>
<%@ page import="bts.cmpe.budget.transfer.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="global.InputChecker"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Boğaziçi Üniversitesi Satın Alma Sistemi</title>
<link href="css/gui.css" rel="stylesheet" type="text/css">
</head>

<body  bgcolor="#FFFFFF">
<div  align="left">
<div id="toprightt"> </div>
	<div id="topright2"> 
  
  
  <table border="0" cellspacing="0" cellpadding="0" width="600" height="500">
  

  <tr>
        <td width="50" height="350"><img src="../../images/spacer.gif" width="50" height="350"></td>
    <td valign="top">
    <h1>Bütçe Güncelleme</h1><br /><br />
		<%//-----------------------------------------------------%>	
        <%//DYNAMIC PAGE HERE BELOW!!!!%>
	<% 	final String selfPage = "updateBudget.jsp";
		final String errorPage = "error.jsp";

		final String ACTION = "action";
		final String INST_CODE = "inst";
		final String FUNC_CODE = "func";
		final String ECO_CODE = "eco";
		final String APPR_TYPE = "apprType";
		final String BUDGET_TYPE = "budgetType";
		
		final String ACTION1 = "action";
		final String INST_CODE1 = "inst";
		final String FUNC_CODE1 = "func";
		final String ECO_CODE1= "eco";
		final String APPR_TYPE1 = "apprType";
		final String BUDGET_TYPE1 = "budgetType";
		
		String actionStr = request.getParameter(ACTION);
//selecting default values for string type inputs
		String instStr = "";
		String funcStr = "";
		String ecoStr = "";
		String apprTypeStr;
		String budgetTypeStr;
		
		String instStr1 = "";
		String funcStr1 = "";
		String ecoStr1 = "";
		String apprTypeStr1;
		String budgetTypeStr1;
		

		if(actionStr == null) {
			
		} 

		else if(actionStr.compareTo("update") == 0) {
			instStr = request.getParameter(INST_CODE);
			funcStr = request.getParameter(FUNC_CODE);
			ecoStr = request.getParameter(ECO_CODE);
			apprTypeStr = request.getParameter(APPR_TYPE);
			budgetTypeStr = request.getParameter(BUDGET_TYPE);
			
			instStr1 = request.getParameter(INST_CODE1);
			funcStr1 = request.getParameter(FUNC_CODE1);
			ecoStr1 = request.getParameter(ECO_CODE1);
			apprTypeStr1 = request.getParameter(APPR_TYPE1);
			budgetTypeStr1 = request.getParameter(BUDGET_TYPE1);
			
			// input check block.
			if(!InputChecker.checkString(instStr)) {
				out.println("*Kurumsal kod alanı kısmını lütfen düzeltiniz.");
			} 
			else if(!InputChecker.checkString(funcStr)) {
				out.println("*Fonksiyonel kod alanı kısmını lütfen düzeltiniz.");
			}
			else if(!InputChecker.checkString(ecoStr)) {
				out.println("*Ekonomik kod alanı kısmını lütfen düzeltiniz.");
			}
			else if(!InputChecker.checkInt(apprTypeStr)) {
				out.println("*Ödenek tipi alanı kısmını lütfen düzeltiniz.");
			}
			else if(!InputChecker.checkInt(budgetTypeStr)) {
				out.println("*Bütçe tipi alanı kısmını lütfen düzeltiniz.");
			}
			else if(!InputChecker.checkString(instStr1)) {
				out.println("*Kurumsal kod alanı kısmını lütfen düzeltiniz.");
			} 
			else if(!InputChecker.checkString(funcStr1)) {
				out.println("*Fonksiyonel kod alanı kısmını lütfen düzeltiniz.");
			}
			else if(!InputChecker.checkString(ecoStr1)) {
				out.println("*Ekonomik kod alanı kısmını lütfen düzeltiniz.");
			}
			else if(!InputChecker.checkInt(apprTypeStr1)) {
				out.println("*Ödenek tipi alanı kısmını lütfen düzeltiniz.");
			}
			else if(!InputChecker.checkInt(budgetTypeStr1)) {
				out.println("*Bütçe tipi alanı kısmını lütfen düzeltiniz.");
			}
			
			
			else { // all inputs are correct in form. 
				// input check phase 2 
				// checking inputs value for legalization
				int budgetType = Integer.parseInt(budgetTypeStr);
				int apprType = Integer.parseInt(apprTypeStr);
				
				int budgetType1 = Integer.parseInt(budgetTypeStr1);
				int apprType1 = Integer.parseInt(apprTypeStr1);
				
				if(budgetType != BudgetTO.STD && budgetType != BudgetTO.WAGER){
					out.println("*Bütçe tipi alanı kısmını lütfen düzeltiniz.");
				} 
				else if(apprType != AppropriationTO.MONTH_3 &&
						apprType != AppropriationTO.MONTH_6) {
					out.println("*Ödenek tipi alanı kısmını lütfen düzeltiniz.");
				}
				
				else if(budgetType1 != BudgetTO.STD && budgetType != BudgetTO.WAGER){
					out.println("*Bütçe tipi alanı kısmını lütfen düzeltiniz.");
				} 
				else if(apprType1 != AppropriationTO.MONTH_3 &&
						apprType1 != AppropriationTO.MONTH_6) {
					out.println("*Ödenek tipi alanı kısmını lütfen düzeltiniz.");
				}

				else { // inputs are correct.
					try {
						BudgetBusinessObj budgetBO = new BudgetBusinessObj();
						BudgetTO oldbudget = new BudgetTO(instStr, funcStr, ecoStr,
								budgetType, 12 / apprType);
						
						BudgetTO newbudget = new BudgetTO(instStr1, funcStr1, ecoStr1,
								budgetType1, 12 / apprType1);
						
						budgetBO.updateDepartment(oldbudget,newbudget);
						out.println("Başarı ile güncellendi.");
					} catch(Exception ex) {
						session.setAttribute("errorMessage", ex.getMessage());
						response.sendRedirect(errorPage);
						return;
					}
				}
			}
		}
%>
<form action="<%=selfPage %>" method="get">
	<input type="hidden" name="action" value="update"/>
	<table cellpadding="1" cellspacing="1">
<tr>
	<td>Eski Bütçe</td>
</tr>
		<tr>
			<td>kurumsal:</td>
			<td><input class="inputCell" type="text" name="<%=INST_CODE%>" value="<%=instStr%>"/></td>
		<tr>
		<tr>
			<td>fonksiyonel:</td>
			<td><input class="inputCell" type="text" name="<%=FUNC_CODE%>" value="<%=funcStr%>"/></td>
		<tr>
		<tr>
			<td>ekonomik:</td>
			<td><input class="inputCell" type="text" name="<%=ECO_CODE%>" value="<%=ecoStr%>"/></td>
		<tr>
		<tr>
			<td>Bütçe tipi:</td>
			<td>
				<select class="inputCell" name="<%=BUDGET_TYPE %>">
				<option value="<%=BudgetTO.STD %>">Standart</option>
				<option value="<%=BudgetTO.WAGER %>">Maaş</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Ödenek tipi:</td>
			<td>
				<select class="inputCell" name="<%=APPR_TYPE %>">
				<option value="<%=AppropriationTO.MONTH_3%>">3 ayda bir</option>
				<option value="<%=AppropriationTO.MONTH_6%>">6 ayda bir</option>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
		</tr>
		
		<tr>
	<td><br /><br />Yeni Bütçe</td>
</tr>
		<tr>
			<td>kurumsal:</td>
			<td><input class="inputCell" type="text" name="<%=INST_CODE1%>" value="<%=instStr%>"/></td>
		<tr>
		<tr>
			<td>fonksiyonel:</td>
			<td><input class="inputCell" type="text" name="<%=FUNC_CODE1%>" value="<%=funcStr%>"/></td>
		<tr>
		<tr>
			<td>ekonomik:</td>
			<td><input class="inputCell" type="text" name="<%=ECO_CODE1%>" value="<%=ecoStr%>"/></td>
		<tr>
		<tr>
			<td>Bütçe tipi:</td>
			<td>
				<select class="inputCell" name="<%=BUDGET_TYPE1 %>">
				<option value="<%=BudgetTO.STD %>">Standart</option>
				<option value="<%=BudgetTO.WAGER %>">Maaş</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Ödenek tipi:</td>
			<td>
				<select class="inputCell" name="<%=APPR_TYPE1 %>">
				<option value="<%=AppropriationTO.MONTH_3%>">3 ayda bir</option>
				<option value="<%=AppropriationTO.MONTH_6%>">6 ayda bir</option>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><br/><input class="mybutton" type="submit" value="düzenle"></td>
		</tr>
		
	</table>
</form>		
        <%//DYNAMIC PAGE HERE ABOVE!!!!%>		
		<%//-----------------------------------------------------%>
		
		
		
		
</td>
  </tr>
    <tr>
    <td width="50" height="50"><img src="../../images/spacer.gif" width="50" height="50"></td>
    <td width="550" height="50"><img src="../../images/spacer.gif" width="550" height="50"></td>
  </tr>
</table>
	</div>
	
	<div id="footer3">	  

	</div>
	
	
	
	</div>
</body>
</html>




