<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	List<String> list = new ArrayList<>();

	try {
	    // Get the database connection
	    ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();

	    // Create a SQL statement
	    Statement stmt = con.createStatement();

	    // Get the combobox from the index.jsp
	    String entity = request.getParameter("price");

	    // Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
	    String str = "SELECT * FROM sells WHERE price <= ?";

	    // Run the query against the database using prepared statement to avoid SQL injection
	    PreparedStatement pstmt = con.prepareStatement(str);
	    pstmt.setString(1, entity);
	    ResultSet result = pstmt.executeQuery();

	    // Make an HTML table to show the results in:
	    out.print("<table>");
	    out.print("<tr>");
	    out.print("<th>Bar</th>");
	    out.print("<th>Beer</th>");
	    out.print("<th>Price</th>");
	    out.print("</tr>");

	    // Parse out the results
	    while (result.next()) {
	        out.print("<tr>");
	        out.print("<td>" + result.getString("fiction") + "</td>");
	        out.print("<td>" + result.getString("non-fiction") + "</td>");
	        out.print("<td>" + result.getString("history") + "</td>");
	        out.print("</tr>");
	    }

	    out.print("</table>");

	    // Close the connection.
	    con.close();
	} catch (SQLException ex) {
	    out.print("Error: " + ex.getMessage());
	}

	%>

</body>
</html>