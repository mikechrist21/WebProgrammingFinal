<%@ include file="../connector/Connect.jsp" %>
<%@include file="../model/User.jsp" %>
<%@page import="java.sql.*, java.util.*" %>
<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("confirmPassword");
	Integer id = (Integer) session.getAttribute("id");
	if(name.length()<1){
		response.sendRedirect("../register.jsp?code=emptyName");
	}
	else if(email.length()<1){
		response.sendRedirect("../register.jsp?code=emptyEmail");
	}
	else if(password.length()<1){
		response.sendRedirect("../register.jsp?code=emptyPassword");
	}
	else if(confirmPassword.length()<1){
		response.sendRedirect("../register.jsp?code=emptyConfirmPassword");
	}
	else if(!password.equals(confirmPassword)){
		response.sendRedirect("../register.jsp?code=invalidPassword");
	}
	else{
		User user = new User().find(id);
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.update();
		response.sendRedirect("../index.jsp?code=profileUpdated");
	}
%>