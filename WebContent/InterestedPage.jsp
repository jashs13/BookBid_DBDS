<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Interested</title>
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
      table {
        margin: 0 auto;
        text-align: center;
    }
	</style>
	<div class="h1"><h1><a href="LoginSuccess.jsp"> BookBid </a></h1></div>
<body>	
<h1 style="font-size:25px"><strong> Set an Alert</strong></h1>
<h3 style="font-size:18px"><strong> What type of item are you interested in?</strong></h3>
<form action="InterestedPageJava.jsp">
	<table>
	<tr>    
		<td><input type="checkbox" id="fiction" name="typeOfDevice" value="fiction"></td><td><label> fiction</label></td>
	</tr>

	<tr>
		<td><input type="checkbox" id="history" name="typeOfDevice" value="history"></td><td><label> history</label></td>
	</tr>

	<tr>
		<td> <input type="checkbox" id="non-fiction" name="typeOfDevice" value="non-fiction"></td><td><label> non-fiction</label></td>
	</tr>
	</table>
	<br>
  <input type="submit" style="font-size:15px;height:30px;width:100px" value="Set Alert">
</form>

</body>
</html>