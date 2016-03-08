<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<sql:query var="wsSchedule" dataSource="${dataSource}">
SELECT itemrun_id, item.item_id, item.item_name ,status.status_id, coach.coach_id, DATE( itemrun_start_datetime ) AS sd, DATE( item_end_datetime ) AS ed, TIME( itemrun_start_datetime ) AS st, TIME( item_end_datetime ) AS et, itemrun_venue, coach.coach_id, status.status_name, user.given_name, user.surname
FROM itemrun, item, 
STATUS , coach, user
WHERE itemrun.item_id = item.item_id
AND itemrun.status_id = status.status_id
AND coach.coach_id = itemrun.coach_id
AND coach.coach_id = user.coach_id
				       
AND  itemrun_id=<%=request.getParameter("wsID")%>

</sql:query>
<sql:query var="coach" dataSource="${dataSource}">
    SELECT * FROM `coach` , user where coach.coach_id =user.coach_id
</sql:query>

<sql:query var="status" dataSource="${dataSource}">
    SELECT * FROM `status`
</sql:query>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Admin Edit Course Schedule</title>
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/bootstrap.min.css" rel="stylesheet">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- Bootstrap CSS and bootstrap datepicker CSS used for styling the demo pages-->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/datepicker.css">

<link rel="stylesheet" type="text/css"
	href="dist/jquery-clockpicker.min.css">
<link rel="stylesheet" type="text/css" href="assets/css/github.min.css">
<link
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/home.css" />
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
</head>

<body>


	<div class="container">

		<div id="content">
			<div class="page-header">
				<div class="container-fluid">

					<h1>Edit Workshop Schedule</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="manageWorkShopSchedule.jsp">Workshop
								Schedule</a></li>
						<li><a href="addWorkshopSchedule.jsp">Add Workshop
								Schedule</a></li>
						<li><a href="">Edit Workshop Schedule</a></li>
					</ul>
				</div>
			</div>
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Edit WorkShop Schedule
						</h3>
					</div>
					<div class="panel-body">


						<c:forEach var="workshop" items="${wsSchedule.rows}">
							<form action="editWorkShopSchedule" method="post"
								class="form-horizontal" data-toggle="validator" role="form">

								<input type="hidden" name="id"
									value="	<c:out value="${workshop.itemrun_id}"/>" />

								<div class="form-group">
									<label class="control-label col-sm-2" for="wsname">Select
										Workshop Name</label>

									<div class="col-sm-9">
										<select class="form-control" name="wsname">
											<option value="${workshop.item_id}">${workshop.item_name}</option>
										</select>
									</div>

								</div>





								<div class="form-group">
									<label class="control-label col-sm-2" for="sdt">Start
										Date :</label>
									<div class="col-sm-9">
										<div class='input-group date' id='datetimepicker1'>
											<input class="form-control" type="text" name="sdt"
												id="example1"  required> <span
												class="input-group-addon"> <span
												class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-2" for="edt">End
										Date :</label>

									<div class="col-sm-9">
										<div class='input-group date' id='datetimepicker1'>
											<input class="form-control" type="text" name="edt"
												id="example2" > <span
												class="input-group-addon"> <span
												class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>

									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-sm-2" for="st">Start
										Time :</label>

									<div class="clearfix">
										<div class="col-sm-9">
											<div class="input-group clockpicker pull-center"
												data-placement="bottom" data-align="top"
												data-autoclose="true">

												<input type="text" class="form-control" 
													name="st" value="${workshop.st}"> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-time"></span>
												</span>
											</div>
										</div>

									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-2" for="et">End Time
										:</label>

									<div class="clearfix">
										<div class="col-sm-9">
											<div class="input-group clockpicker pull-center"
												data-placement="bottom" data-align="top"
												data-autoclose="true">

												<input type="text" class="form-control" 
													name="et" value="${workshop.et}"> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-time"></span>
												</span>
											</div>
										</div>

									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-2" for="coachInCharge">Coach
										In-Charge</label>
									<div class="col-sm-9">

										<select class="form-control" name="coachInCharge">
											<option value="${workshop.coach_id}">${workshop.surname}
												${workshop.given_name}</option>
											<c:forEach var="coach" items="${coach.rows}">
												<option value="${coach.coach_id}">${coach.surname}
													${coach.given_name}</option>
											</c:forEach>
										</select>

									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-sm-2" for="venue">Venue
										:</label>
									<div class="col-sm-9">
										<input class="form-control" type="text" name="venue"
											value="${workshop.itemrun_venue}" required>
									</div>
								</div>



								<div class="form-group">
									<label class="control-label col-sm-2" for="status">Status</label>
									<div class="col-sm-9">

										<select class="form-control" name="status">
											<option value="${workshop.status_id}">${workshop.status_name}</option>
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


	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>

	<!-- Load jQuery and bootstrap datepicker scripts -->
	<script src="js/jquery-1.12.1.min.js"></script>

	<script type="text/javascript">
		// When the document is ready
		$(document).ready(function() {

			$('#example1').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true,
				todayHighlight : true,
	
			}).datepicker('update', new Date());
			;

			$('#example2').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true,
				todayHighlight : false
			}).datepicker('update', new Date());
			;
			
			

			<c:forEach var="workshop" items="${wsSchedule.rows}">
			var datebirth="${workshop.sd}"; 
			</c:forEach>
			$("#example1").datepicker("setDate",new Date(datebirth));
			
			

			<c:forEach var="workshop" items="${wsSchedule.rows}">
			var edatebirth="${workshop.ed}"; 
			</c:forEach>
			$("#example2").datepicker("setDate",new Date(edatebirth));
		});
	</script>


	<script type="text/javascript" src="dist/jquery-clockpicker.min.js"></script>
	<script type="text/javascript">
		$('.clockpicker').clockpicker().find('input').change(function() {
			console.log(this.value);
		});
		$('#single-input').clockpicker({
			placement : 'bottom',
			align : 'right',
			autoclose : true,
			'default' : '20:48'
		});
		$('.clockpicker-with-callbacks').clockpicker({
			donetext : 'Done',
			init : function() {
				console.log("colorpicker initiated");
			},
			beforeShow : function() {
				console.log("before show");
			},
			afterShow : function() {
				console.log("after show");
			},
			beforeHide : function() {
				console.log("before hide");
			},
			afterHide : function() {
				console.log("after hide");
			},
			beforeHourSelect : function() {
				console.log("before hour selected");
			},
			afterHourSelect : function() {
				console.log("after hour selected");
			},
			beforeDone : function() {
				console.log("before done");
			},
			afterDone : function() {
				console.log("after done");
			}
		}).find('input').change(function() {
			console.log(this.value);
		});
		if (/Mobile/.test(navigator.userAgent)) {
			$('input').prop('readOnly', true);
		}
	</script>
	<script
		src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>


</body>
</html>