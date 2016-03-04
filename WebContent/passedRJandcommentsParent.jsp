<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/counsellorNavigation.jsp"></jsp:include>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />


<!-- //var - ownself name -->
<sql:query var="studentrecentjournals" dataSource="${dataSource}">
SELECT `client_journal_id`, `client_id`, `coach_id`, `journal_reflection`, `emotion_rating`, `create_update_datetime`, `privacy_indicator`, `coach_comment`, `coach_comment_datetime` FROM `client_journal` ORDER BY `create_update_datetime` ASC;
</sql:query>
<%
	//allow access only if session exists
	String user = null;

	String role = (String) session.getAttribute("role");
	String uid = null;
	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| !role.equalsIgnoreCase("parent")) {
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


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Manage Course</title>
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


<body>

		<div class="container">
			<div class="container-fluid">
				<ul class="nav nav-tabs">
					<li><a href="studentdetails.jsp">Programs Registered</a></li>
					<li><a href="counsellorrecentjournals.jsp">Recent Journals</a></li>
					<li class="active"><a href="pastjournals.jsp">Past
							Journals</a></li>
					<li><a href="studentaddress.jsp">Address</a></li>
				</ul>

				<div class="panel panel-default">

					<div class="panel-heading">
						<h3 class="panel-title">Student Details: Judith</h3>
					</div>

					<div class="panel-body">

						<div class="row">
							<h4>Past Journal and Comments By Other Counsellor</h4>

							<h4>Mary Seah :</h4>
							<textarea class="form-control" id="message" name="message"
								placeholder="Counsellor's comment is entered here." rows="7"></textarea>

							<h4>Christine Ong :</h4>
							<textarea class="form-control" id="message" name="message"
								placeholder="Counsellor's comment is entered here." rows="7"></textarea>
						</div>

						<ul class="pagination pagination-sm" style="float: right;">
							<li class="disabled"><a href="#">&laquo;</a></li>
							<li class="active"><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
							<li><a href="#">&raquo;</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

	<!-- <Fixed footer> -->
	<nav id="footerMenu"></nav>
	<!-- End <Fixed footer> -->

	<script src="js/footer.js"></script>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>