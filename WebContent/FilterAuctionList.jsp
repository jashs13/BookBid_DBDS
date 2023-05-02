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
<title>BookBid: FiltersAuction List</title>
</head>
	<style>
		body {
			background-color: #f2f2f2;
			font-family: Arial, sans-serif;
			font-size: 16px;
			text-align: center;
		}
		h1 {
		  margin-top: 0;
		  font-size: 3rem;
		  font-weight: bold;
		}
		
		/* Links */
		a:link,
		a:visited {
		  color: black;
		  text-decoration: none;
		  transition: color 0.2s ease-in-out;
		}
		
		a:hover {
		  color: #666;
		  text-decoration: underline;
		}
		
		/* Tables */
		table {
		  border-collapse: collapse;
		  width: 50%;
		  margin: 0 auto;
		  border: 2px solid #4CAF50;
		  font-size: 1.2rem;
		  font-weight: bold;
		}
		
		th {
		  background-color: #4CAF50;
		  color: #fff;
		  padding: 1rem;
		  text-align: center;
		}
		
		td {
		  border: 1px solid #ccc;
		  padding: 1rem;
		  text-align: center;
		  transition: background-color 0.2s ease-in-out;
		}
		
		tr:nth-child(even) {
		  background-color: #f2f2f2;
		}
		
		td:hover {
		  background-color: #e8e8e8;
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
			
			input[type="submit"]:hover {
				background-color: #3e8e41;
			}
	</style>


	<div class="h1"><h1><a href="LoginSuccess.jsp"> BookBid </a></h1></div>
<center><body>	
<h1 style="font-size:25px"><strong>Filtered Auction List</strong></h1>
<br></br>
<form action="AuctionList.jsp">
	<input type="submit" style="font-size:15px;height:30px;width:125px" value="Reset Filter">
</form>
<br>
		<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//ResultSetMetaData metaData = result.getMetaData();	        
			long millis = Instant.now().toEpochMilli();
			java.sql.Timestamp time = new java.sql.Timestamp(millis);
			String currentTimeStamp = time.toString();
	
         	
         	String update = "UPDATE items SET bought = true WHERE ? >= sell_by_date";
		
         	PreparedStatement ps = con.prepareStatement(update);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, currentTimeStamp);
			ps.executeUpdate();
			

			String category = (String)request.getParameter("category");
			String minPrice = request.getParameter("filter_min_price");
			String maxPrice = request.getParameter("filter_max_price");
			PreparedStatement pstmt;
			
			String query;
			if (category.equals("allItems")) {
			    if (!minPrice.equals("") && !maxPrice.equals("")) {
			        query = "select name, item_id from items where bought is not true and current_price >= ? and current_price <= ?";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, minPrice);
			        pstmt.setString(2, maxPrice);
			    }
			    else if (minPrice.equals("") && !maxPrice.equals("")) {
			        query = "select name, item_id from items where bought is not true and current_price <= ?";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, maxPrice);
			    }
			    else if (!minPrice.equals("") && maxPrice.equals("")) {
			        query = "select name, item_id from items where bought is not true and current_price >= ?";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, minPrice);
			    }
			    else {
			        query = "select name, item_id from items where bought is not true";
			        pstmt = con.prepareStatement(query);
			    }
			}
			else {
			    if (!minPrice.equals("") && !maxPrice.equals("")) {
			        query = "select name, item_id from items where bought is not true and type = ? and current_price >= ? and current_price <= ?";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, category);
			        pstmt.setString(2, minPrice);
			        pstmt.setString(3, maxPrice);
			    }
			    else if (minPrice.equals("") && !maxPrice.equals("")) {
			        query = "select name, item_id from items where bought is not true and type = ? and current_price <= ?";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, category);
			        pstmt.setString(2, maxPrice);
			    }
			    else if (!minPrice.equals("") && maxPrice.equals("")) {
			        query = "select name, item_id from items where bought is not true and type = ? and current_price >= ?";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, category);
			        pstmt.setString(2, minPrice);
			    }
			    else {
			        query = "select name, item_id from items where bought is not true and type = ?";
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, category);
			    }
			}
			ResultSet result = pstmt.executeQuery();

    
	        out.println("<form action='BuyPage.jsp'>");
	        out.println("<table>");
	        
    		int size= 0;  
    		if (!result.next()) {  
    		  out.println("<h3 style='font-size:25px'><strong> No Items for this filter!</strong></h3>");
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
	        
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("fail");
		}
	%>
	<form action="LoginSuccess.jsp">
		<input type=hidden style="font-size:15px;height:30px;width:200px" value="Go back to main page">
	</form>
	<br><br>
	<form action="LoginSuccess.jsp">
		<input type="submit" style="font-size:15px;height:30px;width:200px" value="Go back to main page">
	</form>

<br><br>

<br></br>
</body></center>
</html>