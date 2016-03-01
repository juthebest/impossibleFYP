<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<sql:query var="coachuser" dataSource="${dataSource}">
SELECT * 
FROM  `user` , coach
WHERE user.coach_id = coach.coach_id
AND user.coach_id=<%=request.getParameter("coachID")%>

</sql:query>



<%
		//allow access only if session exists
		String user = null;
		if (session.getAttribute("name") == null || session.getAttribute("role") != ("admin")) {
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

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Admin Edit Coach User</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">
<script src="ckeditor/ckeditor.js"></script>
</head>
<body>


	<div class="container">


		<div id="content">
			<div class="page-header">
				<div class="container-fluid">

					<h1>Manage User</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="manageCoachUser.jsp">Manage Coach </a></li>
					</ul>
				</div>
			</div>
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i>Edit Coach User
						</h3>
					</div>
					<div class="panel-body">
						<c:forEach var="coachU" items="${coachuser.rows}">
							<form action="editCoachUser" method="post"
								class="form-horizontal">

<input type="hidden" name="rdate" value="${coachU.create_update_datetime}" />					<input type="hidden" name="Coachid" value="${coachU.coach_id}" />
								<input type="hidden" name="role" value="${coachU.role}" />
								 <input type="hidden" name="userStatus" value="${coachU.userStatus_id}" />
								<div class="form-group">
									<label class="col-sm-2 control-label" for="coach">Salutation:</label>
									<div class="col-sm-10">

										<select class="form-control" id="salutation_input"
											name="salutation">
											<option value="${coachU.salutation}">${coachU.salutation}</option>
											<option value="Mr">Mr</option>
											<option value="Mrs">Mrs</option>
											<option value="Ms">Ms</option>
											<option value="Mdm">Mdm</option>

										</select>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-2" for="csName">Coach
										Surname:</label>
									<div class="col-sm-9">
										<input class="form-control" type="text" name="csName"
											value="${coachU.surname}">
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="cgName">Coach
										Given name:</label>
									<div class="col-sm-9">
										<input class="form-control" type="text" name="cgName"
											value="${coachU.given_name}">
									</div>
								</div>



								<div class="form-group">
									<label class="control-label col-sm-2" for="cEmail">Coach
										Email:</label>
									<div class="col-sm-9">
										<input class="form-control" type="text" name="cEmail"
											value="${coachU.email}">
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="cPassword">Password:</label>
									<div class="col-sm-9">
										<input class="form-control" type="password" name="cPassword"
											value="${coachU.password}">
									</div>
								</div>



								<div class="form-group">
									<label class="control-label col-sm-2" for="cMobile">Mobile:</label>
									<div class="col-sm-9">
										<input class="form-control" type="tel" name="cMobile"
											value="${coachU.mobile}">
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-2" for="cAddress">Address</label>
									<div class="col-sm-9">
										<input class="form-control" type="text" name="cAddress"
											value="${coachU.address}">
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-2" for="cHR">Coach
										Hourly Rate:</label>
									<div class="col-sm-9">
										<input class="form-control" type="text" name="cHR"
											value="${coachU.coach_hourly_rate}">
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="cProfile">Coach
										Profile:</label>
									<div class="col-sm-9">
										<input class="form-control" type="text" name="cProfile"
											value="${coachU.coach_profile}">
									</div>
								</div>


								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Save
										changes</button>
									<a href="manageCoachUser.jsp"><button type="button"
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