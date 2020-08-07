<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%--This is the main page displayed when going to the website.
From here, depending on which button is clicked, the user is sent to a different page
each associated with their own .jsp file (see under WebContent on left) --%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Group 4 Project</title>
	</head>
<body>

<b>Login For Existing Users</b>
<br>
	<form method="post" action="checkLoginDetails.jsp"> <%--If this button is clicked, user sent to checkLoginDetails.jsp--%>
	<table>
	<tr>    
	<td>Username:</td><td><input type="text" name="username"></td> <%--Text fields, "username" and "password" are sent to next page (checkLoginDetails.jsp)--%>
	</tr>
	<tr>
	<td>Password:</td><td><input type="text" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="Login"> <%--Makes a button with the label "Login" on it--%>
	</form>
<br>



<b>Registration for New Customers</b>
<br>
	<form method="post" action="register.jsp"> <%--This button being clicked sends user to register.jsp--%>
	<table>
	<tr>    
	<td>Username:</td><td><input type="text" name="username"></td> <%--Text fields, "username", "password", firstname etc are sent to next page (register.jsp)--%>
	</tr>
	<tr>
	<td>Password:</td><td><input type="text" name="password"></td>
	</tr>
	<tr>    
	<td>First Name:</td><td><input type="text" name="firstname"></td>
	</tr>
	<tr>    
	<td>Last Name:</td><td><input type="text" name="lastname"></td>
	</tr>
	<tr>    
	<td>Email:</td><td><input type="text" name="email"></td>
	</tr>
	</table>
	<input type="submit" value="Register">
	</form>
<br>




</body>
</html>