/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.52 (Ubuntu)
 * Generated at: 2015-05-05 21:05:16 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.shoppingApp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class categories_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<html>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("<h2>Categories</h2>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!--  Precursor text that must appear in every webpage -->\n");
      out.write("\t ");

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
    
      out.write("\n");
      out.write("    Welcome, ");
      out.print(username);
      out.write("!\n");
      out.write("\n");
      out.write("<table>\n");
      out.write("\t<tr>\n");
      out.write(" \t\t<td valign=\"top\">\n");
      out.write("        \t");
      out.write("\n");
      out.write("            ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/browser.html", out, false);
      out.write("\n");
      out.write(" \t\t</td>\n");
      out.write("\t</tr>\n");
      out.write("</table>\n");
      out.write("\n");
      out.write("\n");
      out.write("<table>\n");
      out.write("    <tr>\n");
      out.write("\n");
      out.write("        <td>\n");
      out.write("            ");
      out.write("\n");
      out.write("            \n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

            
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
            
      out.write("\n");
      out.write("            \n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

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
            
      out.write("\n");
      out.write("            \n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

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
            
      out.write("\n");
      out.write("            \n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

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
            
      out.write("\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("select categories.name, categories.description, count(products.name) as numProduct " +
                		"from categories LEFT JOIN products ON categories.name = products.category " +
                		"group by categories.name, categories.description");
                //rs = statement.executeQuery("select * from products");
            
      out.write("\n");
      out.write("            \n");
      out.write("            <!-- Add an HTML table header row to format the results -->\n");
      out.write("            <table border=\"1\">\n");
      out.write("            <tr>\n");
      out.write("                <th>ID</th>\n");
      out.write("                <th>Category Name</th>\n");
      out.write("                <th>Description</th>\n");
      out.write("                <th>Num of products</th>\n");
      out.write("            </tr>\n");
      out.write("\n");
      out.write("            <tr>\n");
      out.write("                <form action=\"categories.jsp\" method=\"POST\">\n");
      out.write("                    <input type=\"hidden\" name=\"action\" value=\"insert\"/>\n");
      out.write("                    <th>&nbsp;</th>\n");
      out.write("                    <th><input value=\"\" name=\"name\" size=\"10\"/></th>\n");
      out.write("                    <th><input value=\"\" name=\"description\" size=\"15\"/></th>\n");
      out.write("                    <th><input type=\"submit\" value=\"Insert\"/></th>\n");
      out.write("                </form>\n");
      out.write("            </tr>\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

                // Iterate over the ResultSet
                while (rs.next()) {
            
      out.write("\n");
      out.write("\n");
      out.write("            <tr>\n");
      out.write("                <form action=\"categories.jsp\" method=\"POST\">\n");
      out.write("                    <input type=\"hidden\" name=\"action\" value=\"update\"/>\n");
      out.write("\n");
      out.write("\n");
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                </td>\n");
      out.write("\n");
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    <input value=\"");
      out.print(rs.getString("name"));
      out.write("\" name=\"name\" size=\"15\"/>\n");
      out.write("                </td>\n");
      out.write("\n");
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    <input value=\"");
      out.print(rs.getString("description"));
      out.write("\" name=\"description\" size=\"15\"/>\n");
      out.write("                </td>\n");
      out.write("               \n");
      out.write("\t\t\t\t ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    <input value=\"");
      out.print(rs.getInt("numProduct"));
      out.write("\" name=\"description\" size=\"15\"/>\n");
      out.write("                </td>\n");
      out.write("               \n");
      out.write("\t\t\t\t\n");
      out.write("\n");
      out.write("\n");
      out.write("                ");
      out.write("\n");
      out.write("                 \n");
      out.write("                <td><input type=\"submit\" value=\"Update\"></td>\n");
      out.write("                \n");
      out.write("                </form>\n");
      out.write("                <form action=\"categories.jsp\" method=\"POST\">\n");
      out.write("                    <input type=\"hidden\" name=\"action\" value=\"delete\"/>\n");
      out.write("                    <input type=\"hidden\" value=\"");
      out.print(rs.getString("name"));
      out.write("\" name=\"name\"/>\n");
      out.write("                    ");
      out.write("\n");
      out.write("                ");

                if(rs.getInt("numProduct") == 0)
                {
                	out.print("<td><input type=\"submit\" value=\"Delete\"/></td>");
                }
                
      out.write("\n");
      out.write("                </form>\n");
      out.write("            </tr>\n");
      out.write("\n");
      out.write("            ");

                }
            
      out.write("\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

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
            
      out.write("\n");
      out.write("        </table>\n");
      out.write("        </td>\n");
      out.write("    </tr>\n");
      out.write("</table>\n");
      out.write("</body>\n");
      out.write("\n");
      out.write("</html>\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
