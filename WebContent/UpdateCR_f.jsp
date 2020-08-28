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


	String crSSN = request.getParameter("SSN");
	String action = request.getParameter("action");
	String newVal = request.getParameter("newVal");

	try {
		
		Class.forName("com.mysql.jdbc.Driver"); 
		java.sql.Connection con = DriverManager.getConnection("[REDACTED]"); 
		Statement stmt = con.createStatement();
		
		String strQuery = "SELECT COUNT(*) FROM CustomerRep WHERE SSN=\'"+crSSN+"\'";
		ResultSet rs = stmt.executeQuery(strQuery);
		rs.next();
		String Countrow = rs.getString(1);
		
	if (Countrow.equals("1")) {
		
				if(action.equals("1")) {	
					String ssnUpdate = "update CustomerRep set SSN =\'"+newVal+"\' WHERE SSN=\'"+crSSN+"\'";
					stmt.executeUpdate(ssnUpdate);
		    		out.println("SSN successfully updated.");
			
			}else{
		    	if(action.equals("2")){
					String userUpdate = "update CustomerRep set username =\'"+newVal+"\' WHERE SSN=\'"+crSSN+"\'";
					stmt.executeUpdate(userUpdate);
			    	out.println("Username successfully updated.");
			
		    }else{
				if(action.equals("3")){
					String pwdUpdate = "update CustomerRep set pass =\'"+newVal+"\' WHERE SSN=\'"+crSSN+"\'";
					stmt.executeUpdate(pwdUpdate);
			    	out.println("Password successfully updated.");
			
			}else{
				if(action.equals("4")){	
					String fNameUpdate = "update CustomerRep set firstName =\'"+newVal+"\' WHERE SSN=\'"+crSSN+"\'";
					stmt.executeUpdate(fNameUpdate);
			    	out.println("First name successfully updated.");
			
			}else{
				if(action.equals("5")){	
					String lNameUpdate = "update CustomerRep set lastName =\'"+newVal+"\' WHERE SSN=\'"+crSSN+"\'";
					stmt.executeUpdate(lNameUpdate);
			    	out.println("Last name successfully updated.");
					}
				}	
			}
			}
			}
	}else{
				
			out.println("Error: SSN NOT FOUND");
		} 
			con.close();
			out.println("<br><a href='manageCR.jsp'> Manage customer representative</a>");
			
	}catch (Exception e){
			out.print(e);
		}
%>

</body>		
</html>   
		   
		   
		   