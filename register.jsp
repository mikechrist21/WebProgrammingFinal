<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/register.css"/>
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
		<button id="btnLogin" onclick="location.href='login.jsp'">
			<div id="btnLoginContainer">
				Login
			</div>
		</button>
	</div>
	<form action="controller/val_register.jsp" method="post">
		<div id="formContainer">
			<div id="formTitle">
				Register
			</div>
			<div class="formRow">
				<div class="formLabel">
					Name
				</div>
				<div class="formFill">
					<input type="text" placeholder="Your Name" name="name">
				</div>
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
				<div class="formLabel">
					Confirm Password
				</div>
				<div class="formFill">
					<input type="password" placeholder="Confirm Password" name="confirmPassword">
				</div>
			</div>
			<div class="formRow">
				<button id="btnRegister">Register</button>
				<button id="btnCancel" formaction="index.jsp">Cancel</button>
			</div>
		</div>
	</form>
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
	else if(code == 'userExists'){
		alert("Email has been registered. Please input different Email");
	}
</script>
</html>