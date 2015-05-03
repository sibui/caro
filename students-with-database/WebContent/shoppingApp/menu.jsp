 <%-- Import the java.sql package --%>
 <%@ page import="java.sql.*"%>
 <%-- -------- Open Connection Code -------- --%>
 	<%
    	Connection conn = null;
		Statement categoryStatement = conn.createStatement();
        ResultSet rsCategory = null;
        rsCategory = categoryStatement.executeQuery("SELECT categories.name FROM categories");
        
    %>
    <b>Links </b>
	<ul>
	<!--  Links depends on whether their a customer or owner -->
	<%
	while(rsCategory.next()){
		out.print("<li><a href=\"categories.jsp?\"></a></li>");
	
	}

	
	%>
	
	
	</ul>