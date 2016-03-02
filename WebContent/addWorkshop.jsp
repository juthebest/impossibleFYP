<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>


<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session"
	user="root" password="" />
<sql:query var="categories" dataSource="${dataSource}">
SELECT * FROM category 
</sql:query>

<sql:query var="status" dataSource="${dataSource}">
SELECT * FROM status 
</sql:query>

<sql:query var="itemType" dataSource="${dataSource}">
SELECT * FROM item_type 
</sql:query>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Add Workshop</title>
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
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<link href="css/fileinput.min.css" media="all" rel="stylesheet"
	type="text/css" />
<script src="ckeditor/ckeditor.js"></script>
<%
	//allow access only if session exists
	String user = null;

	if (session.getAttribute("name") == null || session.getAttribute("role") == null
			|| session.getAttribute("role") != "admin") {
		response.sendRedirect("login.jsp");
	} else
		user = (String) session.getAttribute("name");
	String userName = null;
	String sessionID = null;
	String userrole = null;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("name"))
				userName = cookie.getValue();
			if (cookie.getName().equals("JSESSIONID"))
				sessionID = cookie.getValue();
			if (cookie.getName().equals("role"))
				userrole = cookie.getValue();
		}
	} else {
		sessionID = session.getId();
	}

	/* no session validation logic in the above JSP. It contains link to another JSP page,  */
%>
</head>


<style>
#uploadImages .thumbnail {
	width: 150px;
	height: 150px;
	float: left;
	margin: 2px;
}

#uploadImages .thumbnail img {
	width: 150px;
	height: 150px;
}
</style>
<body>


	<!-- <Start> -->

	<div class="container">

		<div id="content">
			<div class="page-header">
				<div class="container-fluid">

					<h1>WorkShop</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="workshopAdmin.jsp">Manage Workshop</a></li>
						<li><a href="addWorkshop.jsp">Add Workshop</a></li>
					</ul>
				</div>
			</div>
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Add New Workshop
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" data-toggle="validator" role="form" action="InsertWorkshop">



							<div class="form-group required">
								<label class="col-sm-2 control-label" for="course_name">Workshop
									Name:</label>
								<div class="col-sm-10">
									<input type="text" name="course_name" value=""
										placeholder="Course Name" id="course_name"
										class="form-control" required />
								</div>
							</div>
							
								<!-- <div class="form-group required">
									<label class="col-sm-2 control-label" for="input-name1">Image:</label>
									<div class="col-sm-10">
										<input id="input-image-1" name="input-image" type="file"
											class="file-loading" accept="image/*">
										<div id="kv-success-modal" class="modal fade">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
														<h4 class="modal-title">Yippee!</h4>
													</div>
													<div id="kv-success-box" class="modal-body"></div>
												</div>
											</div>
										</div>
									</div>
								</div>  -->
								

							<div class="form-group required"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="course_description">Description:</label>
								<div class="col-sm-10">
									<textarea name="course_description" placeholder="Description"
										id="course_description" class="form-control" required>
											Enter Workshop Description  
									</textarea>
									<script>
										// Replace the <textarea id="editor1"> with a CKEditor
										// instance, using default configuration.
										CKEDITOR.replace('course_description');
									</script>
								</div>
							</div>

							<div class="form-group required">
								<label class="col-sm-2 control-label" for="duration">Duration:</label>
								<div class="col-sm-10">
									<input type="text" name="duration" value=""
										placeholder="Duration(Days)" id="duration"
										class="form-control" required />
								</div>
							</div>

							<div class="form-group required">
								<label class="col-sm-2 control-label" for="course_cost">Cost:</label>
								<div class="col-sm-10">
									<input type="text" name="course_cost" value="" placeholder="Cost($)"
										id="course_cost" class="form-control" required />
								</div>
							</div>

							<!-- this part do the checkbox-->
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="category">Category:</label>
								<div class="col-sm-10">
									<select class="form-control" id="category" name="category">
										<c:forEach var="categories" items="${categories.rows}">
											<option value="<c:out value="${categories.category_id}" />"><c:out
													value="${categories.category_name}" /></option>
										</c:forEach>
									</select>
								</div>
							</div>



							<div class="form-group required">
								<label class="col-sm-2 control-label" for="status">Status:</label>
								<div class="col-sm-10">
									<select class="form-control" id="status" name="status">
										<c:forEach var="status" items="${status.rows}">
											<option value="<c:out value="${status.status_id}" />"><c:out
													value="${status.status_name}" /></option>
										</c:forEach>

									</select>
								</div>
							</div>

							<div class="form-group">
								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Submit</button>
									<a href="workshopAdmin.jsp"><button type="button"
											class="btn btn-danger">Cancel</button></a>

								</div>

							</div>
						</form>


					</div>

				</div>
			</div>
		</div>

	</div>
	<!-- <End> -->


	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/navlinks-admin.js"></script>
	<script src="js/footer.js"></script>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>

	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<!-- canvas-to-blob.min.js is only needed if you wish to resize images before upload.
 This must be loaded before fileinput.min.js -->
	<script src="js/canvas-to-blob.min.js" type="text/javascript"></script>
	<script src="js/fileinput.min.js" type="text/javascript"></script>
	<!-- bootstrap.js below is only needed if you wish to use the feature of viewing details 
 of text file preview via modal dialog -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"
		type="text/javascript"></script>
	<!-- optionally if you need translation for your language then include 
locale file as mentioned below -->
	<script src="js/fileinput.js"></script>
	<script src="js/fileinput_locale_<lang>.js"></script>
	<script>
		$("#input-image-1").fileinput({
			uploadUrl : "/site/image-upload",
			allowedFileExtensions : [ "jpg", "png", "gif" ],
			maxImageWidth : 200,
			maxFileCount : 1,
			resizeImage : true
		}).on('filepreupload', function() {
			$('#kv-success-box').html('');
		}).on('fileuploaded', function(event, data) {
			$('#kv-success-box').append(data.response.link);
			$('#kv-success-modal').modal('show');
		});
	</script>
</body>
</html>