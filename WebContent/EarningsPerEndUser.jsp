<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Earnings Per End-User</title>
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
	  .button-container form, .button-container form div { display: inline; }
	  .button-container button { display: inline; vertical-align: middle;}
</style>
<div class='h1'><h1><a href='AdminDashboard.jsp'> BookBid </a></h1></div>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();

			String query = "select buyer, sum(price) from bought_items group by buyer";
			ResultSet result = stmt.executeQuery(query);
			%>
			<h2 style='font-size:25px'><strong>Sales Report: Earnings per End-User</strong></h2>
			<br><br>
			<% if (!result.next()) {%>
				<h2 style='font-size:25px'><strong>No users bought anything!</strong></h1>
			<% }
			else {%>
				<br><table>
				<tr>
		        <td><strong> User </strong></td><td><strong> Earnings </strong></td>
		        </tr>
	       		<% int i = 1;
	       		result.beforeFirst();
	   	        while(result.next()) {
	   	        	if (i % 2 != 0) {%>
	   	        		<tr>
	   	        		<% out.println("<td><p> " + result.getString(1) + "</p></td><td><p>" + result.getString(2)+"</p></td>");
	   	        		out.println("</tr>");
	   	        	}
	   	        	else {
	   	        		out.println("<tr>");
	   	        		out.println("<td><p>" + result.getString(1) + "</p></td><td><p>" + result.getString(2)+"</p></td>");
	   	        		out.println("</tr>");
	   	        	}
	   	        	i++;
	   	        }%>
	   	        
	   	        </table></form>
	   	  
			<%}
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
		} catch (Exception ex) {
			out.print(ex);
			
		}
%>

</body>
</html>