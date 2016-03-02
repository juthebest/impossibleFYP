<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/publicNavigations.jsp"></jsp:include>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<!-- //var - ownself name -->
<sql:query var="aboutdescriptiontop" dataSource="${dataSource}">
SELECT about_description FROM control where control_id =2;
</sql:query>


<%
	//allow access only if session exists
	String user = null;

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
<title>I'MPOSSIBLE - About</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">

<body>
	<!-- Start of Body  -->
	<div class="container">
		<!-- Border -->
		<div class="jumbotron text-center">
			<div id='content'>
				<c:forEach var="aboutdescription"
					items="${aboutdescriptiontop.rows}">
					<tr>
						<td><c:out value="${aboutdescription.about_description}" />
						<td>
					</tr>
				</c:forEach>
			</div>
		</div>
		<!-- Border XeniaKoh -->
	</div>
	<!-- End of Body  -->

	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<!-- Start of <Navigation links for header and footer> -->
	<script src="js/footer.js"></script>
	<!-- End of <Navigation links for header and footer> -->

	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src='js/jquery.min.js'></script>
	<script src='js/about.js'></script>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
</body>
</html>