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
	Best Customer
	</h2>
	<br>
<%
try {

	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("[REDACTED]"); 
	Statement stmt = con.createStatement();


	String strQuery = "SELECT x.firstname, x.lastname, max(x.revc) as topRev FROM (SELECT firstname, lastname, sum(TotalFare) as revc FROM Reservation JOIN customer using (username) group by username) as x";
	ResultSet rs = stmt.executeQuery(strQuery);
	
	out.print("<table style = 'width:50%'>");

		out.print("<tr>");
		
		out.print("<td>");
		out.print("Customer Name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Total Revenue");
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
			out.print("$");
			out.print(rs.getString("topRev"));
			out.print("</td>");
			
		
			out.print("</tr>");
			
		}
	out.print("</table>");


} catch (Exception e) {
	out.print(e);
out.println("Error"); 
}
	%>
	<br>
	<br>
	<a href='admin.jsp'>Back to management page</a>

</body>
</html>