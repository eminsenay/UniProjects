<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><title>Kandilli Earthquake Analysis</title>
<link rel="stylesheet" type="text/css" href="css/ig.css">
<link href="css/design.css" rel="stylesheet" type="text/css" />
</head><body>
<br>
<br>
<div id="tabs">
  <ul>
    <li class="tab spacer">&nbsp;</li>
	<li class="tab unselectedtab_l">&nbsp;</li>
    <li id="tab1_view" class="tab unselectedtab" style="display: block;" onclick="document.location.href='index.jsp'"><span id="tab1_view_title">Home</span></li>
	<li class="tab unselectedtab_l">&nbsp;</li>
    <li class="tab selectedtab_l">&nbsp;</li>
    <li id="tab0_edit" class="tab edittab selectedtab" style="display: none;">
    </li>
    <li id="tab0_view" class="tab selectedtab" style="display: block;" title="Display earthquake stations"><span id="tab0_view_title">Stations</span></li>
	<li class="tab unselectedtab_r">&nbsp;</li>
    <li class="tab selectedtab_r">&nbsp;</li>
    <li id="tab1_view" class="tab unselectedtab" style="display: block;" onclick="document.location.href='eqQuery.jsp'"><span id="tab1_view_title">Earthquake Search</span></li>
	<li class="tab unselectedtab_r">&nbsp;</li>
    <li class="tab" id="addstuff"></li>
  </ul>
</div>
      <p align="center">&nbsp;</p>
      <p align="center">Please select the type of the station you want to display:</p>
      <form name="eqQuery" method="post" action="stationsAction.jsp">
      <table width="450" border="1" align="center" cellpadding="2" cellspacing="0" class="queryTable">
        <tr>
          <td width="4%">Type:</td>
          <td width="3%"><select name="sttype">
            <option value="0" selected="selected">All</option>
            <option value="1">Short</option>
            <option value="2">Broadband</option>
            <option value="3">Nanometrics</option>
          </select>
          </td>
        </tr>
        <tr>
          <td align="center" colspan="10"><input
			name="Submit" type="submit" class="submit" value="Display" /></td>
        </tr>
      </table>
	  <p>&nbsp;</p>
	  <p>&nbsp;</p>
	  <p>&nbsp;</p>
</form>
<div align="center" class="modtitle"><span class="notifier">This project is created by Emin &#350;enay &amp;Atilla Soner Balk&#305;r </span></div>
<p>&nbsp; </p>
</body></html>