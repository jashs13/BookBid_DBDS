<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.text.*" %>
<%@ page import ="java.time.Instant"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Auction List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
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
        table {
            border-collapse: collapse;
            width: 60%;
        }
        td {
            border: 1px solid #dddddd;
            text-align: center;
            padding: 11px;
        }
        tr:nth-child(even) {
            background-color: #dddddd;
        }
        .button-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
        }
        .button-container form {
            margin: 10px;
        }
        .button-container input[type="submit"] {
				font-size: 15px;
				height: 30px;
				width: 200px;
				background-color: #4CAF50;
				color: white;
				border: none;
				border-radius: 5px;
				cursor: pointer;
			}
			
			input[type="submit"]:hover {
				background-color: #3e8e41;
			}
    </style>
</head>
<center>
<%
//Get the database connection
	ApplicationDB db = new ApplicationDB(); 
	Connection con = db.getConnection();
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	String username = (String)request.getSession().getAttribute("username");
	String checkIfUserIsCustomerRepQuery = "select * from customer_reps where customer_rep_name = '" + username + "'";
	ResultSet checkIfUserIsCustomerRepResults = stmt.executeQuery(checkIfUserIsCustomerRepQuery);
	if (checkIfUserIsCustomerRepResults.next()) {%>
    <div class='h1'><h1><a href='CustomerRepHomePage.jsp'> BookBid </a></h1></div>
<% }
else {%>
    <div class='h1'><h1><a href='LoginSuccess.jsp'> BookBid </a></h1></div>
<%}%>
<body><h1><strong>Auction List</strong></h1><br>
	checkIfUserIsCustomerRepResults.beforeFirst();
	if (!checkIfUserIsCustomerRepResults.next()) {%>
	    <div class='button-container'>
	    <form style='text-align: center' action='FilterPage.jsp'>
	    <input type='submit' value='Filter'></form><br>
	    <form style='text-align: center' action='FilterPageHightoLow.jsp'>
	    <input type='submit' value='Sort Price: High to Low'></form><br>
	    <form style='text-align: center' action='FilterPageLowtoHigh.jsp'>
	    <input type='submit' value='Sort Price: Low to High'></form><br>
	    <form style='text-align: center' action='SearchUsers.jsp'>
	    <input type='submit' value='Search Users'></form>
		</div>
	<% }


