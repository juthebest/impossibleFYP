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

<!-- //var - ownself name, data source is take from line 9 -->


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
<%-- <h3>
	Hi
	<%=userName%>, Login successful. Your Session ID=<%=sessionID%>
	role=<%=userrole%></h3>
<br> User=<%=user%>

<br> UserIDSession=<%=uid%>
<br> UserIDCookie=<%=userID%>
<br>role=<%=role%>

<!-- need to encode all the URLs where we want session information to be passed -->
<a href="CheckoutPage.jsp">Checkout Page</a>
<form action="LogoutServlet" method="get">
	<input type="submit" value="Logout">
</form> --%>


<sql:query var="reflectionjournal" dataSource="${dataSource}">
SELECT * FROM `control` WHERE control_id = 1;
</sql:query>


<sql:query var="clientjournal" dataSource="${dataSource}">
SELECT `client_journal_id`, `client_id`, `coach_id`, `journal_reflection`, `emotion_rating`, `create_update_datetime`, `privacy_indicator`, `coach_comment`, `coach_comment_datetime` FROM `client_journal`
WHERE client_journal_id=<%=request.getParameter("journalid")%>;
</sql:query>



<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Draft Journals</title>

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
      <scricpt src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<script src="ckeditor/ckeditor.js"></script>

<body>
	<div class="container">
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li><a href="user.jsp">Home</a></li>
				<li class="active">Passed Journal</li>
			</ol>
		</div>
	</div>

	<br />

	<div class="item active">
		<form name="form1" method="post" action="userreflectiondraft">
			<div class="container">
				<div class="container-fluid">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">Edit Journal</h3>

							<div class="panel-body">
								<c:forEach var="client" items="${clientjournal.rows}">

									<input type="hidden" value="9" name="clientjournalid" />

									<c:forEach var="rjquestion" items="${reflectionjournal.rows}">
										<p>
											<c:out value="${rjquestion.rj_questions}" />
										</p>
									</c:forEach>

									<textarea name="editor1" id="journal_editor" rows="10"
										cols="80" required>					<c:out
											value="${client.journal_reflection}" />
						</textarea>
									<script>
										CKEDITOR.replace('editor1');
									</script>

									<br />

									<div class="row">
										<label>Emotion Indicator:</label> <br />
										<div class="col-sm-4" style="margin-left: -20px">
											<select class="form-control" id="status" name="emotionrating">
												<option value="${client.emotion_rating}">${client.emotion_rating}</option>
												<option value="Elated">Elated</option>
												<option value="Happy">Happy</option>
												<option value="Sad">Sad</option>
											</select>
										</div>
									</div>


									<br />

									<div class="row">
										<label>Privacy Indicator:</label> <br />
										<div class="col-sm-4" style="margin-left: -20px">
											<select class="form-control" id="status" name="privacyin">
												<option value="${client.privacy_indicator}">${client.privacy_indicator}
												</option>
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
								</c:forEach>

							</div>


						</div>

					</div>
				</div>
			</div>
		</form>
	</div>

	<footer id="footerMenu"></footer>
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
</body>
</html>