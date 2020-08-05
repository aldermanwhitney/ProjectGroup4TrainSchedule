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
<title>Train Schedule Registration</title>
</head>
<body>
<%-- look at register.jsp --%>
success and fail page for adding train schedule<br>
if success, direct user to go back and check train schedule<br>
if fail, direct user to go back and re-register<br>

<%-- 
<%




	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String newUser = request.getParameter("username");
		String newPassword = request.getParameter("password");
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");
		String email = request.getParameter("email");


		//Make an insert statement for the TrainSchedule sql table:
		String insert = "INSERT INTO TrainSchedule(Train_ID, password, firstname, lastname, email)"
				+ "VALUES (?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newUser);
		ps.setString(2, newPassword);
		ps.setString(3, firstName);
		ps.setString(4, lastName);
		ps.setString(5, email);
		
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Insert succeeded! Press the back arrow to log in with these credentials");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :(  -  (Possible Duplicate Key or Contraint Violation)");
	}
--%>

</body>
</html>