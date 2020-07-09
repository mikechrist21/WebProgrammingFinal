<%@include file="../connector/Connect.jsp" %>
<%@include file="../model/Book.jsp"%>
<%@include file="../model/User.jsp"%>
<%@include file="../model/Transaction.jsp"%>
<%@include file="../model/Fine.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>

<%!
	public Integer monthToDay(Integer month){
		if(month == 1)return 0;
		if(month == 2)return 31;
		if(month == 3)return 60;
		if(month == 4)return 91;
		if(month == 5)return 121;
		if(month == 6)return 152;
		if(month == 7)return 182;
		if(month == 8)return 213;
		if(month == 9)return 244;
		if(month == 10)return 274;
		if(month == 11)return 305;
		else return 335;
	}

	public Integer getDiffDate(String dateX, String dateY){
		Integer dayX = Integer.valueOf(dateX.charAt(0))*10+Integer.valueOf(dateX.charAt(1));
		Integer dayY = Integer.valueOf(dateY.charAt(0))*10+Integer.valueOf(dateY.charAt(1));
		Integer monthX = Integer.valueOf(dateX.charAt(3))*10+Integer.valueOf(dateX.charAt(4));
		Integer monthY = Integer.valueOf(dateY.charAt(3))*10+Integer.valueOf(dateY.charAt(4));
		Integer totalDayX = dayX + monthToDay(monthX);
		Integer totalDayY = dayY + monthToDay(monthY);
		return totalDayX-totalDayY;
	}
%>

<%
	Integer trxId = Integer.valueOf(request.getParameter("id"));
	Transaction trx = new Transaction().find(trxId);
	User user = new User().find(trx.getUserId());
	Book book = new Book().find(trx.getBookId());
	trx.setStatus(0);
	trx.update();
	book.setStatus(0);
	book.update();
	Calendar now = Calendar.getInstance();
	int dayOfMonth = now.get(Calendar.DAY_OF_MONTH);
	String dayOfMonthStr = ((dayOfMonth < 10) ? "0" : "") + dayOfMonth;
	int month = now.get(Calendar.MONTH) + 1;
	String monthStr = ((month < 10) ? "0" : "") + month;
	String trxDate = (dayOfMonthStr+"/"+monthStr+"/"+now.get(Calendar.YEAR));
	if(getDiffDate(trx.getTrxDate(),trxDate)>7){
		Fine fine = new Fine();
		fine.setUserId(trx.getUserId());
		fine.setDate(trxDate);
		fine.setStatus(0);
		fine.insert();
	}
	else{
		user.setBorrow(0);
		user.update();
	}
	response.sendRedirect("../manageBorrow.jsp?code=returnSuccess");
%>