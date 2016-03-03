<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	//allow access only if session exists
	String user = null;

	String role = (String) session.getAttribute("role");
	String uid = null;
	if (session.getAttribute("name") == null || session.getAttribute("role") == null || !role.equals("admin")) {
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
<%-- <h3>Hi<%=userName%>, Login successful. Your Session ID=<%=sessionID%>
	role=<%=userrole%></h3>
<br>
User=<%=user%>

<br>
UserIDSession=<%=uid%>
<br>
UserIDCookie=<%=userID%>
<br>
role=<%=role%>

<!-- need to encode all the URLs where we want session information to be passed -->
<a href="CheckoutPage.jsp">Checkout Page</a>
<form action="LogoutServlet" method="post">
	<input type="submit" value="Logout">
</form> --%>
<div class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span>
				<!-- for the responsive icon bar when page shrink -->
				<span class="icon-bar"></span>
			</button>

			<a class="navbar-brand" href="index.jsp"> <img id="brand-image"
				alt="Website logo" src="image/brandimage.PNG" />
			</a>
		</div>

		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="index.jsp"
					class="dropdown-toggle" data-toggle="dropdown">Home <b
						class=caret></b></a>
					<ul class="dropdown-menu">
						<li><a href="index.jsp">I'M POSSIBLE</a></li>
						<li><a href="adminIndex.jsp">Admin homepage</a></li>
					</ul></li>

				<li class="dropdown"><a href="adminIndex.jsp"
					class="dropdown-toggle" data-toggle="dropdown">Manage <b
						class=caret></b></a>
					<ul class="dropdown-menu">
						<li><a href="manageIndex.jsp"> Manage Public Home Page</a></li>
						<li><a href="manageAbout.jsp">Manage About</a></li>
						<li><a href="manageContactUs.jsp">Manage ContactUs</a></li>
						<li><a href="manageCategory.jsp"> Manage Category</a></li>
						<li class="active">
						<li><a href="coachingAdmin.jsp"> Manage Coaching</a></li>
						<li><a href="workshopAdmin.jsp"> Manage WorkShop</a></li>
						<li><a href="programAdmin.jsp"> Manage Program</a></li>
						<li><a href="manageWorkShopSchedule.jsp"> Manage WorkShop
								Schedule</a></li>
						<li><a href="manageItemStatus.jsp"> Manage Status</a></li>

						<li><a href="manageUser.jsp"> Manage Users</a></li>

					</ul></li>


				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-user"></i> Hi <%=user%>
						<b class="caret"></b></a>
					<ul class="dropdown-menu">

						<li><a href="LogoutServlet"><i
								class="fa fa-fw fa-power-off"></i>Logout</a></li>
					</ul></li>
			</ul>
		</div>

	</div>
</div>

