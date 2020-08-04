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
	
		
		//Drop temp views
		String d1 = "Drop View if Exists t1;";
		String d2 = "Drop View if Exists t2;";
		String d3 = "Drop View if Exists t3;";
		String d4 = "Drop View if Exists t4;";
		String d5 = "Drop View if Exists t5;";
		String d6 = "Drop View if Exists schedulewithstops";
		String d7 = "Drop View if Exists totalnumberofstops";
		String d8 = "Drop View if Exists final";
		String d9 = "Drop View if Exists resfinal";
		
		
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
	    "and t1.Departure = t2.Departure\n" +
		"group by t1.Train_ID, t1.Departure);";
		
		
		String str5 = "CREATE VIEW t4\n" + 
				"AS\n" +
		"select t.Departure, t.Train_ID, st.Stop_ID, st.StopNumber, st.Stoptime, s.city, s.state\n" + 
		"from Stops st, Station s, TrainSchedule t\n" + 
		"where s.Station_ID=st.Stop_ID\n" + 
		"and st.Departure = t.Departure\n" + 
		"and st.Train_ID = t.Train_ID";
		
		String str6 = "CREATE VIEW t5\n" + 
				"AS\n" +
				"(Select t3.*, t4.StopNumber, t4.Stop_ID Stop1_ID, t4.Stoptime, t4.city, t4.state\n" + 
				"from t3, t4\n" +
				"where t3.Departure = t4.Departure\n" +
				"and t3.Train_ID=t4.Train_ID);";
				
		String str7 = "SELECT * FROM t5;";
		
		String str8 = "CREATE VIEW schedulewithstops\n" + 
				"AS\n" +
				"(Select t5.*, t4.city destcity, t4.state deststate, t4.StopNumber stopnum, t4.Stop_ID Stop2_ID, t4.Stoptime deststoptime, t4.StopNumber-t5.StopNumber numstops\n" + 
				"from t5\n" +
				"join t4 on t4.Train_ID = t5.Train_ID\n" +
				"and t4.Departure = t5.Departure\n" +
				"where t5.Stoptime<t4.Stoptime\n" +
				"and t5.StopNumber<t4.StopNumber);";
				
				String str9 = "SELECT * FROM schedulewithstops;";
		
				
		String str10 = "CREATE VIEW totalnumberofstops\n" + 
				"AS\n" +
				"(select t.TransitLineName, t.fare, count(distinct s.Stop_ID) totalnumstops\n" +
				"from Stops s, TrainSchedule t\n" +
				"where s.Train_ID = t.Train_ID\n" +
				"and s.Departure = t.Departure\n" + 
				"group by t.TransitLineName);";		
		
			String str11 = "CREATE VIEW final\n" + 
					"AS\n" +
					"(select s.*, n.totalnumstops totaltransitstops\n" +
						"from numberofstops n, schedulewithstops s\n" + 
						"where n.TransitLineName=s.TransitLineName);";
		
						
			String str12 = "CREATE VIEW resfinal\n" + 			
					"AS\n" +
					"(Select final.*, r.ReservationNumber, r.ResDate, r.username, r.TotalFare, r.OriginStop_ID, r.DestinationStop_ID\n" + 
					"from final, Reservation r\n" + 
					"where final.Train_ID = r.Train_ID\n" + 
					"and final.Departure = r.Departure\n" + 
                    "and final.Stop1_ID = r.OriginStop_ID\n" + 
                    "and final.Stop2_ID = r.DestinationStop_ID);"; 
						
						
						
						
						
			/*			
			String str4 = "CREATE VIEW t6\n" + 
					"AS\n" +
					"(Select t3.*, r.ReservationNumber, r.ResDate, r.username, r.TotalFare\n" + 
					"from t3, Reservation r\n" +
					"where t3.Train_ID = r.Train_ID\n" +
					"and t3.Departure = r.Departure);";
		
					*/
	//		String str5 = "SELECT * FROM t6;";
	
	
	String str16 = "SELECT * FROM resfinal where username='" + username + "' and ResDate < '"
			+ currentdate + "';";
			
	String str17 = "SELECT * FROM resfinal where username='" + username + "' and ResDate >= '"
					+ currentdate + "';";	
					
					
					
					//drop any existing views
					stmt.execute(d1);
					stmt.execute(d2);
					stmt.execute(d3);
					stmt.execute(d4);
					stmt.execute(d5);
					stmt.execute(d6);
					stmt.execute(d7);
					stmt.execute(d8);
					stmt.execute(d9);
					
					//create new temporary tables (views)
					stmt.execute(str1);
					stmt.execute(str2);
					stmt.execute(str3);
					stmt.execute(str5);
					stmt.execute(str6);
					stmt.execute(str8);
					stmt.execute(str10);
					stmt.execute(str11);
					stmt.execute(str12);
					
			
	
	//Execute Queries	
	ResultSet currentreservations = stmt.executeQuery(str17);
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
		out.print("Transit Line Origin");
		out.print("</b>");
	out.print("</td>");
	
	//out.print("<td>");
	//out.print("<b>");
		//out.print("Origin State");
		//out.print("</b>");
	//out.print("</td>");
	
	//make a column
	//out.print("<td>");
	//out.print("<b>");
		//out.print("Destination Station ID");
		//out.print("</b>");
	//out.print("</td>");
	
