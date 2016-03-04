<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/userNavigation.jsp"></jsp:include>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

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
		response.sendRedirect("login.html");
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

<!-- //var - ownself name -->
<sql:query var="studentrecentjournals" dataSource="${dataSource}">
SELECT * FROM `client_journal`, `client`,`user`
WHERE `client_journal`.`client_id` = `client`.`client_id`
AND `client`.`client_id` = `user`.`client_id`
AND `user_id` = <%=uid%> 
ORDER BY `user`.`create_update_datetime` ASC
</sql:query>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Student Recent Journals</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>

      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<body id="index">

	<div class="container">
		<div class="page-header">
			<div class="container-fluid">
				<ol class="breadcrumb">
					<li><a href="user.jsp">Home</a></li>
					<li class="active">Reflection Journal</li>
				</ol>
			</div>

			<br />
			<h2>My Journals</h2>

			<div class="title">
				<a href=""> 2015 </a>
			</div>
			<div class="mymonths">
				<a href=""> January </a>. <a href=""> February </a>. <a href="">
					March </a>. <a href=""> April </a>. <a href=""> May </a>. <a href="">
					June </a>. <a href=""> July </a>. <a href=""> August </a>. <a href="">
					September </a>. <a href=""> October </a>. <a href=""> November </a>. <a
					href=""> December </a>.
			</div>
		</div>

		<h3>
			<b>November 2015</b>
		</h3>
		<div class="row">
			<c:forEach var="studentjournals"
				items="${studentrecentjournals.rows}">

				<div class="col-sm-4">
					<div class="thumbnail home-thumb">
						<c:out value="${studentjournals.create_update_datetime}" />
						<img src="image/cat-food-hearts-icon.png"
							style="width: 280px; height: 228px;" alt="New Courses" /> <br />
						<p>
							<c:out value="${studentjournals.journal_reflection}" />
						</p>
						<p>

							Emotion Indicator:
							<c:out value="${studentjournals.emotion_rating}" />
						</p>
						<a
							href="passedRJandcomments.jsp?journalid=${studentjournals.client_journal_id}"
							class="btn btn-danger">View More</a>
					</div>
				</div>
			</c:forEach>
		</div>

	</div>

	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/footer.js"></script>
	<script src="js/navlink-user.js"></script>

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