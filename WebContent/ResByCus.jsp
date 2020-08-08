<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>
		<b>Please enter the customer name </b>
	</h1>
	
	<br>
	
	<form method="post" action="ResByCus_f.jsp">
	
		<table>
		
			<tr>
				<td>First Name:</td>
				<td><input type="text" name="firstName"></td>
			</tr>
			<tr>
				<td>Last Name:</td>
				<td><input type="text" name="lastName"></td>
			</tr>
			
		</table>
		
		<br> <input type="submit" value="submit">
		
	</form>
	<br>
	<br>
	<a href='admin.jsp'>Back to management page</a>


</body>
</html>