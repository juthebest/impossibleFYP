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
<title>I'MPOSSIBLE - Admin Add User</title>
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

	<div class="container">


		<div id="content">
			<div class="page-header">
				<div class="container-fluid">

					<h1>Client User</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="manageUser.jsp">Client User</a></li>
					</ul>
				</div>
			</div>
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Add New Client User
						</h3>
					</div>
					<div class="panel-body">
		







							<div class="tab-content">
								<form action="addUser" method="post" class="form-horizontal">
								<div class="tab-pane active" id="tab-general">
									<div class="row">
										<div class="col-sm-2">
											<ul class="nav nav-pills nav-stacked" id="address">
												<li class="active"><a href="#tab-customer"
													data-toggle="tab">Add Child</a></li>
												<li><a href="#tab-address1" data-toggle="tab"><i
														class="fa fa-plus-circle"
														onclick="$('#address a:first').tab('show'); $('#address a[href=\'#tab-address1\']').parent().remove(); $('#tab-address1').remove();"></i>
														Add Parent</a></li>
												<!--       <li id="address-add"><a onclick="addAddress();"><i class="fa fa-plus-circle"></i> Add Address</a></li> -->
											</ul>
										</div>
										<div class="col-sm-10">
											<div class="tab-content">
												<div class="tab-pane active" id="tab-customer">

													<div class="form-group required">
														<label class="col-sm-2 control-label"
															for="input-salutation"> Salutation</label>
														<div class="col-sm-10">
															<select class="form-control" name="csalutation"
																id="input-salutation">
																<option value="Mr">Mr</option>
																<option value="Ms">Ms</option>

															</select>

														</div>
													</div>



													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-surname">
															Surname</label>
														<div class="col-sm-10">
															<input type="text" name="csurname" placeholder="Surname"
																id="input-surname" pattern="[a-zA-Z]{2,}" title="Minimum 2 letters" class="form-control" required />
														</div>
													</div>
													<div class="form-group required">
														<label class="col-sm-2 control-label"
															for="input-givenname">Given Name</label>
														<div class="col-sm-10">
															<input type="text" name="cgivenname"
																placeholder="Given Name" id="input-givenname"
																class="form-control" pattern="[a-zA-Z]{5,}" title="Minimum 4 letters" required />
														</div>
													</div>





													<div class="form-group required">
														<label class="col-sm-2 control-label" for="dp1">Date
															of Birth</label>
														<div class="col-sm-10">
															<input type="date" name="cdob" value=""
																placeholder="Date of Birth" autocomplete="off" id="dp1"
																class="form-control" required />
														</div>
													</div>

									
													
													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-school">School</label>
														<div class="col-sm-10">
															<input type="text" name="cschool" placeholder="School"
																id="sch" class="form-control" pattern="[a-zA-Z]{5,}" title="Minimum 4 letters" required />
														</div>
													</div>
													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-email">E-Mail</label>
														<div class="col-sm-10">
															<input type="text" name="cemail" placeholder="E-Mail"
																id="input-email" class="form-control" required />
														</div>
													</div>
													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-mobile">Mobile</label>
														<div class="col-sm-10">
															<input type="text" name="cmobile" placeholder="mobile"
																id="input-mobile" class="form-control" pattern='^[89]\d{7}$' required />
														</div>
													</div>

													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-password">Password</label>
														<div class="col-sm-10">
															<input type="password" name="cpassword" value=""
																placeholder="Password" id="input-password"
																class="form-control"  pattern='^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$'
										title="Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:"  autocomplete="off" required />
														</div>
													</div>



													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-address">Address
														</label>
														<div class="col-sm-10">
															<input type="text" name="caddress" value=""
																placeholder="Address " id="input-address"
																class="form-control" attern='(\d{1,3}.)?.+\s(\d{6})$'
										title="Please enter BLK/STREET/unit/postal code"  required />
														</div>
													</div>





												</div>


												<div class="tab-pane" id="tab-address1">
													<input type="hidden" name="address[1][address_id]"
														value="962" />

													<div class="form-group required">
														<label class="col-sm-2 control-label"
															for="input-salutation"> Salutation</label>
														<div class="col-sm-10">
															<select class="form-control" name="psalutation"
																id="input-salutation">
																<option value="Mr">Mr</option>
																<option value="Mrs">Mrs</option>
																<option value="Mrs">Ms</option>

															</select>

														</div>
													</div>
													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-surname">
															Surname</label>
														<div class="col-sm-10">
															<input type="text" name="psurname" placeholder="Surname"
																id="input-surname"pattern="[a-zA-Z]{2,}" title="Minimum 2 letters" class="form-control" required />
														</div>
													</div>
													<div class="form-group required">
														<label class="col-sm-2 control-label"
															for="input-givenname">Given Name</label>
														<div class="col-sm-10">
															<input type="text" name="pgivenname"
																placeholder="Given Name" id="input-givenname"
																pattern="[a-zA-Z]{5,}" title="Minimum 4 letters" class="form-control" required />
														</div>
													</div>


													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-email">E-Mail</label>
														<div class="col-sm-10">
															<input type="text" name="pemail" placeholder="E-Mail"
																id="input-email" class="form-control" required />
														</div>
													</div>
													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-mobile">Mobile</label>
														<div class="col-sm-10">
															<input type="text" name="pmobile" placeholder="mobile"
																id="input-mobile"pattern='^[89]\d{7}$' title="Minimum 8 digits, Starting with 8 or 9" class="form-control" required />
														</div>
													</div>

													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-password">Password</label>
														<div class="col-sm-10">
															<input type="password" name="ppassword" value=""
																placeholder="Password" id="input-password"
																class="form-control" pattern='^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$'
										title="Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:" autocomplete="off" required />
														</div>
													</div>

													<div class="form-group required">
														<label class="col-sm-2 control-label" for="input-address">Address
														</label>
														<div class="col-sm-10">
															<input type="text" name="paddress" value=""
																placeholder="Address " id="input-address"
																pattern='(\d{1,3}.)?.+\s(\d{6})$'
										title="Please enter BLK/STREET/unit/postal code" class="form-control" required />
														</div>
													</div>
													<div class="form-group required">
														<label class="col-sm-2 control-label"
															for="input-salutation"> Relationship to Child</label>
														<div class="col-sm-10">
															<select class="form-control" name="rtc"
																id="input-rtc">
																<option value="father">Father</option>
																<option value="mother">Mother</option>
																<option value="others">Others</option>

															</select>

														</div>
													</div>





													<!-- 
													<div class="form-group">
														<label class="col-sm-2 control-label">Default
															Address As Child</label>
														<div class="col-sm-10">
															<label class="radio"> <input type="radio"
																name="address[1][default]" value="1" checked="checked" />
															</label>
														</div>
													</div> -->
												</div>
											</div>
										</div>
									</div>
								</div>
				<div class="form-group">
								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Save
										changes</button>
									<a href="manageUser.jsp"><button type="button"
											class="btn btn-danger">Cancel</button></a>

								</div>

							</div>
						</form>

							</div>
	

					</div>


				</div>

			</div>
		</div>
	</div>

	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	
	<script src="js/footer.js"></script>


	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		$("#dp1").datepicker({
			dateFormat: 'yy/mm/dd'
		});

	</script>
	
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