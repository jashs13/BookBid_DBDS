<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" name="viewport" content="width=device-width, initial-scale=1.0">
	<title>BookBid: Register</title>
	<style>
		body {
			background-color: #F2F2F2;
			font-family: Arial, sans-serif;
			color: #333333;
			font-size: 16px;
		}
        h1 {
		margin-top: 0;
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
	
		form {
			margin-top: 20px;
		}
	
		input[type="submit"] {
			background-color: #4CAF50;
			color: white;
			padding: 14px 20px;
			margin: 8px 0;
			border: none;
			border-radius: 4px;
			cursor: pointer;
		}
	
		input[type="submit"]:hover {
			background-color: #45a049;
		}
	
		.container {
			display: flex;
			justify-content: center;
			align-items: center;
			flex-direction: column;
			height: 100vh;
		}
	
		.content {
			background-color: #FFFFFF;
			box-shadow: 0px 0px 10px #CCCCCC;
			padding: 20px;
			width: 400px;
			border-radius: 5px;
			display: flex;
			flex-direction: column;
			align-items: center;
		}
	
		.logo {
			font-size: 30px;
			margin: 0;
		}

		.logo a {
			font-weight: bold;
		}
	
		.alert {
			color: red;
			margin-bottom: 10px;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="content">
			<h1 class="logo"><a href="Home.jsp">BookBid</a></h1>
			<%
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				String user = request.getParameter("new_username");
				String pass = request.getParameter("new_password");
				String confirmPass = request.getParameter("confirm_new_password");

				if (!pass.equals(confirmPass)) {
					out.println("<p class='alert'>Passwords don't match</p>");
				} else {
					String query = "select * from user where username = \"" + user + "\"";
					ResultSet result = stmt.executeQuery(query);
					boolean inDb = result.first();

					if (inDb) {
						out.print("<p class='alert'>Username is already taken. Please try a different username.</p>");
					} else if (!inDb) {
						if (user.trim().equals("") || pass.trim().equals("")) {
							out.print("<p class='alert'>Cannot have a blank username or password</p>");
						} else {
							String insert = "INSERT INTO user(username, password)" + "VALUES (?, ?)";
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setString(1, user);
							ps.setString(2, pass);
							ps.executeUpdate();
							out.print("<p>Sign up succeeded!</p>");
						}
					}
				}

				con.close();

			} catch (Exception ex) {
				out.print("<p class='alert'>" + ex + "</p>");
				out.print("<p class='alert'>insert failed</p>");
			}
	%>
	<br></br>
	<form action="Home.jsp">
		<input type="submit" value="Go back to main page">
	</form>
  </div></div>
</body>
</html>