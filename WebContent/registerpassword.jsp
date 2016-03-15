<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/publicNavigations.jsp"></jsp:include>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Register Password</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- for filter bar -->
<link rel="stylesheet" type="text/css" href="css/flaticon.css">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/jquery-ui.min.css" rel="stylesheet">
<script src="http://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="http://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css"
	rel="stylesheet"></link>
<link rel="stylesheet" type="text/css" href="css/home.css" />



<style>
.filter-col {
	padding-left: 10px;
	padding-right: 10px;
}

.testing {
	margin-bottom: 100px;
}
</style>

<body>

	<form class="form-horizontal" method="post" name="myForm"
		action="registerservlet" onsubmit="return ValidateEmail(mail)">
		<div class="container">
			<div class="container-fluid">
				<div class="registrationpanel">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">Registration Page</h3>
						</div>

						<fieldset style="padding-left: 10px">
							<h3>Password for Parent</h3>
							<div class="row">
								<i>Please note that your email address will be your
									username.</i>
							</div>
							<br />

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Email Address:</label>
									<div class="col-sm-4">

										<input type="email" class="form-control" id="course_price"
											placeholder="email address" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"
											title="Enter a valid email address" required>
									</div>
								</div>
							</div>


							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="passwordparent">Password:</label>
									<div class="col-sm-4">
										<input type="password" class="form-control"
											id="passwordparent" name="passwordparent" placeholder="password"
											pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
											title="Password must contain at least six characters, including uppercase, lowercase letters and numbers
											OR Password do not match with Confirm password"
											required />
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="passwordparent1">Confirm
										Password:</label>
									<div class="col-sm-4">
										<input type="password" class="form-control"
											id="passwordparent1" placeholder="password" name="passwordparent"
											required />
									</div>
								</div>
							</div>


							<br>

							<hr />
							<h3>Password for Child</h3>
							<div class="row">
								<i>Please note that your email address will be your
									username. </i>
							</div>
							<br />
							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Email Address:</label>
									<div class="col-sm-4">
										<input type="email" class="form-control" id="course_price"
											placeholder="email address" name="email1" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"
											title="Enter a valid email address" required>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="passwordchild">Password:</label>
									<div class="col-sm-4">
										<input type="password" class="form-control" id="passwordchild"
											placeholder="password" name="passwordchild" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
											title="Password must contain at least six characters, including uppercase, lowercase letters and numbers
											OR Password do not match with Confirm password"
											required>

									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="passwordchild1">Confirm Password:</label>
									<div class="col-sm-4">
										<input type="password" class="form-control"
											id="passwordchild1" placeholder=confirmpassword name="passwordchild"
											pattern=".{6,}"
											title="Password must contain at least six characters, including
											uppercase, lowercase letters and numbers"
											required>

									</div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-12" style='text-align: right'>
									<input type="submit" class="btn btn-primary" value="Submit" onclick="return Validate()">
									<a class="btn btn-danger" href="register.jsp">Back</a>
								</div>
							</div>

							<script type="text/javascript">
								window.params = function() {
									var params = {};
									var param_array = window.location.href
											.split('?')[1].split('&');
									for ( var i in param_array) {
										x = param_array[i].split('=');
										params[x[0]] = x[1];
									}
									return params;
								}();

								document
										.write('<input type="hidden" value="'+window.params.salutation +'" name="salutation">');
								document
										.write('<input type="hidden" value="'+window.params.sname +'" name="sname">');
								document
										.write('<input type="hidden" value="'+window.params.gname +'" name="gname">');
								document
										.write('<input type="hidden" value="'+window.params.gender +'" name="gender">');
								document
										.write('<input type="hidden" value="'+window.params.country +'" name="country">');
								document
										.write('<input type="hidden" value="'+window.params.contact_number +'" name="contact_number">');
								document
										.write('<input type="hidden" value="'+window.params.sa +'" name="contact_number">');
								document
										.write('<input type="hidden" value="'+window.params.address +'" name="address">');
								document
										.write('<input type="hidden" value="'+window.params.postal_code +'" name="postal_code">');
								document
										.write('<input type="hidden" value="'+window.params.salutation1 +'" name="salutation1">');
								document
										.write('<input type="hidden" value="'+window.params.sname1 +'" name="sname1">');
								document
										.write('<input type="hidden" value="'+window.params.gname1 +'" name="gname1">');
								document
										.write('<input type="hidden" value="'+window.params.gender1 +'" name="gender1">');
								document
										.write('<input type="hidden" value="'+window.params.dob +'" name="dob">');
								document
										.write('<input type="hidden" value="'+window.params.relationship +'" name="relationship">');
								document
										.write('<input type="hidden" value="'+window.params.country1 +'" name="country1">');
								document
										.write('<input type="hidden" value="'+window.params.contact_number1 +'" name="contact_number1">');
								document
										.write('<input type="hidden" value="'+window.params.address1 +'" name="address1">');
								document
										.write('<input type="hidden" value="'+window.params.postal_code1 +'" name="postal_code1">');
							</script>

						</fieldset>
					</div>
				</div>
			</div>
		</div>

	</form>

	<script>
		(function Validate() {
			var passwordparent1 = document.getElementById('passwordparent');
			var passwordparent2 = document.getElementById('passwordparent1');

			var checkPasswordValidity = function() {
				if (passwordparent1.value != passwordparent2.value) {
					passwordparent1.setCustomValidity('Passwords must match.');
				} else {
					passwordparent1.setCustomValidity('');
				}
			};

			passwordparent1.addEventListener('change', checkPasswordValidity, false);
			passwordparent2.addEventListener('change', checkPasswordValidity, false);

			var form = document.getElementById('passwordForm');
			form.addEventListener('submit', function(event) {
				checkPasswordValidity();
				if (!this.checkValidity()) {
					event.preventDefault();
					//Implement you own means of displaying error messages to the user here.
					password1.focus();
				}
			}, false);
		}());
	</script>

<script>
		(function Validate() {
			var passwordchild = document.getElementById('password1');
			var passwordchild2 = document.getElementById('passwordchild1');

			var checkPasswordValidity = function() {
				if (passwordchild.value != passwordchild2.value) {
					passwordparent1.setCustomValidity('Passwords must match.');
				} else {
					passwordparent1.setCustomValidity('');
				}
			};

			passwordchild.addEventListener('change', checkPasswordValidity, false);
			passwordchild2.addEventListener('change', checkPasswordValidity, false);

			var form = document.getElementById('passwordForm');
			form.addEventListener('submit', function(event) {
				checkPasswordValidity();
				if (!this.checkValidity()) {
					event.preventDefault();
					//Implement you own means of displaying error messages to the user here.
					password1.focus();
				}
			}, false);
		}());
	</script>
	
	
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>

	<!-- footer -->
	<footer id="footerMenu"></footer>
	<!-- end of footer -->

	<script src="js/footer.js"></script>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>