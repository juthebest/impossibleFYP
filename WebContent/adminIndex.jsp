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
<title>I'MPOSSIBLE - Admin Index Page</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">
</head>

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
<style>
.container{

padding-left:60px
}
</style>

<body>

	<div class="container" >
	<div class="container marketing">
		<div class="row">
			<div class="col-md-2">
				<img class="img-circle" src="image/Courses-icon.png"
					alt="Generic placeholder image" width="160" height="160">
			<a href="workshopAdmin.jsp">
			<h2>Manage WorkShops</h2>
			</a>
				<p>View/Add/Edit/Delete WorkShops</p>

			</div>
			<div class="col-md-2">
				<img class="img-circle" src="image/Courses-icon.png"
					alt="Generic placeholder image" width="160" height="160">
				<a href="coachingAdmin.jsp"><h2>Manage Coaching Session</h2></a>
				<p>View/Add/Edit/Delete Session</p>

			</div>
			<div class="col-md-2">
				<img class="img-circle" src="image/program.jpg"
					alt="Generic placeholder image" width="160" height="160">
				<a href="programAdmin.jsp"><h2>Manage Program</h2></a>
				<p>View/Add/Edit/Delete Program</p>

			</div>
			<div class="col-md-2">
				<img class="img-circle" src="image/schedule.png"
					alt="Generic placeholder image" width="160" height="160">
				<a href="manageWorkShopSchedule.jsp"><h2>Manage Workshops Schedule</h2></a>
				<p>View/Add/Edit/Delete Course Schedule</p>

			</div>

			<div class="col-md-2">
				<img class="img-circle" src="image/user.jpg"
					alt="Generic placeholder image" width="160" height="160">
				<a href="manageUser.jsp"><h2>Manage User</h2></a>
				<p>View/Add/Edit/Delete Admin, Client and Coach User</p>

			</div>
		</div>


	</div>
	<div class="container marketing">
		<div class="row">
			<div class="col-md-2">
				<img class="img-circle" src="image/setting.png"
					alt="Generic placeholder image" width="160" height="160">
				<a href="manageItemStatus.jsp"><h2>Manage Status</h2></a>
				<p>View/Add/Edit/Delete Status</p>

			</div>
			<div class="col-md-2">
				<img class="img-circle" src="image/category.png"
					alt="Generic placeholder image" width="160" height="160">
				<a href="manageCategory.jsp"><h2>Manage Category</h2></a>
				<p>View/Add/Edit/Delete Category</p>

			</div>
			<div class="col-md-2">
				<img class="img-circle" src="image/homepage.png"
					alt="Generic placeholder image" width="160" height="160">
				<a href="manageIndex.jsp">	<h2>Manage Index Home Page</h2></a>
				<p>Insert Banner Picture</p>

			</div>
			<div class="col-md-2">
				<img class="img-circle" src="image/setting.png"
					alt="Generic placeholder image" width="160" height="160">
					<a href="manageAbout.jsp"><h2>Manage About</h2></a>
				<p>Insert About </p>

			</div>
			<div class="col-md-2">
				<img class="img-circle" src="image/contactus.jpg"
					alt="Generic placeholder image" width="160" height="160">
				<a href="manageContactUs.jsp">	<h2>Manage Contact Us</h2></a>
				<p>Insert Contact Us Information</p>

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


</body>
</html>