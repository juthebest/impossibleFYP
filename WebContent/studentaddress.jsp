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


<!-- child details -->
<sql:query var="userprofile" dataSource="${dataSource}">
SELECT * FROM user
WHERE user_id = <%=request.getParameter("userid")%>;</sql:query>

<%
	//allow access only if session exists
	String user = null;

	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| session.getAttribute("role") != "coach") {
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
</head>

<body>
	<div class="container">


		<div class="container-fluid">
			<ul class="nav nav-tabs">
				<li><a href="studentdetails.jsp">Programs Registered</a></li>
				<li><a href="counsellorrecentjournals.jsp">Recent Journals</a></li>
				<li class="active"><a href="studentaddress.jsp">Address</a></li>
			</ul>

			<div class="panel panel-default">

				<div class="panel-heading">
					<c:forEach var="profile" items="${userprofile.rows}">
						<h3 class="panel-title">
							Student Details:
							<c:out value="${profile.surname} ${profile.given_name}" />
						</h3>
					</c:forEach>
				</div>

				<div class="panel-body">

					<div class="row">
						<c:forEach var="profile" items="${userprofile.rows}">
							<p>
								<b>Date of Birth: </b>
								<c:out value="${profile.client_dob}" />
							</p>
							<p>
								<b>Mobile: </b>
								<c:out value="${profile.mobile}" />
							</p>
							<p>
								<b>Address: </b>
								<c:out value="${profile.address}" />
							</p>
							<p>
								<b>Postal Code:</b>52391
							</p>

							<p>
								<b>E-Mail: </b>
								<c:out value="${profile.email}" />
							</p>
							<p>
								<b>School: </b>
								<c:out value="${profile.client_school}" />
							</p>
							<p>
								<b>Gender: </b>
								<c:out value="${profile.salutation}" />
							</p>
						</c:forEach>
					</div>

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