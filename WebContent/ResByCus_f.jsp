<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="javax.sql.*"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>
	Reservations by Customer
	</h2>
	<br>
<%
		try {

			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("[REDACTED]"); 
			//Get the inputs
			String fName = request.getParameter("firstName");
			String lName = request.getParameter("lastName");
			Statement stmt = con.createStatement();

			String strQuery = "SELECT * FROM TrainSchedule Join Reservation using (Train_ID, Departure) JOIN customer using (username) WHERE firstname =\'"+fName+"\' and lastname =\'"+lName+"\'";
			ResultSet rs = stmt.executeQuery(strQuery);
			
			out.print("<table style = 'width:50%'>");

				out.print("<tr>");
				
				out.print("<td>");
				out.print("Customer Name");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Departure");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Origin");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Destination");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Transit Line");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Train ID");
				out.print("</td>");
				
				
				out.print("<td>");
				out.print("Reservation Number");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Total Fare");
				out.print("</td>");
				
	
				
				out.print("</tr>");
				
				while (rs.next()) 
				{
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("firstname"));
					out.print(" ");
					out.print(rs.getString("lastname"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Departure"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("OriginStop_ID"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("DestinationStop_ID"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("TransitLineName"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Train_ID"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("ReservationNumber"));
					out.print("</td>");
					
					out.print("<td>");
					out.print("$");
					out.print(rs.getString("TotalFare"));
					out.print("</td>");
				
					out.print("</tr>");
					
				}
			out.print("</table>");
			con.close();
		}catch (Exception e){
			out.print(e);
		}
	%>

<br>
<br>
<br>
<a href='admin.jsp'>Back to management page</a>
</body>
</html>