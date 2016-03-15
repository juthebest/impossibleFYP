<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/parentNavigation.jsp"></jsp:include>

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




<sql:query var="parentdetails" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE user.parent_id = client.parent_id
AND user.user_id = <%=uid%>;</sql:query>


<c:forEach var="userprofile2" items="${parentdetails.rows}">
	<sql:query var="userprofile" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE client.client_id = user.client_id
AND client.client_id=<c:out value="${userprofile2.client_id}" />
	</sql:query>
</c:forEach>


<%-- 
<!--  get client id so that you know which user register -->
<sql:query var="userprofile" dataSource="${dataSource}">
SELECT * 
FROM  user where user_id= <%=uid%>;
</sql:query> --%>


<sql:query var="workshop" dataSource="${dataSource}">
	select * from item,category_has_item,category,item_type,status
    where item.item_id=category_has_item.item_id 
    AND category_has_item.category_id=category.category_id 
    AND item.item_type_id=item_type.item_type_id
	AND item.status_id=status.status_id
   AND item.item_id=<%=request.getParameter("workshop_id")%>
</sql:query>


<!-- workshop -->
<sql:query var="workshopCategory" dataSource="${dataSource}">
                select * from item,category_has_item,category 
                where item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.status_id = 2
                AND item.item_type_id = 2
                AND item.item_id = <%=request.getParameter("workshop_id")%>
</sql:query>


<c:forEach var="itemrunid2" items="${workshopCategory.rows}">
	<sql:query var="itemrunid" dataSource="${dataSource}">
SELECT * FROM itemrun, item
WHERE itemrun.item_id = item.item_id
AND item.item_id = <c:out value="${itemrunid2.item_id}" />
	</sql:query>
</c:forEach>

<c:forEach var="programhasclient" items="${userprofile.rows}">
	<sql:query var="programhasclientidis" dataSource="${dataSource}">
SELECT * FROM program_has_client
WHERE client_id=<c:out value="${programhasclient.client_id}" />
	</sql:query>
</c:forEach>
<!-- workshop -->

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

	<div class="container">
		<form action="AddCourseForParent" method="post" class="form-horizontal">


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

			<!-- workshop -->
			<c:forEach var="programhasclient"
				items="${programhasclientidis.rows}">

				<input type="hidden" name="programhasclientis"
					value="${programhasclient.program_has_client_id}" />
			</c:forEach>
			<!-- workshop -->

			<c:forEach var="workshopCat" items="${workshop.rows}">

				<div class="page-header">
					<h2>
						<c:out value="${workshopCat.item_name}" />
					</h2>
				</div>

				<div class="col-sm-8">
					<div class="alingment">

						<p>
							<b>Workshop Description:</b>
							<c:out value="${workshopCat.item_desc}"  escapeXml = "false" />
						</p>

						<p>
							<b>Cost:</b>
							<c:out value="${workshopCat.unit_cost}" />
						</p>

						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" name="action"
								value="Submitcourse">Add</button>
							<a class="btn btn-danger" data-dismiss="modal"
								href="ParentPrograms&Courses.jsp">Back</a>
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