# Readme.
Created an online railway booking system using HTML for the user interface,
MySQL for the database server, and Java, Javascript, and JDBC for connectivity between the user
interface and database server. Website was deployed using TomCat.
<br />
Note: Amazon Web Services login credentials and connection to the database have been redacted.<br />
<br />
Features:<br />
<br />
**I. Account functionality**<br />
  -register customers<br />
  -login (for all customers, admin, customer reps)<br />
  -logout (for all customers, admin, customer reps)<br />
<br />
**II. Browsing and search functionality**<br />
 -search for train schedules by origin, destination, date of travel<br />
 -browse the resulting schedules<br />
 -see all the stops a train will make, fare etc.<br />
 -sort by different criteria (by arrival time, departure time, fare)<br />
<br />
**III. Reservations**<br />
 -a customer should be able to make a reservation for a specific route (round-trip/one
 way)<br />
 -get a discount in case of child/senior/disabled<br />
 -cancel existing reservation<br />
 -view current and past reservations with their details (separately)<br />
<br />
**IV. Admin functions**<br />
 -Admin (create an admin account ahead of time)<br />
-add, edit and delete information for a customer representative<br />
 -obtain sales reports per month<br />
-produce a list of reservations:<br />
-by transit line<br />
-by customer name<br />
-produce a listing of revenue per:<br />
 -transit line<br />
 -customer name<br />
 -best customer<br />
 -best 5 most active transit lines<br /> 
<br />
**VI. Customer representative functions:** <br />
 -edit and delete information for train schedules<br />
 -customers browse questions and answers<br />
 -customers search questions by keywords <br />
 -customers send a question to the customer service<br />
-reps reply to customer questions <br />
 -produce a list of train schedules for a given station (as origin/destination)<br /> 
 -produce a list of all customers who have reservations on a given transit line
 and date. <br />
