<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	    pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>BookBid: Edit Account</title>
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
        width: 25%;
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
	</style>
	
<div class="h1"><h1 style="font-size:30px"><strong> <a href="CustomerRepHomePage.jsp"> BookBid </a> </strong></h1></div>

<body>
		<h3 style="font-size:25px"><strong> Edit Account </strong></h3>
	<form method="get" action="EditAccountJava.jsp">
	<table>
		<tr>    
			<td>New Username: </td><td><input type="text" style="width:250px" name="edit_username"></td>
		</tr>
		<tr>
			<td>new Password: </td><td><input type="password" style="width:250px" placeholder="type old password if not changing password" name="edit_password"></td>
		</tr>
		<tr>
			<td>Confirm New Password: </td><td><input type="password" style="width:250px" placeholder="type old password if not changing password" name="edit_confirm_password"></td>
			</tr>
		</table>
		<br>
		<input type="submit" value="Edit Account">
	</form>
<br>
</body>
</html>
