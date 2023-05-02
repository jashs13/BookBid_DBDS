<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>

<!-- Import necessary libraries -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*,http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>BookBid: Filter</title>
    <style>
        body {
            background-color: #f1f1f1;
            font-family: Arial, sans-serif;
            text-align: center;
        }
        h1 {
            margin-top: 0px;
            font-size: 30px;
        }
        a:link {
            color: black;
            text-decoration: none;
        }
        a:visited {
            color: black;
            text-decoration: none;
        }
        a:hover {
            color: black;
            text-decoration: underline;
        }
        table {
            border-collapse: collapse;
            width: 60%
        }
        td {
            border: 1px solid #dddddd;
            text-align: center;
            padding: 11px;
        }
        tr:nth-child(even) {
            background-color: #dddddd;
        }
        select,
        input[type="text"],
        input[type="submit"] {
            border-radius: 5px;
            padding: 5px;
            font-size: 16px;
            border: 1px solid #ccc;
            box-shadow: inset 0 1px 3px #ddd;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #3e8e41;
        }
    </style>
</head>
<body>
<div class="h1">
    <h1><a href="LoginSuccess.jsp"> BookBid </a></h1>
</div>
<form action="FilterAuctionList.jsp">
    <select name='category'>
        <option value='' disabled='disabled' selected='selected'>Select a category</option>
        <option value="allItems" name='allItems'>All Items</option>
        <option value='fiction' name='fiction'>fiction</option>
        <option value='non-fiction' name='non-fiction'>non-fiction</option>
        <option value='history' name='history'>history</option>
    </select>
    <br><br>
    <input type='filter_min_price' id='filter_min_price' name='filter_min_price'
           placeholder='Minimum Price (without $ sign) - optional' style='height: 20px; width: 275px'>
    <input type='filter_max_price' id='filter_max_price' name='filter_max_price'
           placeholder='Maximum Price (without $ sign) - optional' style='height: 20px; width: 275px'>
    <br><br>
    <input type="submit" value="Filter">
</form>
</body>
</html>

        