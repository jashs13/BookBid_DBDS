<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>BookBid: Login</title>
		
		<style>
			body {
				background-color: #f2f2f2;
				font-family: Arial, sans-serif;
				font-size: 16px;
			}
			
			h1 {
				font-size: 30px;
				margin: 0;
				text-align: center;
			}
			
			h3 {
				font-size: 25px;
				margin-top: 30px;
				margin-bottom: 20px;
			}
			
			table {
				margin-bottom: 30px;
			}
			
			input[type="text"],
			input[type="password"] {
				padding: 5px;
				border-radius: 5px;
				border: 1px solid #ccc;
				width: 250px;
			}
			
			input[type="submit"] {
				font-size: 15px;
				height: 30px;
				width: 100px;
				background-color: #4CAF50;
				color: white;
				border: none;
				border-radius: 5px;
				cursor: pointer;
			}
			
			input[type="submit"]:hover {
				background-color: #3e8e41;
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
		</style>
	</head>
	
	<body>
		<div>
			<h1><a href="Home.jsp">BookBid</a></h1>
		</div>
		
		<center>
			<h3>Login</h3>
			<form method="get" action="LoginJava.jsp">
				<table>
					<tr>    
						<td>Username: </td><td><input type="text" name="username"></td>
					</tr>
					<tr>
						<td>Password: </td><td><input type="password" name="password"></td>
					</tr>
				</table>
				<input type="submit" value="Login">
			</form>
		</center>
	</body>
</html>
