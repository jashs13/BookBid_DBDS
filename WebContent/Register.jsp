<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>BookBid: Register</title>
	<style>
		body {
			font-family: Arial, sans-serif;
			background-color: #f1f1f1;
		}
		h1 {
			margin-top: 0px;
			font-size: 30px;
			text-align: center;
		}
		a:link, a:visited {
			color: black;
			text-decoration: none;
		}
		a:hover {
			color: black;
			text-decoration: underline;
		}
		form {
			margin: 0 auto;
			width: 50%;
			background-color: #fff;
			padding: 20px;
			border-radius: 5px;
			box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.3);
		}
		input[type="text"], input[type="password"] {
			width: 100%;
			padding: 10px;
			border-radius: 3px;
			border: 1px solid #ccc;
			box-sizing: border-box;
			margin-top: 5px;
			margin-bottom: 10px;
		}
		input[type="submit"] {
			background-color: #4CAF50;
			color: white;
			padding: 10px 20px;
			border: none;
			border-radius: 3px;
			cursor: pointer;
			font-size: 15px;
		}
		input[type="submit"]:hover {
			background-color: #3e8e41;
		}
	</style>
</head>
<body>
	<h1><a href="Home.jsp"> BookBid </a></h1>
	<form method="get" action="RegisterJava.jsp">
		<h3>Register</h3>
		<label>New Username:</label>
		<input type="text" name="new_username">
		<label>New Password:</label>
		<input type="password" name="new_password">
		<label>Confirm Password:</label>
		<input type="password" name="confirm_new_password">
		<input type="submit" value="Register">
	</form>
</body>
</html>

