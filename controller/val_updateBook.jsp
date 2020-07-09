<%@ include file="../connector/Connect.jsp" %>
<%@include file="../model/Book.jsp" %>
<%@page import="java.sql.*, java.util.*" %>
<%
	Integer id = Integer.valueOf(request.getParameter("id"));
	String bookName = request.getParameter("bookName");
	String bookAuthor = request.getParameter("bookAuthor");
	Integer bookYear = -1;
	Book book = new Book().find(id);
	try{
		bookYear = Integer.valueOf(request.getParameter("bookYear"));
	}catch(Exception e){
		bookYear = -1;
	}
	if(bookName.length()<1){
		response.sendRedirect("../updateBook.jsp?code=emptyName");
	}
	else if(bookAuthor.length()<1){
		response.sendRedirect("../updateBook.jsp?code=emptyAuthor");
	}
	else if(bookYear == -1){
		response.sendRedirect("../updateBook.jsp?code=emptyYear");
	}
	else{
			book.setTitle(bookName);
			book.setAuthor(bookAuthor);
			book.setYear(bookYear);
			book.update();
			response.sendRedirect("../manageBook.jsp?code=updateSuccess");
	}
%>