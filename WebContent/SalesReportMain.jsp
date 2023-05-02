<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Sales Reports</title>
</head>
<style>
		body {
			font-family: Arial, sans-serif;
			background-color: #f1f1f1;
			text-align: center;
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
			width: 200px;
		}
		input[type="submit"]:hover {
			background-color: #3e8e41;
		}
	</style>
	<div class="h1"><h1 style="font-size:30px"><strong> <a href="AdminDashboard.jsp"> BookBid </a> </strong></h1></div>
<body>
<br>
<h3><strong> Generate Sales Report by: </strong></h3>
<br><br><br>
<form action="TotalEarnings.jsp">
	<input type="submit" value="Total Earnings">
</form> 
<br>
<br>
<form action="EarningsPerItem.jsp">
	<input type="submit" value="Earnings per Item">
</form>
<br>
<form action="EarningsPerItemType.jsp">
	<input type="submit" value="Earnings per Item Type">
</form>
<br>
<form action="EarningsPerEndUser.jsp">
	<input type="submit" value="Earnings per End-User">
</form>
<br><br>
<form action="BestSellingItems.jsp">
	<input type="submit" value="Best-Selling Items">
</form>
<br><br>
	<form action="BestBuyers.jsp">
	<input type="submit" value="Best Buyers">
</form>
</body>
</html>