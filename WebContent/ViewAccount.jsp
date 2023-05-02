<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: View Account</title>
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
    
    /* Table styles */
    table {
        border-collapse: collapse;
        margin: 0 auto;
        width: 25%;
    }
    
    th, td {
        border: 1px solid #ccc;
        padding: 12px;
        text-align: center;
    }
    
    th {
        background-color: #f7f7f7;
        font-weight: bold;
        text-transform: uppercase;
    }
    
    tr:nth-child(even) {
        background-color: #f2f2f2;
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
		.button-container form, .button-container form div { display: inline; }
		.button-container button { display: inline; vertical-align: middle;}
</style>
<div class='h1'><h1><a href='CustomerRepHomePage.jsp'> BookBid </a></h1></div>
<body>
	<%
	try {
		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		// Create a SQL statement
		String num = request.getParameter("num");
		String user = (String) request.getSession().getAttribute("selectedUsername" + num);
		String pass = (String) request.getSession().getAttribute("selectedPassword" + num);

		// Set session attributes
		request.getSession().setAttribute("user", user);
		request.getSession().setAttribute("pass", pass);

		// Display user details
		out.println("<h1>User</h1>");
		out.println("<table>");
		out.println("<tr><td><strong>Username</strong></td><td><strong>Password</strong></td></tr>");
		out.println("<tr><td><p>" + user + "</p></td><td><p>" + pass + "</p></td></tr>");
		out.println("</table>");

		// Close the connection
		con.close();
	} catch (Exception e) {
		out.print(e);
		}
%>
<br>
<div class='button-container'>
<form action="EditAccount.jsp">
	<input type="submit" value="Edit Account">
</form>
</div>
</body>
</html>