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
<title>BookBid: Alert List</title>
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
	<div class="h1"><h1><a href="LoginSuccess.jsp"> BookBid </a></h1></div>
<body>	
<h1 style="font-size:25px"><strong> Alert List</strong></h1>
<br></br>
<form style='text:align=center' action="InterestedPage.jsp">
	<input type="submit" style="font-size:15px;height:30px;width:180px" value="Interested in an Item?">
</form>
<br><br>
		<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//ResultSetMetaData metaData = result.getMetaData();
			String user = request.getSession().getAttribute("username").toString();
			String query = "select * from alerts where username = '" + user + "'";
	        ResultSet result = stmt.executeQuery(query);
	        
	        %>
	    <form action='alertUser.jsp'>
        <table>
	        <% 
	        
    		int size= 0;  
    		if (!result.next()) { %>
    			<h3 style='font-size:25px'><strong> No Alerts yet!</strong></h3>
    		<%}
    		else {%>
    			<tr><td><strong><u><big>Alerts</big></u></strong></td></tr>
    			<%
        		int i = 1;
        		result.beforeFirst();
    	        while(result.next()) {
    	        	String message = result.getString(2);
    	        	
    	        	if (i % 2 != 0) {
    	        	%>	
    	        		<tr><td>
    	        		
    	        		<% 
    	        		out.println(message + "</td>");
    		        	request.getSession().setAttribute("selectedAlertItemID"+i, result.getString(2));
    			        request.getSession().setAttribute("selectedAlertMessage"+i, message);
    			        
    	        		out.println("</tr>");
    	        	}
    	        	else {
    	        		out.println("<tr>");
    	        		out.println("<td>" + message + "</td>");
    		        	request.getSession().setAttribute("selectedAlertItemID"+i, result.getString(2));
    			        request.getSession().setAttribute("selectedAlertMessage"+i, message);
    	        		out.println("</tr>");
    	        	}
    	        	i++;
    	        }%>
    	        </table>
    	        </form>
    		<% }
	        
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("insert failed");
		}
	%>
	<form action="LoginSuccess.jsp">
		<input type=hidden value="Go back to main page">
	</form>
	<br><br>
	<form action="LoginSuccess.jsp">
		<input type="submit" value="Go back to main page">
	</form>

<br><br>

<br></br>
</body>
</html>