<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/login.css"/>
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
		<button id="btnRegister" onclick="location.href='register.jsp'">
			<div id="btnRegisterContainer">
				Register
			</div>
		</button>
	</div>
	<form action="controller/val_login.jsp" method="post">
		<div id="formContainer">
			<div id="formTitle">
				Login
			</div>
			<div class="formRow">
				<div class="formLabel">
					Email
				</div>
				<div class="formFill">
					<input type="text" placeholder="Your Email" name="email">
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
				<button id="btnLogin">Login</button>
				<button id="btnCancel" formaction="index.jsp">Cancel</button>
			</div>
		</div>
	</form>
</body>
<script>
	var code = document.getElementById("code").value;
	if(code == 'emptyEmail'){
		alert("Email should be filled");
	}
	else if(code == 'emptyPassword'){
		alert("Password should be filled");
	}
	else if(code =='invalidPassword'){
		alert("Wrong Password");
	}
	else if(code == 'userNotExists'){
		alert("User Not Exists! Please Register First!");
	}
	else if(code == 'registrationComplete'){
		alert("Registration Complete! Please Login First!");
	}
</script>
</html>