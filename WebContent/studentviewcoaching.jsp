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

<sql:query var="coaching" dataSource="${dataSource}">
	select * from item,category_has_item,category,item_type,status
                where item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.item_type_id=item_type.item_type_id
				AND item.status_id=status.status_id
                AND item.item_id=<%=request.getParameter("coaching_id")%>
</sql:query>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - View Coaching Session</title>
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/bootstrap-spinner.css" rel="stylesheet">
<link href="css/home.css" rel="stylesheet">
</head>

<body>

	<div class="container">
		<form action="AddCourseForUser" method="post" class="form-horizontal">

			<c:forEach var="coaching" items="${coaching.rows}">

				<div class="page-header">
					<h2>
						<c:out value="${coaching.item_name}" />
						Coaching Session
					</h2>
				</div>


				<div class="col-sm-8">
					<div class="alingment">

						<p>
							<b>Coaching Session Description:</b>
							<c:out value="${coaching.item_desc}" />
						</p>

						<p>
							<b>Cost:</b>
							<c:out value="${coaching.unit_cost}" />
						</p>

						<div class="form-group">

							<label class="control-label col-sm-1" for="quantity">Quantity:
							</label>

							<div class="col-sm-2">
								<div class="input-group spinner" data-trigger="spinner">
									<input type="text" class="form-control" value="1"
										data-rule="quantity" name="quantity">
									<div class="input-group-addon">
										<a href="javascript:;" class="spin-up" data-spin="up"><i
											class="icon-sort-up"></i></a> <a href="javascript:;"
											class="spin-down" data-spin="down"><i
											class="icon-sort-down"></i></a>
									</div>
								</div>
							</div>
						</div>

						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" name="action"
								value="Submitworkshop">Add</button>
							<a class="btn btn-danger" data-dismiss="modal"
								href=StudentPrograms&Courses.jsp>Back</a>
						</div>

					</div>
				</div>

			</c:forEach>

		</form>
	</div>
	<!-- end of body container -->

	<!-- footer -->
	<footer id="footerMenu"></footer>
	<!-- end of footer -->


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