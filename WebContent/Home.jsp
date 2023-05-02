<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>BookBid</title>
    <style>
      /* Set background color to light grey */
      body {
        background-color: #f2f2f2;
        font-family: Arial, sans-serif;
      }
      /* Add a centered heading with larger font size */
      h1 {
        font-size: 30px;
        text-align: center;
        margin-top: 50px;
      }
      /* Center the forms and give them some margin */
      form {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-top: 30px;
      }
      /* Style the submit buttons with green background and white text */
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
      /* Style the links to look like buttons */
      a.button {
        display: inline-block;
        padding: 10px;
        border-radius: 5px;
        text-decoration: none;
        background-color: #4CAF50;
        color: white;
        font-size: 15px;
        margin-top: 10px;
        margin-right: 10px;
      }
      /* Darken the link on hover */
      a.button:hover {
        background-color: #3e8e41;
      }
      /* Add a container for the links */
      .button-container {
        display: flex;
        justify-content: center;
      }
    </style>
  </head>
  <body>
    <h1>BookBid</h1>
    <form action="Login.jsp">
      <input type="submit" value="Login">
    </form>
    <form action="Register.jsp">
      <input type="submit" value="Register">
    </form>
  </body>
</html>