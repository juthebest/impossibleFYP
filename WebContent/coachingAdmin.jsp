<!DOCTYPE html>
<html lang="en">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<sql:query var="coachingCategory" dataSource="${dataSource}">
                select * from item,item_type,status
                where item.item_type_id=item_type.item_type_id
				AND item.status_id=status.status_id
                AND item.item_type_id=?
                                <sql:param value="1" />
</sql:query>


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Manage Coaching</title>
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>

  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- tablesorter theme file-->
<link rel="stylesheet" href="css/theme.default.css">
<%-- <%
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
%> --%>
<script type="text/javascript">
	$(function validate() {
		var cBvalue = document.getElementsByID("selected");

		var cBselected = 0;
		//Loop through the checkbox elements, and tally the selected
		for (var i = 0; i < cBvalue.length; i++) {
			if (cBvalue[i].checked) {
				cBselected++;
			}
		}
		//If none are selected, then alert your error, and return false
		if (cBselected == 0) {
			alert("Please select checkbox");
			return false;
		}
	});
</script>
</head>





<body>

	<div class="container">
		<div class="jumbotron text-center">
			<div class="container-fluid">
				<div class="panel panel-default">
					<h1>Manage Coaching</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li class="active"><a href="coachingAdmin.jsp">Manage
								Coaching</a></li>

					</ul>

				</div>
			</div>
		</div>
	</div>
	<!-- <div class="alert alert-danger">
		<i class="fa fa-exclamation-circle"></i> Warning: You do not have
		permission to modify courses!
		<button type="button" class="close" data-dismiss="alert">&times;</button>
	</div> -->
	<div class="container">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Coaching</h3>
				</div>

				<div class="panel-body">


					<form action="servletDirectCoaching" method="get"
						enctype="multipart/form-data" id="form-course" onsubmit="return validate()">
						<div class="table-responsive">
							<table id="myTable"
								class="table table-bordered table-hover tablesorter">
								<thead>
									<tr>
										<td /></td>

										<td class="text-left"><a href="#" class="asc">Coaching
												Session Name</a></td>
										<td class="text-left"><a href="#" class="asc">Coaching
												Session Type</a></td>
										<td class="text-left"><a href="#" class="asc">Duration(days)</a></td>

										<td class="text-left"><a href="#" class="asc">Cost</a></td>

										<td class="text-left"><a href="#" class="asc">Status
										</a></td>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="category" items="${coachingCategory.rows}">

										<tr>
											<td class="text-center"><input type="checkbox"
												name="selected"
												value="<c:out
													value="${category.item_id}" />" />
											<td class="text-left"><c:out
													value="${category.item_name}" /></td>
											<td class="text-left"><c:out
													value="${category.item_type_name}" /></td>
											<td class="text-left"><c:out
													value="${category.item_duration}" /></td>
											<td class="text-left"><c:out
													value="${category.unit_cost}" /></td>
											<td class="text-left"><c:out
													value="${category.status_name}" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="pull-right">
							<!--  Icons for delete, edit and copy -->
							<p class="icons">
								<a href="addCoaching.jsp"><button type="button"
										class="btn btn-default btn-sm">Add</button></a>
																	
								<input type="submit" value="Delete" name="direct"
									class="btn btn-default btn-sm" />			
												
								<input type="submit" value="Edit" name="direct"
									class="btn btn-default btn-sm" />
							</p>


						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- <End> -->




	<!-- 	Place bootstrap core javascript below so pages load faster -->

	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->


	<script src="js/footer.js"></script>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
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

		/* <!-- pass in configuration options when you initialize the table. This tells tablesorter to sort on the first and second column in ascending order  -->
		 */
		$(function() {
			$("#myTable").tablesorter({
				sortList : [ [ 1, 0 ], [ 2, 0 ] ]
			});
		});
	</script>
</body>


</html>

