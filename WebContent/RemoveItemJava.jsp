<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Remove Item</title>
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
	<div class="h1"><h1 style="font-size:30px"><strong> <a href="CustomerRepHomePage.jsp"> BookBid </a> </strong></h1></div>
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
			String itemid = (String) request.getSession().getAttribute("itemid");
			String itemName = (String) request.getSession().getAttribute("itemName");

			String delete1 = "delete from alerts where item_id = ?";
			PreparedStatement ps1 = con.prepareStatement(delete1);
			ps1.setString(1, itemid);
			ps1.executeUpdate();

			String delete3 = "delete from bid_history where item_id = ?";
			PreparedStatement ps3 = con.prepareStatement(delete3);
			ps3.setString(1, itemid);
			ps3.executeUpdate();

			String delete4 = "delete from automatic_bid where item_id = ?";
			PreparedStatement ps4 = con.prepareStatement(delete4);
			ps4.setString(1, itemid);
			ps4.executeUpdate();

			String delete2 = "delete from items where item_id = ?";
			PreparedStatement ps2 = con.prepareStatement(delete2);
			ps2.setString(1, itemid);
			ps2.executeUpdate();

			// Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			out.println("Removed " + itemName);
			con.close();

		} catch (Exception ex) {
			out.print(ex);
			out.print("Insert failed");
		}
	%>
	<br></br>
	<form action="AuctionList.jsp">
		<input type="submit" value="View Items">
	</form>
</body>
</html>