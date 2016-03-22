<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/userNavigation.jsp"></jsp:include>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<%
	//allow access only if session exists
	String user = null;

	String role = (String) session.getAttribute("role");
	String uid = null;
	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| !role.equalsIgnoreCase("child")) {
		response.sendRedirect("login.jsp");
	} else
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

<sql:query var="clientid" dataSource="${dataSource}">
SELECT * FROM `user` WHERE user_id = <%=userID%> ;
</sql:query>


<sql:query var="coach_id" dataSource="${dataSource}">
SELECT client.coach_id FROM user, client
WHERE client.client_id = user.client_id
AND user.user_id =<%=userID%> ;
</sql:query>


<sql:query var="reflectionjournal" dataSource="${dataSource}">
SELECT * FROM `control` WHERE control_id = 1;
</sql:query>


<meta charset="utf-8">
<script src="ckeditor/ckeditor.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Reflection Journal</title>
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<link href="path/to/css/star-rating.min.css" media="all"
	rel="stylesheet" type="text/css" />
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="path/to/js/star-rating.min.js" type="text/javascript"></script>
<!-- optionally if you need translation for your language then include 
    locale file as mentioned below -->
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- <style>
.star-rating {
	line-height: 32px;
	font-size: 1.25em;
	cursor: pointer;
}
</style> -->

<style>
.star-rating {
	font-size: 0;
}

.star-rating__wrap {
	display: inline-block;
	font-size: 1rem;
}

.star-rating__wrap:after {
	content: "";
	display: table;
	clear: both;
}

.star-rating__ico {
	float: right;
	padding-left: 2px;
	cursor: pointer;
	color: #FFB300;
}

.star-rating__ico:last-child {
	padding-left: 0;
}

.star-rating__input {
	display: none;
}

.star-rating__ico:hover:before, .star-rating__ico:hover ~
	.star-rating__ico:before, .star-rating__input:checked ~
	.star-rating__ico:before {
	content: "\f005";
}
</style>
<body>

	<div class="container">
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li><a href="user.jsp">Home</a></li>
				<li class="active">Reflection Journal</li>
			</ol>
		</div>
	</div>

	<br />

	<form name="form1" method="post" action="userreflectionjournaluser">
		<div class="container">
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Write A New Journal</h3>
					</div>

					<div class="panel-body">
						<c:forEach var="client" items="${clientid.rows}">
							<input type="hidden"
								value="<c:out value="${client.client_id}" />" name="xenia" />

						</c:forEach>

						<c:forEach var="coachid" items="${coach_id.rows}">
							<input type="hidden"
								value="<c:out value="${coachid.coach_id}" />"
								name="thisisthecoachid" />

						</c:forEach>

						<c:forEach var="rjquestion" items="${reflectionjournal.rows}">
							<p>
								<c:out value="${rjquestion.rj_questions}" />
							</p>
						</c:forEach>

						<textarea name="editor1" id="journal_editor" rows="10" cols="80"
							required>
						</textarea>

						<script>
							CKEDITOR.replace('editor1');
						</script>

						<br />

						<!-- 						
						<div class="star-rating">
							 <div class="btn btn-default btn-sm" value = "1"><span class="fa fa-star-o" data-rating="1"></span></div>
							<span class="fa fa-star-o" data-rating="2"></span> <span
								class="fa fa-star-o" data-rating="3"></span> <span
								class="fa fa-star-o" data-rating="4"></span> <span
								class="fa fa-star-o" data-rating="5"></span> <input
								type="hidden" name="whatever" class="rating-value" value="3">
						</div> -->
						
						
						<!-- <div class="row">
							<label> Today's Emotion Rating: </label> <br />
							<div class="col-sm-2" style="margin-left: -20px">
								<select class="form-control" id="status" name="emotionrating">
									<option value="Elated">Elated</option>
									<option value="Happy">Happy</option>
									<option value="Sad">Sad</option>
								</select>
							</div>
						</div> -->

						<div class="row">
							<label> Today's Emotion Rating: </label> <br />
							<div class="star-rating">
								<div class="star-rating__wrap" >
										
										<!-- <input class="star-rating__input" id="star-rating-5"
										type="radio" name="rating" value="5">
										<label class="star-rating__ico fa fa-star-o fa-lg"
										for="star-rating-5" title="5 out of 5 stars"></label>
										
										<input class="star-rating__input" id="star-rating-4" type="radio"
										name="rating" value="4">
										<label class="star-rating__ico fa fa-star-o fa-lg"
										for="star-rating-4" title="4 out of 5 stars"></label> -->
										
										<input class="star-rating__input" id="star-rating-3" type="radio"
										name="emotionrating" value="Elated">
										<label class="star-rating__ico fa fa-star-o fa-lg"
										for="star-rating-3" title="3 out of 3 stars"></label>
										
										<input class="star-rating__input" id="star-rating-2" type="radio"
										name="emotionrating" value="Happy">
										<label class="star-rating__ico fa fa-star-o fa-lg"
										for="star-rating-2" title="2 out of 3 stars"></label>
										
										<input class="star-rating__input" id="star-rating-1" type="radio"
										name="emotionrating" value="Sad">
										<label class="star-rating__ico fa fa-star-o fa-lg"
										for="star-rating-1" title="1 out of 3 stars"></label>
								</div>
							</div>
						</div>


						<br />

						<div class="row">
							<label>Privacy Indicator:</label> <br />
							<div class="col-sm-4" style="margin-left: -20px">
								<select class="form-control" id="status" name="privacyin">
									<option value="Allow">Allow All</option>
									<option value="Onlycounsellor">Only Counsellor</option>
								</select>
							</div>
						</div>

						<div class="row">
							<div class="form-group">
								<div class="form-actions" style="text-align: right">
									<input type="submit" class="btn btn-primary" name="action"
										value="Save"> <input type="submit"
										class="btn btn-primary" name="action" value="Submit">
									<a class="btn btn-danger" href="user.jsp">Cancel</a>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</form>

	<!-- 	<script>
		var $star_rating = $('.star-rating .fa');

		var SetRatingStar = function() {
			return $star_rating
					.each(function() {
						if (parseInt($star_rating
								.siblings('input.rating-value').val()) >= parseInt($(
								this).data('rating'))) {
							return $(this).removeClass('fa-star-o').addClass(
									'fa-star');
						} else {
							return $(this).removeClass('fa-star').addClass(
									'fa-star-o');
						}
					});
		};

		$star_rating.on('click', function() {
			$star_rating.siblings('input.rating-value').val(
					$(this).data('rating'));
			return SetRatingStar();
		});

		SetRatingStar();
	</script> -->
	<!-- Start of Fixed footer -->
	<footer id="footerMenu"></footer>
	<script src="js/footer.js"></script>
	<!-- End of Fixed footer -->

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>