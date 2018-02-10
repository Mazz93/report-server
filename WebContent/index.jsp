<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Member Login</title>
<!-- CORE CSS-->

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css">
<link rel="shortcut icon" href="Image/title_icon.ico" />
<style type="text/css">
html, body {
	height: 100%;
	background: url("Image/background.jpg") no-repeat;
	background-position: center;
	background-color: e8e8e8;

}

html {
	display: table;
	margin: auto;
}

body {	
	display: table-cell;
	vertical-align: middle;
}

.margin {
	margin: 0 !important;
}
</style>

</head>

<body>
	<FORM ACTION="LoginServlet" METHOD="POST">

		<div id="login-page" class="row">
			<div class="col s12 z-depth-6 card-panel"
				style=" box-shadow: 0 4px 8px 0 rgba(1,1,1,1);">
				<form class="login-form">
					<div class="row">
						 <div class="input-field col s12 center">
							<img src="Image/logo3.png" alt=""
								class="responsive-img valign profile-image-login">

						</div> 
					</div>
					<div class="row margin">
						<div class="input-field col s12">
							<i class="mdi-social-person-outline prefix"></i> 
                            <input class="validate" placeholder="Username" name="empcode" type="text" required> 
                            <label for="empcode" data-error="wrong" data-success="right" class="center-align"></label>
						</div>
					</div>
					<div class="row margin">
						<div class="input-field col s12">
							<i class="mdi-action-lock-outline prefix"></i> <input
								name="password" type="password" required placeholder="Password">
							<label for="password"></label>
						</div>
					</div>

					<div class="row">
						<div class="input-field col s12">
							<INPUT TYPE="SUBMIT" value="Login"
								class="btn waves-effect waves-light col s12" style="background-color: #0080ff;">
						</div>
					</div>
					<%
						if (session.getAttribute("log_error") != null) {
					%>
					<h6
						style="color: red; text-align: center; font-weight: bold; margin-bottom: 10px"><%=session.getAttribute("log_error")%></h6>
					<%
						session.removeAttribute("log_error");
						}
					%>
				</form>
			</div>
		</div>
</body>

</html>