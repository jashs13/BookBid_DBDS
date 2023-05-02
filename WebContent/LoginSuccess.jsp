<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>BuyMe: Login Success</title>
	<style>
		body {
			background-color: #F2F2F2;
			font-family: Arial, sans-serif;
			font-size: 16px;
			margin: 0;
			padding: 0;
		}
		.container {
			align-items: center;
			display: flex;
			flex-direction: column;
			justify-content: center;
			height: 100vh;
			margin: 0 auto;
			max-width: 800px;
			padding: 20px;
			text-align: center;
		}
		h1 {
			margin-top: 0;
			font-size: 30px;
			font-weight: bold;
			text-transform: uppercase;
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
			margin-top: 20px;
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
		p {
			text-align: center;
		}
	</style>
</head>
<body>
	<div class="container">
		<h1><a href="LoginSuccess.jsp">BookBid</a></h1>
		<%
			try {
				// Get the database connection
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				// Create a SQL statement
				Statement stmt = con.createStatement();

				// Get parameters from the HTML form at the index.jsp
				String username = (String) request.getSession().getAttribute("username");
				out.print("Welcome to BookBid, " + username + "!");

				// Close the connection
				con.close();

			} catch (Exception ex) {
				out.print(ex);
				out.print("insert failed");
			}
		%>
		<form action="AuctionList.jsp">
			<input type="submit" value="Buy">
		</form>
		<p>or</p>
		<form action="SellerForm.jsp">
			<input type="submit" value="Sell">
		</form>
		<form action="AlertsList.jsp">
			<input type="submit" value="Alerts">
		</form>
		<form action="QuestionsPage.jsp">
			<input type="submit" value="Questions">
		</form>
		<form action="Home.jsp">
			<input type="submit" value="Logout">
		</form>
	</div>
</body>
</html>
