<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/publicNavigations.jsp"></jsp:include>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<sql:query var="programCategory" dataSource="${dataSource}">
               	select * from program,category_has_program,category
				where program.program_id=category_has_program.program_id
				AND category_has_program.category_id=category.category_id
				AND program.status_id=2               
</sql:query>

<sql:query var="workshopCategory" dataSource="${dataSource}">
                select * from item,category_has_item,category 
                where item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.status_id=2
                AND item.item_type_id=?
                                <sql:param value="2" />
</sql:query>

<sql:query var="coachingCategory" dataSource="${dataSource}">
                select * from item,category_has_item,category 
                where item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.status_id=2
                AND item.item_type_id=?
                                <sql:param value="1" />
</sql:query>


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Courses & Program</title>

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


	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="col-sm-3 col-md-2 sidebar">

			<!-- <form>
		<b>Categories</b>
		<div class="checkbox">
			<label><input type="checkbox" value="" checked>All
				Categories</label>
		</div>
		<div class="checkbox">
			<label><input type="checkbox" value="" checked>Category1</label>
		</div>
		<div class="checkbox">
			<label><input type="checkbox" value="" checked>Category2</label>
		</div>
		<div class="checkbox">		
			<label><input type="checkbox" value="" checked>Category3</label>
		</div>
		<div class="checkbox">
			<label><input type="checkbox" value="" checked>Category4</label>
		</div>
		<div class="checkbox">
			<label><input type="checkbox" value="" checked>Category5</label>
		</div>
		<b>Program & Courses</b>
		<div class="checkbox">
			<label><input type="checkbox" value="" checked>Programs
				and Courses</label>
		</div>
		<div class="checkbox">
			<label><input type="checkbox" value="">Programs only</label>
		</div>
		<div class="checkbox">
			<label><input type="checkbox" value="">Courses only</label>
		</div>
		<a>Types Of Course</a>
		<div class="checkbox">
			<label><input type="checkbox" value="">Coaching
				Courses</label>
		</div>
		<div class="checkbox">
			<label><input type="checkbox" value="">Workshop
				Courses</label>
		</div>
		<div class="form-group">
			<label class="filter-col" style="margin-right: 0;" for="pref-perpage">Rows
				per page:</label> <select id="pref-perpage" class="form-control">
				Use session to select next time
				<option value="9">9</option>
				<option selected="selected" value="10">10</option>
				<option value="15">11</option>
				<option value="20">12</option>
				<option value="30">13</option>
				<option value="40">14</option>
				<option value="50">15</option>
			</select>
		</div>
		<div class="form-group">
			<label class="filter-col" style="margin-right: 0;" for="pref-orderby">Order
				by:</label> <select id="pref-orderby" class="form-control">
				<option>Date closest relative to today</option>
				<option>Date furthest relative to today</option>
			</select>
		</div>
		<button type="submit" class="btn btn-default filter-col">
			<span class="glyphicon glyphicon-record"></span> Save Options
		</button>
	</form> -->

			<!-- When database comes in, if onclick == currently available show those with status available else show full -->

			<!-- Navigation bar -->
			<!-- /Filter Tab -->
			<!-- insert JS here
		To see if something is checked then you write sql to show that thing. :)
		<script>
		$('#your_id').is(':checked')        // Returns a Boolean TRUE if checked
		if ($('#your_id').is(':checked')) {
		// Checkbox was checked
		}
		</script>
		 -->
		</div>



		<!-- Programs&Courses -->
		<!-- same, when database comes in, according to the option on the navigation bar
	, the contents have to show accordingly -->
		<!-- when the database comes, no more hardcoding, auto populate the page with contents
	based on the number of data in the DB, use for loop. -->
		<!-- ROW on programs -->
		<div class="testing">

			<div class="row">
				<h2>Programs</h2>
				<hr>
				<c:forEach var="category" items="${programCategory.rows}">

					<div class="col-xs-6 col-lg-4">
						<div class="alingment">
							<br>
							
							<p>
							<img
							src="http://localhost:8080/impossibleWeb/readImageProgram?id=${category.program_id} class="
							img-thumbnail" alt="Cinque Terre" width="304" height="236">
							</p>

							<p>
								<b>Title: </b>
								<c:out value="${category.program_name}" />
							</p>
							<p>
								<b>Categories: </b>
								<c:out value="${category.category_name}" />
							</p>
							<a class="btn btn-success"
								href="viewProgramDetails.jsp?program_id=${category.program_id}">
								View Details &raquo; </a> <a class="btn btn-info"
								href="register.jsp"> Register &raquo; </a>
						</div>
					</div>
				</c:forEach>
			</div>
			<!--/row-->
			<!-- when the database comes, no more hardcoding, auto populate the page with contents
	based on the number of data in the DB, use for loop. -->
			<!-- ROW on workshops -->
			<div class="row">
				<h2>Workshops</h2>
				<hr>
				<c:forEach var="category" items="${workshopCategory.rows}">

					<div class="col-xs-6 col-lg-4">
						<div class="alingment">
							<br>
							<p>
							<img
							src="http://localhost:8080/impossibleWeb/readImageItem?id=${category.item_id} class="
							img-thumbnail" alt="Cinque Terre" width="304" height="236">
							</p>

							<p>
								<b>Title: </b>
								<c:out value="${category.item_name}" />
							</p>
							<p>
								<b>Categories: </b>
								<c:out value="${category.category_name}" />
							</p>
							<a class="btn btn-success"
								href="viewWorkshops.jsp?workshop_id=${category.item_id}">
								View Details &raquo; </a> <a class="btn btn-info"
								href="register.jsp"> Register &raquo; </a>
						</div>
					</div>
				</c:forEach>
			</div>
			<!--/row-->
			<!-- ROW on coaching -->
			<div class="row">
				<h2>Coaching Sessions</h2>
				<hr>
				<c:forEach var="category" items="${coachingCategory.rows}">
					<div class="col-xs-6 col-lg-4">
						<div class="alingment">
							<br>

							<p>
								<b>Title: </b>

								<c:out value="${category.item_name}" />
							</p>
							<p>
								<b>Categories: </b>
								<c:out value="${category.category_name}" />
							</p>
							<a class="btn btn-success"
								href="viewCoachingSession.jsp?coaching_id=${category.item_id}">
								View Details &raquo; </a> <a class="btn btn-info"
								href="register.jsp"> Register &raquo; </a>
						</div>
					</div>
				</c:forEach>
			</div>
			<!--/row-->


			<script type="text/javascript">
				function contains(text_one, text_two) {
					if (text_one.indexOf(text_two) != -1)
						return true;

				}

				$("#searchText").keyup(
						function() {
							var searchText = $("#searchText").val()
									.toLowerCase();
							$("p b").each(
									function() {
										if (!contains($(this).text()
												.toLowerCase(), searchText))
											$(this).hide();
										else
											$(this).show();
									});
						});
			</script>

			<!--/row-->
		</div>

	</div>


	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/footer.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>