<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	//allow access only if session exists
	String user = null;

	String role = (String) session.getAttribute("role");
	String uid = null;
	if (session.getAttribute("name") == null || session.getAttribute("role") == null || !role.equals("child")) {
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

<div class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="user.jsp"> <img id="brand-image"
				alt="Website logo" src="image/brandimage.PNG" />
			</a>
		</div>

		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> Home <b class=caret></b></a>
					<ul class="dropdown-menu">
						<li><a href="user.jsp">User's Home</a></li>
						<li class="active">
						<li><a href="index.jsp">I'M Counselling</a></li>
					</ul></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> Courses & Programs <b class=caret></b></a>
					<ul class="dropdown-menu">
						<li><a href="myCourseNPrograms.jsp">My Courses & Programs</a></li>
						<li class="active">
						<li><a href="StudentPrograms&Courses.jsp">All Courses &
								Programs</a></li>
					</ul></li>

				<li><form class="navbar-form navbar-right" role="search">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Search ">
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</form></li>


				<%-- <li><a href="#"><i class="fa fa-user"></i> Hi, <%=user%> </a></li>
				<li class="dropdown"><a href="shoppingcart.jsp"
					class="dropdown-toggle" data-toggle="dropdown"> <span
						class="glyphicon glyphicon-shopping-cart"></span> <span
						class="badge">2</span><b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li><a href="userProfile.jsp"><i class="fa fa-fw fa-user"></i> Profile</a></li>
						<li class="divider"></li>
						<li><a href="LogoutServlet"><i class="fa fa-fw fa-power-off"></i>Logout</a></li>
					</ul></li>
					 --%>

				<li class="dropdown"><a href="shoppingcart.jsp"
					class="dropdown-toggle" data-toggle="dropdown"> <span
						class="fa fa-user"></span> Hi, <%=user%><b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li><a href="userProfile.jsp"><i class="fa fa-fw fa-user"></i>
								Profile</a></li>
<!-- 						<li><a href="shoppingcart.jsp"><i
								class="glyphicon glyphicon-shopping-cart"></i> Shopping Cart</a></li> -->

						<li class="divider"></li>
						<li><a href="LogoutServlet"><i
								class="fa fa-fw fa-power-off"></i>Logout</a></li>
					</ul></li>

			</ul>
		</div>
	</div>
</div>