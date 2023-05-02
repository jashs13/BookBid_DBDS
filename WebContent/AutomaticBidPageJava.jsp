<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe: Bid Status</title>
</head>
<style>
		body {
			background-color: #f2f2f2;
			font-family: Arial, sans-serif;
			text-align: center;
		}
		h1 {
            margin-top: 0;
            font-size: 30px;
        }
        a:link,
        a:visited {
            color: black;
            text-decoration: none;
        }
        a:hover {
            color: black;
            text-decoration: underline;
        }
        input[type="button"] {
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
      input[type="button"]:hover {
        background-color: #3e8e41;
      }
	</style>
	<div class="h1"><h1 style="font-size:28px"><strong> <a href="LoginSuccess.jsp"> BookBid </a> </strong></h1></div>
<body>	
<br></br>
<%
try {
		// Get parameters from the HTML form
		String autoBid = request.getParameter("auto_bid");
		String autoBidInc = request.getParameter("auto_bid_inc");
		String currBid = (String) request.getSession().getAttribute("currBid");
		String bidInc = (String) request.getSession().getAttribute("bidInc");
		String itemNum = (String) request.getSession().getAttribute("itemNum");
		String itemName = (String) request.getSession().getAttribute("selectedItemName" + itemNum);
		String itemID = (String) request.getSession().getAttribute("selectedItemID" + itemNum);
		String bidder = (String) request.getSession().getAttribute("username");

		// Validate the bid increment amount
		if (Float.parseFloat(autoBidInc) < Float.parseFloat(bidInc)) {
		    out.println("Cannot make your bid increment lower than the set bid increment amount.");
		    out.println("<a href='AutomaticBidPage.jsp'>");
		    out.println("<br><br><input type='button' value='Back'/>");
		    out.println("</a>");
		} else {
		    // Save the automatic bid in the database
		    ApplicationDB db = new ApplicationDB();
		    Connection con = db.getConnection();

		    String bidHistoryUpdate = "INSERT INTO automatic_bid (item_id, bidder, maximum_bid, bid_increment) VALUES (?, ?, ?, ?)";
		    PreparedStatement updatePs = con.prepareStatement(bidHistoryUpdate);
		    updatePs.setString(1, itemID);
		    updatePs.setString(2, bidder);
		    updatePs.setString(3, autoBid);
		    updatePs.setString(4, autoBidInc);
		    updatePs.executeUpdate();

		    out.println("Your automatic bid has been saved. Return to item listing");
		    out.println("<a href='BuyPage.jsp?num=" + itemNum + "'>");
		    out.println("<br><br><input type='button' value='Back to Item'/>");
		    out.println("</a>");

		    con.close();
		}
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Exception thrown");
	}
%>
</body>
</html>