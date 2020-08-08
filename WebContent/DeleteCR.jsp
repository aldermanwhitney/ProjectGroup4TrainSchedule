<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<br> Delete Customer Representative 
<br>
<br>
<form method="post" action="DeleteCR_f.jsp">
	<table>
	<tr>
	<td>SSN:</td><td><input type="text" name="SSN"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Delete">
	</form>
	<br>
	<br>
	<br>
	<a href='admin.jsp'>Back to management page</a>
</body>
</html>