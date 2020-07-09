<%@ include file="../connector/Connect.jsp" %>
<%@include file="../model/Book.jsp"%>

<%
	Integer id = Integer.valueOf(request.getParameter("id"));
	Book book = new Book();
	book.delete(id);
	response.sendRedirect("../manageBook.jsp?code=deleteSuccess");
%>