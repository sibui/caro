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
	            
	            
				out.print("<li><a href=\"products_browsing.jsp\">All Products</a></li>");
				while(rsCategory.next()){
					out.print("<li><a href=\"products_browsing.jsp?search="+rsCategory.getString("name")+"&searchBar="+searchBar+"\">"+rsCategory.getString("name")+"</a></li>");
				}

	
	%>
	
	
	</ul>

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
            	pstmt.setString(2, "%"+searchBar+"%");
            }
            else if(!isSearch && !searchBar.equals(""))
            {
            	pstmt = conn.prepareStatement("select * from products where name like ?");
            	pstmt.setString(1, "%"+searchBar+"%");
            }
            else
            {
            	pstmt = conn.prepareStatement("select * from products");
            }
            
            
            
           rs = pstmt.executeQuery();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
           
            %>
            <form action="products_browsing.jsp" method="GET">
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
            
            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
                	%>
                	<tr>
    				<td></td>

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
                        <%=rs.getString("category")%>
                    </td>
                   
    				 <%-- Get the middle name --%>
                    <td>
                        <%=rs.getInt("price")%>
                    </td>
                   
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