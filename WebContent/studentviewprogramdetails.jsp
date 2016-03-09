<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/userNavigation.jsp"></jsp:include>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />
<%
	//allow access only if session exists
	String user = null;

	String role = (String) session.getAttribute("role");
	String uid = null;
	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| !role.equalsIgnoreCase("child")) {
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








<!--  get client id so that you know which user register -->
<sql:query var="userprofile" dataSource="${dataSource}">
SELECT * 
FROM  user where user_id= <%=uid%>;
</sql:query>

<sql:query var="programCategory" dataSource="${dataSource}">
               	select * from program,category_has_program,category
				where program.program_id=category_has_program.program_id
				AND category_has_program.category_id=category.category_id
				AND program.status_id = 2   
				AND program.program_id=<%=request.getParameter("program_id")%>
</sql:query>


<sql:query var="program" dataSource="${dataSource}">
               	select * from program,category_has_program,category,status
				where program.program_id=category_has_program.program_id
				AND category_has_program.category_id=category.category_id  
				AND program.status_id=status.status_id
				AND program.program_id=<%=request.getParameter("program_id")%>
</sql:query>
<sql:query var="programItems" dataSource="${dataSource}">
               	SELECT *
				FROM program, item, program_has_item
				WHERE program.program_id = program_has_item.program_id
				AND program_has_item.item_id = item.item_id
				AND program.program_id=<%=request.getParameter("program_id")%>
</sql:query>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - View Program Details</title>
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css"
	rel="stylesheet">
<link href="dist/css/bootstrap-spinner.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link href="css/home.css" rel="stylesheet">
</head>

<body>
	<div class="container">
		<form action="AddCourseForUser" method="post" class="form-horizontal">

			<!-- workshop & coaching & program is -->
			<c:forEach var="gettheuserid" items="${userprofile.rows}">

				<input type="hidden" name="clientidis"
					value="${gettheuserid.client_id}" />
			</c:forEach>
			<!-- workshop & coaching & program -->


			<c:forEach var="program" items="${program.rows}">

				<input type="hidden" name="programidis"
					value="${program.program_id}" />


				<div class="page-header">
					<h1>
						<c:out value="${program.program_name}" />
						Program
					</h1>
				</div>

				<div class="col-sm-8">
					<div class="alingment">

						<h4>Program Description:</h4>
						<c:out value="${program.program_desc}" />
						<br> <br>

						<p>
							<b>Cost:</b>
							<c:out value="${program.program_price}" />
							(including GST)
						</p>

						<br> <br>
						<h4>Program Structure</h4>

						<hr>
						<p>The Program consists of the following items:</p>
						<div class="row">
							<div class="panel-group">

								<div class="panel panel-default">
									<div class="panel-heading">
										<h5>Item Names</h5>
									</div>
									<div class="panel-body">
										<c:forEach var="program" items="${programItems.rows}">
											<p>
												<a href="viewWorkshops.jsp?workshop_id=${program.item_id}"><c:out
														value="${program.item_name}" /></a>
											</p>
										</c:forEach>
									</div>
								</div>
							</div>

						</div>

						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" name="action"
								value="Submitprogram">Add</button>
							<a class="btn btn-danger" data-dismiss="modal"
								href="StudentPrograms&Courses.jsp">Back</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</form>

	</div>

	<!-- footer -->
	<footer id="footerMenu"></footer>
	<!-- end of footer -->

	<script src="js/navlinks.js"></script>
	<script src="js/footer.js"></script>

	<!-- start of login popup modal -->
	<!-- 	Place bootstrap core javascript below so pages load faster -->
	<div class="modal fade" id="login">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal" role="form">
					<div class="modal-header">
						<img src="image/impossiblelogo.png" alt="image logo"
							align="middle" style="width: 204px; height: 48px;">

					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="login-email" class="col-sm-2 control-label">Email:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="Login-email"
									placeholder="tomcat@domain.com">
							</div>
						</div>

						<div class="form-group">
							<label for="login-pwd" class="col-sm-2 control-label">Password*</label>
							<div class="col-sm-5">
								<input type="password" class="form-control" id="Login-name"
									placeholder="Password">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<a class="btn btn-danger" data-dismiss="modal">Close</a>
						<button type="submit" class="btn btn-warning">Sign In</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end of /the popout signin -->

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