<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Bid History</title>
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
    
    /* Form styles */
    form {
        display: inline-block;
        margin-right: 12px;
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
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String username = (String)request.getSession().getAttribute("username");
			String checkIfUserIsCustomerRepQuery = "select * from customer_reps where customer_rep_name = '" + username + "'";
			ResultSet checkIfUserIsCustomerRepResults = stmt.executeQuery(checkIfUserIsCustomerRepQuery);
			if (checkIfUserIsCustomerRepResults.next()) {
				out.println("<div class='h1'><h1><a href='CustomerRepHomePage.jsp'> BookBid </a></h1></div>");
			}
			else {
				out.println("<div class='h1'><h1><a href='LoginSuccess.jsp'> BookBid </a></h1></div>");
			}
			out.println("<center><body>");
			String num = (String)request.getSession().getAttribute("itemNum");
			String itemID = (String)request.getSession().getAttribute("selectedItemID" + num);
			request.getSession().setAttribute("itemid", itemID);
			String itemName = (String)request.getSession().getAttribute("selectedItemName"+num);
			//out.println("hello");
			String query = "select bidder, current_bid from bid_history where item_id = " + itemID;
			ResultSet result = stmt.executeQuery(query);
			
			out.println("<h1 style='font-size:30px'><strong>" + itemName + " Bid History</strong></h1>");
			out.println("<br><br>");
			if (!result.next()) {
				out.println("<h2 style='font-size:25px'><strong>No Bids Have Been Placed!</strong></h1>");
			}
			else {
				out.println("<br>");
				// ITEM DETAILS
				out.println("<table>");
				out.println("<tr>");
		        out.println("<td><strong> Bidder </strong></td><td><strong> Bid </strong></td>");
		        out.println("</tr>");
	       		int i = 1;
	       		result.beforeFirst();
	   	        while(result.next()) {
	   	        	if (i % 2 != 0) {
	   	        		out.println("<tr>");
	   	        		out.println("<td><p> " + result.getString(1) + "</p></td><td><p><a style='font-size:18px' href='ViewBid.jsp?num="+ i + "'>" + result.getString(2)+"</a></p></td>");
	   	        		request.getSession().setAttribute("selectedBidder"+i, result.getString(1));
				        request.getSession().setAttribute("selectedBidAmount"+i, result.getString(2));
	   	        		out.println("</tr>");
	   	        	}
	   	        	else {
	   	        		out.println("<tr>");
	   	        		out.println("<td><p>" + result.getString(1) + "</p></td><td><p><a style='font-size:18px' href='ViewBid.jsp?num="+ i + "'>" + result.getString(2)+"</a></p></td>");
	   	        		request.getSession().setAttribute("selectedBidder"+i, result.getString(1));
				        request.getSession().setAttribute("selectedBidAmount"+i, result.getString(2));
	   	        		out.println("</tr>");
	   	        	}
	   	        	i++;
	   	        }
	   	        out.println("</table>");
	   	        out.println("</form>");
			}
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
		} catch (Exception ex) {
			out.print(ex);
			
		}
%>

</body></center>
</html>