<html>

<body>
<h2>Home</h2>
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
 		</td>
	</tr>
	</table>
    
</body>

</html>

