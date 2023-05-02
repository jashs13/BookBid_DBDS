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
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			String username = (String)request.getSession().getAttribute("username");
			String checkIfUserIsCustomerRepQuery = "SELECT * FROM customer_reps WHERE customer_rep_name = ?";
			PreparedStatement checkIfUserIsCustomerRepStatement = con.prepareStatement(checkIfUserIsCustomerRepQuery);
			checkIfUserIsCustomerRepStatement.setString(1, username);
			ResultSet checkIfUserIsCustomerRepResults = checkIfUserIsCustomerRepStatement.executeQuery();

			if (checkIfUserIsCustomerRepResults.next()) {
				out.println("<div class='h1'><h1><a href='CustomerRepHomePage.jsp'> BookBid </a></h1></div>");
			}
			else {
				out.println("<div class='h1'><h1><a href='LoginSuccess.jsp'> BookBid </a></h1></div>");
			}
			
			out.println("<body>");
			out.println("<h1 style='font-size:25px'><strong> Questions </strong></h1>");
			
						
			String submittedQuestion = request.getParameter("ask_question");
			request.getSession().setAttribute("submittedQuestion", submittedQuestion);
			
			String q = "SELECT * FROM questions WHERE question = ?";
			PreparedStatement statement = con.prepareStatement(q);
			statement.setString(1, submittedQuestion);
			ResultSet checkQuestionDup = statement.executeQuery();



			if(submittedQuestion != null && !checkQuestionDup.next()){
				String insert = "INSERT INTO questions(username, question)"
						+ "VALUES (?, ?)";

				PreparedStatement ps = con.prepareStatement(insert);
				
				ps.setString(1, username);
				ps.setString(2, submittedQuestion);
				ps.executeUpdate();
			}
			checkIfUserIsCustomerRepResults.beforeFirst();
			if (!checkIfUserIsCustomerRepResults.next()) {
				out.println("<form style='text:align=center' action='AskQuestion.jsp'>");
				out.println("<input type='submit' style='font-size:15px;height:30px;width:180px' value='Ask a Question'>");
				out.println("</form>");
				
				out.println("<br>");
				out.println("<form style='text:align=center' action='SearchQuestionsPage.jsp'>");
				out.println("<input type='submit' style='font-size:15px;height:30px;width:180px' value='Search Questions'>");
				out.println("</form>");
				
				
			}
			
			out.println("<br>");
			String query = "SELECT question, question_id FROM questions";
			PreparedStatement preparedStatement = con.prepareStatement(query);
			ResultSet result = preparedStatement.executeQuery();
    
	        out.println("<form action='QuestionsAnswersPage.jsp'>");
	        out.println("<table>");
	        
    		int size= 0;  
    		if (!result.next()) {  
    		  out.println("<h3 style='font-size:25px'><strong> No Questions Yet!</strong></h3>");
    		}
    		else {
    			out.println("<tr>");
    	        out.println("<td><strong><u><big>Questions</big></u></strong></td>");
        		out.println("</tr>");
        		int i = 1;
        		result.beforeFirst();
    	        while(result.next()) {
    	        	if (i % 2 != 0) {
    	        		out.println("<tr>");
    	        		out.println("<td><a style='font-size:18px' href='QuestionAnswersPage.jsp?num="+ i + "'>" + result.getString(1) + "</a></td>");
    		        	request.getSession().setAttribute("selectedQuestionID"+i, result.getString(2));
    			        request.getSession().setAttribute("selectedQuestion"+i, result.getString(1));
    	        		out.println("</tr>");
    	        	}
    	        	else {
    	        		out.println("<tr>");
    	        		out.println("<td><a style='font-size:18px' href='QuestionAnswersPage.jsp?num="+ i + "'>" + result.getString(1) + "</a></td>");
    		        	request.getSession().setAttribute("selectedQuestionID"+i, result.getString(2));
    			        request.getSession().setAttribute("selectedQuestion"+i, result.getString(1));
    	        		out.println("</tr>");
    	        	}
    	        	i++;
    	        }
    	        out.println("<table>");
    	        out.println("</form>");
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
    		}
		} catch (Exception ex) {
			out.print(ex);
			out.print("insert failed");
		}
	%>
</body>
</html>