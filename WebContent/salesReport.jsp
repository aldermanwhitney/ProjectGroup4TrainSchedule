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

			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://cs336db-wa.cfjq7n5mwnaa.us-east-2.rds.amazonaws.com:3306/TrainProjectGroup4","admin", "aw113014"); 

			Statement stmt = con.createStatement();

			String strQuery = "SELECT MONTHNAME(ResDate) as month, sum(TotalFare) as sales FROM Reservation group by month order by month asc ";
			ResultSet rs = stmt.executeQuery(strQuery);
			
			out.print("<table style = 'width:50%'>");

				out.print("<tr>");
				
				out.print("<td>");
				out.print("Month");
				out.print("</td>");

				
				out.print("<td>");
				out.print("Total Sales");
				out.print("</td>");
				
	
				
				out.print("</tr>");
				
				while (rs.next()) 
				{
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("month"));
					out.print("</td>");
					
					
					out.print("<td>");
					out.print("$");
					out.print(rs.getString("sales"));
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