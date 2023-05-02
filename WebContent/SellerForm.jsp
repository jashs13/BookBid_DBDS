<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>

<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html, width=device-width, initial-scale=1.0; charset=ISO-8859-1" name="viewport">
<title>BookBid: Sell</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 10px;
            text-align: center;
        }
        a:link, a:visited {
            color: black;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        input[type=text], 
        input[type=number], 
        select, 
        textarea, 
        input[type=datetime-local] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid #ccc;
            border-radius: 4px;
            resize: none;
        }
        input[type=submit] {
            background-color: #4CAF50;
            color: white;
            font-size: 20px;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type=submit]:hover {
            background-color: #45a049;
        }
        .container {
            width: 80%;
            margin: auto;
        }
        h1 {
            margin-top: 0;
        }
    </style>
</head>
<body>
    <header>
        <h1>BookBid</h1>
    </header>
    <div class="container">
        <h2>Sell an Item</h2>
        <form action="SellerFormSuccess.jsp">
            <select name="category">
                <option value="" disabled selected>Select a category</option>
                <option value="Fiction">Fiction</option>
                <option value="Non-fiction">Non-Fiction</option>
                <option value="History">History</option>
            </select>
            <input type="text" id="item_name" name="item_name" placeholder="Item Name">
            <textarea name="item_desc" id="item_desc" 
                placeholder="Item Description (max. 300 characters)"></textarea>
            <input type="number" id="init_bid" name="init_bid" 
                placeholder="Starting Bid Price (without $ sign)">
            <input type="number" id="bid_inc" name="bid_inc" 
                placeholder="Bid Increment Amount (without $ sign)">
            <input type="number" id="res_price" name="res_price" 
                placeholder="Reserve Price (without $ sign)">
            <input type="datetime-local" id="dur_auction" name="dur_auction"/>
            <input type="submit" value="Place Item on Auction">
        </form>
    </div>
</body>
</html>