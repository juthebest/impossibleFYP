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


<!-- for validation of the form email address -->
<!-- <script>
	function ValidateEmail(mail) {
		var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(mail);
	}
</script> -->
<!-- end of validation for form -->

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
											placeholder="email address" name="email"
											title="Enter a valid email address" required>
									</div>
								</div>
							</div>


							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Password:</label>
									<div class="col-sm-4">

										<input type="password" class="form-control" id="course_price"
											name="password" pattern=".{6,}"
											title="Password must
											contain at least six characters, including
											uppercase, lowercase letters and numbers" placeholder="password"
											required>
									</div>
								</div>
							</div>

<!-- 							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Re-enter
										Password:</label>
									<div class="col-sm-4">
										<input type="password" class="form-control" id="course_price"
											placeholder="password" pattern=".{6,}"
											title="Password must
											contain at least six characters, including
											uppercase, lowercase letters and numbers"
											required>
									</div>
								</div>
							</div> -->
<!-- 
							<script language='javascript' type='text/javascript'>
							function check(input){
								if (input.value != document.getElementById('password').value){
									input.setCustomValidity('Password must be matching');	
								}
							
							else{
/* 								input is valid reset the error message
 */								input.setCustomValidity('');
							}
							}
							</script> -->
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
											placeholder="email address" name="email1"
											title="Enter a valid email address" required>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Password:</label>
									<div class="col-sm-4">
										<input type="password" class="form-control" id="course_price"
											placeholder="password" name="password1" pattern=".{6,}"
											title="Password must contain at least six characters, including
											uppercase, lowercase letters and numbers"
											required>
										<!-- 											;< if (this.checkValidation() form.password_confirm.pattern = this.value;"
 -->
									</div>
								</div>
							</div>

<!-- 							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Confirm
										Password:</label>
									<div class="col-sm-4">
										<input name="password_confirm" type="password"
											class="form-control" id="password_confirm"
											placeholder="password" oninput="checkas(this)" required>
									</div>
								</div>
							</div>

							<script language='javascript' type='text/javascript'>
							function checkas(input){
								if (input.value != document.getElementById('password1').value){
									input.setCustomValidity('Password must be matching');	
								}
							
							else{
/* 								input is valid reset the error message
 */								input.setCustomValidity('');
							}
							}
							</script> -->

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
										.write('<input type="hidden" value="'+window.params.postal_code1 +'" name="postal_code1">')
							;
							</script>
						</fieldset>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-md-12" style='text-align: right'>
				<input type="submit" class="btn btn-primary" value="Submit">
				<a class="btn btn-danger" href="register.jsp">Back</a>
			</div>
		</div>
	</form>


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