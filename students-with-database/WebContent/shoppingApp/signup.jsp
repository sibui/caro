<html>

<body>
<h2>Signup Page</h2>
<table>
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>
<%--             <jsp:include page="/menu.html" /> --%>
			
        </td>
        <td>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
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
                if (action != null && action.equals("signup")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT user values INTO the users table.
                    pstmt = conn
                    .prepareStatement("INSERT INTO users (state, role, age, name) VALUES (?, ?, ?, ?)");

                    pstmt.setString(4, request.getParameter("username"));
                    pstmt.setString(2, request.getParameter("usertype"));
                    pstmt.setString(3, request.getParameter("age"));
                    pstmt.setString(1, request.getParameter("state"));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                    String username = (String) request.getParameter("username");
                    application.setAttribute("username", username);
                    String redirectURL = "home.jsp";
                    response.sendRedirect(redirectURL);
                 
                  
                }
            %>
            
            <%-- -------- UPDATE Code -------- --%>
            <%
                // Check if an update is requested
//                 if (action != null && action.equals("update")) {

//                     // Begin transaction
//                     conn.setAutoCommit(false);

//                     // Create the prepared statement and use it to
//                     // UPDATE student values in the Students table.
//                     pstmt = conn
//                         .prepareStatement("UPDATE students SET pid = ?, first_name = ?, "
//                             + "middle_name = ?, last_name = ? WHERE id = ?");

//                     pstmt.setInt(1, Integer.parseInt(request.getParameter("pid")));
//                     pstmt.setString(2, request.getParameter("first"));
//                     pstmt.setString(3, request.getParameter("middle"));
//                     pstmt.setString(4, request.getParameter("last"));
//                     pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));
//                     int rowCount = pstmt.executeUpdate();

//                     // Commit transaction
//                     conn.commit();
//                     conn.setAutoCommit(true);
//                 }
            %>
            
            <%-- -------- DELETE Code -------- --%>
            <%
                // Check if a delete is requested
//                 if (action != null && action.equals("delete")) {

//                     // Begin transaction
//                     conn.setAutoCommit(false);

//                     // Create the prepared statement and use it to
//                     // DELETE students FROM the Students table.
//                     pstmt = conn
//                         .prepareStatement("DELETE FROM Students WHERE id = ?");

//                     pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
//                     int rowCount = pstmt.executeUpdate();

//                     // Commit transaction
//                     conn.commit();
//                     conn.setAutoCommit(true);
//                 }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the User table.
                rs = statement.executeQuery("SELECT * FROM users");
            %>
            
            <table border="1">
            <form action="signup.jsp" method="POST">
	            Username: <input type="text" name="username">
	        	<select name="usertype">
	        		<option value="owner" name="usertype">Owner</option>
	        		<option value="customer" name="usertype">Customer</option>
	        	</select>
	        	<input type="hidden" name="action" value="signup"/>
	        	Age: <input type="text" name="age">
	        	
	        	<select name="state">
	        		<option name="state" value="ca">CA</option>
	        		<option name="state" value="nv">NV</option>
	        	</select>
	        	<td><input type="submit" value="signup"></td>
            </form>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
            %>

            <tr>
                
                <td>
                    <%=rs.getInt("id")%>
                </td>

                
                <td>
                    <%=rs.getString("state")%>
                </td>

                
                <td>
                    <%=rs.getString("role")%>
                </td>

                
                <td>
                    <%=rs.getInt("age")%>
                </td>

                
                <td>
                    <%=rs.getString("name")%>
                </td>

                <!--  
                <form action="attempt3/students.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" value="<%=rs.getInt("id")%>" name="id"/>
                    Button
                <td><input type="submit" value="Delete"/></td>
                </form>-->
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
            	String redirectURL = "unsuccessful.html";
                response.sendRedirect(redirectURL);
                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
                
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

