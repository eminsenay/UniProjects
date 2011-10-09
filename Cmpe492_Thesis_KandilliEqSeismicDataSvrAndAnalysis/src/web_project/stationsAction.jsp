<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/ig.css">
<link href="css/design.css" rel="stylesheet" type="text/css" />
<title>Kandilli Earthquake Analysis</title>
<%@page import="earthquakeAnalysis.DB"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%
	String[] stTypes = new String[]{"", "Short", "Broadband", "Nanometrics"};
	ArrayList<String> latitude = new ArrayList<String>();
	ArrayList<String> longtitude = new ArrayList<String>();
	ArrayList<String> height = new ArrayList<String>();
	
	ArrayList<Double> d_latitude = new ArrayList<Double>();
	ArrayList<Double> d_longtitude = new ArrayList<Double>();
	ArrayList<Double> d_height = new ArrayList<Double>();
	
	ArrayList<Integer> stNo = new ArrayList<Integer>();
	ArrayList<Integer> stComponent = new ArrayList<Integer>();
	ArrayList<String> stType = new ArrayList<String>();
	
	ArrayList<String> stCode = new ArrayList<String>();
	ArrayList<String> stName = new ArrayList<String>();
	
	int request_sttype = Integer.parseInt(request.getParameter("sttype"));
	String sql_where = "";
	if (request_sttype != 0)
		sql_where = " WHERE sttype = " + request_sttype;
	
	String sql_selectSt = "SELECT * FROM eqstations" + sql_where;

	DB newDB = new DB();
	Connection conn = newDB.getConnection();
	Statement st_selectSt = conn.createStatement();

	ResultSet rs_selectSt = st_selectSt.executeQuery(sql_selectSt);

	NumberFormat form = new DecimalFormat("0.00");
	while (rs_selectSt.next()) {
		
		int int_stType = (rs_selectSt.getInt("sttype"));
		
		stType.add(stTypes[int_stType]);
		
		stCode.add(rs_selectSt.getString("stcode"));
		
		stName.add(rs_selectSt.getString("stname"));
		
		stNo.add(new Integer(rs_selectSt.getInt("stno")));
		
		double tmpNum = rs_selectSt.getDouble("stlatitude");
			
		d_latitude.add(tmpNum);
		latitude.add(form.format(tmpNum));

		tmpNum = rs_selectSt.getDouble("stlongtitude");
		d_longtitude.add(tmpNum);
		longtitude.add(form.format(tmpNum));
		
		tmpNum = rs_selectSt.getDouble("stheight");
		d_height.add(tmpNum);
		height.add(form.format(tmpNum));
		
		stComponent.add(new Integer(rs_selectSt.getInt("stcomponent")));					
	}
	rs_selectSt.close();
	st_selectSt.close();
	conn.close();
%>

<script
src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAIIBfHDvG-v81tqpt_erHtRTXcQf5axDxpXfsoouHMra-I61RKRTuT44u14T6JPOeUFsWQA37zshbkg"
	type="text/javascript"></script>
<script type="text/javascript">

    //<![CDATA[

    function load() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map"));
	map.enableDoubleClickZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GMapTypeControl());
        map.setCenter(new GLatLng(39.9208, 35.3000), 6);
	
	// Add 10 markers in random locations on the map
	//var bounds = map.getBounds();
	//var southWest = bounds.getSouthWest();
	//var northEast = bounds.getNorthEast();
	//var lngSpan = northEast.lng() - southWest.lng();
	//var latSpan = northEast.lat() - southWest.lat();
	<%
	for (int i = 0; i<latitude.size(); i++) {
	%>
	var point = new GLatLng(<%=d_latitude.get(i)%>,<%=d_longtitude.get(i)%>);
	<%
		String nextName = stName.get(i);
		int nextNo = ((Integer)stNo.get(i)).intValue();
	
		double nextHeight = ((Double)d_height.get(i)).doubleValue();
	%>
	map.addOverlay(createMarker(point, "<%=nextName%>", <%=nextNo%>, <%=(float)nextHeight%>));
	<%
	}
	%>
		}
	}
	// Creates a marker at the given point with the given number label
	function createMarker(point, name, no, height) {
		var baseIcon = new GIcon();
		var size = 15;
		//baseIcon.image = "http://labs.google.com/ridefinder/images/mm_20_blue.png";
		//baseIcon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
		//baseIcon.image = "http://maps.google.com/mapfiles/kml/pal4/icon55.png";
		//baseIcon.shadow = "http://maps.google.com/mapfiles/kml/pal4/icon55s.png";
		baseIcon.image = "images/station.png";
		//baseIcon.shadow = "http://maps.google.com/mapfiles/kml/pal4/icon55s.png";
		baseIcon.iconSize = new GSize(size, size);
		//baseIcon.shadowSize = new GSize(size, size);
		
		baseIcon.iconAnchor = new GPoint(0, 0);
		baseIcon.infoWindowAnchor = new GPoint(5, 1);
		
		var marker = new GMarker(point,baseIcon);
	  	GEvent.addListener(marker, "click", function() {
	  		marker.openInfoWindowHtml("Station No:<b> " + no + "</b><br>St. name:<b> " + name + "</b><br>Lat:<b> " + point.lat().toFixed(2) + "</b>&nbsp;&nbsp;&nbsp;Lon:<b> " + point.lng().toFixed(2) + "</b><br>Height:<b> " + height.toFixed(2) + "</b>");
	  });
	return marker;
	}
	
    //]]>
	</script>
