<%@include file="../connector/Connect.jsp" %>
<%@include file="../model/Book.jsp"%>
<%@include file="../model/User.jsp"%>
<%@include file="../model/Transaction.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>

<%
	Integer bookId = Integer.valueOf(request.getParameter("id"));
	Integer userId = (Integer) session.getAttribute("id");
	Book book = new Book().find(bookId);
	book.setStatus(1);
	book.update();
	User user = new User().find(userId);
	user.setBorrow(1);
	user.update();
	Calendar now = Calendar.getInstance();
	int dayOfMonth = now.get(Calendar.DAY_OF_MONTH);
	String dayOfMonthStr = ((dayOfMonth < 10) ? "0" : "") + dayOfMonth;
	int month = now.get(Calendar.MONTH) + 1;
	String monthStr = ((month < 10) ? "0" : "") + month;
	String trxDate = (dayOfMonthStr+"/"+monthStr+"/"+now.get(Calendar.YEAR));
	Transaction trx = new Transaction();
	trx.setUserId(userId);
	trx.setBookId(bookId);
	trx.setTrxDate(trxDate);
	trx.setStatus(2);
	trx.insert();
	response.sendRedirect("../manageBook.jsp?code=borrowSuccess");
%>