%>
<br>
		<%
			long millis = Instant.now().toEpochMilli();
			java.sql.Timestamp time = new java.sql.Timestamp(millis);
			String currentTimeStamp = time.toString();
	
			String updateQuery = "UPDATE items SET bought = true WHERE ? >= sell_by_date";
			PreparedStatement ps = con.prepareStatement(updateQuery);
			ps.setString(1, currentTimeStamp);
			ps.executeUpdate();
	
			// Alerts
			// Alert users who have successfully sold an item
			String soldItemQuery = "SELECT item_id, name FROM items WHERE bought = TRUE AND username = ?";
			PreparedStatement soldItemStatement = con.prepareStatement(soldItemQuery);
			soldItemStatement.setString(1, username);
			ResultSet soldItemResults = soldItemStatement.executeQuery();
	
			while (soldItemResults.next()) {
	
			    String getReservePriceQuery = "SELECT reserve_price FROM items WHERE item_id = ?";
			    PreparedStatement getReservePriceStatement = con.prepareStatement(getReservePriceQuery);
			    getReservePriceStatement.setString(1, soldItemResults.getString(1));
			    ResultSet getReservePriceResult = getReservePriceStatement.executeQuery();
			    
			    if (getReservePriceResult.next() && getReservePriceResult.getString(1) != null) {
			        float price = Float.parseFloat(getReservePriceResult.getString(1));
			        String lastBidPriceQuery = "SELECT current_bid FROM bid_history WHERE item_id = ? ORDER BY current_bid DESC LIMIT 1";
			        PreparedStatement lastBidPriceStatement = con.prepareStatement(lastBidPriceQuery);
			        lastBidPriceStatement.setString(1, soldItemResults.getString(1));
			        ResultSet lastBidPriceResult = lastBidPriceStatement.executeQuery();
			        
			        if (lastBidPriceResult.next()) {
			            float lastBid = Float.parseFloat(lastBidPriceResult.getString(1));
			            
			            if (lastBid < price) {
			                continue;
			            }
			        }
			    }
	
			    String itemSoldToSomeoneQuery = "SELECT bidder FROM bid_history WHERE item_id = ? ORDER BY current_bid DESC LIMIT 1";
			    PreparedStatement itemSoldStatement = con.prepareStatement(itemSoldToSomeoneQuery);
			    itemSoldStatement.setString(1, soldItemResults.getString(1));
			    ResultSet itemSoldResult = itemSoldStatement.executeQuery();
	
			    if (itemSoldResult.next() && itemSoldResult.getString(1) != null) {
			        String alertString = "Your item named " + soldItemResults.getString(2) + " was sold.";
			        String alertInsertForSoldItem = "INSERT IGNORE INTO alerts(item_id, message, username) VALUES (?, ?, ?)";
			        PreparedStatement soldItemAlert = con.prepareStatement(alertInsertForSoldItem);
			        soldItemAlert.setString(1, soldItemResults.getString(1));
			        soldItemAlert.setString(2, alertString);
			        soldItemAlert.setString(3, username);
			        soldItemAlert.executeUpdate();
			    }
			}
	
			// Alert users who have successfully bought an item
			// Find all item ids, iterate through them and add alerts
			String allBoughtItemsQuery = "SELECT item_id, name, type FROM items WHERE bought = TRUE";
			PreparedStatement allBoughtItemsStatement = con.prepareStatement(allBoughtItemsQuery);
			ResultSet allBoughtItemsResult = allBoughtItemsStatement.executeQuery();
	
			String soldPrice = "5.00";
	
			while(allBoughtItemsResult.next()) {
			    String boughtString = "You successfully bought " + allBoughtItemsResult.getString(2) + "."; 
			    String findTheBuyer = "SELECT bidder, current_bid FROM bid_history WHERE item_id = ? ORDER BY current_bid DESC LIMIT 1"; 
			    PreparedStatement buyerOfItemStatement = con.prepareStatement(findTheBuyer);
			    buyerOfItemStatement.setString(1, allBoughtItemsResult.getString(1));
			    ResultSet buyerOfItem = buyerOfItemStatement.executeQuery();
			    
			    String getReservePrice2 = "SELECT reserve_price FROM items WHERE item_id = ?";
			    PreparedStatement getReservePriceStatement = con.prepareStatement(getReservePrice2);
			    getReservePriceStatement.setString(1, allBoughtItemsResult.getString(1));
			    ResultSet getReservePriceResult2 = getReservePriceStatement.executeQuery(); 
			    if(getReservePriceResult2.next() && getReservePriceResult2.getString(1) != null) {
			        float price = Float.parseFloat(getReservePriceResult2.getString(1)); 
			        String lastBidPriceQuery = "SELECT current_bid FROM bid_history WHERE item_id = ? ORDER BY current_bid DESC LIMIT 1";
			        PreparedStatement lastBidPriceStatement = con.prepareStatement(lastBidPriceQuery);
			        lastBidPriceStatement.setString(1, allBoughtItemsResult.getString(1));
			        ResultSet lastBidPriceResult = lastBidPriceStatement.executeQuery(); 
			        if(lastBidPriceResult.next()) {
			            float lastBid = Float.parseFloat(lastBidPriceResult.getString(1)); 
			            if(lastBid < price) {
			                continue; 
			            }
			        }
			    }
			    
			    if(buyerOfItem.next()) {
			        String boughtItemAlert = "INSERT IGNORE INTO alerts(item_id, message, username) VALUES (?, ?, ?)";
			        PreparedStatement boughtItemAlertStatement = con.prepareStatement(boughtItemAlert);
			        boughtItemAlertStatement.setString(1, allBoughtItemsResult.getString(1));
			        boughtItemAlertStatement.setString(2, boughtString); 
			        boughtItemAlertStatement.setString(3, buyerOfItem.getString(1)); 
			        boughtItemAlertStatement.executeUpdate(); 
			        
			        String insertIntoBoughtItems = "INSERT IGNORE INTO bought_items(item_id, category, price, buyer) VALUES (?, ?, ?, ?)";
			        PreparedStatement boughtItemsStatement = con.prepareStatement(insertIntoBoughtItems);
			        boughtItemsStatement.setString(1, allBoughtItemsResult.getString(1));
			        boughtItemsStatement.setString(2, allBoughtItemsResult.getString(3)); 
			        boughtItemsStatement.setString(3, buyerOfItem.getString(2)); 
			        boughtItemsStatement.setString(4, buyerOfItem.getString(1)); 
			        boughtItemsStatement.executeUpdate(); 
			    }
			}

			
			// Alert users if a person bids on an item they're bidding on 
			String allUnboughtItems = "SELECT item_id, name FROM items WHERE bought is not TRUE";
			ResultSet allUnboughtItemsResult = stmt.executeQuery(allUnboughtItems);
			while(allUnboughtItemsResult.next()){
			    // Check if another user bid on this item in bid_history 
			    // and bid a higher price than the current price bid by the user logged in 
			    String getUsersLastBid = "SELECT current_bid FROM bid_history WHERE bidder = ? AND item_id = ? order by current_bid desc limit 1";
			    PreparedStatement getUsersLastBidStatement = con.prepareStatement(getUsersLastBid);
			    getUsersLastBidStatement.setString(1, username);
			    getUsersLastBidStatement.setString(2, allUnboughtItemsResult.getString(1));
			    ResultSet getMyLastBid = getUsersLastBidStatement.executeQuery(); 
			    if(getMyLastBid.next()){
			        float myLastBidFloat = Float.parseFloat(getMyLastBid.getString(1)); 
			        // Now let's check if someone else bid higher than me 
			        String getHigherBid = "SELECT current_bid FROM bid_history WHERE bidder != ? AND current_bid > ? AND item_id = ? order by current_bid desc limit 1";
			        PreparedStatement getHigherBidStatement = con.prepareStatement(getHigherBid);
			        getHigherBidStatement.setString(1, username);
			        getHigherBidStatement.setFloat(2, myLastBidFloat);
			        getHigherBidStatement.setString(3, allUnboughtItemsResult.getString(1));
			        ResultSet checkForHigherBids = getHigherBidStatement.executeQuery(); 
			        if(checkForHigherBids.next()){
			            String higherBidAlertMessage = "A user bid higher than you on " +  allUnboughtItemsResult.getString(2); 
			            String higherBidAlert = "INSERT IGNORE INTO alerts(item_id, message, username) VALUES (?, ?, ?)";
			            PreparedStatement higherBidAlertStatement = con.prepareStatement(higherBidAlert);
			            higherBidAlertStatement.setString(1, allUnboughtItemsResult.getString(1));
			            higherBidAlertStatement.setString(2, higherBidAlertMessage); 
			            higherBidAlertStatement.setString(3, username); 
			            higherBidAlertStatement.executeUpdate(); 
			        }
			    }
			}

			String query = "SELECT name, item_id FROM items WHERE bought IS NOT TRUE";
			PreparedStatement preparedStatement = con.prepareStatement(query);
			ResultSet result = preparedStatement.executeQuery();
			%><form action='BuyPage.jsp'><table><% 

			int size = 0;
			if (!result.next()) {
			    out.println("<h3 style='font-size:25px'><strong>No Items for Auction Yet!</strong></h3>");
			} else {%>
			    <tr>
			    <td><strong><u><big>Items</big></u></strong></td>
			    </tr>
			    <%int i = 1;
			    result.beforeFirst();
			    while (result.next()) {
			        if (i % 2 != 0) {
			            out.println("<tr>");
			            out.println("<td><a style='font-size:18px' href='BuyPage.jsp?num=" + i + "'>" + result.getString(1) + "</a></td>");
			            request.getSession().setAttribute("selectedItemID" + i, result.getString(2));
			            request.getSession().setAttribute("selectedItemName" + i, result.getString(1));
			            out.println("</tr>");
			        } else {
			            out.println("<tr>");
			            out.println("<td><a style='font-size:18px' href='BuyPage.jsp?num=" + i + "'>" + result.getString(1) + "</a></td>");
			            request.getSession().setAttribute("selectedItemID" + i, result.getString(2));
			            request.getSession().setAttribute("selectedItemName" + i, result.getString(1));
			            out.println("</tr>");
			        }
			        i++;
			    }%>
			    </table></form></body>
			}

			// Close the statement and connection
			preparedStatement.close();
			con.close();

	%>
</center>
</html>