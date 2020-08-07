<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.text.*" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Schedules</title>
</head>
<body>
<a href='customerRep.jsp'>Back to Customer Rep Home Page</a>
<h1>Train Schedules List</h1> 

		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			//String entity = request.getParameter("TrainSchedule");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM TrainSchedule";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
	<!--  Make an HTML table to show the results in: -->
	<table style ="width:75%">
		<tr>    
			<th>Train ID</th>
			<th>Origin ID</th>
			<th>Destination ID</th>
			<th>Transit Line</th>
			<th>Departure</th>
			<th>Arrival</th>
			<th>Travel Time</th>
			<th>Fare</th>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("Train_ID") %></td>
					<td><%= result.getString("Origin_ID") %></td>
					<td><%= result.getString("Destination_ID") %></td>
					<td><%= result.getString("TransitLineName") %></td>
					<td><%= result.getString("Departure") %></td>
					<td><%= result.getString("Arrival") %></td>
					<td><%= result.getString("TravelTime") %></td>
					<td><%= result.getString("Fare") %></td>
					<td>
					<form method="post" action="removeTrainScheduleFromDatabase.jsp"> 
					<input type="submit" value="Delete">
					</td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
<br>
<br>
<br>
<br>
<br>

</body>
</html>