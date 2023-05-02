<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Login Success</title>
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
<br>
<%
//Get parameters from the HTML form at the index.jsp
String customerRepName = (String)request.getSession().getAttribute("username");
out.print("Welcome to BookBid, " + customerRepName);
%>
<br><br><br>
<form action="QuestionsPage.jsp">
	<input type="submit" style="font-size:15px;height:50px;width:200px" value="Questions">
</form> 
<br><br>
<form action="AuctionList.jsp">
	<input type="submit" style="font-size:15px;height:50px;width:200px" value="Auctions">
</form> 
<br><br>
<form action="AccountList.jsp">
	<input type="submit" style="font-size:15px;height:50px;width:200px" value="Users">
</form> 
<br></br><br></br>
<form action="Home.jsp">
	<input type="submit" style="font-size:15px;height:30px;width:200px" value="Logout">
</form>
</body>
</html>