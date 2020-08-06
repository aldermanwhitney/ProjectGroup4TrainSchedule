<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Customer Rep</title>
</head>
<body>

<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
<b>Welcome <%=session.getAttribute("user")%> </b>
<a href='logout.jsp'>Log out</a>
<br>
<i>You have Customer Rep privileges</i>
<%
    }
%>


<h1>Add New Train Schedule</h1> 
	<form method ="post" action="addTrainsScheduleToDatabase.jsp"> <%-- add this jsp file --%>
	<table>
	<tr>
		<td>Train ID</td>
		<td><input type ="number" name="Train_ID" value="1234"/></td>
	</tr>
	<tr>
		<td>Origin ID</td>
		<td>  
		<select name="Origin_ID" id="Origin_ID">
      		<option value="30PH">30PH</option>
      		<option value="ABSN">ABSN</option>
      		<option value="ATCO">ATCO</option>
      		<option value="ATLC">ATLC</option>
      		<option value="CHHL">CHHL</option>
      		<option value="EDIS">EDIS</option>
      		<option value="EGG">EGG</option>
      		<option value="ELBT">ELBT</option>
      		<option value="HMLN">HMLN</option>
      		<option value="HMTN">HMTN</option>
      		<option value="LDWD">LDWD</option>
      		<option value="LNDN">LNDN</option>
      		<option value="MTHN">MTHN</option>
      		<option value="MTPK">MTPK</option>
      		<option value="NBWK">NBWK</option>
      		<option value="NELB">NELB</option>
      		<option value="NWAP">NWAP</option>
      		<option value="NWPS">NWPS</option>
      		<option value="NYPS">NYPS</option>
      		<option value="PNSK">PNSK</option>
      		<option value="PRTJ">PRTJ</option>
      		<option value="PRTN">PRTN</option>
      		<option value="RHWY">RHWY</option>
      		<option value="SECA">SECA</option>
      		<option value="TRTN">TRTN</option>
 	 	</select>
  		</td>
	</tr>
	<tr>
		<td>Destination ID</td>
		<td>  
		<select name="Destination_ID" id="Destination_ID">
      		<option value="30PH">30PH</option>
      		<option value="ABSN">ABSN</option>
      		<option value="ATCO">ATCO</option>
      		<option value="ATLC">ATLC</option>
      		<option value="CHHL">CHHL</option>
      		<option value="EDIS">EDIS</option>
      		<option value="EGG">EGG</option>
      		<option value="ELBT">ELBT</option>
      		<option value="HMLN">HMLN</option>
      		<option value="HMTN">HMTN</option>
      		<option value="LDWD">LDWD</option>
      		<option value="LNDN">LNDN</option>
      		<option value="MTHN">MTHN</option>
      		<option value="MTPK">MTPK</option>
      		<option value="NBWK">NBWK</option>
      		<option value="NELB">NELB</option>
      		<option value="NWAP">NWAP</option>
      		<option value="NWPS">NWPS</option>
      		<option value="NYPS">NYPS</option>
      		<option value="PNSK">PNSK</option>
      		<option value="PRTJ">PRTJ</option>
      		<option value="PRTN">PRTN</option>
      		<option value="RHWY">RHWY</option>
      		<option value="SECA">SECA</option>
      		<option value="TRTN">TRTN</option>
 	 	</select>
  		</td>
	</tr>
	<tr>
		<td>Transit Line Name</td>
		<td><input type ="text" name="TransitLineName" value="Northeast Corridor"/></td>
	</tr>
	<tr>
		<td>Departure</td>
		<td><input type ="datetime-local" name="Departure" value="2020-08-08 08:00:00"/></td>
	</tr>
	<tr>
		<td>Arrival</td>
		<td><input type ="datetime-local" name="Arrival" value="2020-08-09 08:00:00" /></td>
	</tr>
	<tr>
		<td>Travel Time(minutes)</td>
		<td><input type ="number" name="TravelTime" value="60"/></td>
	</tr>
	<tr>
		<td>Fare($)</td>
		<td><input type ="number" name="Fare" value="20"/></td>
	</tr>
	</table>
	<input type="submit" value="Add Train Schedule">
</form>



<br>
<a href='viewEditTrainSchedules.jsp'>View Train Schedules</a>

<br>
<a href='forumPage.jsp'>View Forum</a>

</body>
</html>