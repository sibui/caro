<html>

<body>
<h2>Log In Page</h2>
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
            
            
            
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the User table.
                
            %>
            
            <table border="1">
            <form action="login.jsp" method="GET">
	            Username: <input type="text" name="username">
	        	<input type="hidden" name="action" value="login"/>
	        	<td><input type="submit" value="Log In"></td>

            </form>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                String action = (String) request.getParameter("action");
    			String username = (String) request.getParameter("username");

            	if(action != null && action.equals("login"))
            	{
            		
            		//String redirectURL1 = "http://www.google.com";
                    //response.sendRedirect(redirectURL1);
                     pstmt = conn
                    .prepareStatement("select * from users where name = ?");
                     
                     pstmt.setString(1, username);
                    

					  if(username != null)
					  {
						  rs = pstmt.executeQuery();
						  if(rs.next() && username.equals(rs.getString("name")))
						  {
						  	application.setAttribute("username", username);
						  	application.setAttribute("usertype", rs.getString("role"));
						  	String redirectURL = "home.jsp";
		                  	response.sendRedirect(redirectURL);
						  }
					  }
							  
				
					
            		//outputs that its an incorrect username
					 out.print("The provided name "+ username + " is not known. Please use a correct username in textbox.");
					 
            
				  }
            	
            	
       
    
            %>
            
         
    

            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                if(rs != null) 
                {
                	rs.close();
                }

                // Close the Statement
                statement.close();

                // Close the Connection
                conn.close();
            } catch (SQLException e) {
            	//String redirectURL = "unsuccessful.html";
                //response.sendRedirect(redirectURL);
                
                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
                
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