//		out.print("<td>");
//	out.print("<b>");
		//out.print("Destination City");
	//	out.print("</b>");
//	out.print("</td>");
	
	out.print("<td>");
	out.print("<b>");
		out.print("Transit Line Destination");
		out.print("</b>");
	out.print("</td>");

	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Transit Line Name");
		out.print("</b>");
	out.print("</td>");
	
	/*
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
	*/
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Travel Time (minutes)");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Fare Paid");
		out.print("</b>");
	out.print("</td>");
	
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Board Stop");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Board Time");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Disembark Stop");
		out.print("</b>");
	out.print("</td>");
	
	//make a column
	out.print("<td>");
	out.print("<b>");
		out.print("Disembark Time");
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
		String transitline = currentreservations.getString("TransitLineName");
		out.print("</td>");
		
		/*
		out.print("<td>");
			out.print(result.getString("Departure"));
		out.print("</td>");
		*/
		
		String Departure = currentreservations.getString("Departure");
		String passinfo = TrainID + " "+ Departure;
		String numStops = currentreservations.getString("numstops");
		/*
		out.print("<td>");
			out.print(result.getString("Arrival"));
		out.print("</td>");
		*/
		out.print("<td>");
		//out.print(result.getString("TravelTime"));
		
		String deststoptime = currentreservations.getString("deststoptime");
		String originstoptime = currentreservations.getString("Stoptime");
		
		 String[] stringarr = deststoptime.split(" ", 2); 
		 String[] stringarr2 = originstoptime.split(" ", 2); 
		  
	    String desttime = stringarr[1];
	    String orgtime = stringarr2[1];
		
		 String[] stringarr3 = desttime.split(":", 3); 
		 String[] stringarr4 = orgtime.split(":", 3); 
		  

	   int traveltime =  Math.abs(Integer.parseInt(stringarr3[0]) - Integer.parseInt(stringarr4[0]))*60 + (Integer.parseInt(stringarr3[1]) - Integer.parseInt(stringarr4[1]));
	   out.print(traveltime);
	    
	    out.print("</td>");
	
		out.print("<td>");
		String totaltripfare = currentreservations.getString("Fare");

		int thistripfare = Integer.parseInt(totaltripfare)* Integer.parseInt(numStops) / Integer.parseInt(currentreservations.getString("totaltransitstops"));
		double thistripfare2 = Double.parseDouble(totaltripfare)* Double.parseDouble(numStops) / Double.parseDouble(currentreservations.getString("totaltransitstops"));
		DecimalFormat df = new DecimalFormat("#.###");
		//out.print(df.format(thistripfare2));
		out.print("$" + df.format(Double.parseDouble(currentreservations.getString("TotalFare"))));
		out.print("</td>");
		
		out.print("<td>");
		String city = currentreservations.getString("city");
		out.print(currentreservations.getString("city"));
		out.print(", ");
		out.print(currentreservations.getString("state"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(currentreservations.getString("Stoptime"));
		String Stoptime = currentreservations.getString("Stoptime");
		out.print("</td>");
		
		out.print("<td>");
		out.print(currentreservations.getString("destcity"));
		out.print(", ");
		out.print(currentreservations.getString("deststate"));
		String destcity = currentreservations.getString("destcity");
		out.print("</td>");
		
		out.print("<td>");
		out.print(currentreservations.getString("deststoptime"));
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
<%ResultSet pastreservations = stmt.executeQuery(str16);

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