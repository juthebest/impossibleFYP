<!DOCTYPE html>
<html lang="en">
<!-- Start of navigation -->
<jsp:include page="main/userNavigation.jsp"></jsp:include>
<!-- End of navigation -->
<!-- Start of user validation -->
<%
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
%>
<!-- End of user validation -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - User's Home</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<!-- Start of CSS -->
<link href="css/home.css" rel="stylesheet">
<!-- End of CSS -->

<body>
	<div style="padding-top: 100px; padding-left: 170px">

		<div class="row">

			<div class="col-lg-2">
				<a href="http://raindropmemory.deviantart.com/"><img
					class="img-circle" src="image/G12-Folder-Notebook-icon.png"
					alt="Generic placeholder image" class="img-responsive" width="120"
					height="120"></a>
				<h2>Write A Journal</h2>
				<p>Express your emotions and thoughts by writing a journal.</p>
			</div>

			<div class="col-lg-2">
				<img class="img-circle" src="image/Diary-icon.png"
					alt="Generic placeholder image" class="img-responsive" width="140"
					height="140">
				<h2>Recent Journals</h2>
				<p>Journals that are submitted and draft.</p>
			</div>

			<div class="col-lg-2">
				<img class="img-circle" src="image/shopping-icon.png"
					alt="Generic placeholder image" class="img-responsive" width="140"
					height="140">
				<h2>New Courses</h2>
				<p>View courses that are available right now.</p>
			</div>

			<div class="col-lg-2">
				<img class="img-circle" src="image/Books-2-icon.png"
					alt="Generic placeholder image" class="img-responsive" width="140"
					height="140">
				<h2>My Courses</h2>
				<p>View all courses and programs that I have registered.</p>
			</div>

			<div class="col-lg-2">
				<img class="img-circle" src="image/profile-icon.png"
					alt="Generic placeholder image" class="img-responsive" width="140"
					height="140">
				<h2>My Profile</h2>
				<p>View my information and edit my profile.</p>
			</div>

		</div>

		<div class="row">

			<div class="col-lg-2">
				<p>
					<a class="btn btn-default" href="ReflectionJournal.jsp"
						role="button">Write A New Journal &raquo;</a>
				</p>
			</div>

			<div class="col-lg-2">
				<p>
					<a class="btn btn-default" href="studentrecentjournals.jsp"
						role="button">View Journals &raquo;</a>
				</p>
			</div>

			<div class="col-lg-2">
				<p>
					<a class="btn btn-default" href="StudentPrograms&Courses.jsp"
						role="button">View New Programs &raquo;</a>
				</p>
			</div>

			<div class="col-lg-2">
				<p>
					<a class="btn btn-default" href="myCourseNPrograms.jsp"
						role="button">View My Courses &raquo;</a>
				</p>
			</div>

			<div class="col-lg-2">
				<p>
					<a class="btn btn-default" href="userProfile.jsp" role="button">View
						My Profile &raquo;</a>
				</p>
			</div>

		</div>

	</div>

	<!-- Start of fixed footer -->
	<footer id="footerMenu"></footer>
	<script src="js/footer.js"></script>
	<!-- End of fixed footer> -->

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>