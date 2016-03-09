<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/publicNavigations.jsp"></jsp:include>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<!-- //var - ownself name -->
<sql:query var="program" dataSource="${dataSource}">
SELECT * FROM `program` ORDER BY `date_last_updated` DESC LIMIT 3;
</sql:query>


<sql:query var="banner" dataSource="${dataSource}">
SELECT * FROM `banner_image` ;
</sql:query>

<sql:query var="coaching" dataSource="${dataSource}">
SELECT `item_id`, `status_id`, `item_name`, `item_type_id`, `item_desc`, `unit_cost`, `images`, `date_last_updated`, `item_duration` FROM `item` WHERE `item_type_id` = 1 ORDER BY `date_last_updated` DESC LIMIT 3;</sql:query>

<sql:query var="workshop" dataSource="${dataSource}">
SELECT `item_id`, `status_id`, `item_name`, `item_type_id`, `item_desc`, `unit_cost`, `images`, `date_last_updated`, `item_duration` FROM `item` WHERE `item_type_id` = 2 ORDER BY `date_last_updated` DESC LIMIT 3;
</sql:query>

<meta charset="utf-8">
<!-- these are useful for getting your site noticed in search engines-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- support IE 9 or IE 8-->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- responsive web-->
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Home</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/home.css">

<script src="http://code.jquery.com/jquery-1.4.2.min.js"></script>
<script>
	(function($) {
		jQuery.expr[':'].Contains = function(a, i, m) {
			return (a.textContent || a.innerText || "").toUpperCase().indexOf(
					m[3].toUpperCase()) >= 0;
		};

		function listFilter(header, list) {
			var form = $("<form>").attr({
				"class" : "filterform",
				"action" : "#"
			}), input = $("<input>").attr({
				"class" : "filterinput",
				"type" : "text"
			});
			$(form).append(input).appendTo(header);

			$(input)
					.change(
							function() {
								var filter = $(this).val();
								if (filter) {
									$(list).find(
											".movieTitle:not(:Contains("
													+ filter + "))").parent()
											.slideUp();
									$(list).find(
											".movieTitle:Contains(" + filter
													+ ")").parent().slideDown();
								} else {
									$(list).find(".entry").slideDown();
								}
								return false;
							}).keyup(function() {
						$(this).change();
					});
		}

		$(function() {
			listFilter($("#header"), $("#list"));
		});
	}(jQuery));
</script>

<body id="index">
	<!-- start of navigation bar  -->
	<nav id="navMenu"></nav>
	<!-- End of navigation bar  -->

	<!-- start of body container -->
	<!-- start of body rotating banner -->

	<div id="carousel-example-generic" class="carousel slide"
		data-ride="carousel" data-interval="3000">

		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#carousel-example-generic" data-slide-to="0"
				class="active"></li>
			<li data-target="#carousel-example-generic" data-slide-to="1"></li>
			<li data-target="#carousel-example-generic" data-slide-to="2"></li>
		</ol>

		<div class="carousel-inner">
			<div class="item active">
				<c:forEach var="b" items="${banner.rows}">
				<img src="http://localhost:8080/impossibleWeb/JdbcReadFile?id=${b.banner_image_id}"/>
				</c:forEach>
			</div>
		</div>

		<!-- Controls -->
		<a class="left carousel-control" href="#carousel-example-generic"
			role="button" data-slide="prev"> <span
			class="glyphicon glyphicon-chevron-left"></span>
		</a> <a class="right carousel-control" href="#carousel-example-generic"
			role="button" data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right"></span>
		</a>
	</div>
	<br>
	<br>

	<div class="container">
		<div class="row">
			<div class="page-header">
				<h2>Latest Coaching Sessions</h2>
				<hr>
			</div>
			<c:forEach var="coachingimages" items="${coaching.rows}">
				<div class="col-sm-4">
					
					<h3>
						<c:out value="${coachingimages.item_name}" />
					</h3>
					<p>
						<c:out value="${coachingimages.item_desc}" />
					</p>
					<p></p>
					<a
						href="viewCoachingSession.jsp?coaching_id=${coachingimages.item_id}"
						class="btn btn-success">View</a>
				</div>
			</c:forEach>
		</div>

		<br>

		<div class="row">
			<div class="page-header">
				<h2>Latest Programs</h2>
				<hr>
			</div>
			<c:forEach var="latestprogram" items="${program.rows}">
				<div class="col-sm-4">
					
					<h3>
						<c:out value="${latestprogram.program_name}" />
					</h3>
					<p>
						<c:out value="${latestprogram.program_desc}" />
					</p>
					<p></p>
					<a
						href="viewProgramDetails.jsp?program_id=${latestprogram.program_id}"
						class="btn btn-success">View</a>
				</div>
			</c:forEach>
		</div>
		<br>

		<div class="row">
			<div class="page-header">
				<h2>Latest WorkShops</h2>
				<hr>
			</div>
			<c:forEach var="latestworkshops" items="${workshop.rows}">
				<div class="col-sm-4">
					
					<h3>
						<c:out value="${latestworkshops.item_name}" />
					</h3>
					<p>
						<c:out value="${latestworkshops.item_desc}" />
					</p>
					<p></p>
					<a href="viewWorkshops.jsp?workshop_id=${latestworkshops.item_id}"
						class="btn btn-success">View</a>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/footer.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- start of the rotating banner javascript -->
	<script>
		$('.carousel').carousel({
			interval : 3000
		})
	</script>
	<!-- end of the rotating banner javascript -->

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>