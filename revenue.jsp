<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>
	View Revenue Generate by
	</h2>
	<br>
	<form method="post" action="revenue_f.jsp">
		<select name="action" size=1>
			<option value="1">Transit Line</option>
			<option value="2">Customer</option>
		</select>&nbsp;
		<br>
		<br> <input type="submit" value="submit">
	</form>
	<a href='admin.jsp'>Back to management page</a>
	<br>

</body>
</html>