<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:include page="main/publicNavigations.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Login</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">

</head>

<style>
.css {
	padding-top: 120px;
}

.center {
	padding-top: 60px;
	padding-bottom: 45px;
}
</style>
<body>
	<script type="text/javascript">
		window.params = function() {
			var params = {};
			var param_array = window.location.href.split('?')[1].split('&');
			for ( var i in param_array) {
				x = param_array[i].split('=');
				params[x[0]] = x[1];
			}
			return params;
		}();
		window.onload = function() {

			if (window.params.IsSuccess == "false") {
				document.getElementById("result").innerHTML = "<b>Invalid Login Info. Please try again</b><br>";

				document.getElementById("result").style.color = "red";

				//alert();

			}
		}
	</script>

	<div class="css">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<div class="panel panel-warning">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-lock"></i> Please enter your login details.
							</h3>
						</div>
						<div class="panel-body">
							<form action="loginServlet" method="post" class="form-horizontal"
								role="form" onsubmit="return validLogin();">

								<div class="form-group">
									<label for="inputEmail"
										class="col-sm-2 col-sm-offset-1 control-label">Email</label>
									<div class="col-sm-8">
										<input type="email" class="form-control" name="inputEmail"
											id="username" placeholder="Email"
											data-error="Please enter your email" required>
									</div>
								</div>
								<div class="form-group">
									<label for="inputPassword"
										class="col-sm-2 col-sm-offset-1 control-label">Password</label>
									<div class="col-sm-8">
										<input type="password" class="form-control"
											name="inputPassword" placeholder="Password" id="pass"
											data-error="Please enter your password" required>
									</div>
								</div>
								<%-- 			<p  style="color:red;"><b>${error }</b><p>
								<p id="result"></p> --%>

							<%
							if (request.getAttribute("Error") != null) {
						%>
					<p style="color: red">
							<b>
							<%=(String) request.getAttribute("Error")%></b></p>
						<%
							}
						%>
						


								<div class="form-group">
									<label class="col-sm-0 control-label"></label>
									<div class="col-sm-7">
					
											<a href="passwordForgot.jsp">Forgot your password?</a> 
					
									</div>
									<div class="col-sm-4">
										<input type="checkbox" name="inputRemember" id="remember_me">
										Remember me
									</div>
								</div>

								<div class="text-right">
									<button type="submit" class="btn btn-warning">
										<i class="fa fa-key"></i> Log In
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">Register</h3>
						</div>


						<div class="center">
							<div class="panel-body" style="text-align: center">
								<label for="login-email" class="control-label"> Don't
									have an account yet? Sign up with us now!</label> <br /> <br /> <a
									class="btn btn-info" href="register.jsp"> Register Here
									&raquo; </a>
							</div>
						</div>
						<br />
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- <Fixed footer> -->
	<nav id="footerMenu"></nav>
	<!-- End <Fixed footer> -->
	<script src="js/footer.js"></script>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>

	<script>
		$(function() {

			if (localStorage.chkbx && localStorage.chkbx != '') {
				$('#remember_me').attr('checked', 'checked');
				$('#username').val(localStorage.usrname);
				$('#pass').val(localStorage.pass);
			} else {
				$('#remember_me').removeAttr('checked');
				$('#username').val('');
				$('#pass').val('');
			}

			$('#remember_me').click(function() {

				if ($('#remember_me').is(':checked')) {
					// save username and password
					localStorage.usrname = $('#username').val();
					localStorage.pass = $('#pass').val();
					localStorage.chkbx = $('#remember_me').val();
				} else {
					localStorage.usrname = '';
					localStorage.pass = '';
					localStorage.chkbx = '';
				}
			});
		});

		function validLogin() {
			if (document.form.inputEmail.value == "") {
				alert("Please enter Login Name.");
				document.loginform.inputEmail.focus();
				return false;
			}
			if (document.form.inputPassword.value == "") {
				alert("Please enter password.");
				document.userform.inputPassword.focus();
				return false;
			}
			alert("Welcome User");
			return true;
		}
	</script>


</body>
</html>