<script type="text/javascript"> 
 	function divgizle(gizlenecek_div)  
 	{  
 		var temp = document.getElementById(gizlenecek_div).style;  
 		temp.visibility = "hidden";  
 	}  
 	function divgoster(gosterilecek_div)  
 	{  
 		var temp = document.getElementById(gosterilecek_div).style;  
 		temp.visibility = "visible";  
 	}  
 	</script>
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style></head>

<body onload="load()" onunload="GUnload()">
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
    <li id="tab0_view" class="tab selectedtab" style="display: block;" title="Display earthquake stations" onclick="document.location.href='stations.jsp'"><span id="tab0_view_title">Stations</span></li>
	<li class="tab unselectedtab_r">&nbsp;</li>
    <li class="tab selectedtab_r">&nbsp;</li>
    <li id="tab1_view" class="tab unselectedtab" style="display: block;" onclick="document.location.href='eqQuery.jsp'"><span id="tab1_view_title">Earthquake Search</span></li>
	<li class="tab unselectedtab_r">&nbsp;</li>
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
<%
	ArrayList lst = new ArrayList();
	for (int i = 0; i < latitude.size(); i++)
	{
		ArrayList tmp = new ArrayList();
		tmp.add(stType.get(i));
		tmp.add(stNo.get(i));
		tmp.add(stCode.get(i));
		tmp.add(stName.get(i));
		tmp.add(latitude.get(i));
		tmp.add(longtitude.get(i));
		tmp.add(height.get(i));
		tmp.add(stComponent.get(i));
		lst.add(tmp);
	}
    request.setAttribute( "test", lst );
    String lClass = "mars";
    pageContext.setAttribute("tableclass", lClass);
%>
<br/>	
<center>
<display:table name="test" id="_table" pagesize="20"  class="${tableclass}">
	<display:setProperty name="basic.empty.showtable" value="true"/>
	<%ArrayList temp= (ArrayList)_table;%>
	<display:column title="Type" sortable="true">
		<%=temp.get(0)%>	</display:column>
	<display:column title="Station No" sortable="true">
		<%=temp.get(1)%>	</display:column>	
	<display:column title="Station Code" sortable="true">
		<%=temp.get(2)%>	</display:column>	
	<display:column title="Station Name" sortable="true">
		<%=temp.get(3)%>	</display:column>
	<display:column title="Latitude" sortable="true">
		<%=temp.get(4)%>	</display:column>
	<display:column title="Longtitude" sortable="true">
		<%=temp.get(5)%>	</display:column>
	<display:column title="Height" sortable="true">
		<%=temp.get(6)%>	</display:column>	
	<display:column title="Component" sortable="true">
		<%=temp.get(7)%>	</display:column>
</display:table>
</center>
<br/>
<a name="mapStart" id="mapStart"></a>
<table>
	<tr>
		<td>
		<div id="goster"><a href="#mapStart"
			onclick="divgoster('map');divgizle('goster');divgoster('gizle');">Show the map
			</a></div>		</td>
		<td>
		<div id="gizle" style="visibility:hidden"><a href="#mapStart"
			onclick="divgizle('map');divgizle('gizle');divgoster('goster');">Hide the map</a></div>		</td>
	</tr>
</table></td>
  </tr>
  <tr>
    <td valign="top" align="center"><div id="map" style="width: 875px; height: 550px; visibility: hidden" align="center"></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="center" class="modtitle"><span class="notifier">This project is created by Emin &#350;enay &amp;Atilla Soner Balk&#305;r </span></div></td>
  </tr>
</table>
</body>
</html>
