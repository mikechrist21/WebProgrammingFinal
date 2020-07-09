<%@ include file="connector/Connect.jsp" %>
<%@include file="model/User.jsp"%>
<%@include file="model/Book.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/manageBook.css"/>
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

			<div class="content">
				<div id="contentHeader">
					<div id="contentHeaderTitle">
						Manage Book
					</div>
					<button id="btnInsertBook" onclick="location.href='insertBook.jsp'">
						Insert New Book	
					</button>
				</div>
				<div id="bookTable">
					<div id="tableHeaderRow">
						<div>
							No.
						</div>
						<div>
							Book's Title
						</div>
						<div>
							Book Author
						</div>
						<div>
							Year
						</div>
						<div>
							Book Status
						</div>
						<div>
							Action
						</div>
					</div>
					<%
						Vector<Book>bookList = new Book().get();
						for(int i=0;i<bookList.size();i++){
							Book book = bookList.elementAt(i);
						%>
							<div class="grid_row">
								<div>
									<%=i+1%>
								</div>
								<div>
									<%=book.getTitle()%>
								</div>
								<div>
									<%=book.getAuthor()%>
								</div>
								<div>
									<%=book.getYear()%>
								</div>
								<div>
									<%
									if(book.getStatus() == 0){
										out.println("Available");
									}
									else{
										out.println("Borrowed");
									}
									%>
								</div>
								<div>
									<button class="btnUpdate" onclick="location.href='updateBook.jsp?id=<%=book.getId()%>'">Update</button>
									<button class="btnDelete" onclick="location.href='controller/val_deleteBook.jsp?id=<%=book.getId()%>'">Delete</button>
								</div>
							</div>
						<%
						}
						%>
				</div>
			</div>
			<%
		}
		else if(role == 1){
			// User
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

			<div class="content">
				<div id="contentHeader">
					<div id="contentHeaderTitle">
						Manage Book
					</div>
				</div>
				<div id="bookTable">
					<div id="tableHeaderRow">
						<div>
							No.
						</div>
						<div>
							Book's Title
						</div>
						<div>
							Book Author
						</div>
						<div>
							Year
						</div>
						<div>
							Book Status
						</div>
						<div>
							Action
						</div>
					</div>
					<%
						Vector<Book>bookList = new Book().get();
						for(int i=0;i<bookList.size();i++){
							Book book = bookList.elementAt(i);
						%>
							<div class="grid_row">
								<div>
									<%=i+1%>
								</div>
								<div>
									<%=book.getTitle()%>
								</div>
								<div>
									<%=book.getAuthor()%>
								</div>
								<div>
									<%=book.getYear()%>
								</div>
								<div>
									<%
									if(book.getStatus() == 0){
										out.println("Available");
									}
									else{
										out.println("Borrowed");
									}
									%>
								</div>
								<div>
									<%
										if(borrow == 1 || book.getStatus() == 1){
											%>
												<button class="btnBorrowDisabled" disabled>Borrow</button>
											<%
										}
										else{
										%>
											<button class="btnBorrow" onclick="location.href='controller/val_borrowBook.jsp?id=<%=book.getId()%>'">Borrow</button>
										<%
										}
									%>
								</div>
							</div>
						<%
						}
					%>
				</div>
			</div>
		<%
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
	else if(code == 'borrowSuccess'){
		alert("Borrow Book Success");
	}
</script>
</html>