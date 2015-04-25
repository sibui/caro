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
</body>

</html>

