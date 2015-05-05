<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Products</title>
</head>
<body>
	<!--  Precursor text that must appear in every webpage -->
	 <%
     String username = (String) application.getAttribute("username");
	   String usertype = (String) application.getAttribute("usertype");
	   if( usertype != null && !usertype.equals("owner"))
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
	 		<td valign="top">
	        	<%-- -------- Include browser links HTML code -------- --%>
	            <jsp:include page="/browser.html" />
	 		</td>
		</tr>
	</table>


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
            
            <% 
          
	          rsCategory = categoryStatement1.executeQuery("SELECT categories.name FROM categories");
	      
			%>
			   <b>Categories </b>
			   <ul>
				<%
	          
	            String searchBar = request.getParameter("searchBar");
	            if(searchBar == null)
	            {
	            	searchBar = "";
	            }
	            
	            
				out.print("<li><a href=\"products.jsp\">All Products</a></li>");
				while(rsCategory.next()){
					out.print("<li><a href=\"products.jsp?search="+rsCategory.getString("name")+"&searchBar="+searchBar+"\">"+rsCategory.getString("name")+"</a></li>");
				}

	
	%>
	
	
	</ul>
            
            <%-- -------- INSERT Code -------- --%>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    if(request.getParameter("name") != "" && request.getParameter("sku") != "" && request.getParameter("category") != "" && request.getParameter("price") != "") 
                    {    	
	                    
	                    pstmt = conn
	                    .prepareStatement("INSERT INTO products (name, sku, category, price) VALUES (?, ?, ?, ?)");
	
	                    pstmt.setString(1, request.getParameter("name"));
	                    pstmt.setString(2, request.getParameter("sku"));
	                    pstmt.setString(3, request.getParameter("category"));
	                    pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
	               
	
	                    
	                    Statement statement1 = conn.createStatement();
	                    //check to see if sku is unique
	                    pstmt2 = conn.prepareStatement("select * from products where sku = ?");
	                    pstmt2.setString(1, request.getParameter("sku"));
	                    rs = pstmt2.executeQuery();
	                    
	                    //check to see if category is a non-category
	                    pstmt3 = conn.prepareStatement("select categories.name from categories where name = ?");
	                    pstmt3.setString(1, request.getParameter("category")); //deals with injecting 
	                    
						//check for unique sku
	                    if (!rs.next()) 
	                    {
	                    	if( Integer.parseInt(request.getParameter("price")) > 0){
	                            
	                    		//out.print(Integer.parseInt(request.getParameter("price"))+"hi");
		                          rsCategory = pstmt3.executeQuery();

	                    		if(rsCategory.next()){
	   	                         int rowCount = pstmt.executeUpdate();
	                    		} 
	                    		else 
	                    		{
	                    			out.print("Failure to insert new product. Click <a href=\"products.jsp\">here</a> to try again.");
	                    		}
	                    	}
	                    	else
	                    	{
	                    		out.print("Failure to insert new product. Click <a href=\"products.jsp\">here</a> to try again.");
	                    	}
	                    	
	                         //int rowCount = pstmt.executeUpdate();
	                    }
	                    else
	                    {
	          				 out.print("Failure to insert new product. Click <a href=\"products.jsp\">here</a> to try again.");
	                    }
						
						
                    }
                    else
                    {
                    	out.print("Failure to insert new product. Click <a href=\"products.jsp\">here</a> to try again.");
                    }
                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                    
                }
            %>
            
            <%-- -------- UPDATE Code -------- --%>
            <%
                // Check if an update is requested
                if (action != null && action.equals("update")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // UPDATE student values in the Students table.
                    pstmt = conn
                        .prepareStatement("UPDATE products SET name = ?, category = ?,price= ? WHERE sku = ?");
					if (request.getParameter("name") != "" && request.getParameter("price") != "") {
	                    pstmt.setString(1, request.getParameter("name"));
	                    pstmt.setString(4, request.getParameter("sku"));
	                    pstmt.setString(2, request.getParameter("category"));
	                    pstmt.setInt(3, Integer.parseInt(request.getParameter("price")));
	                    
	                    pstmt4 = conn
	                    	.prepareStatement("select * from products where sku = ?");
	                    pstmt4.setString(1, request.getParameter("sku"));
	                    
	                    int rowCount = pstmt.executeUpdate();
					}
					else {
						out.print("Failure to insert new product. Click <a href=\"products.jsp\">here</a> to try again.");
					}
                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- DELETE Code -------- --%>
            <%
                // Check if a delete is requested
                if (action != null && action.equals("delete")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // DELETE students FROM the Students table.
                    pstmt = conn
                        .prepareStatement("DELETE FROM products WHERE sku = ?");
                    //run another query to decrement based upon the category where the product is 
                    pstmt.setString(1, request.getParameter("sku"));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();
            
            //get search variable
            String search = request.getParameter("search");
            
            //search is for category links
            if(search == null)
            {	
            	search = "";
            }
            searchBar = request.getParameter("searchBar");
            if(searchBar == null)
            {
            	searchBar = "";
            }
            
            boolean isSearch = false;
            //if it's null, get ALL products
            if(!search.equals(""))
            {
            	isSearch = true;
            }
            
            	
            if(isSearch && searchBar.equals(""))
            {
            	pstmt = conn.prepareStatement("select * from products where category = ?");
            	pstmt.setString(1, search);
            }
            else if(isSearch && !searchBar.equals(""))
            {
            	pstmt = conn.prepareStatement("select * from products where category = ? and name like ?");
            	pstmt.setString(1, search);
            	pstmt.setString(2, searchBar);
            }
            else if(!isSearch && !searchBar.equals(""))
            {
            	pstmt = conn.prepareStatement("select * from products where name = ?");
            	pstmt.setString(1, searchBar);
            }
            else
            {
            	pstmt = conn.prepareStatement("select * from products");
            }
            
            
            
           rs = pstmt.executeQuery();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
           
            %>
            <form action="products.jsp" method="GET">
            <b>Product Search:</b>
            <input value="" name="searchBar" size=10/>
            <input value="<%=search%>" name="search" type="hidden" />
            <input type="submit" value="Search"/>
            </form>
            <p>You searched for "<%=searchBar %>" product.</p>
            <p>You searched for "<%=search %>" category.</p>
            <br>
            <!-- Add an HTML table header row to format the results -->
            <table border="1">
            <tr>
            	<th>ID</th>
                <th>Name</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Price</th>
            </tr>

            <tr>
                <form action="products.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <th>&nbsp;</th>
                    <th><input value="" name="name" size="10"/></th>
                    <th><input value="" name="sku" size="15"/></th>
                    <input type="hidden" name="search" value="<%=search%>"/>
                    <input type="hidden" name="searchBar" value="<%=searchBar%>"/>
                    <th>
                    	<!-- Start of dropdown for categories -->
			        	  <select name="category">
			        		<option value="">- Please Select -</option>
			        		<%
			        		Statement categoryStatement = conn.createStatement();
                    		rsCategory = categoryStatement.executeQuery("select * from categories");
			        		while(rsCategory.next()) {
			        			out.print("<option value=\""+rsCategory.getString("name")+"\">"+rsCategory.getString("name")+"</option>");
			        		}
			        		%>
			        		
		        		  </select>
            			<!-- End of dropdown -->
            		</th>
                    <th><input value="" name="price" size="15"/></th>
                    <th><input type="submit" value="Insert"/></th>
                </form>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
            %>

            <tr>
                <form action="products.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="sku" value="<%=rs.getString("sku")%>"/>
				
				<td></td>

                <%-- Get the name --%>
                <td>
                    <input value="<%=rs.getString("name")%>" name="name" size="15"/>
                </td>
                
                <%-- Get the sku --%>
                <td>
                    <%=rs.getString("sku")%>
                </td>
                <%-- Get the category --%>
                <td>
                    <!-- Start of dropdown for categories -->
			        	  <select name="category">
			        		<option value="<%=rs.getString("category")%>"><%=rs.getString("category")%></option>
			        		<%
			        		Statement categoryStatement2 = conn.createStatement();
                    		String categoryDropdown = rs.getString("category");
                    		rsCategory = categoryStatement2.executeQuery("select * from categories where categories.name <> '"+categoryDropdown+"'");
			        		while(rsCategory.next()) {
			        			out.print("<option value=\""+rsCategory.getString("name")+"\">"+rsCategory.getString("name")+"</option>");
			        		}
			        		%>
			        		
		        		  </select>
            			<!-- End of dropdown -->
                </td>
               
				 <%-- Get the middle name --%>
                <td>
                    <input value="<%=rs.getInt("price")%>" name="price" size="15"/>
                </td>
               
				


                <%-- Button --%>
                <td><input type="submit" value="Update"></td>
                </form>
                <form action="products.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" value="<%=rs.getString("sku")%>" name="sku"/>
                    <%-- Button --%>
                <td><input type="submit" value="Delete"/></td>
                </form>
            </tr>

            <%
                }
            %>

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