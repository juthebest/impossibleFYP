<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />


<sql:query var="wsSchedule" dataSource="${dataSource}">
SELECT * FROM itemrun ,item,status,coach,user
where itemrun.item_id = item.item_id
AND itemrun.status_id = status.status_id
AND coach.coach_id=itemrun.coach_id
AND coach.coach_id= user.coach_id
				       
				       
</sql:query>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Admin Workshop Schedule</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<script src="http://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="http://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css"
	rel="stylesheet"></link>
<link href="css/home.css" rel="stylesheet">

<!-- tablesorter theme file-->
<link rel="stylesheet" href="css/theme.default.css">
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

		<div class="jumbotron text-center">
			<div class="container-fluid">
				<div class="panel panel-default">

					<h1>WorkShop Schedule</h1>
					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li class="active"><a href="workshopAdmin.jsp">Manage WorkShop</a></li>
						<li><a href="manageWorkShopSchedule.jsp">Manage Workshop
								Schedule</a></li>
					</ul>


					<div id="wrapper">
						<div id="myScheduler"></div>
					</div>


				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="container-fluid">
			<!-- <div class="alert alert-danger">
				<i class="fa fa-exclamation-circle"></i> Warning: You do not have
				permission to modify courses!
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div> -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Course Schedule List</h3>
				</div>
				<div class="panel-body">

			

					<div class="row">
						<div class="pull-right">

							<!--  Icons for delete, edit and copy -->
							<p class="icons">
								<a href="addWorkshopSchedule.jsp"><button type="button"
										class="btn btn-default btn-sm">
										<span class="glyphicon glyphicon-plus"></span> Add
									</button></a>
								<button type="button" class="btn btn-default btn-sm"
									onClick="checkbox_test()">
									<span class="glyphicon glyphicon-trash"></span> Delete
								</button>



							</p>
						</div>
					</div>

					<form action="delete" method="post" enctype="multipart/form-data"
						id="form-product">
						<div class="table-responsive">
							<table id="myTable"
								class="table table-bordered table-hover tablesorter">
								<thead>
									<tr>
										<!-- <td style="width: 1px;" class="text-center"
											data-sorter="false"><input type="checkbox"
											onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
 -->
										<td class="text-left"><a href="#" class="asc">Course
												Title</a></td>

										<td class="text-left"><a href="#">Start datetime</a></td>
										<td class="text-left"><a href="#">End datetime</a></td>


										<td class="text-left"><a href="#">Trainer</a></td>
										<td class="text-left"><a href="#">Venue</a></td>

										<td class="text-left"><a href="#">Status</a></td>
										<td class="text-left"><a href="#" class="asc">Edit</a></td>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="workshop" items="${wsSchedule.rows}">

										<tr>
											<td class="text-center"><input type="checkbox"
												name="selected[]" value="${workshop.itemrun_id}" /></td>
											<td class="text-left">${workshop.item_name}</td>
											<td class="text-left">${workshop.itemrun_start_datetime}</td>
											<td class="text-left">${workshop.item_end_datetime}</td>
											<td class="text-left">${workshop.given_name}${workshop.surname}</td>
											<td class="text-left">${workshop.itemrun_venue}</td>
											<td class="text-left">${workshop.status_name}</td>
											<td class="text-center">

												<button type="button" class="btn btn-default btn-sm"
													onclick="location.href='editWorkShopSchedule.jsp?wsID=${workshop.itemrun_id}'">
													<span class="glyphicon glyphicon-edit"></span> Edit
												</button>
											</td>

										</tr>
									</c:forEach>



								</tbody>
							</table>
						</div>
					</form>


					<div class="row">
						<div class="col-sm-6 text-left">

							<ul class="pagination">
								<li class="disabled"><a href="#">&laquo;</a></li>
								<li class="active"><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">&raquo;</a></li>
							</ul>

						</div>
						<div class="col-sm-6 text-right">Showing 1 to 20 of 38 (2
							Pages)</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- footer -->
	<footer id="footerMenu"></footer>
	<!-- end of footer -->


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
	<script>
		YUI().use('aui-scheduler', function(Y) {
			var events = [ {
				content : 'Partial Lunar Eclipse',
				endDate : new Date(2013, 3, 25, 5),
				startDate : new Date(2013, 3, 25, 1)
			}, {
				color : "#8d8",
				content : 'Earth Day Lunch',
				disabled : true,
				endDate : new Date(2013, 3, 22, 13),
				meeting : true,
				reminder : true,
				startDate : new Date(2013, 3, 22, 12)
			}, {
				content : "Weeklong",
				endDate : new Date(2013, 3, 27),
				startDate : new Date(2013, 3, 21)
			} ];

			var agendaView = new Y.SchedulerAgendaView();
			var dayView = new Y.SchedulerDayView();
			var weekView = new Y.SchedulerWeekView();
			var monthView = new Y.SchedulerMonthView();

			var eventRecorder = new Y.SchedulerEventRecorder();

			new Y.Scheduler({
				activeView : weekView,
				boundingBox : '#myScheduler',
				date : new Date(2013, 3, 25),
				eventRecorder : eventRecorder,
				items : events,
				render : true,
				views : [ dayView, weekView, monthView, agendaView ]
			});
		});
	</script>

	<!-- load jQuery and tablesorter scripts -->
	<script type="text/javascript" src="js/jquery-latest.js"></script>
	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>

	<!-- tablesorter widgets (optional) -->
	<script type="text/javascript" src="js/jquery.tablesorter.widgets.js"></script>
	<script>
	<!-- 	Start by telling tablesorter to sort your table when the document is loaded: -->
		$(function() {
			$("#myTable").tablesorter();
		});

		//pass in configuration options when you initialize the table. This tells tablesorter to sort on the first and second column in ascending order.  -->
		$(function() {
			$("#myTable").tablesorter({
				sortList : [ [ 1, 0 ], [ 2, 0 ], ]
			});
		});
	</script>
	<script type="text/javascript">

		function checkbox_test() {

			var counter = 0, 
			i = 0, 
			url = '', 
		
			input_obj = document.getElementsByTagName('input');
			
			for (i = 0; i < input_obj.length; i++) {
		
				if (input_obj[i].type === 'checkbox'
						&& input_obj[i].checked === true) {
				

					url = url + '&wseID=' + input_obj[i].value;
					counter++;

				}

			}


			if (counter > 0) {
			
				url = url.substr(1);

				alert("confirm('Delete/Uninstall cannot be undone! Are you sure you want to do this?') ");
			
				window.location.href = 'deleteWorkShopScheduleServlet?' + url;
			} else {
				alert('There is no checked checkbox');
			}
			var table = document.getElementById('myTable');
			var rowCount = table.rows.length;   
			for (var i = 0; i < rowCount; i++) {            
				var row = table.rows[i];             
				var chkbox = row.cells[0].childNodes[0];              
				if (null != chkbox && true == chkbox.checked) {        
					table.deleteRow(i);                  
					rowCount--;                  
					i--;
				}

			}
		}
	</script>


</body>
</html>