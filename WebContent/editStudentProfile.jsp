<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/userNavigation.jsp"></jsp:include>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />
<%
	//allow access only if session exists
	String user = null;

	String role = (String) session.getAttribute("role");
	String uid = null;
	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| !role.equalsIgnoreCase("child")) {
		response.sendRedirect("login.jsp");
	} else
		user = (String) session.getAttribute("name");
	uid = (String) session.getAttribute("uid");
	String userName = null;
	String sessionID = null;
	String userrole = null;
	String userID = null;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("name"))
				userName = cookie.getValue();
			if (cookie.getName().equals("JSESSIONID"))
				sessionID = cookie.getValue();
			if (cookie.getName().equals("role"))
				userrole = cookie.getValue();
			if (cookie.getName().equals("id"))
				userID = cookie.getValue();
		}
	} else {
		sessionID = session.getId();
	}

	/* no session validation logic in the above JSP. It contains link to another JSP page,  */
%>

<sql:query var="userprofile" dataSource="${dataSource}">
SELECT * 
FROM  user where user_id= <%=uid%>;
</sql:query>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Edit User Profile</title>
<link rel="stylesheet" type="text/css" href="css/flaticon.css">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet">

<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/jquery-ui.min.css" rel="stylesheet">
<script src="http://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="http://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css"
	rel="stylesheet"></link>
<link rel="stylesheet" type="text/css" href="css/home.css" />
</head>

<body>
	<div class="container">
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li><a href="user.jsp">Home</a></li>
				<li><a href="userProfile.jsp">Profile</a></li>
				<li class="active">Edit User Profile</li>
			</ol>
		</div>
	</div>

	<br />
	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<h4>
					<b>User Information</b>
				</h4>
				<hr />
				<div class="panel panel-default">
					<div class="panel-body">

						<c:forEach var="studentdetails" items="${userprofile.rows}">
							<form action="editStudentProfile" method="post"
								class="form-horizontal">

								<input type="hidden" name="userid"
									value="${studentdetails.user_id}" /> <input type="hidden"
									name="role" value="${studentdetails.role}" /> <input
									type="hidden" name="rdate"
									value="${studentdetails.create_update_datetime}" /> <input
									type="hidden" name="userStatus"
									value="${studentdetails.userStatus_id}" />

								<div class="form-group">
									<label class="col-sm-2 control-label" for="coach">Salutation:</label>
									<div class="col-sm-9">

										<select class="form-control" id="salutation_input"
											name="salutation">
											<option value="${studentdetails.salutation}">${studentdetails.salutation}</option>
											<option value="Mr">Mr</option>
											<option value="Mrs">Mrs</option>
											<option value="Ms">Ms</option>
											<option value="Mdm">Mdm</option>

										</select>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="studentsname">Surname:</label>
									<div class="col-sm-10">
										<input type="text" name="studentsname" class="form-control"
											value="${studentdetails.surname}" pattern="[A-Za-z]{2,}"
											title="Minimum 2 characters required.
											Only Alphabets are being accepted."
											required />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="gname">Given
										Name:</label>
									<div class="col-sm-10">
										<input type="text" name="gname" class="form-control"
											value="${studentdetails.given_name}" pattern="[A-Za-z]{3,}"
											title="Minimum 3 characters required.
											Only Alphabets are being accepted."
											required />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="smobile">Contact
										Number:</label>
									<div class="col-sm-10">
										<input type="text" name="smobile" class="form-control"
											value="${studentdetails.mobile}" pattern="\d{8}" required
											title="Please enter a valid phone number with 8 digits"
											required />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="parentaddress">Address:</label>
									<div class="col-sm-10">
										<input type="text" name="saddress" class="form-control"
											value="${studentdetails.address}" required />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="parentemail">E-Mail:</label>
									<div class="col-sm-10">
										<input type="email" name="semail" class="form-control"
											value="${studentdetails.email}"
											pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"
											title="Enter a valid email address" required />
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-2" for="uPassword">Password:</label>
									<div class="col-sm-9">
										<input class="form-control" type="password" name="uPassword" id = "uPassword"
											value="${studentdetails.password}"
											pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
											title="Password must contain at least six characters, including uppercase, lowercase letters and numbers
											OR Password do not match with Confirm password"
											required>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-2" for="cPassword">Confirm
										Password:</label>
									<div class="col-sm-9">
										<input class="form-control" type="password" name="cPassword" id = "cPassword"
											required>
									</div>
								</div>

								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Submit</button>
									<a href="userProfile.jsp"><button type="button"
											class="btn btn-danger">Cancel</button></a>
								</div>

							</form>
						</c:forEach>

					</div>
				</div>

			</div>
		</div>
	</div>


	<script>
		(function Validate() {
			var passwordparent1 = document.getElementById('uPassword');
			var passwordparent2 = document.getElementById('cPassword');

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
	
	
	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/footer.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>

	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>