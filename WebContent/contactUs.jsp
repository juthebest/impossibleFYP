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
<sql:query var="contactus" dataSource="${dataSource}">
SELECT office_address,office_tel_number,country_code,office_email,office_directions FROM control WHERE control_id = 1;
</sql:query>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Contact Us</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script
	src="http://jashkenas.github.com/coffee-script/extras/coffee-script.js"></script>
<meta name="viewport" content="width=device-width">
<link href='http://fonts.googleapis.com/css?family=Doppio+One'
	rel='stylesheet' type='text/css'>

<style>
.map {
	min-width: 300px;
	min-height: 300px;
	width: 100%;
	height: 100%;
}

.header {
	background-color: #F5F5F5;
	color: #36A0FF;
	height: 70px;
	font-size: 27px;
	padding: 10px;
}

.navbar-fixed-bottom {
	height: 15px;
}

.hello {
	padding-top: 10px;
}
</style>

<body>
	<div class="container" style="margin-bottom: 50px">
		<div class="row">
			<div class="col-md-6">
				<div class="well well-sm">
					<form class="form-horizontal" method="post">
						<fieldset>
							<legend class="text-center header">Contact Us</legend>
							<div class="form-group">
								<label for="subject" class="col-sm-3 control-label">Subject:</label>
								<label class="radio-inline"> <input type="radio"
									name="optradio">Enquiry
								</label> <label class="radio-inline"> <input type="radio"
									name="optradio">Feedback
								</label>
							</div>

							<div class="col-xs-5">
								Salutation: <select class="form-control">
									<option>Mr</option>
									<option>Mrs</option>
									<option>Ms</option>
									<option>Mdm</option>
									<option>Dct</option>
									<option>Prf</option>
								</select>
							</div>

							<div class="col-xs-5">
								Surname: <input id="name" name="fullname" type="text"
									class="form-control" placeholder="Name">
							</div>


							<div class="col-xs-6">
								<div class="hello">
									Given Name: <input type="text" class="form-control"
										placeholder="">
								</div>
							</div>


							<div class="col-xs-5">
								<div class="hello">
									Contact Number: <input id="phonenumber" name="phone" type="tel"
										class="form-control" placeholder="Mobile Number">
								</div>
							</div>

							<div class="col-xs-5">
								<div class="hello">
									Email Address: <input id="emailaddress" name="mail"
										type="email" class="form-control"
										placeholder="jane.doe@example.com">
								</div>
							</div>

							<div class="col-md-12">
								<hr />
								<div class="hello">
									Message For Us:
									<textarea class="form-control" id="message" name="message"
										placeholder="Enter your message for us here. We will get back to you within 2 business days."
										rows="7"></textarea>
								</div>
							</div>


							<div class="form-group">
								<div class="col-md-10 col-md-offset-1"></div>
							</div>


						</fieldset>
					</form>
					<div class="form-group">
						<div class="form-actions">
							<a class="btn btn-primary btn-md" href="#">Submit</a>
						</div>
					</div>
				</div>
			</div>


			<div class="col-md-6">
				<div class="panel panel-default">
					<legend class="text-center header">Our Office</legend>
					<div class="panel-body text-center">


						<strong>Find Us @</strong> <br>

						<c:forEach var="contactusdescription" items="${contactus.rows}">

							<c:out value="${contactusdescription.office_address}" />
							<br />
							<br />
							<c:out value="${contactusdescription.office_directions}" />
							<br />
							<br />
							<strong>Call Us @ </strong>
							<br />
							<br />
							<c:out value="${contactusdescription.office_tel_number}" />
							<br />
							<br />
							<strong>Mail Us @ </strong>
							<br>
							<a href="mailto:#"><c:out
									value="${contactusdescription.office_email}" /></a>
							<address>${contactusdescription.office_map_link}"</address>
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

	<script>
		$(document)
				.ready(
						function() {
							$("address")
									.each(
											function() {
												var embed = "<iframe width='425' height='350' frameborder='0' scrolling='no'  marginheight='0' marginwidth='0'   src='https://maps.google.com/maps?&amp;q="
														+ encodeURIComponent($(
																this).text())
														+ "&amp;output=embed'></iframe>";
												$(this).html(embed);

											});
						});
	</script>
</body>
</html>


