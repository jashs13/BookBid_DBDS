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
	// Get parameters from the HTTP request
		String manBid = request.getParameter("man_bid");
		String currBid = request.getSession().getAttribute("currBid").toString();
		String bidInc = request.getSession().getAttribute("bidInc").toString();
		String itemNum = (String) request.getSession().getAttribute("itemNum");
		String itemName = request.getSession().getAttribute("selectedItemName" + itemNum).toString();
		String itemID = request.getSession().getAttribute("selectedItemID" + itemNum).toString();
		String seller = request.getSession().getAttribute("seller").toString();
		String buyer = request.getSession().getAttribute("username").toString();
		
		// Check if the manual bid is valid
		if (Float.parseFloat(manBid) < Float.parseFloat(currBid)) {
		    out.println("Cannot place a bid lower than the current highest bid.");
		    out.println("<a href='ManualBidPage.jsp'>");
		    out.println("<br><br><input type='button' value='Back'/>");
		    out.println("</a>");
		} else if (Float.parseFloat(manBid) - Float.parseFloat(currBid) < Float.parseFloat(bidInc)) {
		    out.println("Cannot place a bid lower than the bid increment amount.");
		    out.println("<a href='ManualBidPage.jsp'>");
		    out.println("<br><br><input type='button' value='Back'/>");
		    out.println("</a>");
		} else {
		    // Get a database connection
		    ApplicationDB db = new ApplicationDB();	
		    Connection con = db.getConnection();
				
		    // Update the bid for the item
		    String updateBid = "UPDATE items SET current_price = ? WHERE item_id = ?";
		    PreparedStatement ps = con.prepareStatement(updateBid);
		    ps.setString(1, manBid);
		    ps.setString(2, itemID);
		    ps.executeUpdate();
				
		    // Display success message and link back to the item page
		    out.println("Your bid of $" + manBid + " was successfully placed for " + itemName + "!");
		    out.println("<a href='BuyPage.jsp?num=" + request.getSession().getAttribute("itemNum").toString() + "'>");
		    out.println("<br><br><input type='button' value='Back to Item'/>");
		    out.println("</a>");
				
		    // Update the bid history for the item
		    String bidHistoryUpdate = "INSERT INTO bid_history (item_id, current_bid, bidder) VALUES (?, ?, ?)";
		    PreparedStatement updatePs = con.prepareStatement(bidHistoryUpdate);
		    updatePs.setString(1, itemID);
		    updatePs.setString(2, manBid);
		    updatePs.setString(3, buyer);
		    updatePs.executeUpdate();
				
		    // Check for an automatic bid on the item
		    String checkForAutomaticbid = "SELECT maximum_bid, bidder FROM automatic_bid WHERE item_id = ?";
		    PreparedStatement checkForAutoBid = con.prepareStatement(checkForAutomaticbid);
		    checkForAutoBid.setString(1, itemID);
		    ResultSet automaticBidCheck = checkForAutoBid.executeQuery(); 
		    if (automaticBidCheck.next()) {
		        // If there is an automatic bid, check if the manual bid exceeds the upper limit of the automatic bid
		        if (Float.parseFloat(manBid) > Float.parseFloat(automaticBidCheck.getString(1))) {
		            String alertMsg = "A user bid higher than your maximum bid cap on the item " + itemName; 
		            String alertForAutoBidder = "INSERT IGNORE INTO alerts(item_id, message, username) VALUES (?, ?, ?)";
		            PreparedStatement preparedStatement = con.prepareStatement(alertForAutoBidder); 
		            preparedStatement.setString(1, itemID); 
		            preparedStatement.setString(2, alertMsg); 
					preparedStatement.setString(3, automaticBidCheck.getString(2)); 
					preparedStatement.executeUpdate(); 

				}
			}
			con.close();
		}
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Exception thrown");
	}
%>
</body>
</html>