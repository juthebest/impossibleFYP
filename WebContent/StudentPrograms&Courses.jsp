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
</sql:query>

<sql:query var="workshopCategory" dataSource="${dataSource}">
                select * from item,category_has_item,category 
                where item.item_id = category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.status_id = 2
                AND item.item_type_id=?
                                <sql:param value="2" />
</sql:query>

<sql:query var="coachingCategory" dataSource="${dataSource}">
                select * from item,category_has_item,category 
                where item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.status_id=2
                AND item.item_type_id=?
                                <sql:param value="1" />
</sql:query>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - My Courses & Program</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">


<!-- for filter bar -->
<style>
.filter-col {
	padding-left: 10px;
	padding-right: 10px;
}

.testing {
	margin-bottom: 100px;
}
</style>

</head>

<body>
	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

		<div class="testing">

			<div class="row">
				<h2>Programs</h2>
				<hr>
				<form action="AddCourseForUser" method="post"
					class="form-horizontal">
					
					<c:forEach var="gettheuserid" items="${userprofile.rows}">

						<input type="hidden" name="clientidis"
							value="${gettheuserid.client_id}" />
					</c:forEach>

					<c:forEach var="category" items="${programCategory.rows}">

						<input type="hidden" name="programidis"
							value="${category.program_id}" />

						<div class="col-xs-6 col-lg-4">
							<div class="alingment">
								<br>
								<p>
									<b>Title: </b>
									<c:out value="${category.program_name}" />
								</p>
								<p>
									<b>Categories: </b>
									<c:out value="${category.category_name}" />
								</p>
								<a class="btn btn-success"
									href="viewProgramDetails.jsp?program_id=${category.program_id}">
									View Details &raquo; </a> <a class="btn btn-info"
									href="register.jsp?program_id=${category.program_id}">
									Register &raquo; </a>


								<button type="submit" class="btn btn-primary">Submit</button>

							</div>
						</div>
					</c:forEach>
				</form>
			</div>


			<div class="row">
				<h2>Workshops</h2>
				<hr>
				<c:forEach var="category" items="${workshopCategory.rows}">

					<div class="col-xs-6 col-lg-4">
						<div class="alingment">
							<br>

							<p>
								<b>Title: </b>
								<c:out value="${category.item_name}" />
							</p>
							<p>
								<b>Categories: </b>
								<c:out value="${category.category_name}" />
							</p>
							<a class="btn btn-success"
								href="viewWorkshops.jsp?workshop_id=${category.item_id}">
								View Details &raquo; </a> <a class="btn btn-info"
								href="shoppingcart.html"> Register &raquo; </a>
						</div>
					</div>
				</c:forEach>
			</div>


			<div class="row">
				<h2>Coaching Sessions</h2>
				<hr>
				<c:forEach var="category" items="${coachingCategory.rows}">
					<div class="col-xs-6 col-lg-4">
						<div class="alingment">
							<br>

							<p>
								<b>Title: </b>

								<c:out value="${category.item_name}" />
							</p>
							<p>
								<b>Categories: </b>
								<c:out value="${category.category_name}" />
							</p>
							<a class="btn btn-success"
								href="viewCoachingSession.jsp?coaching_id=${category.item_id}">
								View Details &raquo; </a> <a class="btn btn-info" href="#">
								Register &raquo; </a>
						</div>
					</div>
				</c:forEach>
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

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>