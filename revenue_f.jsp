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
		String action = request.getParameter("action");

		if(action.equals("1"))
		{
			
			try {

				//Get the database connection
				Class.forName("com.mysql.jdbc.Driver"); 
				java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://cs336db-wa.cfjq7n5mwnaa.us-east-2.rds.amazonaws.com:3306/TrainProjectGroup4","admin", "aw113014"); 
				Statement stmt = con.createStatement();
				
				String strQuery = "SELECT sum(TotalFare) as revt, TransitLineName FROM Reservation JOIN TrainSchedule using (Train_ID, Departure) group by TransitLineName";

				ResultSet rs = stmt.executeQuery(strQuery);
				
				out.print("<table style = 'width:50%'>");

					out.print("<tr>");
					
					out.print("<td>");
					out.print("Transit Line");
					out.print("</td>");
					
					out.print("<td>");
					out.print("Revenue");
					out.print("</td>");
					
					out.print("</tr>");
					
					while (rs.next()) 
					{
						
						out.print("<tr>");
						
						out.print("<td>");
						out.print(rs.getString("TransitLineName"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(rs.getString("revt"));
						out.print("</td>");
						
					
						out.print("</tr>");
						
					}
				out.print("</table>");

			
			} catch (Exception e) {
				out.print(e);
			}
			
		}
		
		
		else if (action.equals("2"))
		{
			try {

				Class.forName("com.mysql.jdbc.Driver"); 
				java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://cs336db-wa.cfjq7n5mwnaa.us-east-2.rds.amazonaws.com:3306/TrainProjectGroup4","admin", "aw113014"); 
				Statement stmt = con.createStatement();
			

				String strQuery = "SELECT firstname, lastname, sum(TotalFare) as revc FROM Reservation JOIN customer using (username) group by username";
				ResultSet rs = stmt.executeQuery(strQuery);
				
				out.print("<table style = 'width:50%'>");

					out.print("<tr>");
					
					out.print("<td>");
					out.print("Customer Name");
					out.print("</td>");
					
					out.print("<td>");
					out.print("Total Sales");
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
						out.print(rs.getString("revc"));
						out.print("</td>");
						
					
						out.print("</tr>");
						
					}
				out.print("</table>");

			
			} catch (Exception e) {
				out.print(e);
			}
		}
		
		else{
			out.println("Error"); 
		}
	%>

</body>
</html>