<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />


<sql:query var="adminUser" dataSource="${dataSource}">
SELECT `user_id`, `coach_id`, `client_id`, `parent_id`, `email`, `password`, `surname`, `given_name`, `mobile`, `role`, `create_update_datetime`, `salutation`, `address`, `userStatus_id` FROM `user` WHERE role="admin" AND user_id=<%=request.getParameter("adminID")%>


</sql:query>

<%
	//allow access only if session exists
	String user = null;

	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| session.getAttribute("role") != "admin") {
		response.sendRedirect("login.jsp");
	} else
		user = (String) session.getAttribute("name");
	String userName = null;
	String sessionID = null;
	String userrole = null;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("name"))
				userName = cookie.getValue();
			if (cookie.getName().equals("JSESSIONID"))
				sessionID = cookie.getValue();
			if (cookie.getName().equals("role"))
				userrole = cookie.getValue();
		}
	} else {
		sessionID = session.getId();
	}

	/* no session validation logic in the above JSP. It contains link to another JSP page,  */
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Edit Admin User</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">
<script src="ckeditor/ckeditor.js"></script>
</head>
<body>



	<div class="container">


		<div id="content">
			<div class="page-header">
				<div class="container-fluid">

					<h1>Adminstrator</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="manageAdminUser.jsp">Manage Admin User</a></li>
					</ul>
				</div>
			</div>
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Edit Adminstrator
						</h3>
					</div>
					<div class="panel-body">
						<c:forEach var="adminU" items="${adminUser.rows}">

							<form class="form-horizontal" data-toggle="validator" role="form"
								method="post" action="editAdminUser">
<input type="hidden" name="rdate" value="${adminU.create_update_datetime}" />	
								<input type="hidden" name="adminid" value="${adminU.user_id}" />
								<input type="hidden" name="role" value="${adminU.role} " /> <input
									type="hidden" name="userStatus"
									value="${adminU.userStatus_id} " />
								<div class="form-group">
									<label class="col-sm-2 control-label" for="admin">Salutation:</label>
									<div class="col-sm-10">

										<select class="form-control" id="salutation_input"
											name="salutation">
											<option value="${adminU.salutation}">${adminU.salutation}</option>
											<option value="Mr">Mr</option>
											<option value="Mrs">Mrs</option>
											<option value="Ms">Ms</option>
											<option value="Mdm">Mdm</option>

										</select>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="sName">Surname</label>
									<div class="col-sm-10">
										<input class="form-control" type="text" name="sName"
											value="${adminU.surname}" pattern="[a-zA-Z]{2,}" title="Minimum 2 letters"  required>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="gName">Given
										Name:</label>
									<div class="col-sm-10">
										<input class="form-control" type="text" name="gName"
											value="${adminU.given_name}" pattern="[a-zA-Z]{5,}" title="Minimum 4 letters"  required>
									</div>
								</div>


								<div class="form-group">
									<label class="col-sm-2 control-label" for="aEmail">Admin
										Email:</label>
									<div class="col-sm-10">
										<input class="form-control" type="email" name="aEmail"
											value="${adminU.email}" required>

									</div>
								</div>


								<div class="form-group">
									<label class="col-sm-2 control-label" for="aPassword">Admin
										Password:</label>
									<div class="col-sm-10">
										<input class="form-control" type="password" name="aPassword"
											placeholder="Password" value="${adminU.password}"  pattern='^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$'
										title="Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:" required>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="aMobile">Mobile:</label>
									<div class="col-sm-10">
										<input class="form-control" type="tel" pattern='^[89]\d{7}$' title="Must start with 8/9 and 8 digits"
											class="form-control" name="aMobile" value="${adminU.mobile}"
											required>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="aAddress">Address</label>
									<div class="col-sm-10">
										<input class="form-control" type="text" name="aAddress"
											value="${adminU.address}" pattern='(\d{1,3}.)?.+\s(\d{6})$'
										title="Please enter BLK/STREET/unit/postal code" required>
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
											.write('<input type="hidden" value="'+window.params.catid +'" name="catid">');
								</script>


								<div class="form-actions">

									<button type="submit" class="btn btn-primary">Save
										changes</button>
									<a href="manageAdminUser.jsp"><button type="button"
											class="btn btn-danger">Cancel</button></a>

								</div>
							</form>

						</c:forEach>
					</div>
				</div>

			</div>
		</div>
	</div>


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
	<script>
	
	var validations ={
		    email: [/^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/, 'Please enter a valid email address']
		};
		$(document).ready(function(){
		    // Check all the input fields of type email. This function will handle all the email addresses validations
		    $("input[type=email]").change( function(){
		        // Set the regular expression to validate the email 
		        validation = new RegExp(validations['email'][0]);
		        // validate the email value against the regular expression
		        if (!validation.test(this.value)){
		            // If the validation fails then we show the custom error message
		            this.setCustomValidity(validations['email'][1]);
		            return false;
		        } else {
		            // This is really important. If the validation is successful you need to reset the custom error message
		            this.setCustomValidity('');
		        }
		    });
		})
	</script>

</body>
</html>