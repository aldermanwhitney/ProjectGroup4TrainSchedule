<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Customer</title>
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
<br><i>You have customer privileges</i><br>
<%
    }
%>

<br>
<form method="post" action="viewReservationDetails.jsp">
<input type="submit" value="View My Reservations">
<input type="hidden" id="hiddeninfo" name="username" value="<%=session.getAttribute("user")%>"/>
</form>
	<br>
	<br>


<b>Search Train Schedules</b>
<br>
	<form method="post" action="scheduleSearchResult.jsp"> <%--This button being clicked sends user to scheduleSearch.jsp--%>
	<table>
	<tr>    
	<td>Origin:</td><td><input type="text" name="origin"></td> <%--Text fields, "origin", "destination", "traveldate" etc are sent to next page (scheduleSearchResult.jsp)--%>
	</tr>
	<tr>
	<td>Destination:</td><td><input type="text" name="destination"></td>
	</tr>
	<tr>    
	<td>Travel Date:</td><td><input type="date" name="traveldate" required pattern="\d{4}-\d{2}-\d{2}" title="YYYY-MM-DD" value="2020-08-24"
       min="2020-08-06" max="2025-08-25">
    <span class="validity"></span></td>
	</tr>
	<tr>    
	<td>	
</td>
	</tr>
	</table>
	<i>Sort By:</i>
	<br>
	 <input type="radio" name="command" value="Stoptime"/>Arrival Time
	 <input type="radio" name="command" value="deststoptime"/>Departure Time
	 <input type="radio" name="command" value="tf"/>Fare
	 <br>
	 <br>
	<input type="submit" value="Search">
	</form>
<br>
<a href='forumPage.jsp'>View Forum</a>
<br>
<a href='logout.jsp'>Log Out</a>

</body>
</html>