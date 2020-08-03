<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%--This is the main page displayed when going to the website.
From here, depending on which button is clicked, the user is sent to a different page
each associated with their own .jsp file (see under WebContent on left) --%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Group 4 Project</title>
	</head>
<body>

<b>Login For Existing Users</b>
<br>
	<form method="post" action="checkLoginDetails.jsp"> <%--If this button is clicked, user sent to checkLoginDetails.jsp--%>
	<table>
	<tr>    
	<td>Username:</td><td><input type="text" name="username"></td> <%--Text fields, "username" and "password" are sent to next page (checkLoginDetails.jsp)--%>
	</tr>
	<tr>
	<td>Password:</td><td><input type="text" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="Login"> <%--Makes a button with the label "Login" on it--%>
	</form>
<br>



<b>Registration for New Customers</b>
<br>
	<form method="post" action="register.jsp"> <%--This button being clicked sends user to register.jsp--%>
	<table>
	<tr>    
	<td>Username:</td><td><input type="text" name="username"></td> <%--Text fields, "username", "password", firstname etc are sent to next page (register.jsp)--%>
	</tr>
	<tr>
	<td>Password:</td><td><input type="text" name="password"></td>
	</tr>
	<tr>    
	<td>First Name:</td><td><input type="text" name="firstname"></td>
	</tr>
	<tr>    
	<td>Last Name:</td><td><input type="text" name="lastname"></td>
	</tr>
	<tr>    
	<td>Email:</td><td><input type="text" name="email"></td>
	</tr>
	</table>
	<input type="submit" value="Register">
	</form>
<br>



<%--These are just line breaks--%>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


<%--

(Just commented out old code so that we can reference it later if need be)


Hello World1 <!-- the usual HTML way -->
<% out.println("Hello World2"); %> <!-- output the same thing, but using 
                                      jsp programming -->

									  
<br>

 <!-- Show html form to i) display something, ii) choose an action via a 
  | radio button -->
<!-- forms are used to collect user input 
	The default method when submitting form data is GET.
	However, when GET is used, the submitted form data will be visible in the page address field-->
<form method="post" action="show.jsp">
    <!-- note the show.jsp will be invoked when the choice is made -->
	<!-- The next lines give HTML for radio buttons being displayed -->
  <input type="radio" name="command" value="beers"/>Let's have a beer! Click here to see the beers.
  <br>
  <input type="radio" name="command" value="bars"/>Let's go to a bar! Click here to see the bars.
    <!-- when the radio for bars is chosen, then 'command' will have value 
     | 'bars', in the show.jsp file, when you access request.parameters -->
  <br>
  <input type="submit" value="submit" />
</form>
<br>

An existing bar wants to sell an existing beer! Type the bar, the beer and the price of the beer:
<br>
	<form method="get" action="sellsNewBeer.jsp">
		<table>
			<tr>    
				<td>Bar</td><td><input type="text" name="barvalia"></td>
			</tr>
			<tr>
				<td>Beer</td><td><input type="text" name="beer"></td>
			</tr>
			<tr>
				<td>Price</td><td><input type="text" name="price"></td>
			</tr>
		</table>
		<input type="submit" value="Add the selling beer!">
	</form>
<br>


Alternatively, lets type in a new bar, a new beer, and a price that this bar will sell the beer for.
<br>
	<form method="post" action="newBarBeerPrice.jsp">
	<table>
	<tr>    
	<td>Bar</td><td><input type="text" name="bar"></td>
	</tr>
	<tr>
	<td>Beer</td><td><input type="text" name="beer"></td>
	</tr>
	<tr>
	<td>Price</td><td><input type="text" name="price"></td>
	</tr>
	</table>
	<input type="submit" value="Add me!">
	</form>
<br>

Or we can query the beers with price:
<br>
	<form method="get" action="query.jsp">
		<select name="price" size=1>
			<option value="3.0">$3.0 and under</option>
			<option value="5.0">$5.0 and under</option>
			<option value="8.0">$8.0 and under</option>
		</select>&nbsp;<br> <input type="submit" value="submit">
	</form>
<br>

 --%>

</body>
</html>