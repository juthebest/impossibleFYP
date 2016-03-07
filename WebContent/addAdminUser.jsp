<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Add New Admin User</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">

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

</head>
<body>

	

	<div class="container">


		<div id="content">
			<div class="page-header">
				<div class="container-fluid">

					<h1>Administrator</h1>

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
							<i class="fa fa-pencil"></i> Add New Administrator
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" data-toggle="validator" role="form"
							method="post" name="myForm" action="addAdminUser">




							<div class="form-group">
								<label class="control-label col-sm-2" for="admin">Salutation:</label>
								<div class="col-sm-9">

									<select class="form-control" id="salutation_input"
										name="salutation">
										<option value="Mr">Mr</option>
										<option value="Mrs">Mrs</option>
										<option value="Ms">Ms</option>
										<option value="Mdm">Mdm</option>

									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="control-label col-sm-2" for="sName">Surname</label>
								<div class="col-sm-9">
									<input class="form-control" type="text" name="sName"
										placeholder="Name" pattern="[a-zA-Z]{2,}" title="Minimum 2 letters" required>
								</div>
							</div>

							<div class="form-group">
								<label class="control-label col-sm-2" for="gName">Given
									Name:</label>
								<div class="col-sm-9">
									<input class="form-control" type="text" name="gName"
										placeholder="Name" pattern="[a-zA-Z]{5,}" title="Minimum 4 letters" required>
								</div>
							</div>


							<div class="form-group">
								<label class="control-label col-sm-2" for="aEmail">Admin
									Email:</label>
								<div class="col-sm-9">
									<input class="form-control" type="email" name="aEmail"
										placeholder="Email" data-error="This email address is invalid" 
										required>
									<div class="help-block with-errors"></div>
								</div>
							</div>


							<div class="form-group">
								<label class="control-label col-sm-2" for="aPassword">Admin
									Password:</label>
								<div class="col-sm-9">
									<input class="form-control" type="password" name="aPassword"
										placeholder="Password"  pattern='^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$'
										title="Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:"  required>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="aMobile">Mobile:</label>
								<div class="col-sm-9">
									<input class="form-control" type="tel" pattern='^[89]\d{7}$'
										name="aMobile" placeholder="Mobile number" required>
								</div>
							</div>

							<div class="form-group">
								<label class="control-label col-sm-2" for="aAddress">Address</label>
								<div class="col-sm-9">
									<input class="form-control" type="text" name="aAddress" pattern='(\d{1,3}.)?.+\s(\d{6})$'
										title="Please enter BLK/STREET/unit/postal code" placeholder="Address" required>
								</div>
							</div>

							<div class="form-group">
								<label class="control-label col-sm-2" for="status">User
									Status:</label>
								<div class="col-sm-4">
									<select class="form-control" name="status">
										<option value="1">Pending</option>
										<option value="2">Registered</option>
									</select>
								</div>

							</div>



							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Save
									changes</button>
								<a href="manageAdminUser.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>

							</div>


						</form>
						
						

					

			
					</div>
				</div>
			</div>

		</div>
	</div>


	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->
	<script src="js/footer.js"></script>


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