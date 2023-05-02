<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookBid: Register</title>
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
	<div class="h1"><h1 style="font-size:30px"><strong> <a href="Home.jsp"> BookBid </a> </strong></h1></div>
<body>	
<br></br>
		<%
		try (Connection con = new ApplicationDB().getConnection();
			     PreparedStatement pstmt = con.prepareStatement("SELECT customer_rep_id FROM customer_reps WHERE customer_rep_name = ?");
			     PreparedStatement ps = con.prepareStatement("INSERT INTO replys(reply, customer_rep_id, question_id) VALUES (?, ?, ?)")) {
			     
			    String username = (String)request.getSession().getAttribute("username");
			    String num = (String)request.getSession().getAttribute("questionNum");
			    String reply = request.getParameter("answer_question");
			    
			    pstmt.setString(1, username);
			    ResultSet customerRepIDResult = pstmt.executeQuery();
			    customerRepIDResult.next();
			    String customerRepID = customerRepIDResult.getString(1);
			    String questionID = (String)request.getSession().getAttribute("selectedQuestionID"+num);
			    
			    out.println(reply);
			    out.println();
			    
			    ps.setString(1, reply);
			    ps.setString(2, customerRepID);
			    ps.setString(3, questionID);
			    ps.executeUpdate();
			    
			    out.println();
			    out.print(": Answer Submitted!");
			} catch (SQLException ex) {
			    out.print(ex);
			    out.print("insert failed");
			}
	%>
	<br></br>
	<form action="QuestionsPage.jsp">
		<input type="submit" value="Go back to Questions">
	</form>
</body>
</html>