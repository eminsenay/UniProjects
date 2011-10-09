<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/template.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="css/design.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/ig.css">
<!-- InstanceBeginEditable name="title" -->
<title>Kandilli Earthquake Analysis</title>
<!-- InstanceEndEditable --><!-- InstanceBeginEditable name="jspcode" -->
<%@page import="earthquakeAnalysis.DB"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%
	ArrayList latitude = new ArrayList();
	ArrayList longtitude = new ArrayList();
	ArrayList magnitude = new ArrayList();
	ArrayList depth = new ArrayList();
	ArrayList d_latitude = new ArrayList();
	ArrayList d_longtitude = new ArrayList();
	ArrayList d_magnitude = new ArrayList();
	ArrayList d_depth = new ArrayList();
	ArrayList eqDate = new ArrayList();
	ArrayList d_eqDate = new ArrayList();
	ArrayList eqTime = new ArrayList();
	boolean warning = false;
	if (request.getParameter("Submit") == null) {
		warning = true;
	} else {
		// verileri al
		String fromDay = request.getParameter("from_day");
		String fromMonth = request.getParameter("from_month");
		String fromYear = request.getParameter("from_year");

		String toDay = request.getParameter("to_day");
		String toMonth = request.getParameter("to_month");
		String toYear = request.getParameter("to_year");

		String fromLatitude = request.getParameter("from_latitude");
		String toLatitude = request.getParameter("to_latitude");

		String fromLongtitude = request.getParameter("from_longtitude");
		String toLongtitude = request.getParameter("to_longtitude");

		String fromMagnitude = request.getParameter("from_magnitude");
		String toMagnitude = request.getParameter("to_magnitude");

		// gelenleri kontrol et, sayı geleceği kontrol ediliyor
		if (fromDay == null || fromDay.equals(""))
			fromDay = "1";
		if (fromMonth == null || fromMonth.equals(""))
			fromMonth = "1";
		if (fromYear == null || fromYear.equals(""))
			fromYear = "1900";

		if (toDay == null || toDay.equals(""))
			toDay = "31";
		if (toMonth == null || toMonth.equals(""))
			toMonth = "12";
		if (toYear == null || toYear.equals(""))
			toYear = "2500";

		if (fromLatitude == null || fromLatitude.equals(""))
			fromLatitude = "0";
		if (toLatitude == null || toLatitude.equals(""))
			toLatitude = "90";
		if (fromLongtitude == null || fromLongtitude.equals(""))
			fromLongtitude = "0";
		if (toLongtitude == null || toLongtitude.equals(""))
			toLongtitude = "90";
		if (fromMagnitude == null || fromMagnitude.equals(""))
			fromMagnitude = "-1";
		if (toMagnitude == null || toMagnitude.equals(""))
			toMagnitude = "13";

		String fromDate = fromYear + "-" + fromMonth + "-" + fromDay;
		String toDate = toYear + "-" + toMonth + "-" + toDay;		

		String sql_selectEq = "SELECT * FROM eqdata WHERE eqdate BETWEEN ? AND ? "
		+ "AND eqlatitude BETWEEN ? AND ? "
		+ "AND eqlongtitude BETWEEN ? AND ? "
		+ "AND eqmagnitude BETWEEN ? AND ? ";

		DB newDB = new DB();
		Connection conn = newDB.getConnection();
		if (conn != null)
		{
			PreparedStatement ps_selectEq = conn
			.prepareStatement(sql_selectEq);
			ps_selectEq.setString(1, fromDate);
			ps_selectEq.setString(2, toDate);
			ps_selectEq.setString(3, fromLatitude);
			ps_selectEq.setString(4, toLatitude);
			ps_selectEq.setString(5, fromLongtitude);
			ps_selectEq.setString(6, toLongtitude);
			ps_selectEq.setString(7, fromMagnitude);
			ps_selectEq.setString(8, toMagnitude);
	
			ResultSet rs_selectEq = ps_selectEq.executeQuery();
	
			NumberFormat form = new DecimalFormat("0.00");
			while (rs_selectEq.next()) {
				double tmpNum = rs_selectEq.getDouble("eqlatitude");
				
				d_latitude.add(new Double(tmpNum));
				latitude.add(form.format(tmpNum));
	
				tmpNum = rs_selectEq.getDouble("eqlongtitude");
				d_longtitude.add(new Double(tmpNum));
				longtitude.add(form.format(tmpNum));
				
				tmpNum = rs_selectEq.getDouble("eqmagnitude");
				if (tmpNum == -1)
					magnitude.add("N/A");
				else
					magnitude.add(form.format(tmpNum));
				d_magnitude.add(new Double(tmpNum));
				
				tmpNum = rs_selectEq.getDouble("eqdepth");			
				depth.add(form.format(tmpNum));
				d_depth.add(new Double(tmpNum));
							
				eqDate.add(rs_selectEq.getString("eqDate"));
				d_eqDate.add(rs_selectEq.getDate("eqDate"));
				
				eqTime.add(rs_selectEq.getString("eqTime"));			
			}
			rs_selectEq.close();
			ps_selectEq.close();
			conn.close();
		}
	}
%>

