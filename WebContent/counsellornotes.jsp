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

<!-- get coach id-->
<sql:query var="coachidis" dataSource="${dataSource}">
SELECT * FROM user WHERE user_id = <%=uid%>;
</sql:query>


<c:forEach var="coach" items="${coachidis.rows}">
	<!-- parent details -->
	<sql:query var="counsellornotes" dataSource="${dataSource}">
select coach_note.coach_id, coach_note.coach_note_id, coach_note.note_details, coach_note.create_update_datetime, coach_note.client_id,
user.coach_id, user.given_name from coach_note, client, user
WHERE coach_note.coach_id = client.coach_id
AND client.client_id = user.client_id
AND coach_note.coach_id=<c:out value="${coach.coach_id}" />
	</sql:query>
</c:forEach>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Counsellor Notes</title>
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
					<h3 class="panel-title">All Notes</h3>
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
										<th class="sorter-false"></th>
										<th class="text-left">Date and Time Last Updated</th>
										<th class="text-left">Comment of Note</th>
										<th class="text-left">Student Name</th>
										<th class="text-left">Edit</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="notes" items="${counsellornotes.rows}">

										<tr>
											<td class="text-left"><input type="checkbox"
												name="checkbox" value="${notes.coach_note_id}"></td>

											<td class="text-left"><c:out
													value="${notes.create_update_datetime}" /></td>
											<td class="text-left"><c:out
													value="${notes.note_details}" /></td>
											<td class="text-left"><c:out value="" /> <c:out
													value="${notes.given_name}" /></td>
											<td class="text-center">
												<button type="button" class="btn btn-default btn-sm"
													onclick="location.href='editCoachNote.jsp?journalID=${notes.coach_note_id}'">
													<span class="glyphicon glyphicon-edit"></span> Edit
												</button>
											</td>
										</tr>

									</c:forEach>
							</table>

						</div>
					</form>

				</div>
			</div>
		</div>
	</div>

	<!-- Start of Fixed footer -->
	<footer id="footerMenu"></footer>
	<script src="js/footer.js"></script>
	<!-- End of Fixed footer -->

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


	<script src="dist/js/jquery.tablesorter.min.js"></script>
	<script src="dist/js/jquery.tablesorter.widgets.min.js"></script>

	<script>
		$(function() {
			$('table').tablesorter({

				usNumberFormat : false,
				sortReset : true,
				sortRestart : true

			});
		});
	</script>

</body>
</html>