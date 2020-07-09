<%@ include file="../connector/Connect.jsp" %>
<%@include file="../model/Book.jsp" %>
<%@page import="java.sql.*, java.util.*" %>
<%
	String tempBookName = request.getParameter("bookName");
	String bookName = "";
	for(int i=0;i<tempBookName.length();i++){
		if(tempBookName.charAt(i) == '\''){
			bookName += "\'\'";
		}
		else bookName += tempBookName.charAt(i);
	}
	String bookAuthor = request.getParameter("bookAuthor");
	Integer bookYear = -1;
	try{
		bookYear = Integer.valueOf(request.getParameter("bookYear"));
	}catch(Exception e){
		bookYear = -1;
	}
	if(bookName.length()<1){
		response.sendRedirect("../insertBook.jsp?code=emptyName");
	}
	else if(bookAuthor.length()<1){
		response.sendRedirect("../insertBook.jsp?code=emptyAuthor");
	}
	else if(bookYear == -1){
		response.sendRedirect("../insertBook.jsp?code=emptyYear");
	}
	else{
		Book book = new Book().exists("title",bookName);
		if(book != null){
			response.sendRedirect("../insertBook.jsp?code=bookExists");
		}
		else{
			book = new Book();
			book.setTitle(bookName);
			book.setAuthor(bookAuthor);
			book.setYear(bookYear);
			book.setStatus(0);
			book.insert();
			response.sendRedirect("../manageBook.jsp?code=insertSuccess");
		}
	}
%>