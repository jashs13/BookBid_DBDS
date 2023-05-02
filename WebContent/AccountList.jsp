<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Auction List</title>
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
        width: 50%;
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
	</style>
<div class='h1'><h1><a href='CustomerRepHomePage.jsp'> BookBid </a></h1></div>
<body>
<br>
		<%
		try {
			// Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			// Create a SQL statement
			Statement stmt = con.createStatement();
			String username = (String) request.getSession().getAttribute("username");
			String query = "SELECT username, password FROM user";
			ResultSet result = stmt.executeQuery(query);
	%>
			// Display BuyMe Users
			<h1 style='font-size:25px'><strong>BookBid Users</strong></h1>
			<br>
			<form action='BuyPage.jsp'>
			<table>

	<% 		// Check if there are any users
			if (!result.next()) {%>
			    <h3 style='font-size:25px'><strong>No Users Yet!</strong></h3>
			<% } else {%>
			    <tr>
			    <td><strong><u><big>Users</big></u></strong></td>
			    </tr>
			    <% int i = 1;
			    result.beforeFirst();
			    while (result.next()) {
			        if (result.getString(1).equals("admin")) {
			            continue;
			        }
			        if (i % 2 != 0) {%>
			            <tr>
			           <% out.println("<td><a style='font-size:18px' href='ViewAccount.jsp?num=" + i + "'>" + result.getString(1)
			                    + "</a></td>");
			            request.getSession().setAttribute("selectedUsername" + i, result.getString(1));
			            request.getSession().setAttribute("selectedPassword" + i, result.getString(2));

			            %></tr>
			        <% } else {
			            out.println("<tr>");
			            out.println("<td><a style='font-size:18px' href='ViewAccount.jsp?num=" + i + "'>" + result.getString(1)
			                    + "</a></td>");
			            request.getSession().setAttribute("selectedUsername" + i, result.getString(1));
			            request.getSession().setAttribute("selectedPassword" + i, result.getString(2));

			            out.println("</tr>");
			        }
			        i++;
			    }%>
			    <table></form>
			    <%
			}

			// Close the connection
			con.close();
		} catch (Exception ex) {
			out.print(ex);
			out.print("insert failed");
			}
	%>
	<form action="LoginSuccess.jsp">
		<input type=hidden style="font-size:15px;height:30px;width:200px" value="Go back to main page">
	</form>
	<br><br>
	<form action="CustomerRepHomePage.jsp">
		<input type="submit" style="font-size:15px;height:30px;width:200px" value="Go back to main page">
	</form>

<br><br>
<br></br>
</body>
</html>