<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<!--   -->
<sql:query var="status" dataSource="${dataSource}">
    SELECT * FROM `status` 

</sql:query>
<sql:query var="coach" dataSource="${dataSource}">
    SELECT * FROM `coach` , user where coach.coach_id =user.coach_id

</sql:query>
<sql:query var="item" dataSource="${dataSource}">
    SELECT * FROM `item` 

</sql:query>
<%
	//allow access only if session exists
	String user = null;

	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| session.getAttribute("role") != "admin") {
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
<title>I'MPOSSIBLE - Admin Add Course Schedule</title>

<link rel="stylesheet" type="text/css" href="css/flaticon.css">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet">


<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>


<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/jquery-ui.min.css" rel="stylesheet">
<script src="http://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="http://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css"
	rel="stylesheet"></link>
<link rel="stylesheet" type="text/css" href="css/home.css" />
</head>

<body>



	<div class="container">

		<div id="content">
			<div class="page-header">
				<div class="container-fluid">

					<h1>Add New Workshop Schedule</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="manageWorkShopSchedule.jsp">Workshop Schedule</a></li>
						<li><a href="addWorkshopSchedule.jsp">Add Workshop Schedule</a></li>
					</ul>
				</div>
			</div>
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Add New WorkShop Schedule
						</h3>
					</div>
					<div class="panel-body">



						<form action="addWorkShopSchedule" method="post"
							class="form-horizontal" data-toggle="validator"  role="form">

							<div class="form-group">
								<label class="control-label col-sm-2" for="wsname">Select
									Workshop Name</label>
								<div class="col-sm-9">

									<select class="form-control" name="wsname">
										<c:forEach var="item" items="${item.rows}">
											<option value="${item.item_id}">${item.item_name}</option>
										</c:forEach>
									</select>

								</div>

							</div>



							<div class="form-group">
								<label class="col-sm-2 control-label" for="sdt">Start
									DateTime:</label>
								<div class="col-sm-9">
									<input type="datetime" class="form-control" name="sdt"
										value="2014-02-06 9:00" required>
								</div>

							
							</div>

						
							<div class="form-group">
									<label class="col-sm-2 control-label" for="edt">End
									Datetime:</label>
								<div class="col-sm-9">
									<input type="datetime" class="form-control" name="edt"
										value="2014-02-06 9:00" required>
								</div>
							</div>


							<div class="form-group">
								<label class="control-label col-sm-2" for="coachInCharge">Coach
									In-Charge</label>
								<div class="col-sm-9">

									<select class="form-control" name="coachInCharge">
										<c:forEach var="coach" items="${coach.rows}">
											<option value="${coach.coach_id}">${coach.surname}${coach.given_name}
											</option>
										</c:forEach>
									</select>

								</div>

							</div>


							<div class="form-group">
								<label class="control-label col-sm-2" for="venue">Venue
									:</label>
								<div class="col-sm-9">
									<input class="form-control" type="text" name="venue" required>
								</div>
							</div>



							<div class="form-group">
								<label class="control-label col-sm-2" for="status">Status</label>
								<div class="col-sm-9">

									<select class="form-control" name="status">
										<c:forEach var="status" items="${status.rows}">
											<option value="${status.status_id}">${status.status_name}</option>
										</c:forEach>
									</select>
								</div>

							</div>



							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Save
									changes</button>
								<a href="manageWorkShopSchedule.jsp"><button type="button"
										class="btn btn-danger">Cancel</button></a>

							</div>


						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->
	<script src="js/footer.js"></script>
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		$("#dp1").datepicker({
		//changeMonth: true,
		//changeYear: true
		});
		$("#dp2").datepicker({
		//changeMonth: true,
		//changeYear: true
		});
	</script>

	<script>
		YUI().use('aui-timepicker', function(Y) {
			new Y.TimePicker({
				trigger : '#time',
				popover : {
					zIndex : 1
				},
				on : {
					selectionChange : function(event) {
						console.log(event.newSelection)
					}
				}
			});
		});
	</script>
</body>
</html>