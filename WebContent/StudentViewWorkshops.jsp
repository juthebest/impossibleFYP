<!DOCTYPE html>
<html lang="en">
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


<sql:query var="workshopCategory" dataSource="${dataSource}">
                select * from item,category_has_item,category 
                where item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.item_id=<%=request.getParameter("workshop_id")%>

</sql:query>


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Student View Workshops</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">

</head>

<body>
	<!-- start of navigation bar  -->
	<nav id="navMenu"></nav>
	<!-- End of navigation bar  -->

	<div class="container">
		<c:forEach var="workshopCategory" items="${workshopCategory.rows}">

			<div class="page-header">
				<h2>
					<c:out value="${workshopCategory.item_name}" />
					Workshop
				</h2>
			</div>

			<form class="form-horizontal" role="form">
				<div class="col-sm-8">
					<div class="alingment">

						<p>
							<b>Workshop Description:</b>
							<c:out value="${workshopCategory.item_desc}" />
						</p>

						<p>
							<b>Cost:</b>
							<c:out value="${workshopCategory.unit_cost}" />
						</p>

						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" name="action"
								value="Submitcourse">Add</button>
							<a class="btn btn-danger" data-dismiss="modal"
								href="StudentPrograms&Courses.jsp">Back</a>
						</div>
					</div>
				</div>
			</form>

		</c:forEach>
	</div>
	<!-- end of body container -->

	<!-- footer -->
	<footer id="footerMenu"></footer>
	<!-- end of footer -->

	<script src="js/navlinks.js"></script>
	<script src="js/footer.js"></script>
	<script src="js/jquery.spinner.js"></script>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>

	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>