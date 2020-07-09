<%@ include file="connector/Connect.jsp" %>
<%@include file="model/User.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="style/profile.css"/>
		<title>Binus Library</title>
	</head>
	<body>
		<%
			Integer id = null;
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
				response.sendRedirect("index.jsp");
			}
			else {
				// Staff & User
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
					<button id="btnHome" onclick="location.href='index.jsp'">
						<div id="btnProfileContainer">
							Home
						</div>
					</button>
				</div>
				<div class="content">
					<form action="controller/val_updateprofile.jsp" method="post">
						<div id="formContainer">
							<div id="formTitle">
								Profile
							</div>
							<div class="formRow">
								<div class="formLabel">
									Name
								</div>
								<div class="formFill">
									<input type="text" placeholder="Your Name" name="name" value="<%=name%>">
								</div>
							</div>
							<div class="formRow">
								<div class="formLabel">
									Email
								</div>
								<div class="formFill">
									<input type="text" placeholder="Your Email" name="email" value="<%=email%>">
								</div>
							</div>
							
							<div class="formRow">
								<div class="formLabel">
									Password
								</div>
								<div class="formFill">
									<input type="password" placeholder="Your Password" name="password">
								</div>
							</div>
							<div class="formRow">
								<div class="formLabel">
									Confirm Password
								</div>
								<div class="formFill">
									<input type="password" placeholder="Confirm Password" name="confirmPassword">
								</div>
							</div>
							<div class="formRow">
								<button id="btnUpdate">Update</button>
								<button id="btnCancel" formaction="index.jsp">Cancel</button>
							</div>
						</div>
					</form>
				</div>
				<%
			}
		%>
		
	</body>
</html>