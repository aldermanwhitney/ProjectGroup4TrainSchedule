<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<%


	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		String ssn = request.getParameter("SSN");
		
		String strQuery = "SELECT COUNT(*) FROM CustomerRep WHERE SSN=\'" + ssn + "\'";;
		ResultSet rs = stmt.executeQuery(strQuery);
		rs.next();
		String Countrow = rs.getString(1);
	    //out.println(Countrow);
		
		if (Countrow.equals("1")) {

		String delete = "DELETE from CustomerRep WHERE SSN=\'" + ssn + "\'";
		PreparedStatement ps = con.prepareStatement(delete);
		ps.executeUpdate();
		con.close();
		out.println("Deletion succeeded!");
		out.println("<a href='manageCR.jsp'> manage customer representative</a>");
		
		}
		else
		{
			out.println("The SSN you want to delete is not correct, please check again.");
			
		}
		
		
		
	} catch (Exception e) {
		out.print(e);
	}
%>



</body>
</html>