<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br> Add New Customer Representative 
<br>
<br>
<form method="post" action="AddCR_f.jsp">
	<table>
	<tr>    
	<td>Username:</td><td><input type="text" name="username"></td> 
	</tr>
	<tr>
	<td>Password:</td><td><input type="text" name="pass"></td>
	</tr>
	<tr>    
	<td>First Name:</td><td><input type="text" name="firstname"></td>
	</tr>
	<tr>    
	<td>Last Name:</td><td><input type="text" name="lastname"></td>
	</tr>
	<tr>    
	<td>SSN:</td><td><input type="text" name="SSN"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Register">
	</form>
<br>
<br>
<br>
<br>
<a href='admin.jsp'>Back to management page</a>
</body>
</html>