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
<title>Confirm Reservation Details</title>
</head>
<body>


<b>Confirm Reservation Details</b><br>


<%

try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	
	String trainiddeparture = request.getParameter("command");
	//out.println(trainiddeparture);
	String trainid = trainiddeparture.substring(0,4);
	String departure = trainiddeparture.substring(4);
	//out.println("\nTrain ID:" + trainid);
	//out.println("\nDeparture Time:" +departure);
	
	String username = session.getAttribute("user").toString(); 
	String str1 = "SELECT * FROM customer where username = '" + username + "';";
	
		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			
			ResultSet userinfo = stmt.executeQuery(str1);
			userinfo.next();

			String firstname = userinfo.getString("firstname");
			String lastname = userinfo.getString("lastname");
			String email = userinfo.getString("email");
			
			
			//Display User Details
			%>
			<br>
			<b>First Name:</b> <%out.print(firstname);%><br>
			<b>Last Name:</b> <%out.print(lastname);%><br>
			<b>Email:</b> <%out.print(email);%><br>
			<b>Username:</b> <%out.print(username);%><br>

			<%
		
	//get and display departure, arrival and fare
			String d1 = "Drop View if Exists t1;";
			String d2 = "Drop View if Exists t2;";
			String d3 = "Drop View if Exists t3;";
	
			String str2 = "CREATE VIEW t1\n" +
			"AS\n" +
			"(select t.Train_ID, t.Origin_ID, s.City, s.State, t.TransitLineName, t.Departure, t.Arrival, t.TravelTime, t.fare\n" +
			"from TrainSchedule t, Station s\n" +
			"where s.Station_ID=t.Origin_ID);\n";
			
			String str3 = "CREATE VIEW t2\n" + 
			"AS\n" +
			"(select t.Train_ID, t.Destination_ID, s.City, s.State, t.TransitLineName, t.Departure, t.Arrival, t.TravelTime, t.fare\n" +
			"from TrainSchedule t, Station s\n" +
			"where s.Station_ID=t.Destination_ID);";

			String str4 = "CREATE VIEW t3\n" + 
					"AS\n" +
			"(Select t1.Train_ID, t1.Origin_ID, t1.City OriginCity, t1.State OriginState, t2.Destination_ID, t2.City DestinationCity, t2.State DestinationState, t1.TransitLineName, t1.Departure, t1.Arrival, t1.TravelTime, t1.fare\n" +
			"From t1\n" +
			"Join t2\n" +
			"On t1.Train_ID=t2.Train_ID\n" +
			"group by t1.Train_ID, t1.Departure);";		
			
			String str5 = "SELECT * FROM t3 where Train_ID = '" + trainid + "' and Departure = '" + departure + "'";
			
			
			//drop any existing views
			stmt.execute(d1);
			stmt.execute(d2);
			stmt.execute(d3);
			
			//create temp tables
			stmt.execute(str2);
			stmt.execute(str3);
			stmt.execute(str4);
			
			ResultSet routeinfo = stmt.executeQuery(str5);
			routeinfo.next();
			
			String arrival = routeinfo.getString("Arrival");
			String origincity = routeinfo.getString("OriginCity");
			String originstate = routeinfo.getString("OriginState");
			
			String departure2 = routeinfo.getString("Departure");
			String destinationcity = routeinfo.getString("DestinationCity");
			String destinationstate = routeinfo.getString("DestinationState");
			
			String fare = routeinfo.getString("Fare");
			
			double originalfare = Double.parseDouble(fare);
			double finalfare = originalfare;
			
			DecimalFormat df = new DecimalFormat("#.##");
			//df.setRoundingMode(RoundingMode.CEILING);
			    //Double d = originalfare.doubleValue();
			  //  System.out.println(df.format(d));
			
			//Display Route Details
			%>
			<br>
			<b>Origin:</b> <%out.print(origincity + ", " + originstate);%><br>
			<b>Destination:</b> <%out.print(destinationcity + ", " + destinationstate);%><br>
			<b>Departure:</b> <%out.print(departure);%><br>
			<b>Arrival:</b> <%out.print(arrival);%><br>


			<%
			
			//Round Trip or One Way
			String trip = request.getParameter("trip");
			if (trip.equals("roundtrip")){
				trip = "Round Trip (Fare x 2)";
				finalfare *= 2;
			}
			else{
				trip = "One Way";
			}
			
			
			
			
			 String discount = request.getParameter("discount");
			 System.out.println(discount);
			 String discount2;
			if (discount.equals("senior")){
				finalfare = finalfare - finalfare*.35;
				discount2 = "Senior - 35% Off";
			}
			else if (discount.equals("disabled")){
				finalfare = finalfare - finalfare*.50;
				discount2 = "Disabled - 50% Off";
			}
			else if (discount.equals("child")){
				finalfare = finalfare - finalfare*.25;
				discount2 = "Child - 25% Off";
			}
			else{
				discount2 = "Not Applicable";
			}
			
			%>
			<br><b><i>Payment Details</i></b><br>
			<b>Original Fare:</b> <%out.print(fare);%><br>
			<b>Trip: </b> <%out.print(trip);%><br>
			<b>Discount: </b> <%out.print(discount2);%><br>
			<b>Final Fare:</b> <%out.print(df.format(finalfare));%><br>
			<%
			
			
			%>
			<form method="post" action="addReservationToDatabase.jsp">
			<input type="submit" value="Confirm">
			<input type="hidden" id="reservationinfo" name="trainid" value="<%=trainid%>"/>
			<input type="hidden" id="reservationinfo" name="departure" value="<%=departure%>"/>
			<input type="hidden" id="reservationinfo" name="username" value="<%=username%>"/>
			<input type="hidden" id="reservationinfo" name="finalfare" value="<%=finalfare%>"/>
			</form>

			<form method="post" action="customer.jsp">
			<input type="submit" value="Cancel"></form>
			<%
			
			
			
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>










</body>
</html>