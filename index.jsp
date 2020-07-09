<%@ include file="connector/Connect.jsp" %>
<%@include file="model/User.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="style/index.css"/>
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
			Integer id;
			String email = "";
			String name = "";
			Integer role = -1;
			try{
				id = (Integer) session.getAttribute("id");
			}catch(Exception e){
				id = -1;
			}
			if(id != null){
				User user = new User().find(id);
				email = user.getEmail();
				name = user.getName();
				role = user.getRole();
			}
			if(role == -1){
				%>

				<%-- Header Area --%>

				<div id="header">
					<div id="logo">
						<img src="img/logo_binus.png">
					</div>
					<div id="title">
						Binus Library
					</div>
					<button id="btnRegister" onclick="location.href='register.jsp'">
						<div id="btnRegisterContainer">
							Register
						</div>
					</button>
					<button id="btnLogin" onclick="location.href='login.jsp'">
						<div id="btnLoginContainer">
							Login
						</div>
					</button>
				</div>
				<%
			}
			else if(role == 0){
				// Staff
				%>
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
					<button id="btnUser" onclick="location.href='userList.jsp'">
						<div id="btnUserContainer">
							User List
						</div>
					</button>
					<div id="profileName">
						Hi, <%=name%>
					</div>
				</div>
				<div class="content">
					<div id="contentHeader">
						<div id="contentHeaderTitle">
							Welcome Back, <%=name%> !
						</div>
					</div>
					<div class="contentContainer">
						<div class="contentTitle">
							Manage Books
						</div>
						<div class="contentDesc">
							You can add new books, update book's detail, and delete a book from database.
						</div>
						<button class="btnContent" onclick="location.href='manageBook.jsp'">
							Manage
						</button>
					</div>
					<div class="contentContainer">
						<div class="contentTitle">
							Manage Transactions
						</div>
						<div class="contentDesc">
							View all users transaction (borrow and return) history and pending transaction here. 
						</div>
						<button class="btnContent" onclick="location.href='manageTransaction.jsp'">
							Manage
						</button>
					</div>
					<div class="contentContainer">
						<div class="contentTitle">
							Manage Borrow
						</div>
						<div class="contentDesc">
							You can update Book Status that already returned by User. 
						</div>
						<button class="btnContent" onclick="location.href='manageBorrow.jsp'">
							Manage
						</button>
					</div>
					<div class="contentContainer">
						<div class="contentTitle">
							Manage Fine
						</div>
						<div class="contentDesc">
							View all Fine (due to late return) history from all of the users.
						</div>
						<button class="btnContent" onclick="location.href='manageFine.jsp'">
							Manage
						</button>
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
					<div id="profileName">
						Hi, <%=name%>
					</div>
				</div>
				<div class="content">
					<div id="contentHeader">
						<div id="contentHeaderTitle">
							Welcome Back, <%=name%> !
						</div>
						<div id="contentHeaderCaption">
							"[I] read books because I love them, not because I think I should read them." <br>
							- Simon Van Booy
						</div>
					</div>
					<hr>
					<div class="contentContainer">
						<div class="contentTitle">
							Find Your Book
						</div>
						<div class="contentDesc">
							Find your favorite book here. We have many books to fulfill your passion, <%=name%>.
						</div>
						<button class="btnContent" onclick="location.href='manageBook.jsp'">
							Find
						</button>
					</div>
					<div class="contentContainer">
						<div class="contentTitle">
							Transaction History
						</div>
						<div class="contentDesc">
							View your transaction history (Your borrow history and your borrowing request status). 
						</div>
						<button class="btnContent" onclick="location.href='manageTransaction.jsp'">
							View
						</button>
					</div>
				</div>
				<%
			}
		%>
		
	</body>
	<script>
	var code = document.getElementById("code").value;
	if(code == 'emptyName'){
		alert("Name should be filled");
	}
	else if(code == 'emptyEmail'){
		alert("Email should be filled");
	}
	else if(code == 'emptyPassword'){
		alert("Password should be filled");
	}
	else if(code == 'emptyConfirmPassword'){
		alert("Confirm Password should be filled");
	}
	else if(code =='invalidPassword'){
		alert("Password and Confirm Password is not equal");
	}
	else if(code == 'profileUpdated'){
		alert("Profile has been Updated");
	}
</script>
</html>