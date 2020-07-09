<%@ include file="connector/Connect.jsp" %>
<%@include file="model/User.jsp"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/userList.css"/>
	<title>Binus Library</title>
</head>
<body>
	<%
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

			
			<div class="content">
				<div id="userTable">
					<div id="tableHeaderRow">
						<div class="colNumber">
							No.
						</div>
						<div class="colName">
							Name
						</div>
						<div class="colEmail">
							Email
						</div>
						<div class="colRole">
							Role
						</div>
					</div>
					<%
						Vector<User>userList = new User().get();
						for(int i=0;i<userList.size();i++){
							User user = userList.elementAt(i);
						%>
							<div class="tableRow">
								<div class="colNumber">
									<%=i+1%>
								</div>
								<div class="colName">
									<%=user.getName()%>
								</div>
								<div class="colEmail">
									<%=user.getEmail()%>
								</div>
								<div class="colRole">
									<%
										if(user.getRole() == 0){
											out.println("Staff");
										}
										else{
										out.println("User");
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
</html>