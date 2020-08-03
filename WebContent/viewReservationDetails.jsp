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
<title>Reservation Details</title>
</head>
<body>

<br><b><i>Current Reservations</i></b><br>
Choose a current reservation to cancel it<br>

<%
	//Get username passed from customer.jsp
	String username = request.getParameter("username");
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	
	//get current date in correct format for DB
		Calendar now = Calendar.getInstance();
		int dayOfMonth = now.get(Calendar.DAY_OF_MONTH);
		String dayOfMonthStr = ((dayOfMonth < 10) ? "0" : "") + dayOfMonth;
		int month = now.get(Calendar.MONTH) + 1;
		String monthStr = ((month < 10) ? "0" : "") + month;
		int year = now.get(Calendar.YEAR);
		System.out.print(dayOfMonth+"/"+month+"/"+year);

		String currentdate = year + "-" + monthStr + "-" + dayOfMonthStr;
	
	//create temp tables for join
			String d1 = "Drop View if Exists t1;";
			String d2 = "Drop View if Exists t2;";
			String d3 = "Drop View if Exists t3;";
			String d4 = "Drop View if Exists t6;";
			
			String str1 = "CREATE VIEW t1\n" +
			"AS\n" +
			"(select t.Train_ID, t.Origin_ID, s.City, s.State, t.TransitLineName, t.Departure, t.Arrival, t.TravelTime, t.fare\n" +
			"from TrainSchedule t, Station s\n" +
			"where s.Station_ID=t.Origin_ID);\n";
			
			String str2 = "CREATE VIEW t2\n" + 
			"AS\n" +
			"(select t.Train_ID, t.Destination_ID, s.City, s.State, t.TransitLineName, t.Departure, t.Arrival, t.TravelTime, t.fare\n" +
			"from TrainSchedule t, Station s\n" +
			"where s.Station_ID=t.Destination_ID);";

			String str3 = "CREATE VIEW t3\n" + 
					"AS\n" +
			"(Select t1.Train_ID, t1.Origin_ID, t1.City OriginCity, t1.State OriginState, t2.Destination_ID, t2.City DestinationCity, t2.State DestinationState, t1.TransitLineName, t1.Departure, t1.Arrival, t1.TravelTime, t1.fare\n" +
			"From t1\n" +
			"Join t2\n" +
			"On t1.Train_ID=t2.Train_ID\n" +
			"group by t1.Train_ID, t1.Departure);";
		
			String str4 = "CREATE VIEW t6\n" + 
					"AS\n" +
					"(Select t3.*, r.ReservationNumber, r.ResDate, r.username, r.TotalFare\n" + 
					"from t3, Reservation r\n" +
					"where t3.Train_ID = r.Train_ID\n" +
					"and t3.Departure = r.Departure);";
		
	//		String str5 = "SELECT * FROM t6;";
	
	
	String str6 = "SELECT * FROM t6 where username='" + username + "' and ResDate < '"
			+ currentdate + "';";
			
	String str7 = "SELECT * FROM t6 where username='" + username + "' and ResDate >= '"
					+ currentdate + "';";	
					
					
					
					//drop any existing views
					stmt.execute(d1);
					stmt.execute(d2);
					stmt.execute(d3);
					stmt.execute(d4);
					
					//create new temporary tables (views)
					stmt.execute(str1);
					stmt.execute(str2);
					stmt.execute(str3);
					stmt.execute(str4);
			
	
	//Execute Queries	
	ResultSet currentreservations = stmt.executeQuery(str7);
	//ResultSet pastreservations = stmt.executeQuery(str6);
	
	String resnum;
	
	//Make an HTML table to show the results in:
	out.print("<table>");

	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td>");
	//print out column header
	out.print("<b>");
	out.print("Train ID");
	out.print("</b>");
	out.print("</td>");
	
	//make a column
	//out.print("<td>");
	//out.print("<b>");
		//out.print("Origin Station ID");
		//out.print("</b>");
	//out.print("</td>");
	
	out.print("<td>");
	out.print("<b>");
		out.print("Origin");
		out.print("</b>");
	out.print("</td>");
	
	
	out.print("<td>");
	out.print("<b>");
		out.print("Destination");
		out.print("</b>");
	out.print("</td>");

	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Transit Line Name");
		out.print("</b>");
	out.print("</td>");
	
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Departure");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Arrival");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Travel Time (minutes)");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Fare");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Reservation #");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Reservation Date");
		out.print("</b>");
	out.print("</td>");	
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Cancel");
		out.print("</b>");
	out.print("</td>");
	
	out.print("</tr>");

	//parse out the results
	while (currentreservations.next()) {
		
		
		//make a row
		out.print("<tr>");
		
		//make a column
		out.print("<td>");
		//Print out current bar or beer name:
		out.print(currentreservations.getString("Train_ID"));
		out.print("</td>");
		
		String TrainID = currentreservations.getString("Train_ID");
		//out.print("<td>");
		//Print out current bar/beer additional info: Manf or Address
		//	out.print(result.getString("Origin_ID"));
		//out.print("</td>");

		out.print("<td>");
		out.print(currentreservations.getString("OriginCity"));
		out.print(", ");
		out.print(currentreservations.getString("OriginState"));
	 	out.print("</td>");
		
		//out.print("<td>");
		//out.print(result.getString("t1.State"));
	 	//out.print("</td>");
		
		//out.print("<td>");
		//out.print(result.getString("Destination_ID"));
	 	//out.print("</td>");
	 	
		out.print("<td>");
		out.print(currentreservations.getString("DestinationCity"));
		out.print(", ");
		out.print(currentreservations.getString("DestinationState"));
	 	out.print("</td>");
		
		//out.print("<td>");
		//out.print(result.getString("t2.State"));
	 	//out.print("</td>");
		
		out.print("<td>");
		out.print(currentreservations.getString("TransitLineName"));
		out.print("</td>");
		
		out.print("<td>");
			out.print(currentreservations.getString("Departure"));
		out.print("</td>");
		
		String Departure = currentreservations.getString("Departure");
		String passinfo = TrainID + " "+ Departure;
		
		out.print("<td>");
			out.print(currentreservations.getString("Arrival"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(currentreservations.getString("TravelTime"));
		out.print("</td>");
	
		out.print("<td>");
		out.print(currentreservations.getString("TotalFare"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(currentreservations.getString("ReservationNumber"));
		resnum = currentreservations.getString("ReservationNumber");
		out.print("</td>");
	
		out.print("<td>");
		out.print(currentreservations.getString("ResDate"));
		out.print("</td>");	
		
		out.print("<td>");	
		%><form method="post" action="removeReservationFromDatabase.jsp">
		<input type="submit" value="Cancel">
		<input type="hidden" id="resinfo" name="reservationnumber" value="<%=resnum%>"/>
		</form><%
		out.print("</td>");


		
		
		
		
		
		

		
		out.print("</tr>");

		
		
		out.print("<tr>");
		out.print("<tr>");
		out.print("<tr>");
		out.print("<tr>");
		out.print("<tr>");
		out.print("<tr>");
		out.print("<tr>");
		out.print("<tr>");
		out.print("<tr>");
		out.print("<tr>");
		out.print("</tr>");
		out.print("</tr>");
		out.print("</tr>");
		out.print("</tr>");
		out.print("</tr>");
		out.print("</tr>");
		out.print("</tr>");
		out.print("</tr>");
		out.print("</tr>");
		out.print("</tr>");
		

	}
	out.print("</table>");

	
	
	
	
	

%>
<br><br><b><i>Past Reservations</i></b><br>
<%ResultSet pastreservations = stmt.executeQuery(str6);

//Make an HTML table to show the results in:
out.print("<table>");

//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//print out column header
out.print("<b>");
out.print("Train ID");
out.print("</b>");
out.print("</td>");

//make a column
//out.print("<td>");
//out.print("<b>");
	//out.print("Origin Station ID");
	//out.print("</b>");
//out.print("</td>");

out.print("<td>");
out.print("<b>");
	out.print("Origin");
	out.print("</b>");
out.print("</td>");


out.print("<td>");
out.print("<b>");
	out.print("Destination");
	out.print("</b>");
out.print("</td>");


//make a column
out.print("<td>");
out.print("<b>");
	out.print("Transit Line Name");
	out.print("</b>");
out.print("</td>");


//make a column
out.print("<td>");
out.print("<b>");
	out.print("Departure");
	out.print("</b>");
out.print("</td>");

//make a column
out.print("<td>");
out.print("<b>");
	out.print("Arrival");
	out.print("</b>");
out.print("</td>");

//make a column
out.print("<td>");
out.print("<b>");
	out.print("Travel Time (minutes)");
	out.print("</b>");
out.print("</td>");

//make a column
out.print("<td>");
out.print("<b>");
	out.print("Fare");
	out.print("</b>");
out.print("</td>");

//make a column
out.print("<td>");
out.print("<b>");
	out.print("Reservation #");
	out.print("</b>");
out.print("</td>");

//make a column
out.print("<td>");
out.print("<b>");
	out.print("Reservation Date");
	out.print("</b>");
out.print("</td>");	

out.print("</tr>");

//parse out the results
while (pastreservations.next()) {
	
	
	//make a row
	out.print("<tr>");
	
	//make a column
	out.print("<td>");
	//Print out current bar or beer name:
	out.print(pastreservations.getString("Train_ID"));
	out.print("</td>");
	
	String TrainID = pastreservations.getString("Train_ID");
	//out.print("<td>");
	//Print out current bar/beer additional info: Manf or Address
	//	out.print(result.getString("Origin_ID"));
	//out.print("</td>");

	out.print("<td>");
	out.print(pastreservations.getString("OriginCity"));
	out.print(", ");
	out.print(pastreservations.getString("OriginState"));
 	out.print("</td>");
	
	//out.print("<td>");
	//out.print(result.getString("t1.State"));
 	//out.print("</td>");
	
	//out.print("<td>");
	//out.print(result.getString("Destination_ID"));
 	//out.print("</td>");
 	
	out.print("<td>");
	out.print(pastreservations.getString("DestinationCity"));
	out.print(", ");
	out.print(pastreservations.getString("DestinationState"));
 	out.print("</td>");
	
	//out.print("<td>");
	//out.print(result.getString("t2.State"));
 	//out.print("</td>");
	
	out.print("<td>");
	out.print(pastreservations.getString("TransitLineName"));
	out.print("</td>");
	
	out.print("<td>");
		out.print(pastreservations.getString("Departure"));
	out.print("</td>");
	
	String Departure = pastreservations.getString("Departure");
	String passinfo = TrainID + " "+ Departure;
	
	out.print("<td>");
		out.print(pastreservations.getString("Arrival"));
	out.print("</td>");
	
	out.print("<td>");
	out.print(pastreservations.getString("TravelTime"));
	out.print("</td>");

	out.print("<td>");
	out.print(pastreservations.getString("TotalFare"));
	out.print("</td>");
	
	out.print("<td>");
	out.print(pastreservations.getString("ReservationNumber"));
	out.print("</td>");

	out.print("<td>");
	out.print(pastreservations.getString("ResDate"));
	out.print("</td>");	
	
	


	
	
	
	
	
	

	
	out.print("</tr>");

	
	
	out.print("<tr>");
	out.print("<tr>");
	out.print("<tr>");
	out.print("<tr>");
	out.print("<tr>");
	out.print("<tr>");
	out.print("<tr>");
	out.print("<tr>");
	out.print("<tr>");
	out.print("<tr>");
	out.print("</tr>");
	out.print("</tr>");
	out.print("</tr>");
	out.print("</tr>");
	out.print("</tr>");
	out.print("</tr>");
	out.print("</tr>");
	out.print("</tr>");
	out.print("</tr>");
	out.print("</tr>");
	

}
out.print("</table>");


//close the connection.
db.closeConnection(con);
%>




</body>
</html>