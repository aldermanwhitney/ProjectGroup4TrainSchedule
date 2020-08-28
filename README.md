# Readme.
Created an online railway booking system using HTML for the user interface,
MySQL for the database server, and Java, Javascript, and JDBC for connectivity between the user
interface and database server. Website was deployed using TomCat.

Note: Amazon Web Services login credentials and connection to the database have been redacted.

Features:

I. Account functionality
  register customers
  login (for all customers, admin, customer reps)
  logout (for all customers, admin, customer reps)

II. Browsing and search functionality
 search for train schedules by origin, destination, date of travel
 browse the resulting schedules
 see all the stops a train will make, fare etc.
 sort by different criteria (by arrival time, departure time, fare)

III. Reservations
 [] a customer should be able to make a reservation for a specific route (round-trip/one
 way)
 [] get a discount in case of child/senior/disabled
 [] cancel existing reservation
 [] view current and past reservations with their details (separately)

IV. Admin functions
 [] Admin (create an admin account ahead of time)
[] add, edit and delete information for a customer representative
 [] obtain sales reports per month
[] produce a list of reservations:
[] by transit line
[] by customer name
[] produce a listing of revenue per:
 [] transit line
 [] customer name
 [] best customer
 [] best 5 most active transit lines 

VI. Customer representative functions: 
 [] edit and delete information for train schedules
 [] customers browse questions and answers
 [] customers search questions by keywords 
 [] customers send a question to the customer service
[] reps reply to customer questions 
 [] produce a list of train schedules for a given station (as origin/destination) 
 [] produce a list of all customers who have reservations on a given transit line
 and date. 
