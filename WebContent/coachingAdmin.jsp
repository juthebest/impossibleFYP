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
<!-- Pick a theme, load the plugin & initialize plugin -->
<link href="dist/css/theme.default.min.css" rel="stylesheet">
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


					<!-- <form action="servletDirectCoaching" method="get"
					enctype="multipart/form-data" id="form-course" onsubmit="return validate()"> -->
						
			<div class="pull-right">
							<!--  Icons for delete, edit and copy -->
							<p class="icons">
								<a href="addCoaching.jsp"><button type="button"
										class="btn btn-default btn-sm">Add</button></a>
																	
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
										<td  class="sorter-false"></td>

										<td class="text-left"><a href="#" class="asc">Coaching
												Session Name</a></td>
										<td class="text-left"><a href="#" class="asc">Coaching
												Session Type</a></td>
										<td class="text-left"><a href="#" class="asc">Duration(days)</a></td>

										<td class="text-left"><a href="#" class="asc">Cost</a></td>

										<td class="text-left"><a href="#" class="asc">Status
										</a></td>
										<td  class="sorter-false"><a href="#" class="asc">Edit</a></td>

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
										
										
											<td class="text-center">

											<button type="button" class="btn btn-default btn-sm"
												onclick="location.href='editCoaching.jsp?catID=${category.item_id}'">
												<span class="glyphicon glyphicon-edit"></span> Edit
											</button>
										</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
			
		<!-- 		</form> -->
				</div>
			</div>
		</div>
	</div>


<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->


	<script src="js/footer.js"></script>
	

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
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

			var counter = 0, 
			i = 0, 
			url = '', 
		
			input_obj = document.getElementsByTagName('input');
		
			for (i = 0; i < input_obj.length; i++) {
			
				if (input_obj[i].type === 'checkbox'
						&& input_obj[i].checked === true) {
					url = url + '&catID=' + input_obj[i].value;

					counter++;

				}

			}

		
			if (counter > 0) {
				
				url = url.substr(1);
			
				alert("confirm('Delete/Uninstall cannot be undone! Are you sure you want to do this?') ");
			
				 window.location.href = 'deleteServletCoaching?' + url; 
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

