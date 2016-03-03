<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


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
				<li><a href="index.jsp">Home</a></li>
				<li><a href="about.jsp">About</a></li>
				<li><a href="viewProgramsNcourses.jsp">Courses and Programs</a></li>
				<li><a href="contactUs.jsp">Contact Us</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-user"></i> User <b
						class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp"><i class="fa fa-fw fa-sign-in"></i>Log
								In</a></li>
					</ul></li>
			</ul>

		</div>
	</div>
</div>
;
