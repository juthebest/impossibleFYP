<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />


<sql:query var="userc" dataSource="${dataSource}">
SELECT * 
FROM  `user` 
WHERE role =  'child'
OR role =  'parent'


</sql:query>




<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Manage User</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">



<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>

  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<script src="http://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="http://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css"
	rel="stylesheet"></link>
<link href="css/home.css" rel="stylesheet">
<!-- tablesorter theme file-->
<link rel="stylesheet" href="css/theme.default.css">
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
					<h1>Manage User</h1>
					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="manageCoachUser.jsp">Manage Coach User</a></li>
						<li><a href="manageAdminUser.jsp">Manage Admin User</a></li>
						<li><a href="manageUser.jsp">Manage Client User</a></li>
					</ul>







				</div>
			</div>

		</div>
	</div>
	<div class="container">
		<div class="container-fluid">

			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Client User List</h3>
				</div>
				<div class="panel-body">



					<div class="pull-right">

						<!--  Icons for delete, edit and copy -->
						<p class="icons">
							<a href="addUser.jsp"><button type="button"
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
										<!-- <td style="width: 1px;" class="text-center"
											data-sorter="false"><input type="checkbox"
											onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td> -->
										<td class="text-left"><a href="#" class="asc">User
												Salutation</a></td>


										<td class="text-left"><a href="#" class="asc">User
												Name</a></td>
								

										<td class="text-left"><a href="#">User Mobile</a></td>
										<td class="text-left"><a href="#">User Email</a></td>
										<td class="text-left"><a href="#">User Address</a></td>

										<td class="text-left"><a href="#">User Date
												Registered</a></td>


										<td class="text-left"><a href="#">User Role</a></td>
	<td class="text-left"><a href="#">Date</a></td>


									</tr>
								</thead>
								<tbody>
				
									<c:forEach var="userm" items="${userc.rows}">
						
										<tr>
											<td class="text-center"><input type="checkbox"
												name="selected[]" value="${userm.user_id}" /></td>

											<td class="text-left"><c:out
													value=" ${userm.salutation}" /></td>
													
											<td class="text-left"><c:out
													value="${userm.given_name} ${userm.surname}" /></td>
												
											
												
										
											<td class="text-left"><c:out value="${userm.mobile}" /></td>
											<td class="text-left"><c:out value="${userm.email}" /></td>
											<td class="text-left"><c:out value="${userm.address}" /></td>
											<td class="text-left"><c:out
													value="${userm.create_update_datetime}" /></td>
											<td class="text-left"><c:out value="${userm.role}" /></td>
											
											<td class="text-center">

											<button type="button" class="btn btn-default btn-sm"
												onclick="location.href='editUser.jsp?userID=${userm.user_id}'">
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






	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/navlinks-admin.js"></script>
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
				

					url = url + '&userID=' + input_obj[i].value;
					counter++;

				}

			}


			if (counter > 0) {
			
				url = url.substr(1);
	
				alert( "confirm('Delete/Uninstall cannot be undone! Are you sure you want to do this?') ");

				window.location.href = 'deleteUser?' + url;
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


