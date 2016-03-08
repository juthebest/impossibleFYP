<!DOCTYPE html>
<html lang="en">
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<jsp:include page="main/parentNavigation.jsp"></jsp:include>

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

<sql:query var="parentdetails" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE user.parent_id = client.parent_id
AND user.user_id = <%=uid%>;</sql:query>


<c:forEach var="userprofile2" items="${parentdetails.rows}">
	<sql:query var="chilid2" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE client.client_id = user.client_id
AND client.client_id=<c:out value="${userprofile2.client_id}" />
	</sql:query>
</c:forEach>

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
<title>I'MPOSSIBLE - View User Profile</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">

<body>
	<div class="container">
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li><a href="parenthomepage.jsp">Home</a></li>
				<li class="active">Profile</li>
			</ol>
		</div>
	</div>


	<br />
	<div class="container">

		<div class="row">
			<h4>
				<b>User Information</b>
			</h4>
			<hr />
			<div class="col-sm-4">

				<c:forEach var="parentprofile" items="${parentdetails.rows}">

					<p>
						<b>Name:</b>
						<c:out
							value="${parentprofile.surname} ${parentprofile.given_name}" />
					</p>
					<p>
						<b>E-Mail: </b>
						<c:out value="${parentprofile.email}" />
					</p>

					<p>
						<b>Mobile: </b>
						<c:out value="${parentprofile.mobile}" />
					</p>
					<p>
						<b>Address: </b>
						<c:out value="${parentprofile.address}" />
					</p>
				</c:forEach>


			</div>
			<div class="col-sm-4">
				<c:forEach var="profilechild" items="${chilid2.rows}">

					<p>
						<b>Child's Name:</b>
						<c:out value="${profilechild.surname} ${profilechild.given_name}" />
					</p>
					<p>
						<b>Child's Date of Birth: </b>
						<c:out value="${profilechild.client_dob}" />
					</p>
					<p>
						<b>Child's E-Mail: </b>
						<c:out value="${profilechild.email}" />
					</p>

					<p>
						<b>Child's Mobile: </b>
						<c:out value="${profilechild.mobile}" />
					</p>
					<p>
						<b>Child's Address: </b>
						<c:out value="${profilechild.address}" />
					</p>
					<p>
						<b>Child's School: </b>
						<c:out value="${profilechild.client_school}" />
					</p>
				</c:forEach>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-8">
				<h4>
					<b>Item Structure</b>
				</h4>
				<hr>
				<p>The Student have the following Item Structure:</p>
				<div class="panel-group">

					<div class="panel panel-default">
						<div class="panel-heading">
							<h5>Item Names</h5>
						</div>
						<div class="panel-body">

							<c:forEach var="programsforstudents" items="${chilid.rows}">
								<p>
									<c:out value="${programsforstudents.program_name}" />
								</p>
							</c:forEach>

							<c:forEach var="coursesforstudents" items="${studentcourse.rows}">
								<p>
									<c:out value="${coursesforstudents.item_name}" />
								</p>
							</c:forEach>
						</div>
					</div>
				</div>


			</div>
		</div>
		<p style="text-align: right">
			<a class="btn btn-default" href="editparentprofile.jsp" role="button"><i
				class="glyphicon glyphicon-edit"></i>Edit</a> <a class="btn btn-default"
				href="parenthomepage.jsp" role="button">Back</a>

		</p>
	</div>

	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

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
</body>
</html>