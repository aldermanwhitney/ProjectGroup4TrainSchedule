<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Train Schedule Delete Page</title>
</head>
<body>

<br> Delete Train Schedule
<br>
<br>
<form method="post" action="removeTrainScheduleFromDatabase.jsp">
	<table>
	<tr>
	<td>Train_ID:</td><td><input type="text" name="Train_ID"></td>
	</tr>
	<tr>
	<td>Departure:</td><td><input type="text" name="Departure"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Delete">
	</form>
	<br>
	<br>
	<br>
	<a href='viewEditTrainSchedules.jsp'>Back to Train Schedules</a>
</body>
</html>