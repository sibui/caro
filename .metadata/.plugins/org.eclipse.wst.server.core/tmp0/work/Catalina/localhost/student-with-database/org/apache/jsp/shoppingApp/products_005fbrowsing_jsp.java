/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.52 (Ubuntu)
 * Generated at: 2015-05-05 21:05:35 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.shoppingApp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class products_005fbrowsing_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("<title>Products</title>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\t<!--  Precursor text that must appear in every webpage -->\n");
      out.write("\t ");

	     String username = (String) application.getAttribute("username");
		 String usertype = (String) application.getAttribute("usertype");
	
		 if (username == null || usertype == null ) {
		  	 String redirectURL = "login.jsp";
		     response.sendRedirect(redirectURL);
	     }
    
      out.write("\n");
      out.write("    Welcome, ");
      out.print(username);
      out.write("!\n");
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
            
      out.write("\n");
      out.write("            \n");
      out.write("            ");
 
          
	          rsCategory = categoryStatement1.executeQuery("SELECT categories.name FROM categories");
	      
			
      out.write("\n");
      out.write("\t\t\t   <b>Categories </b>\n");
      out.write("\t\t\t   <ul>\n");
      out.write("\t\t\t\t");

	          
	            String searchBar = request.getParameter("searchBar");
	            if(searchBar == null)
	            {
	            	searchBar = "";
	            }
	            
	            
				out.print("<li><a href=\"products_browsing.jsp\">All Products</a></li>");
				while(rsCategory.next()){
					out.print("<li><a href=\"products_browsing.jsp?search="+rsCategory.getString("name")+"&searchBar="+searchBar+"\">"+rsCategory.getString("name")+"</a></li>");
				}

	
	
      out.write("\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t</ul>\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

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
           
            
      out.write("\n");
      out.write("            <form action=\"products_browsing.jsp\" method=\"GET\">\n");
      out.write("            <b>Product Search:</b>\n");
      out.write("            <input value=\"\" name=\"searchBar\" size=10/>\n");
      out.write("            <input value=\"");
      out.print(search);
      out.write("\" name=\"search\" type=\"hidden\" />\n");
      out.write("            <input type=\"submit\" value=\"Search\"/>\n");
      out.write("            </form>\n");
      out.write("            <p>You searched for \"");
      out.print(searchBar );
      out.write("\" product.</p>\n");
      out.write("            <p>You searched for \"");
      out.print(search );
      out.write("\" category.</p>\n");
      out.write("            <br>\n");
      out.write("            <!-- Add an HTML table header row to format the results -->\n");
      out.write("            <table border=\"1\">\n");
      out.write("            <tr>\n");
      out.write("            \t<th>ID</th>\n");
      out.write("                <th>Name</th>\n");
      out.write("                <th>SKU</th>\n");
      out.write("                <th>Category</th>\n");
      out.write("                <th>Price</th>\n");
      out.write("            </tr>\n");
      out.write("            \n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

                // Iterate over the ResultSet
                while (rs.next()) {
                	
      out.write("\n");
      out.write("                \t<tr>\n");
      out.write("    \t\t\t\t<td></td>\n");
      out.write("\n");
      out.write("                    ");
      out.write("\n");
      out.write("                    <td>\n");
      out.write("                    \t");
String skuResult = rs.getString("sku");
      out.write("\n");
      out.write("                        <a href=\"product_ordering.jsp?sku=");
      out.print(skuResult);
      out.write('"');
      out.write('>');
      out.print(rs.getString("name"));
      out.write("</a>\n");
      out.write("                        \n");
      out.write("                    </td>\n");
      out.write("                    \n");
      out.write("                    ");
      out.write("\n");
      out.write("                    <td>\n");
      out.write("                        ");
      out.print(rs.getString("sku"));
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                    ");
      out.write("\n");
      out.write("                    <td>\n");
      out.write("                        ");
      out.print(rs.getString("category"));
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                   \n");
      out.write("    \t\t\t\t ");
      out.write("\n");
      out.write("                    <td>\n");
      out.write("                        ");
      out.print(rs.getInt("price"));
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                   \n");
      out.write("                </tr>\n");
      out.write("                ");

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
            
      out.write("\n");
      out.write("        </table>\n");
      out.write("        </td>\n");
      out.write("    </tr>\n");
      out.write("</table>\n");
      out.write("</body>\n");
      out.write("</html>");
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
