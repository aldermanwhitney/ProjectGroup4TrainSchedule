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

<%
		try {

			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://cs336db-wa.cfjq7n5mwnaa.us-east-2.rds.amazonaws.com:3306/TrainProjectGroup4","admin", "aw113014"); 
			//Get the inputs
			String fName = request.getParameter("firstName");
			String lName = request.getParameter("lastName");
			Statement stmt = con.createStatement();

			String strQuery = "SELECT * FROM Reservation JOIN customer using (username) WHERE firstname =\'"+fName+"\' and lastname =\'"+lName+"\'";
			ResultSet rs = stmt.executeQuery(strQuery);
			
			out.print("<table style = 'width:50%'>");

				out.print("<tr>");
				
				out.print("<td>");
				out.print("Customer Name");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Reservation Number");
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
					out.print(rs.getString("ReservationNumber"));
					out.print("</td>");
					
				
					out.print("</tr>");
					
				}
			out.print("</table>");
		
		} catch (Exception e) {
			out.print(e);
		}
	%>


</body>
</html>