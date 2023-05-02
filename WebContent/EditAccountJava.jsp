<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Edit Account</title>
</head>
<style>
		body {
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
        width: 200px;
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
	<div class="h1"><h1 style="font-size:30px"><strong> <a href="CustomerRepHomeJava.jsp"> BookBid </a> </strong></h1></div>
<body>	
<br></br>
		<%
		try {
		    // Get the database connection
		    ApplicationDB db = new ApplicationDB();
		    Connection con = db.getConnection();

		    // Get parameters from the HTML form at the Register.jsp
		    String oldUser = (String) request.getSession().getAttribute("user");
		    String oldPass = (String) request.getSession().getAttribute("pass");

		    String newUser = request.getParameter("edit_username");
		    String newPass = request.getParameter("edit_password");
		    String newConfirmPass = request.getParameter("edit_confirm_password");

		    // Check if username is unchanged
		    if (oldUser.equals(newUser)) {
		        String updatePasswordQuery = "UPDATE user SET password = ? WHERE username = ?";
		        PreparedStatement ps = con.prepareStatement(updatePasswordQuery);
		        ps.setString(1, newPass);
		        ps.setString(2, newUser);
		        ps.executeUpdate();
		        out.print("Account edited successfully!");
		    } else {
		        // Check if passwords match
		        if (!newPass.equals(newConfirmPass)) {
		            out.println("Passwords don't match");
		        } else {
		            // Check if username already exists
		            String checkUsernameQuery = "SELECT * FROM user WHERE username = ?";
		            PreparedStatement pstmt = con.prepareStatement(checkUsernameQuery);
		            pstmt.setString(1, newUser);
		            ResultSet result = pstmt.executeQuery();

		            boolean inDb = result.first();
		            if (inDb) {
		                out.print("Username is already taken. Please try a different username.");
		            } else if (!inDb) {
		                // Check if username and password are not blank
		                if (newUser.trim().equals("") || newPass.trim().equals("")) {
		                    out.print("Cannot have a blank username or password");
		                } else {
		                    String updateAccountQuery = "UPDATE user SET username = ?, password = ? WHERE username = ?";
		                    PreparedStatement ps = con.prepareStatement(updateAccountQuery);
		                    ps.setString(1, newUser);
		                    ps.setString(2, newPass);
		                    ps.setString(3, oldUser);
		                    ps.executeUpdate();
		                    out.print("Account edited successfully!");
		                }
		            }
		        }
		    }

		    // Close the connection
		    con.close();
		} catch (SQLException ex) {
		    out.print(ex);
		    out.print("insert failed");
		}
	%>
	<br></br>
	<form action="AccountList.jsp">
		<input type="submit" value="View Accounts">
	</form>
</body>
</html>