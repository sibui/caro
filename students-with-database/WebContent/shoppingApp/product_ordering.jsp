<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Ordering</title>
</head>
<body>
<h2>Product Ordering</h2>
	<%
     String username = (String) application.getAttribute("username");
	 String usertype = (String) application.getAttribute("usertype");
	   
	   //redirect user if the product is somehow not specified
	   String sku = request.getParameter("sku");
	   if(sku == null)
	   {
		   String redirectURL = "noaccess.html";
	       response.sendRedirect(redirectURL);
	   }
	   else if(sku.equals(""))
	   {
		   String redirectURL = "noaccess.html";
	       response.sendRedirect(redirectURL);   
	   }
	   
	   if (username == null || usertype == null ) {
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
            ResultSet rsCategory1 = null;

            
            
            
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
                if (action != null && action.equals("buy")) {

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
	                    pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
	                    
	                    String quantity = request.getParameter("quantity");
						int i = 0;
				    	boolean check = true;
				    	
				    	while(i < quantity.length()){ //checks for integer
				    		//new letter
				    		char letter = quantity.charAt(i);
				    		int ascii = (int)letter;				    
				    		i++;
				    		if(ascii < 48 || ascii >= 58 ){ //invalid case - out of range
				    			check = false;
				    		}
				    		
				    	}
				    	
				    	
				    	if(check)
				    	{
		                    if( Integer.parseInt(request.getParameter("quantity")) > 0)
		                    {
			                    pstmt.setInt(3, Integer.parseInt(request.getParameter("quantity")));

		   	                    int rowCount = pstmt.executeUpdate();
		   	      		   		String redirectURL = "products_browsing.jsp";
		   	 	      	 		response.sendRedirect(redirectURL);
		   	                    
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
            
            pstmt = conn.prepareStatement("select * from products where sku = ?");
        	pstmt.setString(1, sku);
        	rs = pstmt.executeQuery();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
            <tr>
            <th>Current Product</th>
            </tr>
            <tr>
                <th>Name</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Price</th>
                <th>Quantity</th>
            </tr>
            
            <%-- -------- Product Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
                	%>
                	<tr>

                    <%-- Get the name --%>
                    <td>
                    	<%String skuResult = rs.getString("sku");%>
                        <a href="product_ordering.jsp?sku=<%=skuResult%>"><%=rs.getString("name")%></a>
                        
                    </td>
                    
                    <%-- Get the sku --%>
                    <td>
                        <%=rs.getString("sku")%>
                    </td>
                    <%-- Get the category --%>
                    <td>
                        <%
                        pstmt4 = conn.prepareStatement("select * from categories where id = ?");
                        pstmt4.setInt(1, rs.getInt("category"));
                        rsCategory1 = pstmt4.executeQuery();
                        rsCategory1.next();
                        String category = rsCategory1.getString("name");
                        %>
                        <%=category%>
                    </td>
                   
    				 <%-- Get the middle name --%>
                    <td>
                        <%=rs.getInt("price")%>
                    </td>
                    <form action="product_ordering.jsp" method="POST">
                    <input type="hidden" name="sku" value="<%=rs.getString("sku")%>"/>
                    <input type="hidden" name="action" value="buy"/>
                    <input type="hidden" name="price" value="<%=rs.getString("price")%>"/>
                    <td>
                    <input type="text"   name="quantity" value=""/>
                    </td>
                    <td>
                    <input type="submit" value="Add to Cart"/>
                    </td>
                    </form>
                   
                </tr>
                <%
                }
            %>
            <tr>
            </tr>
            <tr>
            <th>YOUR CART</th>
            </tr>
                        <tr>
                <th>Owner</th>
                <th>SKU</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Cost</th>
            </tr>
            <%-- -------- Cart Iteration Code -------- --%>
            <%
                // Create the statement
            
            pstmt = conn.prepareStatement("select * from carts where owner = ?");
        	pstmt.setString(1, username);
        	rs = pstmt.executeQuery();
        	int cartTotal = 0;
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
            %>  
            
                      
<%
                // Iterate over the ResultSet
                while (rs.next()) {
                	int productTotal = rs.getInt("quantity")*rs.getInt("price");
                	cartTotal = cartTotal + productTotal;
                	%>
                	<tr>

                    <%-- Get the owner --%>
                    <td>
                    	<%=rs.getString("owner")%>
                        
                    </td>
                    
                    <%-- Get the sku --%>
                    <td>
                        <%=rs.getString("sku")%>
                    </td>
               		<%-- Get the middle name --%>
                    <td>
                        <%=rs.getInt("price")%>
                    </td>
                    <%-- Get the category --%>
                    <td>
                        <%=rs.getInt("quantity")%>
                    </td>
                    <td>
                    <%=productTotal%>
                    </td>
                   
                   
                </tr>

                <%
                }
            %>         
                <tr>
                <th></th>
                <th></th>
                <th></th>
                <th size=10> CART TOTAL:</th>
                <th><%=cartTotal%>
                </tr>
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