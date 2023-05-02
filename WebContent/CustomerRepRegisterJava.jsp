<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Register</title>
</head>
<style>body {
       background-color: #f7f7f7;
       font-family: Arial, sans-serif;
       font-size: 16px;
       line-height: 1.5;
       text-align: center;
   }
    
    /* Heading styles */
    h1 {
        font-size: 32px;
        font-weight: bold;
        margin-top: 0;
        margin-bottom: 24px;
        text-align: center;
        text-transform: uppercase;
    }
    
    /* Link styles */
    a:link,
    a:visited {
        color: black;
        text-decoration: none;
    }
    a:hover {
        color: black;
        text-decoration: underline;
    }
    input[type="submit"] {
        font-size: 15px;
        height: 30px;
        width: 300px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }
      /* Darken the button on hover */
      input[type="submit"]:hover {
        background-color: #3e8e41;
      }
	</style>
	<div class="h1"><h1 style="font-size:30px"><strong> <a href="Home.jsp"> BookBid </a> </strong></h1></div>
<body>	
<br></br>
		<%
		try {
			// Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			// Create a SQL statement
			Statement stmt = con.createStatement();

			// Get parameters from the HTML form at the Register.jsp
			String user = request.getParameter("cus_rep_username");
			String pass = request.getParameter("cus_rep_password");
			String confirmPass = request.getParameter("confirm_cus_rep_password");

			if (!pass.equals(confirmPass)) {
			    out.println("Passwords don't match");
			} else {
			    String query = "SELECT * FROM customer_reps WHERE customer_rep_name = ?";
			    PreparedStatement pstmt = con.prepareStatement(query);
			    pstmt.setString(1, user);
			    ResultSet result = pstmt.executeQuery();
			    boolean inDb = result.first();
			    if (inDb) {
			        out.print("Username is already taken. Please try a different username.");
			    } else if (!inDb) {
			        if (user.trim().equals("") || pass.trim().equals("")) {
			            out.print("Cannot have a blank username or password");
			        } else {
			            // Make an insert statement for the Sells table:
			            String insert = "INSERT INTO customer_reps (customer_rep_name, customer_rep_password) VALUES (?, ?)";
			            // Create a Prepared SQL statement allowing you to introduce the parameters of the query
			            PreparedStatement ps = con.prepareStatement(insert);

			            // Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			            ps.setString(1, user);
			            ps.setString(2, pass);
			            ps.executeUpdate();
			            out.print("You successfully created a customer representative account!");
			        }
			    }
			}

			// Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
		}catch (Exception ex) {
			out.print(ex);
			out.print("Insert failed");
		}
		%>
		<br></br>
		<form action="AdminDashboard.jsp">
		<input type="submit" value="Go back to main page">
	</form>
</body>
</html>