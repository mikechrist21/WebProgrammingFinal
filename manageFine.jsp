<%@ include file="connector/Connect.jsp" %>
<%@include file="model/User.jsp"%>
<%@include file="model/Book.jsp"%>
<%@include file="model/Transaction.jsp"%>
<%@include file="model/Fine.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/manageFine.css"/>
	<title>Binus Library</title>
</head>
<body>
	<%
		Integer cnt = 0;
		String code = request.getParameter("code");
		Boolean has_response = (code != null);
		if(has_response){
		%>
			<input type="hidden" value="<%=code%>" id="code">
		<%
		}
		Integer id = null;
		Integer role = -1;
		Integer borrow = 0;
		try{
			id = (Integer) session.getAttribute("id");
		}catch(Exception e){

		}
		if(id != null){
			User user = new User().find(id);
			role = user.getRole();
			borrow = user.getBorrow();
		}
		if(role != 0){
			response.sendRedirect("index.jsp");
		}
		else if(role == 0){
			// Staff
			%>
			<%-- Header Area --%>

			<div id="header">
				<a href="index.jsp">
					<div id="logo">
						<img src="img/logo_binus.png">
					</div>
				</a>
				<div id="title">
					Binus Library
				</div>
				<button id="btnLogout" onclick="location.href='controller/val_logout.jsp'">
					<div id="btnLogoutContainer">
						Logout
					</div>
				</button>
				<button id="btnProfile" onclick="location.href='profile.jsp'">
					<div id="btnProfileContainer">
						Profile
					</div>
				</button>
				<button id="btnHome" onclick="location.href='index.jsp'">
					<div id="btnHomeContainer">
						Home
					</div>
				</button>
			</div>


			<%-- Content Area --%>
			<%
			Vector<Fine>fineList = new Fine().get();
			Integer sz = fineList.size();
			%>
			<div class="content">
				<div id="contentHeader">
					<div id="contentHeaderTitle">
						Fine List
					</div>
				</div>
				<%
				if(sz>0){
					%>
					<div id="bookTable">
						<div id="tableHeaderRow">
							<div>
								No.
							</div>
							<div>
								Transaction Date
							</div>
							<div>
								User Name
							</div>
							<div>
								Action
							</div>
						</div>
						<%
							cnt = 0;
							for(int i=sz-1;i>=0;i--){
								Fine fine = fineList.elementAt(i);
								cnt += 1;
								User user = new User().find(fine.getUserId());
								%>
								<div class="grid_row">
									<div>
										<%=cnt%>
									</div>
									<div>
										<%=fine.getDate()%>
									</div>
									<div>
										<%=user.getName()%>
									</div>
									<div>
										<%
										if(fine.getStatus() == 0){
										%>
											<button class="btnPaid" onclick="location.href='controller/val_paidFine.jsp?id=<%=fine.getId()%>'">Paid</button>
										<%
										}
										%>
									</div>
									</div>
								<%
							}
						%>
					</div>
				<%
				}
			%>
			</div>
			<%
		}
	%>
	
</body>
<script type="text/javascript">
	var code = document.getElementById("code").value;
	if(code == 'paidSuccess'){
		alert("Payment Success");
	}
</script>
</html>