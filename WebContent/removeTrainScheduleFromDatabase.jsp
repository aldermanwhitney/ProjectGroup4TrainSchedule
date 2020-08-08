<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Schedule Delete status page</title>
</head>
<a href='viewEditTrainSchedules.jsp'>View Train Schedules</a>
<br>
<body>

<%

	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the viewEditTrainSchedules.jsp
		String deleteTrain_ID = request.getParameter("Train_ID"); //fix this
		String deleteDeparture = request.getParameter("Departure"); //fix this


		//Make an insert statement for the TrainSchedule sql table:
		String remove = "DELETE FROM TrainSchedule where Train_ID = ? AND Departure = ?"; //fix this
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(remove);

		//Add parameters of the query. Start with 1, the 0-parameter is the DELETE statement itself
		ps.setString(1, deleteTrain_ID); //fix this
		ps.setString(2, deleteDeparture); //fix this
		
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Train Schedule deleted succeeded!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Train Schedule Delete failed, Please try again. (Possible Duplicate Key or Contraint Violation)");
	}
%>


</body>
</html>