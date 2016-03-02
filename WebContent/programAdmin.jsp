<!DOCTYPE html>
<html lang="en">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<!-- select * from item,category_has_item,category,item_type,status
                where item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.item_type_id=item_type.item_type_id
				AND item.status_id=status.status_id
                AND item.item_type_id=?     -->

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session"
	user="root" password="" />

<sql:query var="programCategory" dataSource="${dataSource}">
               	select * from program,status
				where program.status_id=status.status_id  
				
				       
</sql:query>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Manage Program</title>
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<link href="css/home.css" rel="stylesheet">
<!-- tablesorter theme file-->
<link rel="stylesheet" href="css/theme.default.css">
<%-- <%
	
	
	
		//allow access only if session exists
		String user = null;

		String role=(String) session.getAttribute("role");
		String uid = null;
		 if(session.getAttribute("name") == null || session.getAttribute("role") == null || !role.equals("admin")){
		response.sendRedirect("login.html");
		}else user = (String) session.getAttribute("name");
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
 --%>
</head>

<script src="ckeditor/ckeditor.js"></script>

<body>

	<div class="container">
		<div class="jumbotron text-center">
			<div class="container-fluid">
				<div class="panel panel-default">
					<h1>Manage Program</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li class="active"><a href="programAdmin.jsp">Manage
								Programs</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Programs</h3>
				</div>

				<div class="panel-body">

					<form action="servletDirectProgram" method="get" enctype="multipart/form-data"
						id="form-category">
						<div class="table-responsive">
							<table id="myTable"
								class="table table-bordered table-hover tablesorter">

								<thead>
									<tr>
										<td style="width: 1px;" class="text-center"
											data-sorter="false"><input type="checkbox"
											onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>

										<td class="text-left"><a class="asc">Program
												Name</a></td>

										<td class="text-left"><a class="asc">Duration(days)</a></td>

										<td class="text-left"><a class="asc">Cost</a></td>

										<td class="text-left"><a class="asc">Status</a></td>
										
										
									</tr>
								</thead>

								<tbody>
									<c:forEach var="category" items="${programCategory.rows}">
										<tr>
											<td class="text-center"><input type="checkbox"
												name="selected"
												value="<c:out
													value="${category.program_id}" />" />
											<td class="text-left"><c:out
													value="${category.program_name}" /></td>
											<td class="text-left"><c:out
													value="${category.program_duration}" /></td>
											<td class="text-left"><c:out
													value="${category.program_price}" /></td>
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

								<a href="addProgram.jsp"><button type="button"
										class="btn btn-default btn-sm">Add</button></a>

								<!-- <button type="button" class="btn btn-default btn-sm"
								onclick="confirm('Delete/Uninstall cannot be undone! Are you sure you want to do this?') ? $('#form-product').submit() : false;">
								<span class="glyphicon glyphicon-trash"></span> Delete
							</button> -->
								<input type="submit" value="Delete" name="direct"
									class="btn btn-default btn-sm" />

								<!-- <a
								href="editWorkshop.jsp?selectedId="><button
									type="button" class="btn btn-default btn-sm">
									<span class="glyphicon glyphicon-edit"></span> Edit
								</button></a> -->
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
	<div class="modal fade" id="addCourse">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal">
					<div class="modal-header">
						<h4>Courses</h4>
					</div>

					<div class="modal-body">
						<div class="panel panel-default">
							<!-- Default panel contents -->
							<div class="panel-heading">
								<label>Add Course</label>
							</div>

							<!-- Table -->
							<table class="table table-striped">
								<tr>
									<td>Anger Management</td>
									<td>
										<!-- use sql to extract the contents of a particular table -->
										<div class="dropdown">
											<button class="btn btn-default dropdown-toggle" type="button"
												id="dropdownMenu1" data-toggle="dropdown"
												aria-haspopup="true" aria-expanded="true">
												Date <span class="caret"></span>
											</button>
											<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
												<li><a href="#">21/10/2015</a></li>
												<li><a href="#">12/11/2015</a></li>
												<li><a href="#">10/11/2015</a></li>
												<li><a href="#">25/11/2015</a></li>
												<li><a href="#">Add New...</a></li>
											</ul>
										</div>
									</td>
									<td><input type="checkbox" name="checkbox"
										value="checkbox"></td>

								</tr>
								<tr>
									<td>Stress Management</td>
									<td>
										<!-- use sql to extract the contents of a particular table -->
										<div class="dropdown">
											<button class="btn btn-default dropdown-toggle" type="button"
												id="dropdownMenu1" data-toggle="dropdown"
												aria-haspopup="true" aria-expanded="true">
												Date <span class="caret"></span>
											</button>
											<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
												<li><a href="#">21/10/2015</a></li>
												<li><a href="#">12/11/2015</a></li>
												<li><a href="#">10/11/2015</a></li>
												<li><a href="#">25/11/2015</a></li>
												<li><a href="#">Add New...</a></li>
											</ul>
										</div>
									</td>
									<td><input type="checkbox" name="checkbox"
										value="checkbox"></td>

								</tr>
								<tr>
									<td>Relaxing</td>
									<td>
										<!-- use sql to extract the contents of a particular table -->
										<div class="dropdown">
											<button class="btn btn-default dropdown-toggle" type="button"
												id="dropdownMenu1" data-toggle="dropdown"
												aria-haspopup="true" aria-expanded="true">
												Date <span class="caret"></span>
											</button>
											<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
												<li><a href="#">21/10/2015</a></li>
												<li><a href="#">12/11/2015</a></li>
												<li><a href="#">10/11/2015</a></li>
												<li><a href="#">25/11/2015</a></li>
												<li><a href="#">Add New...</a></li>
											</ul>
										</div>
									</td>
									<td><input type="checkbox" name="checkbox"
										value="checkbox"></td>

								</tr>
								<tr>
									<td>Resting</td>
									<td>
										<!-- use sql to extract the contents of a particular table -->
										<div class="dropdown">
											<button class="btn btn-default dropdown-toggle" type="button"
												id="dropdownMenu1" data-toggle="dropdown"
												aria-haspopup="true" aria-expanded="true">
												Date <span class="caret"></span>
											</button>
											<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
												<li><a href="#">21/10/2015</a></li>
												<li><a href="#">12/11/2015</a></li>
												<li><a href="#">10/11/2015</a></li>
												<li><a href="#">25/11/2015</a></li>
												<li><a href="#">Add New...</a></li>
											</ul>
										</div>
									</td>
									<td><input type="checkbox" name="checkbox"
										value="checkbox"></td>
								</tr>
							</table>
						</div>
					</div>

					<div class="modal-footer">
						<a class="btn btn-default" data-dismiss="modal">Close</a>
						<button type="submit" class="btn btn-primary">Add Course</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- /the popout signin shit -->


	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/navlinks-admin.js"></script>
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
	$(function(){
  $("#myTable").tablesorter();
});

<!-- pass in configuration options when you initialize the table. This tells tablesorter to sort on the first and second column in ascending order.  -->
$(function(){
  $("#myTable").tablesorter({ sortList: [ [1,0], [2,0],] });
});
  

	</script>
</body>
</html>