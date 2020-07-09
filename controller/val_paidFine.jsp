<%@include file="../connector/Connect.jsp" %>
<%@include file="../model/User.jsp"%>
<%@include file="../model/Fine.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>

<%
	Integer fineId = Integer.valueOf(request.getParameter("id"));
	Fine fine = new Fine().find(fineId);
	User user = new User().find(fine.getUserId());
	fine.setStatus(1);
	out.println(fine.getStatus());
	fine.update();
	out.println(fine.getStatus());
	user.update();
	response.sendRedirect("../manageFine.jsp?code=paidSuccess");
%>