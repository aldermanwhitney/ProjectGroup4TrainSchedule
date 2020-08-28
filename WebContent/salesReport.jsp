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
	Monthly Sales Report
	</h2>
	<br>
<%
		try {

			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("[REDACTED]"); 

			Statement stmt = con.createStatement();

			String strQuery = "SELECT MONTHNAME(ResDate) as month, sum(TotalFare) as sales FROM Reservation group by month order by ResDate asc ";
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