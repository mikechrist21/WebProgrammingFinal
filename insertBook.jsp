<%@ include file="connector/Connect.jsp" %>
<%@include file="model/User.jsp"%>
<%@include file="model/Book.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/insertBook.css"/>
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
		try{
			id = (Integer) session.getAttribute("id");
		}catch(Exception e){

		}
		if(id != null){
			User user = new User().find(id);
			role = user.getRole();
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
			<form action="controller/val_insertBook.jsp" method="post">
				<div id="formContainer">
					<div id="formTitle">
						Insert New Book
					</div>
					<div class="formRow">
						<div class="formLabel">
							Book Name
						</div>
						<div class="formFill">
							<input type="text" placeholder="Book Name" name="bookName">
						</div>
					</div>
					<div class="formRow">
						<div class="formLabel">
							Book Author
						</div>
						<div class="formFill">
							<input type="text" placeholder="Book Author" name="bookAuthor">
						</div>
					</div>
					
					<div class="formRow">
						<div class="formLabel">
							Book Year
						</div>
						<div class="formFill">
							<input type="number" placeholder="Book Year" name="bookYear">
						</div>
					</div>
					<div class="formRow">
						<button id="btnInsert">Insert</button>
						<button id="btnCancel" formaction="manageBook.jsp">Cancel</button>
					</div>
				</div>
			</form>
			<%
		}
	%>

	
</body>
<script>
	var code = document.getElementById("code").value;
	if(code == 'emptyName'){
		alert("Book Name should be filled");
	}
	else if(code == 'emptyAuthor'){
		alert("Book Author should be filled");
	}
	else if(code == 'emptyYear'){
		alert("Book Year should be filled");
	}
	else if(code == 'bookExists'){
		alert("Book has been registered. Please input different title");
	}
</script>
</html>