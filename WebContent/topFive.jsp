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
	Top 5 Most Active Transit Lines
	</h2>
	<br>
<%
		try {

			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("[REDACTED]"); 
			Statement stmt = con.createStatement();
			/****right now we know the attribute trip_type  = oneway, so we skip it and put it as a conditional statement***/

			String strQuery = "SELECT TransitLineName, count(*) as ResMade FROM Reservation JOIN TrainSchedule using (Train_ID, Departure) group by TransitLineName order by ResMade DESC LIMIT 5";
			ResultSet rs = stmt.executeQuery(strQuery);
			
			out.print("<table style = 'width:50%'>");

				out.print("<tr>");
				
				out.print("<td>");
				out.print("Transit Line Name");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Number of tickets sold");
				out.print("</td>");
				
	
				
				out.print("</tr>");
				
				while (rs.next()) 
				{
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("TransitLineName"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("ResMade"));
					out.print("</td>");
					
				
					out.print("</tr>");
					
				}
			out.print("</table>");
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
	%>
	<br>
	<br>
	<a href='admin.jsp'>Back to management page</a>

</body>
</html>