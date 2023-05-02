<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>BookBid: Search Users</title>
	<style>
		body {
			background-color: #f2f2f2;
			font-family: Arial, sans-serif;
		}
			h1 {
			margin-top: 0px;
			text-align: center;
			font-size: 30px;
			font-weight: bold;
			color: #333333;
		}
		
		a:link, a:visited {
			color: black;
			text-decoration: none;
		}
		
		a:hover {
			color: black;
			text-decoration: underline;
		}
		
		.center {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
		}
		
		.form {
			text-align: center;
			background-color: white;
			border: 1px solid #dddddd;
			padding: 20px;
			width: 400px;
			box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
		}
		
		.form h3 {
			text-align: center;
			font-size: 25px;
			font-weight: bold;
			color: #333333;
			margin-bottom: 20px;
		}
		
		.form table {
			text-align: center;
			margin-bottom: 20px;
		}
		
		.form table td {
			padding: 5px;
		}
		
		.form input[type="text"] {
			border: 1px solid #dddddd;
			padding: 5px;
			width: 250px;
		}
		
		.form select {
			border: 1px solid #dddddd;
			padding: 5px;
			width: 250px;
		}
		
		.form input[type="submit"] {
			background-color: #4CAF50;
			border: none;
			color: white;
			padding: 10px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 15px;
			cursor: pointer;
			width: 100px;
		}
	</style>
</head>
<body>
	<div class="center">
		<div class="form">
			<h1>BookBid</h1>
			<h3>Search User Activity</h3>
			<form method="get" action="SearchUsersSuccess.jsp">
				<table>
					<tr>    
						<td>Username:</td>
						<td><input type="text" name="searched_user"></td>
					</tr>
				</table>
				<br> 
				<select name="type_of_user">
			    	<option value="" disabled="disabled" selected="selected">See what items they</option>
			    	<option value="bid" name="bid">bid</option>
			    	<option value="sold" name="sold">sold</option>
				</select>
				<br><br>
				<input type="submit" value="Search">
			</form>
		</div>
	</div>
</body>
</html>






		