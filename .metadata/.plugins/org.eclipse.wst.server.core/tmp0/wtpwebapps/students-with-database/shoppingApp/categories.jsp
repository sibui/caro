<html>

<body>
<h2>Categories</h2>




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
            ResultSet rs = null;
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/cse135?" +
                    "user=postgres&password=postgres");
            %>
            
            <%-- -------- INSERT Code -------- --%>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    pstmt = conn
                    .prepareStatement("INSERT INTO categories (description, name,numProducts) VALUES (?, ?,0)");

                    pstmt.setString(1, request.getParameter("description"));
                    pstmt.setString(2, request.getParameter("name"));
               

                    int rowCount = pstmt.executeUpdate();

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
                        .prepareStatement("UPDATE categories SET description = ?, name = ?");

                    pstmt.setString(1, request.getParameter("description"));
                    pstmt.setString(2, request.getParameter("name"));
                    int rowCount = pstmt.executeUpdate();

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
                        .prepareStatement("DELETE FROM categories WHERE name = ?");

                    pstmt.setString(1, request.getParameter("name"));
                    Statement statement1 = conn.createStatement();
                    pstmt2 = conn.prepareStatement("select categories.name, categories.description, count(products.name) as numProduct " +
                    		"from categories LEFT JOIN products ON categories.name = products.category where categories.name = ? " +
                    		"group by categories.name, categories.description having count(products.name) = 0");
                    pstmt2.setString(1, request.getParameter("name"));
                    rs = pstmt2.executeQuery();
                    
                    if(rs.next())
                    {
                    	int rowCount = pstmt.executeUpdate();
                    }
                    else
                    {
       				 out.print("Data modification failure. Click <a href=\"categories.jsp\">here</a> to try again.");
	
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

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("select categories.name, categories.description, count(products.name) as numProduct " +
                		"from categories LEFT JOIN products ON categories.name = products.category " +
                		"group by categories.name, categories.description");
                //rs = statement.executeQuery("select * from products");
            %>
            
            <!-- Add an HTML table header row to format the results -->
            <table border="1">
            <tr>
                <th>ID</th>
                <th>Category Name</th>
                <th>Description</th>
                <th>Num of products</th>
            </tr>

            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <th>&nbsp;</th>
                    <th><input value="" name="name" size="10"/></th>
                    <th><input value="" name="description" size="15"/></th>
                    <th><input type="submit" value="Insert"/></th>
                </form>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
            %>

            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
<%--                     <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/> --%>

                <%-- Get the id --%>
                <td>
                </td>

                <%-- Get the first name --%>
                <td>
                    <input value="<%=rs.getString("name")%>" name="name" size="15"/>
                </td>

                <%-- Get the middle name --%>
                <td>
                    <input value="<%=rs.getString("description")%>" name="description" size="15"/>
                </td>
               
				 <%-- Get the middle name --%>
                <td>
                    <input value="<%=rs.getInt("numProduct")%>" name="description" size="15"/>
                </td>
               
				


                <%-- Button --%>
                 
                <td><input type="submit" value="Update"></td>
                
                </form>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" value="<%=rs.getString("name")%>" name="name"/>
                    <%-- Button --%>
                <%
                if(rs.getInt("numProduct") == 0)
                {
                	out.print("<td><input type=\"submit\" value=\"Delete\"/></td>");
                }
                %>
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

				 out.print("Data modification failure. Click <a href=\"categories.jsp\">here</a> to try again.");
				
                //throw new RuntimeException(e);
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
