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
		<td><input type ="text" name="Origin_ID" value="NWBR"/></td>
	</tr>
	<tr>
		<td>Destination ID</td>
		<td><input type ="text" name="Destination_ID" value="NYPS"/></td>
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