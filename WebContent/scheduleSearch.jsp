<%@ page import ="java.sql.*" %>
<%@ page import ="java.text.*" %>
<%@ page import ="java.util.Date" %>


<%--This page checks the train schedule data input from the customer.jsp with our database
to ultimately return the user to where the search results are displayed - scheduleSearchResult.jsp--%>


<%
    //get info from index.jsp page where users enter login info
    String origin = request.getParameter("origin");   
    String destination = request.getParameter("destination");    
    String traveldate = request.getParameter("traveldate");
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    //surround below line with try catch block as below code throws checked exception
    
    try{
    	Date startDate = sdf.parse(traveldate);	
    	out.println(sdf.format(traveldate));
    }
    catch (Exception e){
    	
    }
    //do further processing with Date object
    
    
    
    Class.forName("com.mysql.jdbc.Driver");
    
    //connect to database instance
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336db-wa.cfjq7n5mwnaa.us-east-2.rds.amazonaws.com:3306/TrainProjectGroup4","admin", "aw113014");
    Statement st = con.createStatement();
    ResultSet rs;
    
    rs = st.executeQuery("select * from TrainSchedule");
    response.sendRedirect("scheduleSearchResult.jsp");
    
    /*
    
    //search database
    //first, search customer table for username and password combo
    rs = st.executeQuery("select * from TrainSchedule where username='" + origin + "' and password='" + destination + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome user " + userid); //welcome message for user
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("customer.jsp");
    
    } else {
    // username/password not found in user table, check customer rep table	
    	rs = st.executeQuery("select * from CustomerRep where username='" + userid + "' and pass='" + pwd + "'");	
    
        if (rs.next()) {
            session.setAttribute("user", userid); // the username will be stored in the session
            out.println("welcome customer rep" + userid); //welcome message for user
            out.println("customer rep priveliges");
            out.println("<a href='logout.jsp'>Log out</a>");
            response.sendRedirect("customerRep.jsp");
        }
        else{
        	// username/password not found in customer or customer rep table, check admin table	
        	rs = st.executeQuery("select * from Admin where username='" + userid + "' and pass='" + pwd + "'");	
        
            if (rs.next()) {
                session.setAttribute("user", userid); // the username will be stored in the session
                out.println("welcome admin" + userid); //welcome message for user
                out.println("Admin priveliges");
                out.println("<a href='logout.jsp'>Log out</a>");
                response.sendRedirect("admin.jsp");
            }
            else{
            	
            	//username/password not found in database at all, must be an invalid password/username combo
            	//sends user back to index.jsp (main page)
            	out.println("Invalid password <a href='index.jsp'>try again</a>");
            }
        }
    
    
      */  
    
%>