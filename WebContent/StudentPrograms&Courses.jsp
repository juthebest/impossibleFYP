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


<!-- workshop -->
<sql:query var="workshopCategory" dataSource="${dataSource}">
                select * from item,category_has_item,category, itemrun
                where itemrun.item_id = item.item_id
                AND item.item_id = category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.status_id = 2
                AND item.item_type_id=?
                                <sql:param value="2" />
</sql:query>

<c:forEach var="itemrunid2" items="${workshopCategory.rows}">
	<sql:query var="itemrunid" dataSource="${dataSource}">
SELECT * FROM itemrun, item
WHERE itemrun.item_id = item.item_id
AND item.item_id=<c:out value="${itemrunid2.item_id}" />
	</sql:query>
</c:forEach>

<c:forEach var="programhasclient" items="${userprofile.rows}">
	<sql:query var="programhasclientidis" dataSource="${dataSource}">
SELECT * FROM program_has_client
WHERE client_id=<c:out value="${programhasclient.client_id}" />
	</sql:query>
</c:forEach>

<!-- workshop -->

<!-- coaching -->
<sql:query var="coachingCategory" dataSource="${dataSource}">
                select * from item,category_has_item,category, itemrun
                where itemrun.item_id = item.item_id
                AND item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.status_id=2
                AND item.item_type_id=?
                                <sql:param value="1" />
</sql:query>

<c:forEach var="itemcoachrunid2" items="${coachingCategory.rows}">
	<sql:query var="itemcoachrunid" dataSource="${dataSource}">
SELECT * FROM itemrun, item
WHERE itemrun.item_id = item.item_id
AND item.item_id=<c:out value="${itemcoachrunid2.item_id}" />
	</sql:query>
</c:forEach>

<c:forEach var="programcoachhasclient2" items="${userprofile.rows}">
	<sql:query var="programcoachhasclientidis" dataSource="${dataSource}">
SELECT * FROM program_has_client
WHERE client_id=<c:out value="${programcoachhasclient2.client_id}" />
	</sql:query>
</c:forEach>
<!-- coaching -->

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

</head>

<body>
	<div class="container">
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li><a href="user.jsp">Home</a></li>
				<li class="active">Student Programs & Courses</li>
			</ol>
		</div>
	</div>

	<br />

	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

		<div class="testing">
			<div class="pull-right">
				<%
					if (request.getAttribute("Error") != null) {
				%>
				<p style="color: red">

					<%=(String) request.getAttribute("Error")%></p>
				<%
					}
				%>
			</div>
			<form action="AddCourseForUser" method="post" class="form-horizontal">
				<div class="row">
					<h2>Programs</h2>
					<hr>

					<!-- workshop & coaching & program -->
					<c:forEach var="gettheuserid" items="${userprofile.rows}">

						<input type="hidden" name="clientidis"
							value="${gettheuserid.client_id}" />
					</c:forEach>
					<!-- workshop & coaching & program -->

					<!-- workshop -->
					<c:forEach var="getitemrunid" items="${itemrunid.rows}">
						<input type="hidden" name="itemrunidgetid"
							value="${getitemrunid.itemrun_id}" />
					</c:forEach>
					<!-- workshop -->


					<!-- coaching -->
					<c:forEach var="getitemcoachrunid" items="${itemcoachrunid.rows}">
						<input type="hidden" name="itemcoachrunidis"
							value="${getitemcoachrunid.itemrun_id}" />
					</c:forEach>
					<!-- coaching -->


					<!-- workshop -->
					<c:forEach var="programhasclient"
						items="${programhasclientidis.rows}">

						<input type="hidden" name="programhasclientis"
							value="${programhasclient.program_has_client_id}" />
					</c:forEach>
					<!-- workshop -->

					<!-- coaching -->
					<c:forEach var="programcoachhasclient"
						items="${programcoachhasclientidis.rows}">

						<input type="hidden" name="programhasclientidis"
							value="${programcoachhasclient.program_has_client_id}" />
					</c:forEach>
					<!-- coaching -->


					<c:forEach var="categoryp" items="${programCategory.rows}">


						<div class="col-xs-6 col-lg-4">
							<div class="alingment">
								<br> <input type="hidden" name="costis"
									value="${categoryp.program_price}" />

								<p>
									<img
										src="http://localhost:8080/impossibleWeb/readImageProgram?id=${categoryp.program_id} class="
										img-thumbnail" class="img-responsive" alt="Cinque Terre" width="304" height="236">
								</p>
								<p>
									<b>Title: </b>
									<c:out value="${categoryp.program_name}" />
<%-- 									<input name="programidis" value="${categoryp.program_id}" />
 --%>
								</p>
								<p>
									<b>Categories: </b>
									<c:out value="${categoryp.category_name}" />
								</p>
								<a class="btn btn-success"
									href="studentviewprogramdetails.jsp?program_id=${categoryp.program_id}">
									View Details &raquo; </a>


							<!-- 	<button type="submit" class="btn btn-primary" name="action"
									value="Submitprogram">Add</button> -->


							</div>
						</div>
					</c:forEach>
				</div>


				<div class="row">
					<h2>Workshops</h2>
					<hr>
					<c:forEach var="categoryw" items="${workshopCategory.rows}">

						<div class="col-xs-6 col-lg-4">
							<div class="alingment">
								<p>
									<img
										src="http://localhost:8080/impossibleWeb/readImageItem?id=${categoryw.item_id} class="
										img-thumbnail" alt="Cinque Terre" class="img-responsive" width="304" height="236">
								</p>

								<br> <input type="hidden" name="itemrunhasclientid"
									value="${categoryw.itemrun_has_client_id}" />

								<p>
									<b>Title: </b>
									<c:out value="${categoryw.item_name}" />
								</p>
								<p>
									<b>Categories: </b>
									<c:out value="${categoryw.category_name}" />
								</p>
								<a class="btn btn-success"
									href="StudentViewWorkshops.jsp?workshop_id=${categoryw.item_id}">
									View Details &raquo; </a>
<!-- 
								<button type="submit" class="btn btn-primary" name="action"
									value="Submitcourse">Add</button> -->

							</div>
						</div>
					</c:forEach>
				</div>


				<div class="row">
					<h2>Coaching Sessions</h2>
					<hr>
					<c:forEach var="categoryc" items="${coachingCategory.rows}">
						<div class="col-xs-6 col-lg-4">
							<div class="alingment">
								<br>

								<p>
									<img
										src="http://localhost:8080/impossibleWeb/readImageItem?id=${categoryc.item_id} class="
										img-thumbnail" alt="Cinque Terre" class="img-responsive" width="304" height="236">
								</p>

								<p>
									<b>Title: </b>
									<c:out value="${categoryc.item_name}" />
								</p>
								<p>
									<b>Categories: </b>
									<c:out value="${categoryc.category_name}" />
								</p>
								<a class="btn btn-success"
									href="studentviewcoaching.jsp?coaching_id=${categoryc.item_id}">
									View Details &raquo; </a>

					<!-- 			<button type="submit" class="btn btn-primary" name="action"
									value="Submitworkshop">Add</button> -->
							</div>
						</div>
					</c:forEach>
				</div>

				<br /> <br /> <br /> <br /> <br />
			</form>

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