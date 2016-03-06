<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/parentNavigation.jsp"></jsp:include>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<h3>
	Hi
	<%=userName%>, Login successful. Your Session ID=<%=sessionID%>
	role=<%=userrole%></h3>
<br> User=<%=user%>

<br> UserIDSession=<%=uid%>
<br> UserIDCookie=<%=userID%>
<br>role=<%=role%>

<!-- need to encode all the URLs where we want session information to be passed -->
<a href="CheckoutPage.jsp">Checkout Page</a>
<form action="LogoutServlet" method="get">
	<input type="submit" value="Logout">
</form>

<!-- //var - find client id -->
<sql:query var="studentname" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE client.parent_id = user.parent_id
AND user.user_id = <%=uid%>;
</sql:query>


<c:forEach var="studentprograms" items="${studentname.rows}">
	<sql:query var="chilid" dataSource="${dataSource}">
SELECT * FROM `program_has_client`, `program`, `client`
WHERE `program`.`program_id` = `program_has_client`.`program_id`
AND `program_has_client`.`client_id` = `client`.`client_id`
AND `program_has_client`.`enrollment_status_id` = 2
AND client.client_id = <c:out value="${studentprograms.client_id}" />;
	</sql:query>
</c:forEach>

<c:forEach var="courses" items="${studentname.rows}">
	<sql:query var="studentcourse" dataSource="${dataSource}">
SELECT * FROM item, itemrun, itemrun_has_client, client
WHERE item.item_id = itemrun.item_id
AND itemrun.itemrun_id = itemrun_has_client.itemrun_id
AND itemrun_has_client.client_id = client.client_id
AND client.client_id = <c:out value="${courses.client_id}" />;
	</sql:query>
</c:forEach>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - User Course and Program</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
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
			<ol class="breadcrumb">
				<li><a href="parenthomepage.jsp">Home</a></li>
				<li class="active">My Courses & Programs</li>
			</ol>
		</div>
	</div>

	<br />

	<div class="container">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<h4>Program Registered</h4>
						<c:forEach var="programsforstudents" items="${chilid.rows}">
							<div class="col-sm-8">
								<br />
								<c:out value="${programsforstudents.program_name}" />
								<br /> <i>Date Registered : <c:out
										value="${programsforstudents.date_registered}" />
								</i>
							</div>
						</c:forEach>
					</div>

					<hr />

					<div class="row">
						<h4>Course Registered</h4>
						<c:forEach var="courseforstudents" items="${studentcourse.rows}">
							<div class="col-sm-8">
								<br />
								<c:out value="${courseforstudents.item_name}" />
								<br /> <i>Date Registered : <c:out
										value="${courseforstudents.date_registered}" />
								</i>
							</div>
						</c:forEach>
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
</body>
</html>