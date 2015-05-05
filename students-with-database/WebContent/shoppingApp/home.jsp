<html>

<body>
   <%
       String username = (String) application.getAttribute("username");
   	   String usertype = (String) application.getAttribute("usertype");
       if (username == null) {
    	   String redirectURL = "login.jsp";
           response.sendRedirect(redirectURL);
       }
    %>
    Welcome, <%=username%>! You are a <%= usertype %>
    
    <table>
	<tr>
 		<td valign="top">
        	<%-- -------- Include browser links HTML code -------- --%>
            <jsp:include page="/browser.html" />
	   		<% 
		    if( usertype != null && usertype.equals("customer"))
		    {
		    	out.print("<ul><li><a href=\"/student-with-database/shoppingApp/buy.jsp\">Buy Shopping Cart</a></li></ul>");

		    }
			%>
 		</td>
	</tr>
	</table>
    
</body>

</html>

