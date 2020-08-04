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
<title>CreatingReservation...</title>
</head>
<body>

<% 
//Get paramaters from makeReservation.jsp
	String trainid = request.getParameter("trainid");
	String departure = request.getParameter("departure");
	String username = request.getParameter("username");
	String finalfare = request.getParameter("finalfare");
	
	String Stop1_ID = request.getParameter("Stop1_ID");
	String Stop2_ID = request.getParameter("Stop2_ID");
	//out.println("Stop1 ID: "+ Stop1_ID);
	//out.println("Stop2 ID: "+ Stop2_ID);
	
	%>


<%	

//The Hidden Value is <=trainid + "\n" + departure + "\n" + username + "\n" + finalfare + "\n">

//Get the database connection
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();		

//get current date in correct format for DB
Calendar now = Calendar.getInstance();
int dayOfMonth = now.get(Calendar.DAY_OF_MONTH);
String dayOfMonthStr = ((dayOfMonth < 10) ? "0" : "") + dayOfMonth;
int month = now.get(Calendar.MONTH) + 1;
String monthStr = ((month < 10) ? "0" : "") + month;
int year = now.get(Calendar.YEAR);
System.out.print(dayOfMonth+"/"+month+"/"+year);

String currentdate = year + "-" + monthStr + "-" + dayOfMonthStr;



//create reservation number
String str1 = "SELECT * FROM Reservation Order by ReservationNumber asc;";

Statement stmt = con.createStatement();
ResultSet resnums = stmt.executeQuery(str1);
	
int reservationnum = 1;

   //increment to find a number thats not in the table to reservation number assigned is unique	
	while (resnums.next()) {
			reservationnum++; 
	}


   
   //double check reservation number isnt already in database
	String str2 = "SELECT * FROM Reservation Order by ReservationNumber asc;";
	ResultSet resnums2 = stmt.executeQuery(str2);
	
	
	int resvalue; 
	while (resnums2.next()) {
		
		resvalue = Integer.parseInt(resnums2.getString("ReservationNumber"));
		
		//found duplicate reservation number
		if (reservationnum == resvalue){
			reservationnum += 13;		
		} 
	}
	
	
	
	
/*
String str3 = "INSERT into Reservation values(" + reservationnum + ", '" + currentdate + "' ,"
		+ " '" + username + "' , '" + trainid + ", '" + departure + "');";

*/	

		
		//Make an insert statement for the Reservation sql table:
		String insert = "INSERT INTO Reservation(ReservationNumber, ResDate, username, Train_ID, Departure, TotalFare, OriginStop_ID, DestinationStop_ID)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the insert
		ps.setString(1, Integer.toString(reservationnum));
		ps.setString(2, currentdate);
		ps.setString(3, username);
		ps.setString(4, trainid);
		ps.setString(5, departure);
		ps.setString(6, finalfare);
		ps.setString(7, Stop1_ID);
		ps.setString(8, Stop2_ID);
		
		//Run the query against the DB
		ps.executeUpdate();
		



//Close the connection
		con.close();
 %>
 
<b>Success!</b><br><br> 
Your trip is confirmed. The Reservation Number is <%=reservationnum%><br><br>

<a href='customer.jsp'>Back to Your Customer Home Page</a>






</body>
</html>