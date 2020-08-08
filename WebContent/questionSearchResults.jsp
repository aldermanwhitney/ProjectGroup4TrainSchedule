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
<title>Question Search Results</title>
</head>
<body>
Question Search Results

<%

	try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the index.jsp
		String keyWord = request.getParameter("searchQuery"); //fix this
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String search = "SELECT * FROM Questions WHERE Question LIKE '%?%'"; 
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(search);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, keyWord);
		//Run the query against the DB
		ps.executeUpdate();
		//Run the query against the database.
		ResultSet result = ps.executeQuery(search);

		
		%>
	<!--  Make an HTML table to show the results in: -->
	<table style ="width:75%">
		<tr>    
			<th>Questions</th>
			<th>Answers</th>
		</tr>
			<%
			while (result.next()) { %>
			<tr>    
				<td><%= result.getString("Question") %></td>
				<td><%= result.getString("Answer") %></td>
			</tr>
			

		<% }
		
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Search Success! Press the back arrow to log in with these credentials"); //fix this
		%>
		</table>
		<%
	} catch (Exception ex) {
		out.print(ex);
		out.print("Search failed  -  (Possible Duplicate Key or Contraint Violation)"); //fix this
	}
%>

</body>
</html>