<html>

<body>
   <%
       String username = (String) application.getAttribute("username");
       if (username == null) {
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
    
</body>

</html>

