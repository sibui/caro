/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.52 (Ubuntu)
 * Generated at: 2015-05-05 23:42:03 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.shoppingApp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class product_005fordering_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<title>Product Ordering</title>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\t");

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
    
      out.write("\n");
      out.write("    Welcome, ");
      out.print(username);
      out.write("!\n");
      out.write("    \n");
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
      out.write("\t\n");
      out.write("\t ");
      out.write("\n");
      out.write("            ");

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
            
      out.write("\n");
      out.write("\t\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

                // Create the statement
                Statement statement = conn.createStatement();
            
            pstmt = conn.prepareStatement("select * from products where sku = ?");
        	pstmt.setString(1, sku);
        	rs = pstmt.executeQuery();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
            
      out.write("\n");
      out.write("\n");
      out.write("            <!-- Add an HTML table header row to format the results -->\n");
      out.write("            <table border=\"1\">\n");
      out.write("            <tr>\n");
      out.write("            <th>Current Product</th>\n");
      out.write("            </tr>\n");
      out.write("            <tr>\n");
      out.write("                <th>Name</th>\n");
      out.write("                <th>SKU</th>\n");
      out.write("                <th>Category</th>\n");
      out.write("                <th>Price</th>\n");
      out.write("                <th>Quantity</th>\n");
      out.write("            </tr>\n");
      out.write("            \n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

                // Iterate over the ResultSet
                while (rs.next()) {
                	
      out.write("\n");
      out.write("                \t<tr>\n");
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
      out.write("                    <form action=\"product_ordering.jsp\" method=\"POST\">\n");
      out.write("                    <input type=\"hidden\" name=\"sku\" value=\"");
      out.print(rs.getString("sku"));
      out.write("\"/>\n");
      out.write("                    <input type=\"hidden\" name=\"action\" value=\"buy\"/>\n");
      out.write("                    <input type=\"hidden\" name=\"price\" value=\"");
      out.print(rs.getString("price"));
      out.write("\"/>\n");
      out.write("                    <td>\n");
      out.write("                    <input type=\"text\"   name=\"quantity\" value=\"\"/>\n");
      out.write("                    </td>\n");
      out.write("                    <td>\n");
      out.write("                    <input type=\"submit\" value=\"Add to Cart\"/>\n");
      out.write("                    </td>\n");
      out.write("                    </form>\n");
      out.write("                   \n");
      out.write("                </tr>\n");
      out.write("                ");

                }
            
      out.write("\n");
      out.write("            <tr>\n");
      out.write("            </tr>\n");
      out.write("            <tr>\n");
      out.write("            <th>YOUR CART</th>\n");
      out.write("            </tr>\n");
      out.write("                        <tr>\n");
      out.write("                <th>Owner</th>\n");
      out.write("                <th>SKU</th>\n");
      out.write("                <th>Price</th>\n");
      out.write("                <th>Quantity</th>\n");
      out.write("                <th>Cost</th>\n");
      out.write("            </tr>\n");
      out.write("            ");
      out.write("\n");
      out.write("            ");

                // Create the statement
            
            pstmt = conn.prepareStatement("select * from carts where owner = ?");
        	pstmt.setString(1, username);
        	rs = pstmt.executeQuery();
        	int cartTotal = 0;
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
            
      out.write("  \n");
      out.write("            \n");
      out.write("                      \n");

                // Iterate over the ResultSet
                while (rs.next()) {
                	int productTotal = rs.getInt("quantity")*rs.getInt("price");
                	cartTotal = cartTotal + productTotal;
                	
      out.write("\n");
      out.write("                \t<tr>\n");
      out.write("\n");
      out.write("                    ");
      out.write("\n");
      out.write("                    <td>\n");
      out.write("                    \t");
      out.print(rs.getString("owner"));
      out.write("\n");
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
      out.write("               \t\t");
      out.write("\n");
      out.write("                    <td>\n");
      out.write("                        ");
      out.print(rs.getInt("price"));
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                    ");
      out.write("\n");
      out.write("                    <td>\n");
      out.write("                        ");
      out.print(rs.getInt("quantity"));
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                    <td>\n");
      out.write("                    ");
      out.print(productTotal);
      out.write("\n");
      out.write("                    </td>\n");
      out.write("                   \n");
      out.write("                   \n");
      out.write("                </tr>\n");
      out.write("\n");
      out.write("                ");

                }
            
      out.write("         \n");
      out.write("                <tr>\n");
      out.write("                <th></th>\n");
      out.write("                <th></th>\n");
      out.write("                <th></th>\n");
      out.write("                <th size=10> CART TOTAL:</th>\n");
      out.write("                <th>");
      out.print(cartTotal);
      out.write("\n");
      out.write("                </tr>\n");
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
      out.write("</table>    \n");
      out.write("\n");
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
