<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>



<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />


<sql:query var="coachuser" dataSource="${dataSource}">
SELECT * 
FROM  `user` , coach
WHERE user.coach_id = coach.coach_id

				       
</sql:query>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Manage Coach User</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">
<!-- Pick a theme, load the plugin & initialize plugin -->
<link href="dist/css/theme.default.min.css" rel="stylesheet">
</head>
<body>
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

	<!-- Start of body  -->
	<div class="container">
		<div class="jumbotron text-center">
			<div class="container-fluid">
				<div class="panel panel-default">
					<h1>Manage Coach User</h1>
					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="manageAdminUser.jsp">Manage Admin User</a></li>
						<li><a href="manageUser.jsp">Manage Client User</a></li>
						<li><a href="manageCoachUser.jsp">Manage Coach User</a></li>
					</ul>







				</div>


			</div>
		</div>

	</div>

	<div class="container">
		<div class="container-fluid">

			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Coach User List</h3>
				</div>
				<div class="panel-body">



					<div class="pull-right">
	<%
							if (request.getAttribute("Error") != null) {
						%>
						<p style="color: red">

							<%=(String) request.getAttribute("Error")%></p>
						<%
							}
						%>

						<!--  Icons for delete, edit and copy -->
						<p class="icons">
							<a href="addCoachUser.jsp"><button type="button"
									class="btn btn-default btn-sm">
									<span class="glyphicon glyphicon-plus"></span> Add
								</button></a>
							<button type="button" class="btn btn-default btn-sm"
								onClick="checkbox_test()">
								<span class="glyphicon glyphicon-trash"></span> Delete
							</button>

						</p>
					</div>



					<div class="table-responsive">
						<table id="myTable"
							class="table table-bordered table-hover tablesorter">
							<thead>
								<tr>
								



									<td class="sorter-false"></td>
									<td class="text-left"><a href="#">Coach Name</a></td>
									<td class="text-left"><a href="#">Coach Email</a></td>
									<td class="text-left"><a href="#">Salutation</a></td>
									<td class="text-left"><a href="#">Coach Mobile</a></td>


									<td class="text-left"><a href="#">Registered Date</a></td>
									<td class="text-left"><a href="#">Coach Hourly Rate</a></td>
									<td class="text-left"><a href="#">Coach Profile</a></td>
									<td class="text-left"><a href="#">Address </a></td>

									<td class="sorter-false"><a href="#" class="asc">Edit</a></td>

								</tr>
							</thead>
							<tbody>
								<c:forEach var="coachU" items="${coachuser.rows}">
									<tr>


										<td class="text-center"><input type="checkbox"
											name="selected[]" value="${coachU.coach_id}" /></td>

										<td class="text-left"><c:out
												value=" ${coachU.given_name} ${coachU.surname} " /></td>
										<td class="text-left"><c:out value="${coachU.email}" /></td>

										<td class="text-left"><c:out value="${coachU.salutation}" /></td>
										<td class="text-left"><c:out value="${coachU.mobile}" /></td>
										<td class="text-left"><c:out
												value="${coachU.create_update_datetime}" /></td>
										<td class="text-left"><c:out
												value="${coachU.coach_hourly_rate}" /></td>
										<td class="text-left"><c:out
												value="${coachU.coach_profile}" /></td>
										<td class="text-left"><c:out value="${coachU.address}" /></td>
										<td class="text-center">




											<button type="button" class="btn btn-default btn-sm"
												onclick="location.href='editCoachUser.jsp?coachID=${coachU.coach_id}'">
												<span class="glyphicon glyphicon-edit"></span> Edit
											</button>
										</td>
									</tr>
								</c:forEach>





							</tbody>
						</table>
					</div>


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


	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->


	<script src="js/footer.js"></script>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<!-- jQuery: required (tablesorter works with jQuery 1.2.3+) -->
	<script src="docs/js/jquery-1.2.6.min.js"></script>


	<script src="dist/js/jquery.tablesorter.min.js"></script>
	<script src="dist/js/jquery.tablesorter.widgets.min.js"></script>
	<script>
		$(function() {

			$('table').tablesorter({

				usNumberFormat : false,
				sortReset : true,
				sortRestart : true

			});
		});
	</script>
	<script type="text/javascript">
		function checkbox_test() {

			var counter = 0, i = 0, url = '',

			input_obj = document.getElementsByTagName('input');

			for (i = 0; i < input_obj.length; i++) {

				if (input_obj[i].type === 'checkbox'
						&& input_obj[i].checked === true) {

					url = url + '&coachID=' + input_obj[i].value;
					counter++;

				}

			}

			if (counter > 0) {

				url = url.substr(1);

				alert("confirm('Delete/Uninstall cannot be undone! Are you sure you want to do this?') ");

				window.location.href = 'deleteCoach?' + url;
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


