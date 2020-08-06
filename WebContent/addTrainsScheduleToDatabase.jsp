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
<br>
<br>

<%

	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String newTrain_ID = request.getParameter("Train_ID");
		String newOrigin_ID = request.getParameter("Origin_ID");
		String newDestination_ID = request.getParameter("Destination_ID");
		String newTransitLineName = request.getParameter("TransitLineName");
		String newDeparture = request.getParameter("Departure");
		String newArrival = request.getParameter("Arrival");
		String newTravelTime = request.getParameter("TravelTime");
		String newFare = request.getParameter("Fare");


		//Make an insert statement for the TrainSchedule sql table:
		String insert = "INSERT INTO TrainSchedule(Train_ID, Origin_ID, Destination_ID, TransitLineName, Departure, Arrival, TravelTime, Fare)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newTrain_ID);
		ps.setString(2, newOrigin_ID);
		ps.setString(3, newDestination_ID);
		ps.setString(4, newTransitLineName);
		ps.setString(5, newDeparture);
		ps.setString(6, newArrival);
		ps.setString(7, newTravelTime);
		ps.setString(8, newFare);
		
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Train Schedule Insert succeeded! Press the back arrow to add more train schedules, view train schedules, or view forum.");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Train Schedule Insert failed, Please try again. (Possible Duplicate Key or Contraint Violation)");
	}
%>

</body>
</html>