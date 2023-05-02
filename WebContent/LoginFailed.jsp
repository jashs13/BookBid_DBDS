<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>BookBid: Login Fail</title>
	<style>
		body {
			font-family: Arial, sans-serif;
			background-color: #F9F9F9;
		}
		h1 {
			margin-top: 0;
			font-size: 28px;
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
			text-align: center;
			margin-top: 20px;
		}
		p {
			text-align: center;
		}
		input[type="submit"] {
			background-color: #3CB371;
			color: white;
			border: none;
			border-radius: 5px;
			padding: 10px 20px;
			font-size: 16px;
			cursor: pointer;
		}
	</style>
</head>
<body>
	<h1><a href="Home.jsp">BookBid</a></h1>
	<p>Sign-in Failed. The username or password you entered is not correct. Please try again!</p>
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
	%>
	<form action="Home.jsp">
		<input type="submit" value="Go back to main page">
	</form>
</body>
</html>

