<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>

<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Successfully Placed on Auction</title>
    <style>
    	body {
			background-color: #F2F2F2;
			font-family: Arial, sans-serif;
			font-size: 16px;
			margin: 0;
			padding: 0;
			text-align: center;
		}
        h1 {
            margin-top: 0;
        }
        a:link, a:visited {
			color: black;
			text-decoration: none;
		}
		a:hover {
			color: black;
			text-decoration: underline;
		}
	    .h1 {
	        font-size: 30px;
	    }
	    input[type="submit"] {
			background-color: #4CAF50;
			border: none;
			border-radius: 4px;
			color: white;
			cursor: pointer;
			font-size: 15px;
			height: 30px;
			margin-top: 10px;
			width: 200px;
			transition: background-color 0.3s;
		}
		input[type="submit"]:hover {
			background-color: #3E8E41;
		}
		form {
			margin-top: 20px;
		}
	</style>
</head>
<body>
    <div class="h1">
        <h1>
            <strong>
                <a href="LoginSuccess.jsp">BookBid</a>
            </strong>
        </h1>
    </div>
        <br>
        <%
            try {
                //Get the database connection
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();        
				
                //Create a SQL statement
                Statement stmt = con.createStatement();

                //Get parameters from the HTML form at the index.jsp
                String username = (String) request.getSession().getAttribute("username");
                String category = (String) request.getParameter("category");
                String itemName = request.getParameter("item_name");
                String itemDesc = request.getParameter("item_desc");
                String initBid = request.getParameter("init_bid");
                String bidInc = request.getParameter("bid_inc");
                String durAuction = request.getParameter("dur_auction");
                String reservePrice = request.getParameter("res_price");

                //Make an insert statement for the Sells table:
                String insert = "INSERT INTO items(name, type, description, username, starting_bid, bid_increment, current_price, sell_by_date, reserve_price)" + 
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                //Create a Prepared SQL statement allowing you to introduce the parameters of the query
                PreparedStatement ps = con.prepareStatement(insert);

                //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
                ps.setString(1, itemName);
                ps.setString(2, category);
                ps.setString(3, itemDesc);
                ps.setString(4, username);
                ps.setString(5, initBid);
                ps.setString(6, bidInc);
                ps.setString(7, initBid);
                ps.setString(8, durAuction);
                ps.setString(9, reservePrice);
                ps.executeUpdate();
                out.print("Item set for auction!");

                // We need to find the item_id of the last item
                String findItemIdQuery = "SELECT item_id FROM items WHERE name = ? AND sell_by_date = ?";
				PreparedStatement findItemIdStmt = con.prepareStatement(findItemIdQuery);
				findItemIdStmt.setString(1, itemName);
				findItemIdStmt.setString(2, durAuction);
				ResultSet findItemIdSet = findItemIdStmt.executeQuery();
				findItemIdSet.next();
				String recentlyPostedItemId = findItemIdSet.getString(1);


                // Send alert to users who are all interested in this item
                String listOfUsersInterested = "SELECT username FROM user_interests WHERE type = ?";
				PreparedStatement usersInterestedStatement = con.prepareStatement(listOfUsersInterested);
				usersInterestedStatement.setString(1, category);
				ResultSet usersInterestedSet = usersInterestedStatement.executeQuery();


                while (usersInterestedSet.next()) {
                	String currentUsername = usersInterestedSet.getString(1); 
					String alertMessage = "A " + category + " you're interested in named " + itemName + " was just posted!";
					String alertTableInsertion = "INSERT INTO alerts(item_id, message, username) VALUES (?, ?, ?)";
					
					PreparedStatement alertPreparedStatement = con.prepareStatement(alertTableInsertion); 
					
					alertPreparedStatement.setString(1, recentlyPostedItemId); 
					alertPreparedStatement.setString(2, alertMessage); 
					alertPreparedStatement.setString(3, currentUsername); 
					
					//out.println(alertPreparedStatement.toString()); 
					
					alertPreparedStatement.execute(); 
				}
				//Close the connection to release the resources of the server.
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("insert failed");
			}
		%>
		<br></br>
		<form action="AuctionList.jsp">
			<input type="submit" value="Go to Auction List">
		</form>
</body>
</html>