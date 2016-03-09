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
<%-- <h3>
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
</form> --%>


<sql:query var="coachid" dataSource="${dataSource}">
SELECT coach_id FROM user
WHERE user_id = <%=uid%> ;
</sql:query>


<c:forEach var="profilestudent" items="${coachid.rows}">
	<!-- parent details -->
	<sql:query var="parentname" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE client.parent_id = user.parent_id
AND client.coach_id=<c:out value="${profilestudent.coach_id}" />
ORDER BY `client`.parent_id ASC
	</sql:query>
</c:forEach>

<c:forEach var="profilestudents" items="${coachid.rows}">
	<!-- parent details -->
	<sql:query var="childname" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE client.client_id = user.client_id
AND client.coach_id=<c:out value="${profilestudents.coach_id}" />
ORDER BY `client`.client_id ASC
	</sql:query>
</c:forEach>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Manage Counsellor</title>

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
<!-- tablesorter theme file-->
<link rel="stylesheet" href="css/theme.default.css">

<body>

	<div class="container">

		<div class="container-fluid">
			<div class="panel panel-default">

				<div class="panel-heading">
					<h3 class="panel-title">My Students</h3>
				</div>

				<div class="panel-body">
					<p class="icons">
						<a href="coachnotes.jsp"><button type="button"
								class="btn btn-default btn-sm">
								<span class="glyphicon glyphicon-plus"></span> Write a new note
							</button></a>
					</p>
					<form action="#" method="post" enctype="multipart/form-data"
						id="form-course">
						<div class="table-responsive">
							<table id="myTable"
								class="table table-bordered table-hover tablesorter">

								<thead>
									<tr>
										<th class="text-left">Student's Name</th>
										<th class="text-left">Join Date</th>
										<th class="text-left">Programs Registered</th>
										<th class="text-left">Address</th>

									</tr>
								</thead>

								<tbody>

									<c:forEach var="child" items="${childname.rows}">
										<tr>
											<td class="text-left"><c:out
													value="${child.surname} ${child.given_name}" /></td>
											<td class="text-left"><c:out
													value="${child.create_update_datetime}" />
											<td class="text-left"><a
												href="studentdetails.jsp?userid=${child.user_id}">View
													Registered Programs</a></td>
											<td class="text-left"><a
												href="studentaddress.jsp?userid=${child.user_id}">View
													Address</a></td>

										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End <Fixed footer> -->

	<script src="js/footer.js"></script>

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
	<!-- load jQuery and tablesorter scripts -->
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>

	<script>
		$(function() {
			$("#myTable").tablesorter();
		});
	</script>

</body>
</html>


