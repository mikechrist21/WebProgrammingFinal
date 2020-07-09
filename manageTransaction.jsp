<%@ include file="connector/Connect.jsp" %>
<%@include file="model/User.jsp"%>
<%@include file="model/Book.jsp"%>
<%@include file="model/Transaction.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/manageTransaction.css"/>
	<title>Binus Library</title>
</head>
<body>
	<%
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
		if(role == -1){
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
			Vector<Transaction>trxList = new Transaction().get();
			Integer sz = trxList.size();
			Integer cnt = 0;
			Boolean pending = false;
			Boolean flag = false;
			for(int i=0;i<sz;i++){
				Transaction trx = trxList.elementAt(i);
				if(trx.getStatus() == 2){
					pending = true;
					break;
				}
			}
			for(int i=0;i<sz;i++){
				Transaction trx = trxList.elementAt(i);
				if(trx.getStatus() < 2){
					flag = true;
					break;
				}
			}
			if(pending){
				%>
				<div class="content">
					<div id="contentHeader">
						<div id="contentHeaderTitle">
							Pending Transaction
						</div>
					</div>
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
								Book Name
							</div>
							<div>
								Action
							</div>
						</div>
						<%
							cnt = 0;
							for(int i=sz-1;i>=0;i--){
								Transaction trx = trxList.elementAt(i);
								if(trx.getStatus() == 2){
									cnt += 1;
									User user = new User().find(trx.getUserId());
									Book book = new Book().find(trx.getBookId());
									%>
									<div class="grid_row">
										<div>
											<%=cnt%>
										</div>
										<div>
											<%=trx.getTrxDate()%>
										</div>
										<div>
											<%=user.getName()%>
										</div>
										<div>
											<%=book.getTitle()%>
										</div>
										<div>
											<button class="btnApprove" onclick="location.href='controller/val_approveBorrow.jsp?id=<%=trx.getId()%>'">Approve</button>
										</div>
									</div>
								<%
								}
							}
						%>
					</div>
				</div>
				<%
			}
			if(flag){
				%>
				<div class="content">
					<div id="contentHeader">
						<div id="contentHeaderTitle">
							Transaction
						</div>
					</div>
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
								Book Name
							</div>
							<div>
								Book Status
							</div>
						</div>
						<%
							cnt = 0;
							for(int i=sz-1;i>=0;i--){
								Transaction trx = trxList.elementAt(i);
								if(trx.getStatus() < 2){
									cnt += 1;
									User user = new User().find(trx.getUserId());
									Book book = new Book().find(trx.getBookId());
									%>
									<div class="grid_row">
										<div>
											<%=cnt%>
										</div>
										<div>
											<%=trx.getTrxDate()%>
										</div>
										<div>
											<%=user.getName()%>
										</div>
										<div>
											<%=book.getTitle()%>
										</div>
										<div>
											<%
											if(trx.getStatus() == 0){
												out.println("Returned");
											}
											else if(trx.getStatus() == 1){
												out.println("Borrowed");
											}
											%>
										</div>
									</div>
								<%
								}
							}
						%>
					</div>
				</div>
				<%
			}
		}
		else if(role == 1){
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
			Vector<Transaction>trxList = new Transaction().get();
			Integer sz = trxList.size();
			Integer cnt = 0;
			if(sz>0){
				%>
				<div class="content">
					<div id="contentHeader">
						<div id="contentHeaderTitle">
							Transaction
						</div>
					</div>
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
								Book Name
							</div>
							<div>
								Book Status
							</div>
						</div>
						<%
							cnt = 0;
							for(int i=sz-1;i>=0;i--){
								Transaction trx = trxList.elementAt(i);
								if(trx.getUserId() == id){
									cnt += 1;
									User user = new User().find(trx.getUserId());
									Book book = new Book().find(trx.getBookId());
									%>
									<div class="grid_row">
										<div>
											<%=cnt%>
										</div>
										<div>
											<%=trx.getTrxDate()%>
										</div>
										<div>
											<%=user.getName()%>
										</div>
										<div>
											<%=book.getTitle()%>
										</div>
										<div>
											<%
											if(trx.getStatus() == 0){
												out.println("Returned");
											}
											else if(trx.getStatus() == 1){
												out.println("Borrowed");
											}
											else{
												out.println("Pending");
											}
											%>
										</div>
									</div>
								<%
								}
							}
						%>
					</div>
				</div>
				<%
			}
		}
	%>
	
</body>
<script type="text/javascript">
	var code = document.getElementById("code").value;
	if(code == 'insertSuccess'){
		alert("Insert New Book Success");
	}
	else if(code == 'updateSuccess'){
		alert("Update Book Success");
	}
	else if(code == 'deleteSuccess'){
		alert("Delete Book Success");
	}
</script>
</html>