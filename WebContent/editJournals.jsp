<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/counsellorNavigation.jsp"></jsp:include>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />


<sql:query var="journal" dataSource="${dataSource}">
     SELECT * FROM `client_journal`  WHERE client_journal_id=<%=request.getParameter("journalID")%>

</sql:query>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Add Journal Comment</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">

<body>
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
	%>

	<div class="container">
		<div id="content">

			<div class="page-header">
				<div class="container-fluid">
					<h1>Comment</h1>
				</div>
			</div>

			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Add Journal Comment
						</h3>
					</div>

					<div class="panel-body">

						<c:forEach var="journaldetails" items="${journal.rows}">
							<form method="post" class="form-horizontal" name="myForm"
								action="addJournalComment">

								<input type="hidden"
									value="${journaldetails.client_journal_id}" name="id"></input>

								<div class="form-group required">
									<label class="col-sm-2 control-label" for="input-name1">Student
										Journal</label>
									<div class="col-sm-10">
										<textfield> <input type="text" name="status_name"
											value="${journaldetails.journal_reflection}"
											placeholder="Status Name" id="input-name1"
											class="form-control" required /></textfield>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="emotionrating">Emotion
										Rating: </label>
									<div class="col-sm-10">
										<input type="text" name="emotionrating" id="input-emotion"
											value="${journaldetails.emotion_rating}" class="form-control"
											required></input>

									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="indicator">Privacy
										Indicator: </label>
									<div class="col-sm-10">
										<input type="text" name="indicator" id="input-indicator"
											value="${journaldetails.privacy_indicator}"
											class="form-control" required></input>

									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="datesubmitted">Submitted
										Date: </label>
									<div class="col-sm-10">
										<input type="text" name="datesubmitted"
											placeholder="Submitted date" id="input-submitdate"
											value="${journaldetails.create_update_datetime}"
											class="form-control" required></input>

									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="coachcomment">Comment:
									</label>
									<div class="col-sm-10">
										<input type="text" name="coachcomment"
											placeholder="Please enter comment here." id="input-comment"
											value="${journaldetails.coach_comment}" class="form-control"
											required></input>

									</div>
								</div>

								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Save
										changes</button>
									<a href="counsellorjournals.jsp"><button type="button"
											class="btn btn-danger">Cancel</button></a>
								</div>

							</form>
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