<!-- InstanceEndEditable --><!-- InstanceBeginEditable name="js" -->
<!--  localhost <script
	src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAIIBfHDvG-v81tqpt_erHtRTwM0brOpm-All5BF6PoaKBxRWWERQZKV6N2GbmvNOc8_9bTI5p7jUgHg"
	type="text/javascript"></script>-->
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
		double nextMagnitude = ((Double)d_magnitude.get(i)).doubleValue();
		Date nextDate = (Date)d_eqDate.get(i);
		String nextTime = (String)eqTime.get(i);
		double nextDepth = ((Double)d_depth.get(i)).doubleValue();
		if (nextMagnitude == -1)
		{
	%>
	map.addOverlay(createMarker(point, "N/A", <%=(float)nextDepth%>, "<%=nextDate%>", "<%=nextTime%>"));
	<%
		}
		else
		{
	%>
	map.addOverlay(createMarker(point, <%=(float)nextMagnitude%>, <%=(float)nextDepth%>, "<%=nextDate%>", "<%=nextTime%>"));
	<%			
		}
	}
	%>
		}
	}
	// Creates a marker at the given point with the given number label
	function createMarker(point, magnitude, depth, nextDate, nextTime) {
		var baseIcon = new GIcon();
		var size;
		if (magnitude == "N/A")
			size = 20;
		else
			size = 4*magnitude;
		//baseIcon.image = "http://labs.google.com/ridefinder/images/mm_20_blue.png";
		//baseIcon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
		//baseIcon.image = "http://maps.google.com/mapfiles/kml/pal4/icon55.png";
		//baseIcon.shadow = "http://maps.google.com/mapfiles/kml/pal4/icon55s.png";
		baseIcon.image = "images/icon2.png";
		//baseIcon.shadow = "http://maps.google.com/mapfiles/kml/pal4/icon55s.png";
		baseIcon.iconSize = new GSize(size, size);
		//baseIcon.shadowSize = new GSize(size, size);
		
		baseIcon.iconAnchor = new GPoint(0, 0);
		baseIcon.infoWindowAnchor = new GPoint(5, 1);
		
		var marker = new GMarker(point,baseIcon);
	  	GEvent.addListener(marker, "click", function() {
	  		if (magnitude == "N/A")
	  			marker.openInfoWindowHtml("Lat:<b> " + point.lat().toFixed(2) + "</b>&nbsp;&nbsp;&nbsp;Date:<b> " + nextDate + "</b><br>Lon:<b> " + point.lng().toFixed(2) + "</b>&nbsp;&nbsp;&nbsp;Time:<b> " + nextTime + "</b><br>Mgn:<b> " + magnitude + "</b>&nbsp;&nbsp;&nbsp;Depth:<b> " + depth.toFixed(2) + "</b>");
	  		else
	  			marker.openInfoWindowHtml("Lat:<b> " + point.lat().toFixed(2) + "</b>&nbsp;&nbsp;&nbsp;Date:<b> " + nextDate + "</b><br>Lon:<b> " + point.lng().toFixed(2) + "</b>&nbsp;&nbsp;&nbsp;Time:<b> " + nextTime + "</b><br>Mgn:<b> " + magnitude.toFixed(1) + "</b>&nbsp;&nbsp;&nbsp;Depth:<b> " + depth.toFixed(2) + "</b>");
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
<!-- InstanceEndEditable --><!-- InstanceParam name="onload" type="boolean" value="true" --><!-- InstanceParam name="ol" type="text" value="load()" --><!-- InstanceParam name="oul" type="text" value="GUnload()" -->
</head>
<body onload="load()" onunload="GUnload()">
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
    <td valign="top"><!-- InstanceBeginEditable name="MainPane" -->
<%
if (warning) {
%>
<p>Please use the query page.</p>
<%
} else {
	ArrayList lst = new ArrayList();
	for (int i = 0; i < latitude.size(); i++)
	{
		ArrayList tmp = new ArrayList();
		tmp.add(latitude.get(i));
		tmp.add(longtitude.get(i));
		tmp.add(magnitude.get(i));
		tmp.add(eqDate.get(i));
		tmp.add(eqTime.get(i));
		tmp.add(depth.get(i));
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
	<display:column title="Date" sortable="true">
		<%=temp.get(3)%>
	</display:column>
	<display:column title="Time" sortable="false">
		<%=temp.get(4)%>
	</display:column>	
	<display:column title="Latitude" sortable="true">
		<%=temp.get(0)%>
	</display:column>
	<display:column title="Longtitude" sortable="true">
		<%=temp.get(1)%>
	</display:column>
	<display:column title="Depth" sortable="true">
		<%=temp.get(5)%>
	</display:column>	
	<display:column title="Magnitude" sortable="true">
		<%=temp.get(2)%>
	</display:column>
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
    <td valign="top" align="center"><div id="map" style="width: 875px; height: 550px; visibility: hidden" align="center"></div>
<%
}
%>	
	
	<!-- InstanceEndEditable --></td>
  </tr>
  <tr>
    <td valign="top"><div align="center" class="modtitle"><span class="notifier">This project is created by Emin &#350;enay &amp;Atilla Soner Balk&#305;r </span></div></td>
  </tr>
</table>
</body>
<!-- InstanceEnd --></html>
