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

	
	String routedetails = request.getParameter("command");
	//String numstops = request.getParameter("numstops");
	//out.println(routedetails);
	
	 String[] stringarr = routedetails.split(",", 6); 
	  
      for (String a : stringarr) {
          //System.out.println(a); 
      }
	
    String trainid = stringarr[0];
    String departure = stringarr[1];
    String destcity = stringarr[2];
    String deststoptime = stringarr[3];
    String city = stringarr[4];
    String Stoptime = stringarr[5];
    
   // out.println(trainid + numstops + departure);
	
	//String trainid = trainiddeparture.substring(0,4);
	//String departure = trainiddeparture.substring(4);
	//out.println("\nTrain ID:" + trainid);
	//out.println("\nDeparture Time:" +departure);
	
	String username = session.getAttribute("user").toString(); 
	String userinfostring = "SELECT * FROM customer where username = '" + username + "';";
	
		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			
			ResultSet userinfo = stmt.executeQuery(userinfostring);
			userinfo.next();

			String firstname = userinfo.getString("firstname");
			String lastname = userinfo.getString("lastname");
			String email = userinfo.getString("email");
			
			//get current date in correct format for DB
			Calendar now = Calendar.getInstance();
			int dayOfMonth = now.get(Calendar.DAY_OF_MONTH);
			String dayOfMonthStr = ((dayOfMonth < 10) ? "0" : "") + dayOfMonth;
			int month = now.get(Calendar.MONTH) + 1;
			String monthStr = ((month < 10) ? "0" : "") + month;
			int year = now.get(Calendar.YEAR);
			//System.out.print(dayOfMonth+"/"+month+"/"+year);

			String currentdate = year + "-" + monthStr + "-" + dayOfMonthStr;
			
			
			//Display User Details
			%><br>Reservation Date: <%out.print(currentdate);%><br>
			<br><i>Account Information</i><br>
			<b>First Name:</b> <%out.print(firstname);%><br>
			<b>Last Name:</b> <%out.print(lastname);%><br>
			<b>Email:</b> <%out.print(email);%><br>
			<b>Username:</b> <%out.print(username);%><br>

			<%
		
			String d1 = "Drop View if Exists t1;";
			String d2 = "Drop View if Exists t2;";
			String d3 = "Drop View if Exists t3;";
			String d4 = "Drop View if Exists t4;";
			String d5 = "Drop View if Exists t5;";
			String d6 = "Drop View if Exists schedulewithstops";
			String d7 = "Drop View if Exists numberofstops";
			String d8 = "Drop View if Exists final";
			String d9 = "Drop View if Exists btwnstops";
			
			
			
			
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
					"(Select t5.*, t4.city destcity, t4.state deststate, t4.Stop_ID Stop2_ID, t4.StopNumber stopnum, t4.Stoptime deststoptime, t4.StopNumber-t5.StopNumber numstops\n" + 
					"from t5\n" +
					"join t4 on t4.Train_ID = t5.Train_ID\n" +
					"and t4.Departure = t5.Departure\n" +
					"where t5.Stoptime<t4.Stoptime\n" +
					"and t5.StopNumber<t4.StopNumber);";
					
					String str9 = "SELECT * FROM schedulewithstops;";
			
					
			String str10 = "CREATE VIEW numberofstops\n" + 
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
				
				String str12 = "SELECT * FROM final;";
					//Run the query against the database.
			
			//drop any existing views
			stmt.execute(d1);
			stmt.execute(d2);
			stmt.execute(d3);
			stmt.execute(d4);
			stmt.execute(d5);
			stmt.execute(d6);
			stmt.execute(d7);
			stmt.execute(d8);
			
			
			//create new temporary tables (views)
			stmt.execute(str1);
			stmt.execute(str2);
			stmt.execute(str3);
			stmt.execute(str5);
			stmt.execute(str6);
			stmt.execute(str8);
			stmt.execute(str10);
			stmt.execute(str11);
			
			
			//ResultSet result;

			
			
			String str4 = "SELECT * FROM final where Train_ID ='" + trainid 
					+ "' and destcity = '"    + destcity +  "' and Departure = '"
							+ departure + "' and deststoptime = '" + deststoptime + "' and city = '"+ 
					city + "' and Stoptime = '" + Stoptime + "' ;";
			//result = stmt.executeQuery(str4);
			//out.println(str4);
			
			//out.println("114");
			
			ResultSet routeinfo = stmt.executeQuery(str4);
			routeinfo.next();
			
			//transit line info
			/*
			String arrival = routeinfo.getString("Arrival");
			String origincity = routeinfo.getString("OriginCity");
			String originstate = routeinfo.getString("OriginState");
			
			String departure2 = routeinfo.getString("Departure");
			String destinationcity = routeinfo.getString("DestinationCity");
			String destinationstate = routeinfo.getString("DestinationState");
			
			String fare = routeinfo.getString("Fare");
			*/
			//travel time
				String deststoptime2 = routeinfo.getString("deststoptime");
				String originstoptime2 = routeinfo.getString("Stoptime");
				
				 String[] stringarr5 = deststoptime2.split(" ", 2); 
				 String[] stringarr6 = originstoptime2.split(" ", 2); 
				  
			    String desttime = stringarr5[1];
			    String orgtime = stringarr6[1];
				
				 String[] stringarr7 = desttime.split(":", 3); 
				 String[] stringarr8 = orgtime.split(":", 3); 
				  

			   int traveltime =  Math.abs(Integer.parseInt(stringarr7[0]) - Integer.parseInt(stringarr8[0]))*60 + (Integer.parseInt(stringarr7[1]) - Integer.parseInt(stringarr8[1]));
			
			
			//stops info
			String departure2 = routeinfo.getString("Stoptime");
			String origincity = routeinfo.getString("city");
			String originstate = routeinfo.getString("state");
			
			String arrival = routeinfo.getString("deststoptime");
			String destinationcity = routeinfo.getString("destcity");
			String destinationstate = routeinfo.getString("deststate");
			
			String StopNumber = routeinfo.getString("StopNumber");
			String stopnum = routeinfo.getString("stopnum");
			
			String fare = routeinfo.getString("Fare");
			
			double originalfare = Double.parseDouble(fare);
			double finalfare = originalfare;
			
			DecimalFormat df = new DecimalFormat("#.##");
			//df.setRoundingMode(RoundingMode.CEILING);
			    //Double d = originalfare.doubleValue();
			  //  System.out.println(df.format(d));
			
			//Display Route Details
			//between stops
			String betweenstops = "CREATE VIEW btwnstops\n" + 
					"AS\n" +
				"select distinct city\n" +
				"from final\n" +
 				"where Train_ID = '" + trainid + "'\n" +
				"and Departure = '" + departure + "'\n" +
				"and StopNumber > '" + StopNumber + "'\n" +
				"and stopnum <'" + stopnum + "'\n\n"
				+ "union\n\n" +
				"select distinct destcity\n" +
				"from final\n" +
 				"where Train_ID = '" + trainid + "'\n" +
				"and Departure = '" + departure + "'\n" +
				"and StopNumber > '" + StopNumber + "'\n" +
				"and stopnum <'" + stopnum + "';";

		String x = "SELECT * FROM btwnstops;";
				Statement stmt2 = con.createStatement();
				stmt2.execute(d9);
				stmt2.execute(betweenstops);
				ResultSet interimstops = stmt2.executeQuery(x);
			
				
			
			%>
			<br><i>Route Details</i><br>
			<b>Origin:</b> <%out.print(origincity + ", " + originstate);%><br>
			<b>Destination:</b> <%out.print(destinationcity + ", " + destinationstate);%><br>
			<b>Departure:</b> <%out.print(departure2);%><br>
			<b>Arrival:</b> <%out.print(arrival);%><br>
			<b>Travel Time:</b><%out.print(traveltime + " minutes");%><br>
			<b>Interim Stops:</b><%while (interimstops.next()){
					out.print(interimstops.getString("city") + ", ");
				}%>
			<br>
			<br>

			<%
			
			String totaltripfare = routeinfo.getString("Fare");

			int thistripfare = Integer.parseInt(totaltripfare)* Integer.parseInt(routeinfo.getString("numStops")) / Integer.parseInt(routeinfo.getString("totaltransitstops"));
			double numfare = Double.parseDouble(totaltripfare)* Double.parseDouble(routeinfo.getString("numStops")) / Double.parseDouble(routeinfo.getString("totaltransitstops"));
			DecimalFormat df2 = new DecimalFormat("#.##");
			
			
			//Round Trip or One Way
			String trip = request.getParameter("trip");
			if (trip.equals("roundtrip")){
				trip = "Round Trip: " + "$" + df2.format(numfare) + " x 2 = $" + df2.format(numfare*2);
				finalfare = numfare * 2;
			}
			else{
				trip = "One Way";
				finalfare = numfare;
			}
			
			//int numfare = (Integer.parseInt(fare)/Integer.parseInt(numstops));
			
				
				//out.print(df.format(thistripfare2));
				
			
			
			
			 String discount = request.getParameter("discount");
			 //System.out.println(discount);
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
			
			
			
			
			%><i>Transit Line Details</i><br>
			<b>Transit Line:</b> <%out.print(routeinfo.getString("TransitLineName"));%><br>
			<b>Transit Line Total Fare:</b> <%out.print("$" + df2.format(Double.parseDouble(routeinfo.getString("fare"))));%><br>
			<b>Train ID:</b><%out.print(trainid);%><br>
			<b>Number of Transit Stops:</b> <%out.print(Integer.parseInt(routeinfo.getString("totaltransitstops")));%><br>
			<b>Price per Stop:</b><%out.print("$" + df2.format(Double.parseDouble(routeinfo.getString("fare"))));%>
			<%out.print(" / ");%> 
			<%out.print(Integer.parseInt(routeinfo.getString("totaltransitstops")));%>
			<%out.print(" = ");%>
			<%out.print ("$" + (df2.format(Double.parseDouble(routeinfo.getString("fare")) / Double.parseDouble(routeinfo.getString("totaltransitstops")))));%><br>
			<br>
			
			<i>Payment Details</i><br>
			<b>Number of Stops:</b> <%out.print(routeinfo.getString("numStops"));%><br>
			<b>Your Fare:</b> <%out.print(routeinfo.getString("numStops"));%>
			<%out.print(" x ");%>
			<%out.print ("$" + (df2.format(Double.parseDouble(routeinfo.getString("fare")) / Double.parseDouble(routeinfo.getString("totaltransitstops")))));%>
			<%out.print(" = ");%>
			<%out.print("$" + df2.format(numfare));%>
			
			<br>
			<b>Trip: </b> <%out.print((trip));%><br>
			<b>Discount: </b> <%out.print(discount2);%><br>
			<br>
			<b><i>Final Fare:</i></b> <%out.print("$" + df2.format(finalfare));%><br><br>
			<%
			String Stop1_ID = routeinfo.getString("Stop1_ID");
			String Stop2_ID = routeinfo.getString("Stop2_ID");
			
			%>
			<form method="post" action="addReservationToDatabase.jsp">
			<input type="submit" value="Confirm">
			<input type="hidden" id="reservationinfo" name="trainid" value="<%=trainid%>"/>
			<input type="hidden" id="reservationinfo" name="departure" value="<%=departure%>"/>
			<input type="hidden" id="reservationinfo" name="username" value="<%=username%>"/>
			<input type="hidden" id="reservationinfo" name="finalfare" value="<%=finalfare%>"/>
			<input type="hidden" id="reservationinfo" name="Stop1_ID" value="<%=Stop1_ID%>"/>
			<input type="hidden" id="reservationinfo" name="Stop2_ID" value="<%=Stop2_ID%>"/>
			
			
			
			</form>

			<form method="post" action="customer.jsp">
			<input type="submit" value="Cancel"></form>
			<%
			
			
			
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			//out.print(e);
			out.print("Select a Route from the top of the page before pressing Reserve!");
		}
	%>










</body>
</html>