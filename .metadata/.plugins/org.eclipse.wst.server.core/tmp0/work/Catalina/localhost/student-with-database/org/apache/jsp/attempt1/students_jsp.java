/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.52 (Ubuntu)
 * Generated at: 2015-04-23 02:17:06 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.attempt1;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class students_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<h2>Attempt 1</h2>\n");
      out.write("<table>\n");
      out.write("    <tr>\n");
      out.write("        <td valign=\"top\">\n");
      out.write("            ");
      out.write("\n");
      out.write("            ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/menu.html", out, false);
      out.write("\n");
      out.write("        </td>\n");
      out.write("        <td>\n");
      out.write("            ");
      out.write("\n");
      out.write("            \n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/cse135?" +
                    "user=cse135&password=cse135");
            
      out.write("\n");
      out.write("            \n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("SELECT * FROM students");
            
      out.write("\n");
      out.write("            \n");
      out.write("            <!-- Add an HTML table header row to format the results -->\n");
      out.write("            <table border=\"1\">\n");
      out.write("            <tr>\n");
      out.write("                <th>ID</th>\n");
      out.write("                <th>PID</th>\n");
      out.write("                <th>First Name</th>\n");
      out.write("                <th>Middle Name</th>\n");
      out.write("                <th>Last Name</th>\n");
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
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    ");
      out.print(rs.getInt("id"));
      out.write("\n");
      out.write("                </td>\n");
      out.write("\n");
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    ");
      out.print(rs.getInt("pid"));
      out.write("\n");
      out.write("                </td>\n");
      out.write("\n");
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    ");
      out.print(rs.getString("first_name"));
      out.write("\n");
      out.write("                </td>\n");
      out.write("\n");
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    ");
      out.print(rs.getString("middle_name"));
      out.write("\n");
      out.write("                </td>\n");
      out.write("\n");
      out.write("                ");
      out.write("\n");
      out.write("                <td>\n");
      out.write("                    ");
      out.print(rs.getString("last_name"));
      out.write("\n");
      out.write("                </td>\n");
      out.write("            </tr>\n");
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