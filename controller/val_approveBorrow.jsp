<%@include file="../connector/Connect.jsp" %>
<%@include file="../model/Book.jsp"%>
<%@include file="../model/User.jsp"%>
<%@include file="../model/Transaction.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>

<%
	Integer trxId = Integer.valueOf(request.getParameter("id"));
	Transaction trx = new Transaction().find(trxId);
	trx.setStatus(1);
	trx.update();
	response.sendRedirect("../manageTransaction.jsp?code=borrowSuccess");
%>