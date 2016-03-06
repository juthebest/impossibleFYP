<!DOCTYPE html>
<html lang="en">
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<jsp:include page="main/parentNavigation.jsp"></jsp:include>

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
			|| !role.equalsIgnoreCase("parent")) {
		response.sendRedirect("login.html");
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
<h3>
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
</form>

<sql:query var="parentdetails" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE user.parent_id = client.parent_id
AND user.user_id = <%=uid%>;</sql:query>



<c:forEach var="userprofile2" items="${parentdetails.rows}">
	<sql:query var="chilid2" dataSource="${dataSource}">
SELECT * FROM user, client
WHERE client.client_id = user.client_id
AND client.client_id=<c:out value="${userprofile2.client_id}" />
	</sql:query>
</c:forEach>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Edit User Profile</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/home.css" rel="stylesheet">

<body>
	<div class="container">
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li><a href="parenthomepage.jsp">Home</a></li>
				<li><a href="ParentProfile.jsp">Profile</a></li>
				<li class="active">Edit User Profile</li>
			</ol>
		</div>
	</div>

	<br />
	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<h4>
					<b>User Information</b>
				</h4>
				<hr />
				<div class="panel panel-default">
					<div class="panel-body">

						<c:forEach var="parentprofile" items="${parentdetails.rows}">
							<form action="editParents" method="post"
								class="form-horizontal">


								<div class="form-group">
									<label class="col-sm-2 control-label" for="parentname">Given
										Name</label>
									<div class="col-sm-10">
										<input type="text" name="parentname" class="form-control"
											value="${parentprofile.given_name}" required />
									</div>
								</div>
								
								
								<input type="hidden" name="parentid"
									value="${parentprofile.parent_id}" />
									
									
<%-- 
								<div class="form-group">
									<label class="col-sm-2 control-label" for="parentsurname">Surname</label>
									<div class="col-sm-10">
										<input type="text" name="parentsurname" class="form-control"
											value="${parentprofile.surname}" required />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="parentemail">E-Mail:
									</label>
									<div class="col-sm-10">
										<input type="text" name="parentemail" class="form-control"
											value="${parentprofile.email}" required />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="parentmobile">Mobile:
									</label>
									<div class="col-sm-10">
										<input type="text" name="parentmobile" class="form-control"
											value="${parentprofile.mobile}" required />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="parentaddress">Address:
									</label>
									<div class="col-sm-10">
										<input type="text" name="parentaddress" class="form-control"
											value="${parentprofile.address}" required />
									</div>
								</div> --%>

								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Submit</button>
									<a href="ParentProfile.jsp"><button type="button"
											class="btn btn-danger">Cancel</button></a>
								</div>

							</form>
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

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>

	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>