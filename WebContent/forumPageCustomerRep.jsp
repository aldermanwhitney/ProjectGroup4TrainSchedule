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
<%-- This is the forum page the customer rep sees --%>
<title>Forum for Questions and Answers: Customer Rep View</title>
	</head>
		<body>
			<a href='customerRep.jsp'>Back to Customer Rep Home Page</a>
			<h1>Forum: Customer Rep View</h1>
			
			
				<% try {
	
						//Get the database connection
						ApplicationDB db = new ApplicationDB();	
						Connection con = db.getConnection();		

						//Create a SQL statement
						Statement stmt = con.createStatement();
						//Get the selected radio button from the index.jsp
						//String entity = request.getParameter("TrainSchedule");
						//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
						String str = "SELECT * FROM Questions";
						//Run the query against the database.
						ResultSet result = stmt.executeQuery(str);
				%>
				<!--  Make an HTML table to show the results in: -->
					<table style ="width:70%">
					<tr>
						<td>username</td>    
						<td>Questions</td>
						<td>Answers</td>
						<td>Reply</td>
					</tr>
				<%
						//parse out the results
						while (result.next()) { %>
							<tr>
								<td><%= result.getString("Username") %></td>    
								<td><%= result.getString("Question") %></td>
								<td><%= result.getString("Answer") %></td>
								<td><a href='replyToCustomer.jsp'>Reply</a></td>
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