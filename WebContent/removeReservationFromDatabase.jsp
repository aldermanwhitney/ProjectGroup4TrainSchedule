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
<title>Delete Reservation</title>
</head>
<body>


<% 
//Get paramaters from viewReservationDetails.jsp
	String resnum = request.getParameter("reservationnumber");
	out.print(resnum);
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	
	//Make an insert statement for the Reservation sql table:
	String remove = "DELETE FROM Reservation where ReservationNumber = ?";
			
	
			PreparedStatement ps = con.prepareStatement(remove);
			
			//Add parameters of the insert
			ps.setString(1, resnum);
	
			//Run the query against the DB
			ps.executeUpdate();
	
	
	//close the connection.
	db.closeConnection(con);
%>

<b>Success!</b><br><br> 
Your Reservation has been cancelled.<br><br>

<a href='customer.jsp'>Back to Your Customer Home Page</a>

</body>
</html>