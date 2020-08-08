<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br> Edit Customer Representative Data <br>
<br>
<form method="post" action="UpdateCR_f.jsp">
	<table>
		<tr>
		<td>Customer Representative SSN:</td>
		<td><input type="text" name="SSN"></td>
		</tr>
	</table>	
	
	<br> Please select attribute to edit:
	<select name="action" size=1>
		<option value="1">SSN</option>
		<option value="2">Username</option>
		<option value="3">Password</option>
		<option value="4">First Name</option>
		<option value="5">Last Name</option>
	</select>&nbsp;
	<br>
	<br>
	<table>
		<tr>
		<td>Enter New Value:</td>
		<td><input type="text" name="newVal"></td>
		</tr>
	</table>	
		<br>
		<br> <input type="submit" value="Update">
	</form>
	<br>
	<br>
	<a href='admin.jsp'>Back to management page</a>
	<br>
</body>
</html>