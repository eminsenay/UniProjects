<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"><title>Kandilli Earthquake Analysis</title>
<link href="css/design.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/ig.css">
<script type="text/javascript">
<!--
function setToday()
{
	var formName = document.forms['eqQuery'];
	var currentTime = new Date();
	var month = currentTime.getMonth() + 1;
	var day = currentTime.getDate();
	var year = currentTime.getFullYear();
	formName.to_day[day-1].selected = true;
	formName.to_month[month-1].selected = true;
	formName.to_year[year-2005].selected = true;
}
//-->
</script>
</head><body onload="setToday();">
<br>
<br>
<div id="tabs">
  <ul>
    <li class="tab spacer">&nbsp;</li>
	<li class="tab unselectedtab_l">&nbsp;</li>
    <li id="tab1_view" class="tab unselectedtab" style="display: block;" onclick="document.location.href='index.jsp'"><span id="tab1_view_title">Home</span></li>
	<li class="tab unselectedtab_r">&nbsp;</li>
    <li class="tab unselectedtab_l">&nbsp;</li>
    <li id="tab1_view" class="tab unselectedtab" style="display: block;" onclick="document.location.href='stations.jsp'"><span id="tab1_view_title">Stations</span></li>
	<li class="tab unselectedtab_r">&nbsp;</li>
	<li class="tab selectedtab_l">&nbsp;</li>
    <li id="tab0_edit" class="tab edittab selectedtab" style="display: none;">
    </li>
    <li id="tab0_view" class="tab selectedtab" style="display: block;" title="Search for an earthquake"><span id="tab0_view_title">Earthquake Search</span></li>
    <li class="tab selectedtab_r">&nbsp;</li>
    <li class="tab" id="addstuff"></li>
  </ul>
</div>
<p>&nbsp; </p>
<table width="100%" border="0">
  <tr>
    <td valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td valign="top">
      <p align="center">Please fill in the blanks to specify earthquakes you want to
        display:</p>
		<form name="eqQuery" method="post" action="eqQueryAction.jsp">
      <table width="450" border="1" align="center" cellpadding="2" cellspacing="0" class="queryTable">
        <tr>
          <th colspan="10">Date</th>
        </tr>
        <tr>
          <td width="4%">From:</td>
          <td width="3%"><select name="from_day" id="from_day">
            <option value="1" selected="selected">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
            <option value="19">19</option>
            <option value="20">20</option>
            <option value="21">21</option>
            <option value="22">22</option>
            <option value="23">23</option>
            <option value="24">24</option>
            <option value="25">25</option>
            <option value="26">26</option>
            <option value="27">27</option>
            <option value="28">28</option>
            <option value="29">29</option>
            <option value="30">30</option>
            <option value="31">31</option>
          </select>
          </td>
          <td width="3%"><select name="from_month" id="from_month">
		    <option value="1" selected="selected">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
          </select>
          </td>
          <td width="4%"><select name="from_year" id="from_year">
            <option value="2005" selected="selected">2005</option>
            <option value="2006">2006</option>
            <option value="2007">2007</option>
          </select>
          </td>
          <td width="5%">&nbsp;</td>
          <td width="2%">To:</td>
          <td width="3%"><select name="to_day" id="to_day">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
            <option value="19">19</option>
            <option value="20">20</option>
            <option value="21">21</option>
            <option value="22">22</option>
            <option value="23">23</option>
            <option value="24">24</option>
            <option value="25">25</option>
            <option value="26">26</option>
            <option value="27">27</option>
            <option value="28">28</option>
            <option value="29">29</option>
            <option value="30">30</option>
            <option value="31">31</option>
          </select></td>
          <td width="3%"><select name="to_month" id="to_month">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
          </select></td>
          <td colspan="2"><select name="to_year" id="to_year">
            <option value="2005">2005</option>
            <option value="2006">2006</option>
            <option value="2007">2007</option>
          </select></td>
        </tr>
        <tr>
          <th colspan="10">Latitude</th>
        </tr>
        <tr>
          <td>From:</td>
          <td><input name="from_latitude" type="text" size="4" maxlength="3" /></td>
          <td colspan="3">&nbsp;</td>
          <td>To:</td>
          <td colspan="4"><input name="to_latitude" type="text" size="4" maxlength="3" /></td>
        </tr>
        <tr>
          <th colspan="10">Longtitude</th>
        </tr>
        <tr>
          <td>From:</td>
          <td><input name="from_longtitude" type="text" size="4" maxlength="3" /></td>
          <td colspan="3">&nbsp;</td>
          <td>To:</td>
          <td colspan="4"><input name="to_longtitude" type="text" size="4" maxlength="3" /></td>
        </tr>
        <tr>
          <th colspan="10">Magnitude</th>
        </tr>
        <tr>
          <td>From:</td>
          <td><input name="from_magnitude" type="text" size="4" maxlength="3" /></td>
          <td colspan="3">&nbsp;</td>
          <td>To:</td>
          <td colspan="4"><input name="to_magnitude" type="text" size="4" maxlength="3" /></td>
        </tr>
        <tr>
          <td align="center" colspan="10"><input
			name="Submit" type="submit" class="submit" value="Display" /></td>
        </tr>
      </table>
	  </form>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr>
    <td valign="top"><div align="center" class="modtitle"><span class="notifier">This project is created by Emin &#350;enay &amp;Atilla Soner Balk&#305;r </span></div></td>
  </tr>
</table>
</body></html>