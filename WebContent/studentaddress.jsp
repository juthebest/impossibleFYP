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

<!-- parent details -->
<c:forEach var="profileparentis" items="${userprofile.rows}">
	<sql:query var="parentprofile" dataSource="${dataSource}">
SELECT * FROM client, user
WHERE client.parent_id = user.parent_id
AND client.client_id = <c:out value="${profileparentis.client_id}" />;</sql:query>
</c:forEach>


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
			<c:forEach var="page" items="${userprofile.rows}">
				<ul class="nav nav-tabs">
					<li><a href="studentdetails.jsp?userid=${page.user_id}">Programs
							Registered</a></li>
					<li class="active"><a
						href="studentaddress.jsp?userid=${page.user_id}">Address</a></li>
				</ul>
			</c:forEach>
			
			<div class="panel panel-default">

				<c:forEach var="profile" items="${userprofile.rows}">

					<div class="panel-body">
						<div class="row">
							<h5>
								<c:out value="${profile.given_name}" />
								's Information
							</h5>

							<p>
								<b>Mobile: </b>
								<c:out value="${profile.mobile}" />
							</p>
							<p>
								<b>E-Mail: </b>
								<c:out value="${profile.email}" />
							</p>
							<p>
								<b>Address: </b>
								<c:out value="${profile.address}" />
							</p>
						</div>

					</div>
				</c:forEach>

				<c:forEach var="parentdetails" items="${parentprofile.rows}">

					<div class="panel-body">

						<div class="row">
							<h5>Next Kin's Information</h5>
							<p>
								<b>Name: </b>
								<c:out
									value="${parentdetails.salutation} ${parentdetails.given_name} ${parentdetails.surname}" />
							</p>

							<p>
								<b>Relationship to child: </b>
								<c:out value="${parentdetails.relationship_to_child}" />
							</p>
							<p>
								<b>Mobile: </b>
								<c:out value="${parentdetails.mobile}" />
							</p>
							<p>
								<b>E-Mail: </b>
								<c:out value="${parentdetails.email}" />
							</p>
							<p>
								<b>Address: </b>
								<c:out value="${parentdetails.address}" />
							</p>

						</div>

					</div>

				</c:forEach>

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