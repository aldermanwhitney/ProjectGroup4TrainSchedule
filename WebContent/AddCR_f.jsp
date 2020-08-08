<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%--This page inserts customer rep info into tuples into the database--%>

<%


	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the admin.jsp
		String ssn = request.getParameter("SSN");
		String newUser = request.getParameter("username");
		String newPassword = request.getParameter("pass");
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");


		//Make an insert statement for the customer sql table:
		String insert = "INSERT INTO CustomerRep(SSN, username, pass, firstname, lastname)"
				+ "VALUES (?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, ssn);
		ps.setString(2, newUser);
		ps.setString(3, newPassword);
		ps.setString(4, firstName);
		ps.setString(5, lastName);
		
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Insert succeeded!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :(  -  (Possible Duplicate Key)");
	}
%>



</body>
</html>