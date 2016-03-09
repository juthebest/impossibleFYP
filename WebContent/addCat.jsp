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
<title>I'MPOSSIBLE - Add Category</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

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

					<h1>Category</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="manageCategory.jsp">Categories</a></li>
					</ul>
				</div>
			</div>
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Add Category
						</h3>
					</div>
					<div class="panel-body">






						<form name="form" class="form-horizontal" method="post" action="addCatServlet" >
						
						<%
							if (request.getAttribute("Error") != null) {
						%>
						<p style="color: red">
							
							<%=(String) request.getAttribute("Error")%></p>
						<%
							}
						%>
						
							<div class="form-group">
								<label class="col-sm-2 control-label" for="name">Category
									Name</label>
								<div class="col-sm-10">
									<input type="text" name="name" id="cat_name"
										class="form-control" pattern="^[A-Z].*"  title="Must start with uppercase" required />
								</div>
							</div>


							<div class="form-group">
								<label class="col-sm-2 control-label" for="desc">Description</label>
								<div class="col-sm-10">
									<textarea name="desc" id="cat_desc" class="form-control"
								 required></textarea>

								</div>
							</div>


							<div class="form-actions">

								<button type="submit" class="btn btn-primary">Save
									changes</button>
								<a href="manageCategory.jsp"><button type="button"
										class="btn btn-danger">Cancel</button></a>

							</div>

						</form>
						<div id="message"></div>

					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/navlinks-admin.js"></script>
	<script src="js/footer.js"></script>

	<script src="js/bootstrap.min.js"></script>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->



	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
var ck_name = /^[A-Za-z0-9 ]{3,20}$/;
var ck_email = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]
{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i 
var ck_username = /^[A-Za-z0-9_]{1,20}$/;
var ck_password =  /^[A-Za-z0-9!@#$%^&*()_]{6,20}$/;

function validate(form){
var name = form.name.value;
var email = form.email.value;
var username = form.username.value;
var password = form.password.value;
var gender = form.gender.value;
var errors = [];
 
 if (!ck_name.test(name)) {
  errors[errors.length] = "You valid Name .";
 }
 if (!ck_email.test(email)) {
  errors[errors.length] = "You must enter a valid email 
address.";
 }
 if (!ck_username.test(username)) {
  errors[errors.length] = "You valid UserName no special 
char .";
 }
 if (!ck_password.test(password)) {
  errors[errors.length] = "You must enter a valid Password ";
 }
 if (gender==0) {
  errors[errors.length] = "Select Gender";
 }
 if (errors.length > 0) {

  reportErrors(errors);
  return false;
 }
  return true;
}
function reportErrors(errors){
 var msg = "Please Enter Valide Data...\n";
 for (var i = 0; i<errors.length; i++) {
 var numError = i + 1;
  msg += "\n" + numError + ". " + errors[i];
}
 alert(msg);
}
</script>

</body>
</html>