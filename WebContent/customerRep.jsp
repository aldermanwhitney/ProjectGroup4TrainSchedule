<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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


<form method ="post" action ="viewEditTrainSchedules.jsp">
<input type = "submit" value ="View Train Schedules">
<input type = "hidden" id ="hiddeninfo" name ="username" value ="<%=session.getAttribute("user")%>"/>
</form>



</body>
</html>