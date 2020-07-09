<%@ include file="../connector/Connect.jsp" %>
<%@include file="../model/User.jsp" %>
<%@page import="java.sql.*, java.util.*" %>
<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	if(email.length()<1){
		response.sendRedirect("../login.jsp?code=emptyEmail");
	}
	else if(password.length()<1){
		response.sendRedirect("../login.jsp?code=emptyPassword");
	}
	else{
		User user = new User().exists("email",email);
		if(user != null){
			if(password.equals(user.getPassword())){
				session.setAttribute("id",user.getId());
				response.sendRedirect("../index.jsp");
			}
			else{
				response.sendRedirect("../login.jsp?code=invalidPassword");
			}
		}
		else{
			response.sendRedirect("../login.jsp?code=userNotExists");
		}
	}
%>