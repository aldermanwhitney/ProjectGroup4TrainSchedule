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
<title>Train Schedule Search Result</title>
</head>
<body>

<b><u>Train Schedule Search Result</u></b><br>
<i>Select a route from the below schedule to book a reservation.</i><br><br>

<form method="post" action="makeReservation.jsp">
<%

try {
	
	
    //get info from customer.jsp page where customer enters seach info
    //may need to fix capitlization later
    String origin = request.getParameter("origin"); 
    String destination = request.getParameter("destination");   
    String traveldate = request.getParameter("traveldate");
    
    //get selected radio button for seach sorting
    String sortcommand = request.getParameter("command");
    
    /*
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    //surround below line with try catch block as below code throws checked exception
    
    try{
    	Date startDate = sdf.parse(traveldate);	
    	out.println(sdf.format(traveldate));
    	System.out.println(sdf.format(traveldate));
    }
    catch (Exception e){
    	
    }
    */
	
    //out.print(traveldate);
    //String origincapitalized = origin.substring(0, 1).toUpperCase() + origin.substring(1);
    //String destinationcapitalized = destination.substring(0, 1).toUpperCase() + origin.substring(1);
    
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			//Get the selected radio button from the index.jsp
			//String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			//String str = "SELECT * FROM TrainSchedule";
			//"Drop table if exists t1;\n" +
			//		"Drop table if exists t2;\n" +
			//"Create Temporary table t1\n" + 
			//"create temporary table t2\n" +
			
			
			String d1 = "Drop View if Exists t1;";
			String d2 = "Drop View if Exists t2;";
			String d3 = "Drop View if Exists t3;";
			String d4 = "Drop View if Exists t4;";
			String d5 = "Drop View if Exists t5;";
			
			
			
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
			
			
			String str5 = "CREATE VIEW t4\n" + 
					"AS\n" +
			"select t.Departure, t.Train_ID, st.Stop_ID, st.Stoptime, s.city\n" + 
			"from Stops st, Station s, TrainSchedule t\n" + 
			"where s.Station_ID=st.Stop_ID\n" + 
			"and st.Departure = t.Departure\n" + 
			"and st.Train_ID = t.Train_ID";
			
			String str6 = "CREATE VIEW t5\n" + 
					"AS\n" +
					"(Select t3.*, t4.Stoptime, t4.city\n" + 
					"from t3, t4\n" +
					"where t3.Departure = t4.Departure\n" +
					"and t3.Train_ID=t4.Train_ID);";
					
			String str7 = "SELECT * FROM t5;";
			
			//Run the query against the database.
			
			//drop any existing views
			stmt.execute(d1);
			stmt.execute(d2);
			stmt.execute(d3);
			stmt.execute(d4);
			stmt.execute(d5);
			
			//create new temporary tables (views)
			stmt.execute(str1);
			stmt.execute(str2);
			stmt.execute(str3);
			stmt.execute(str5);
			stmt.execute(str6);
			
			
			ResultSet result;
			
			//execute seach depending on what attributes have been selected in the search
			
			//destination field empty, search origins and date only
			if (!origin.equals("") && destination.equals("")){
				String stred = "SELECT * FROM t3 where OriginCity ='" + origin + "' and Departure LIKE '"
						+ traveldate + "%' Order by " + sortcommand + " asc;";
				result = stmt.executeQuery(stred);
				
			}
			//origin field empty, search destinations and date only
			else if (origin.equals("") && !destination.equals("")){
				String streo = "SELECT * FROM t3 where DestinationCity ='" + destination + "' and Departure LIKE '"
						+ traveldate + "%' Order by " + sortcommand + " asc;";
				result = stmt.executeQuery(streo);
			}
			
			//both empty, search all by date
			else if ((origin.equals("") && destination.equals(""))){
				String strbe = "SELECT * FROM t3 where Departure LIKE '" + traveldate + "%' Order by " + sortcommand + " asc;";
				result = stmt.executeQuery(strbe);
			}
			else{
			//origin and destination both have fields, search by both and date	
				String str4 = "SELECT * FROM t3 where OriginCity ='" + origin 
						+ "' and DestinationCity = '"    + destination +  "' and Departure LIKE '"
								+ traveldate + "%' Order by " + sortcommand + " asc;";
				result = stmt.executeQuery(str4);
			}
			
			
			//ResultSet stops = stmt.executeQuery()
			
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
//			out.print("<b>");
				//out.print("Destination City");
			//	out.print("</b>");
		//	out.print("</td>");
			
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
				out.print("Stops");
				out.print("</b>");
			out.print("</td>");
			
			//make a column
			out.print("<td>");
			out.print("<b>");
				out.print("Choose Route");
				out.print("</b>");
			out.print("</td>");	
			
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				
				//create new stops table for each interation of train schedule to check
				ResultSet stopstable = stmt2.executeQuery(str7);
				
				
				//make a row
				out.print("<tr>");
				
				//make a column
				out.print("<td>");
				//Print out current bar or beer name:
				out.print(result.getString("Train_ID"));
				out.print("</td>");
				
				String TrainID = result.getString("Train_ID");
				//out.print("<td>");
				//Print out current bar/beer additional info: Manf or Address
				//	out.print(result.getString("Origin_ID"));
				//out.print("</td>");

				out.print("<td>");
				out.print(result.getString("OriginCity"));
				out.print(", ");
				out.print(result.getString("OriginState"));
			 	out.print("</td>");
				
				//out.print("<td>");
				//out.print(result.getString("t1.State"));
			 	//out.print("</td>");
				
				//out.print("<td>");
				//out.print(result.getString("Destination_ID"));
			 	//out.print("</td>");
			 	
				out.print("<td>");
				out.print(result.getString("DestinationCity"));
				out.print(", ");
				out.print(result.getString("DestinationState"));
			 	out.print("</td>");
				
				//out.print("<td>");
				//out.print(result.getString("t2.State"));
			 	//out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("TransitLineName"));
				out.print("</td>");
				
				out.print("<td>");
					out.print(result.getString("Departure"));
				out.print("</td>");
				
				String Departure = result.getString("Departure");
				String passinfo = TrainID + " "+ Departure;
				
				out.print("<td>");
					out.print(result.getString("Arrival"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("TravelTime"));
				out.print("</td>");
			
				out.print("<td>");
				out.print(result.getString("Fare"));
				out.print("</td>");
				
				
				//out.print("<tr>");
				//make a column
				out.print("<td>");
				
				while (stopstable.next()) {
					//make a row
					
				if (result.getString("Train_ID").equals(stopstable.getString("Train_ID")) &&
						result.getString("Departure").equals(stopstable.getString("Departure"))){
			
					
					out.print(stopstable.getString("city"));
					out.print("<br/>");
					out.print(stopstable.getString("Stoptime"));
					out.print("<br/>");
					out.print("<br/>");

					
							
				}
				}
				//out.print("</tr>");
				//make a column
			out.print("<td>");	
			
			
				
				%><input type="radio" name="command" value="<%=TrainID + " " + Departure%>"/><%
				out.print("</td>");
				
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
		} catch (Exception e) {
			out.print(e);
		}
	%>
	<br>
	<i><b>Discounts</b></i><br>
	Senior <input type="radio" name="discount" value="senior"/><br>
	Child <input type="radio" name="discount" value="child"/><br>
	Disabled <input type="radio" name="discount" value="disabled"/><br>
	Not Applicable <input type="radio" name="discount" value="notapplicable" checked="checked"/><br>
	<br>
	<b>Ticket</b><br>
	Round Trip <input type="radio" name="trip" value="roundtrip" checked = "checked"/>
	One Way <input type="radio" name="trip" value="oneway"/><br>
	<br>	
	<input type="submit" value="Reserve"></form>
	<br><br><br><br>	
	<form method="post" action="customer.jsp"> <%--This button being clicked sends user to scheduleSearch.jsp--%>
	<b>Book A Reservation</b>
	<br>
	<table>
	<tr>    
	<td>Train ID:</td><td><input type="text" name="origin"></td> <%--Text fields, "origin", "destination", "traveldate" etc are sent to next page (scheduleSearchResult.jsp)--%>
	</tr>
	<tr>
	<td>Departure:</td><td><input type="text" name="destination"></td>
	</tr>
	<tr>    
	<td>Departure:</td><td><input type="date" name="traveldate" required pattern="\d{4}-\d{2}-\d{2} \d{2}:\d{2}:d{2}:d{1}" title="YYYY-MM-DD HH:MM:ss.s" value="2020-08-06 10:00:00.0"
       min="2020-08-06" max="2025-12-31">
    <span class="validity"></span></td>
	</tr>
	<tr>    
	<td>	
</td>
	</tr>
	</table>
	<br>
	<i>Book:</i>
	<br>
	 <input type="radio" name="command" value="Arrival"/>Round Trip
	 <input type="radio" name="command" value="Departure"/>One Way
	 <input type="radio" name="command" value="Fare"/>Fare
	 <br>
	 <br>
	<input type="submit" value="Search">
	</form>



</body>
</html>