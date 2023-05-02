<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Buy</title>
</head>
<style>
    /* Body styles */
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
			
			//Get parameters from the HTML form at the index.jsp
			String num = request.getParameter("num").toString();
			request.getSession().setAttribute("itemNum", num);
			
			String itemid = (String)request.getSession().getAttribute("selectedItemID" + num);
			request.getSession().setAttribute("itemid", itemid);
			String itemName = (String)request.getSession().getAttribute("selectedItemName"+num);
			request.getSession().setAttribute("itemName", itemName);
			String username = (String)request.getSession().getAttribute("username");
			
			Statement stmtCR = con.createStatement();
			String checkIfUserIsCustomerRepQuery = "select * from customer_reps where customer_rep_name = '" + username + "'";
			ResultSet checkIfUserIsCustomerRepResults = stmtCR.executeQuery(checkIfUserIsCustomerRepQuery);
			if (checkIfUserIsCustomerRepResults.next()) {
				out.println("<div class='h1'><h1><a href='CustomerRepHomePage.jsp'> BookBid </a></h1></div>");
			}
			else {
				out.println("<div class='h1'><h1><a href='LoginSuccess.jsp'> BookBid </a></h1></div>");
			}
			
			out.println("<center><body>");
			String query = "select * from items where item_id = \"" + itemid + "\"";
			ResultSet result = stmt.executeQuery(query);
			ResultSetMetaData resultMetaData = result.getMetaData();
			result.next();
			
			
			// Before rendering the item price, see if any automatic bidding stuff has to happen
			String autobid = "SELECT * FROM automatic_bid WHERE item_id = \"" + itemid + "\"" ;
			Statement stmt2 = con.createStatement();
			ResultSet autobids = stmt2.executeQuery(autobid);
			if(autobids.next()) {
				// At this point we know automatic bids exist. Let's check if the last bid on the item was made by the same person 
				// who is automatically bidding
				String automaticBidder = autobids.getString(2); 
				String itemBidHistory = "SELECT * FROM bid_history WHERE item_id = \"" + itemid + "\" ORDER BY current_bid DESC LIMIT 1" ;
				Statement stmt3 = con.createStatement();
				ResultSet itemBidHistoryResults = stmt3.executeQuery(itemBidHistory);
				// Check if there are bid histories on this item 
				if(itemBidHistoryResults.next()){
					if(!itemBidHistoryResults.getString(3).equals(automaticBidder)){
						// If the last bid wasn't caused by the automatic bidder, try to kick in automatic bidder's bid 
						float currentPrice = Float.parseFloat(result.getString(8));
						float proposedAutomaticBid = currentPrice + Float.parseFloat(autobids.getString(4)); 
						if(proposedAutomaticBid <= Float.parseFloat(autobids.getString(3))){
							// we're good for this bid 
							String bidHistoryUpdate = "INSERT INTO bid_history (item_id, current_bid, bidder) VALUES (?, ?, ?)";
							PreparedStatement updatePs = con.prepareStatement(bidHistoryUpdate);
							updatePs.setString(1, itemid);
							updatePs.setString(2, proposedAutomaticBid+"");
							updatePs.setString(3, automaticBidder);
							updatePs.executeUpdate();

							String updateBid = "update items set current_price = ? where item_id = ?";
							//Create a Prepared SQL statement allowing you to introduce the parameters of the query
							PreparedStatement ps = con.prepareStatement(updateBid);

							//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
							ps.setString(1, proposedAutomaticBid+"");
							ps.setString(2, itemid);
							ps.executeUpdate();
						}
					}
				}
				else{ 
					float currentPrice = Float.parseFloat(result.getString(8));
					float proposedAutomaticBid = currentPrice + Float.parseFloat(autobids.getString(4)); 
					if(proposedAutomaticBid <= Float.parseFloat(autobids.getString(3))){
						// we're good for this bid 
						String bidHistoryUpdate = "INSERT INTO bid_history (item_id, current_bid, bidder) VALUES (?, ?, ?)";
						PreparedStatement updatePs = con.prepareStatement(bidHistoryUpdate);
						updatePs.setString(1, itemid);
						updatePs.setString(2, proposedAutomaticBid+"");
						updatePs.setString(3, automaticBidder);
						updatePs.executeUpdate();

						String updateBid = "update items set current_price = ? where item_id = ?";
						//Create a Prepared SQL statement allowing you to introduce the parameters of the query
						PreparedStatement ps = con.prepareStatement(updateBid);

						//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
						ps.setString(1, proposedAutomaticBid+"");
						ps.setString(2, itemid);
						ps.executeUpdate();
					}
				}

			}
			

			
			Statement stmt4 = con.createStatement();
			result = stmt4.executeQuery(query);
			resultMetaData = result.getMetaData();
			result.next();

			
			request.getSession().setAttribute("currBid", result.getString(8));
			request.getSession().setAttribute("bidInc", result.getString(7));
			request.getSession().setAttribute("seller", result.getString(5));

			String seller = request.getSession().getAttribute("seller").toString();
			
			
			out.println("<h1 style='font-size:30px'><strong>" + result.getString(2) + "</strong></h1>");
			out.println("<h3 style='font-size:22px'><strong> Current Price: $" + result.getString(8) + "</strong></h3>");
			
			if (!seller.equals(username)) {
				
				checkIfUserIsCustomerRepResults.beforeFirst();
				if (checkIfUserIsCustomerRepResults.next()) {%>
					<div class='button-container'>
		            <form style='text:align=center' action='RemoveItemJava.jsp'>
		            <input type='submit' style='font-size:15px;height:30px;width:150px' value='Remove Item'>
		            </form>

		    		<form style='text:align=center' action='BidHistoryPage.jsp'>
		            <input type='submit' style='font-size:15px;height:30px;width:150px' value='View Bid History'>
		            </form>
		            </div>
				<% }
				else {%>
					
					<div class='button-container'>
		            <form style='text:align=center' action='ManualBidPage.jsp'>
		            <input type='submit' style='font-size:15px;height:30px;width:150px' value='Place Manual Bid'>
		            </form>

		    		<form style='text:align=center' action='BidHistoryPage.jsp'>
		            <input type='submit' style='font-size:15px;height:30px;width:150px' value='View Bid History'>
		            </form>
		            
		            // Place Automatic Bid Button
		            <form style='text:align=center' action='AutomaticBidPage.jsp'>
		            <input type='submit' style='font-size:15px;height:30px;width:150px' value='Place Automatic Bid'>
		            </form>
		            </div>
				<%}%>
	            <br><br>
				
			<%}
			else{ %>
	    		<form style='text:align=center' action='BidHistoryPage.jsp'>
	            <input type='submit' style='font-size:15px;height:30px;width:150px' value='View Bid History'>
	            </form>
				<p>You cannot buy your own item</p>
			<% }%>
			
			<br>
			<table>
			<tr>
			<%
	        out.println("<td><strong> Item ID </strong></td><td><p>" + result.getString(1)+"</p></td>");
	        out.println("</tr>");
	        
	        out.println("<tr>");
	        out.println("<td><strong> Name </strong></td><td><p>" + result.getString(2)+"</p></td>");
	        out.println("</tr>");
	        
	        out.println("<tr>");
	        out.println("<td><strong> Category </strong></td><td><p>" + result.getString(3)+"</p></td>");
	        out.println("</tr>");
	        
	        out.println("<tr>");
	        out.println("<td><strong> Description </strong</td><td><p>" + result.getString(4)+"</p></td>");
	        out.println("</tr>");
	        
	        out.println("<tr>");
	        out.println("<td><strong> Seller </strong></td><td><p>" + result.getString(5)+"</p></td>");
	        out.println("</tr>");
	        
	        out.println("<tr>");
	        out.println("<td><strong> Starting Bid <strong></td><td><p>$" + result.getString(6)+"</p></td>");
	        out.println("</tr>");
	        
	        out.println("<tr>");
	        out.println("<td><strong> Bid Increment </strong</td><td><p>$" + result.getString(7)+"</p></td>");
	        out.println("</tr>");
	        
	        out.println("<tr>");
	        out.println("<td><strong> Sell-By Date </strong></td><td><p>" + result.getString(9)+"</p></td>");
	        out.println("</tr>");
    		
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
		} catch (Exception ex) {
			out.print(ex);
			
		}
%>

</table></body></center>
</html>