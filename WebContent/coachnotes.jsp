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


<%
	//allow access only if session exists
	String user = null;

	String role = (String) session.getAttribute("role");
	String uid = null;
	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| !role.equalsIgnoreCase("coach")) {
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



<%-- <c:forEach var="coachstudents" items="${coachidis.rows}">
	<!-- parent details -->
	<sql:query var="parentid" dataSource="${dataSource}">
	SELECT user.given_name FROM client, user
WHERE client.client_id = user.client_id
AND client.coach_id = <c:out value="${coachstudents.coach_id}" />
	</sql:query>
</c:forEach> --%>


<!-- get coach id-->
<sql:query var="coachidis" dataSource="${dataSource}">
SELECT * FROM user WHERE user_id = <%=uid%>;
</sql:query>


<c:forEach var="profilestudents" items="${coachidis.rows}">
	<!-- parent details -->
	<sql:query var="coachstudents" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE client.client_id = user.client_id
AND client.coach_id=<c:out value="${profilestudents.coach_id}" />
ORDER BY `client`.client_id ASC
	</sql:query>
</c:forEach>

<sql:query var="parentid" dataSource="${dataSource}">
SELECT * FROM client, user
WHERE client.parent_id = user.parent_id
AND user.user_id = <%=uid%>;
</sql:query>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Coach Notes</title>
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">

<body>
	<div class="container">
		<div class="jumbotron">
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Add New Note
						</h3>
					</div>
					<div class="panel-body">
						<form name="form1" method="post" action="writecoachnotes">
							<div class="content">
								<div class="container">

									<div class="row">
										<div class="form-group form-group-md">
											<label class="col-sm-2 control-label" for="status">Student
												Name:</label>
											<div class="col-sm-4">
												<select class="form-control" id="status" name="Student">

													<c:forEach var="name" items="${coachstudents.rows}">

														<option value="<c:out value="${name.client_id}"/>"><c:out
																value="${name.given_name}" /></option>

													</c:forEach>
												</select>
											</div>

										</div>
									</div>

									<c:forEach var="coachid" items="${coachidis.rows}">
										<input type="hidden"
											value="<c:out value="${coachid.coach_id}" />"
											name="thisisthecoachid" />

									</c:forEach>

									<br>


									<div class="row">
										<div class="form-group form-group-md">
											<label class="col-sm-2 control-label" for="seo">Counsellor's
												Comment:</label>
											<div class="col-sm-9">
												<textarea class="form-control" id="message" name="message"
													placeholder="Counsellor's comment is entered here."
													rows="7"></textarea>
											</div>
										</div>
									</div>
									<br />

									<div class="row">
										<div class="form-group">
											<div class="form-actions" style="text-align: right">
												<button type="submit" class="btn btn-primary"
													id="UpdateButton">Submit</button>
												<a class="btn btn-danger" href="counsellornotes.jsp">Cancel</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</form>
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