<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Categories</title>
</head>
<body>

	


	<!--  Precursor text that must appear in every webpage -->
	 <%
       String username = (String) application.getAttribute("username");
	   String usertype = (String) application.getAttribute("usertype");
	   if(usertype.equals("customer")){
		   //redirect to another html page since 
		   //you are a customer with no access to that page
		   String redirectURL = "noaccess.html";
           response.sendRedirect(redirectURL);
		   
	   }
	   else if (username == null) {
    	   String redirectURL = "login.jsp";
           response.sendRedirect(redirectURL);
       }
    %>
    Welcome, <%=username%>!
</body>
</html>