<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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

<div class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="parenthomepage.jsp"> <img
				id="brand-image" alt="Website logo" src="image/brandimage.PNG" />
			</a>
		</div>

		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> Home <b class=caret></b></a>
					<ul class="dropdown-menu">
						<li><a href="parenthomepage.jsp">User's Home</a></li>
						<li class="active">
						<li><a href="index.jsp">I'M POSSIBLE</a></li>
					</ul></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> Courses & Programs <b class=caret></b></a>
					<ul class="dropdown-menu">
						<li><a href="ParentCoursesNPrograms.jsp">My Courses &
								Programs</a></li>
						<li class="active">
						<li><a href="StudentPrograms&Courses.jsp">All Courses &
								Programs</a></li>
					</ul></li>
				<li><a href="contactUs.jsp">Contact Us</a></li>


				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-user"></i> Hi, <%=user%>
						<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="ParentProfile.jsp"><i
								class="fa fa-fw fa-user"></i>Profile</a></li>
						<li><a href="LogoutServlet"><i
								class="fa fa-fw fa-power-off"></i>Logout</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
</div>
;
