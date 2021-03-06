<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<jsp:include page="main/publicNavigations.jsp"></jsp:include>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

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
<title>I'MPOSSIBLE - Workshops</title>

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
<%
	//allow access only if session exists
	String user = null;
	String uid = null;
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

</head>

<body>

	<div class="container">
		<c:forEach var="workshopCategory" items="${workshopCategory.rows}">

			<div class="page-header">
				<h2>
					<c:out value="${workshopCategory.item_name}" />
					Workshop
				</h2>
			</div>


			<div class="row">
				<div class="col-sm-4">
					<div class="container">

						<img
							src="http://localhost:8080/impossibleWeb/readImageItem?id=${workshopCategory.item_id} class="
							img-thumbnail" alt="Cinque Terre" width="304" height="236">
					</div>


				</div>
				<div class="col-sm-8">

					<div class="alingment">


						<p>
							<b>Workshop Description:</b>
							
							<c:out value="${workshopCategory.item_desc}" escapeXml="false"/>
						</p>

						<p>
							<b>Cost:</b>
							<c:out value="${workshopCategory.unit_cost}" />
						</p>




					</div>
				</div>
			</div>


			<div class="modal-footer">
				<a class="btn btn-info" data-dismiss="modal" href="register.jsp">Register</a><a
					class="btn btn-danger" data-dismiss="modal"
					href="viewProgramsNcourses.jsp">Back</a>

			</div>

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