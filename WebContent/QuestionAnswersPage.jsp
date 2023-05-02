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
<title>BookBid: Questions</title>
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
    
    /* Table styles */
    table {
        border-collapse: collapse;
        margin: 0 auto;
        width: 100%;
    }
    
    th, td {
        border: 1px solid #ccc;
        padding: 12px;
        text-align: center;
    }
    
    th {
        background-color: #f7f7f7;
        font-weight: bold;
        text-transform: uppercase;
    }
    
    tr:nth-child(even) {
        background-color: #f2f2f2;
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

	<%
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	//Statement stmt2 = con.createStatement();
	
	String num = (String)request.getParameter("num");
	request.getSession().setAttribute("questionNum", num);
	
	String question = (String)request.getSession().getAttribute("selectedQuestion"+num);
	String questionID = (String)request.getSession().getAttribute("selectedQuestionID"+num);
	request.getSession().setAttribute("question", question);
	String username = (String)request.getSession().getAttribute("username");
	
	String checkIfUserIsCustomerRepQuery = "select * from customer_reps where customer_rep_name = '" + username + "'";
	ResultSet checkIfUserIsCustomerRepResults = stmt.executeQuery(checkIfUserIsCustomerRepQuery);
	if (checkIfUserIsCustomerRepResults.next()) {
		out.println("<div class='h1'><h1><a href='CustomerRepHomePage.jsp'> BookBid </a></h1></div>");
	}
	else {
		out.println("<div class='h1'><h1><a href='LoginSuccess.jsp'> BookBid </a></h1></div>");
	}
	out.println("<center><body>");
	out.println("<tr>");
    out.println("<td><big>" + question + "</big></td>");
	out.println("</tr>");
	out.println("<br>");
	out.println("<br>");
	out.println("<td><big>Answers</big></td>");
	out.println("<br>");
	
	checkIfUserIsCustomerRepResults.beforeFirst();
	if (checkIfUserIsCustomerRepResults.next()) {
		out.println("<form style='text:align=center' action='AnswerQuestion.jsp'>");
		out.println("<input type='submit' style='font-size:15px;height:30px;width:200px' value='Answer Question'>");
		out.println("</form>");
		out.println("<br>");
	}
	
	String query = "select replys.reply, customer_reps.customer_rep_name from replys, customer_reps where replys.customer_rep_id = customer_reps.customer_rep_id and question_id = " + questionID; 
	ResultSet result = stmt.executeQuery(query);
	out.println("<table>");

	if (!result.next()) {  
	  out.println("<h3 style='font-size:25px'><strong> No Answers Yet!</strong></h3>");
	}
	else {
		int i = 1;
		result.beforeFirst();
        while(result.next()) {
        	if (i % 2 != 0) {
        		out.println("<tr>");
        		out.println("<td><strong>"+ result.getString(2) + " replied: </strong>" + result.getString(1) + "</td>");
        		out.println("</tr>");
        	}
        	else {
        		out.println("<tr>");
        		out.println("<td><strong>"+ result.getString(2) + " replied: </strong>" + result.getString(1) + "</td>");
        		out.println("</tr>");
        	}
        	i++;
        }
        out.println("<table>");
	}
	con.close();
	%>
</body>
</html>