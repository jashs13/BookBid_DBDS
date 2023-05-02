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
<title>BookBid: User's Auction List</title>
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
    a {
        color: #333;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    
    a:hover {
        color: #0077cc;
    }
    
    /* Table styles */
    table {
        border-collapse: collapse;
        margin: 0 auto;
        width: 100%;
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
</head>
<body>
    <div class="h1">
        <h1><a href="LoginSuccess.jsp">BookBid</a></h1>
    </div>
        <br>
        <%
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String boughtOrSold = (String)request.getParameter("type_of_user");
			String user = (String)request.getParameter("searched_user");
			
			out.println("<h1 style='font-size:25px'><strong>" + user + "'s Items </strong></h1>");
			out.println("<br>");
			out.println("<form action='AuctionList.jsp'>");
			out.println("<input type='submit' style='font-size:15px;height:30px;width:125px' value='Reset'>");
			out.println("</form>");
			out.println("<br>");

			String verify = "select * from user where username = '" + user + "'";
			ResultSet verifyResult = stmt.executeQuery(verify);
	        boolean inDb = verifyResult.first();
	       
	        if(inDb) {
	        	//ResultSetMetaData metaData = result.getMetaData();
		        long millis = Instant.now().toEpochMilli();
				java.sql.Timestamp time = new java.sql.Timestamp(millis);
				String currentTimeStamp = time.toString();
	         	
	         	String update = "UPDATE items SET bought = true WHERE ? >= sell_by_date";
			
	         	PreparedStatement ps = con.prepareStatement(update);

				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, currentTimeStamp);
				ps.executeUpdate();
				PreparedStatement pstmt;
				
				
				String query = "";
				if (boughtOrSold.equals("bid")) {
					query = "SELECT items.name, bid_history.item_id, bid_history.bidder FROM bid_history, items WHERE items.item_id = bid_history.item_id AND bid_history.bidder = ?";
					pstmt = con.prepareStatement(query);	
				}
				else {
					query = "SELECT name, item_id FROM items WHERE username = ?";
					pstmt = con.prepareStatement(query);
				}
				
				pstmt.setString(1, user);
				ResultSet result = pstmt.executeQuery();
	    
		        out.println("<form action='BuyPage.jsp'>");
		        out.println("<table>");
		        
	    		int size= 0;  
	    		if (!result.next()) {  
	    		  out.println("<h3 style='font-size:25px'><strong> No Items!</strong></h3>");
	    		}
	    		else {
	    			out.println("<tr>");
	    	        out.println("<td><strong><u><big>Items</big></u></strong></td>");
	        		out.println("</tr>");
	        		int i = 1;
	        		result.beforeFirst();
	    	        while(result.next()) {
	    	        	if (i % 2 != 0) {
	    	        		out.println("<tr>");
	    	        		out.println("<td><a style='font-size:18px' href='BuyPage.jsp?num="+ i + "'>" + result.getString(1) + "</a></td>");
	    		        	request.getSession().setAttribute("selectedItemID"+i, result.getString(2));
	    			        request.getSession().setAttribute("selectedItemName"+i, result.getString(1));
	    	        		out.println("</tr>");
	    	        	}
	    	        	else {
	    	        		out.println("<tr>");
	    	        		out.println("<td><a style='font-size:18px' href='BuyPage.jsp?num="+ i + "'>" + result.getString(1) + "</a></td>");
	    		        	request.getSession().setAttribute("selectedItemID"+i, result.getString(2));
	    			        request.getSession().setAttribute("selectedItemName"+i, result.getString(1));
	    	        		out.println("</tr>");
	    	        	}
	    	        	i++;
	    	        }
	    	        out.println("<table>");
	    	        out.println("</form>");
	    		}
		        
	        }
	        else{
	        	//out.print("Sign in failed. The username or password you entered is not correct.");
	        	out.println("The user you tried to search for does not exist.");
	        }
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("fail");
		}
	%>
        <form action="LoginSuccess.jsp">
            <input type="hidden" style="font-size:15px;height:30px;width:200px" value="Go back to main page">
        </form>
        <br><br>

        <form action="LoginSuccess.jsp">
            <input type="submit" style="font-size:15px;height:30px;width:200px" value="Go back to main page">
        </form>

        <br><br>
        <br>
</body>
</html>