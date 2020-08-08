<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Tools</title>
</head>
<body>
<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("user")%> 
<br>
<br>
<b>You have Administrator privileges</b>
<br>
<br> <a href='manageCR.jsp'> Manage customer representative</a>
<br>
<br> <a href='adminRes.jsp'> Produce lists of reservations</a>
<br>
<br> <a href='revenue.jsp'> Produce list of revenue </a>
<br>
<br> <a href='salesReport.jsp'> Obtain sales report</a>
<br>
<br> <a href='bestCustomer.jsp'> Best Customer</a>
<br>
<br> <a href='topFive.jsp'> Top 5 Most Active Transit Lines</a>
<br>
<br>
<br>
<br>
<br>
<a href='logout.jsp'>Log out</a>
<%
    }
%>
</body>
</html>