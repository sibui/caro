<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Ordering</title>
</head>
<body>
	<%
     String username = (String) application.getAttribute("username");
	 String usertype = (String) application.getAttribute("usertype");
	   
	   
	   if( usertype != null && !usertype.equals("customer"))
	   {
		   //redirect to another html page since 
		   //you are a customer with no access to that page
		   String redirectURL = "noaccess.html";
         response.sendRedirect(redirectURL);
	   }
	   else if (username == null || usertype == null ) {
  	   String redirectURL = "login.jsp";
         response.sendRedirect(redirectURL);
     }
    %>
    Welcome, <%=username%>!
    
<table>
    <tr>

        <td>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            PreparedStatement pstmt2 = null;
            PreparedStatement pstmt3 = null;
            PreparedStatement pstmt4 = null;
            ResultSet rs = null;
            ResultSet rsCategory = null;

            
            
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/cse135?" +
                    "user=postgres&password=postgres");
        		Statement categoryStatement1 = conn.createStatement();
            %>
	
	 <%-- -------- BUY Code -------- --%>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("Purchase")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    if(request.getParameter("quantity") != "") 
                    {    	
	                    
	                    pstmt = conn
	                    .prepareStatement("INSERT INTO carts (owner, sku, quantity, price) VALUES (?, ?, ?, ?)");
	
	                    pstmt.setString(1, username);
	                    pstmt.setString(2, request.getParameter("sku"));
	                    pstmt.setInt(3, Integer.parseInt(request.getParameter("quantity")));
	                    pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
	               
	
	                    if( Integer.parseInt(request.getParameter("quantity")) > 0)
	                    {
	   	                    int rowCount = pstmt.executeUpdate();
	   	      		   		//String redirectURL = "products_browsing.jsp";
	   	 	      	 		//response.sendRedirect(redirectURL);
	   	                    
	                    } 
	                    else 
	                   	{
	                    	out.print("<b>Please insert a valid value for quantity</b>");
	                    }						
                    }
                    else
                    {
                    	out.print("<b>Please insert a valid value for quantity</b>");
                    }
                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                    
                }
            %>
	

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();
            
            pstmt = conn.prepareStatement("select * from carts where owner = ?");
        	pstmt.setString(1, username);
        	rs = pstmt.executeQuery();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
            <tr>
            <th>Shopping Cart</th>
            </tr>
            <tr>
                <th>Name</th>
                <th>SKU</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
            
            <%-- -------- Product Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                int cartTotal = 0;
                while (rs.next()) {
                	int productTotal = rs.getInt("quantity") * rs.getInt("price");
                	cartTotal = cartTotal + productTotal;
                	%>
                	<tr>

                    <%-- Get the name --%>
                    <td>
                    	<%=rs.getString("owner")%>
                    </td>
                    
                    <%-- Get the sku --%>
                    <td>
                        <%=rs.getString("sku")%>
                    </td>
                    <%-- Get the quantity --%>
                    <td>
                        <%=rs.getInt("quantity")%>
                    </td>
    				<%-- Get the price --%>
                    <td>
                        <%=rs.getInt("price")%>
                    </td>
                    <%-- Get the product total --%>
                    <td>
                    	<%=productTotal%>
                    </td>
                </tr>
                <%
                }
            %>
            <tr>
            	<th>Your Total</th>
            	<th><%=cartTotal %></th>
            </tr>
            
            <table>
	            <tr>
	           		<th>Credit Card Number</th>
		            <form action="buy.jsp" method="POST">
		                <th><input value="" name="creditCard" size="10"/></th>
		                <td><input name="action" type="submit" value="Purchase"/></td>
		            </form>
	            </tr>
            </table>
            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                rs.close();

                // Close the Statement
                statement.close();

                // Close the Connection
                conn.close();
            } catch (SQLException e) {

				 //out.print("Data modification failure. Please refresh the page.");
				
                throw new RuntimeException(e);
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation

                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) { } // Ignore
                    rs = null;
                }
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) { } // Ignore
                    pstmt = null;
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { } // Ignore
                    conn = null;
                }
            }
            %>
        </table>
        </td>
    </tr>
</table>    

</body>
</html>