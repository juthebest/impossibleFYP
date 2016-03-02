<!DOCTYPE html>
<html lang="en">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="main/adminNavigations.jsp"></jsp:include>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session"
	user="root" password="" />


<sql:query var="workshop" dataSource="${dataSource}">
                select * from item,category_has_item,category,item_type,status
                where item.item_id=category_has_item.item_id 
                AND category_has_item.category_id=category.category_id 
                AND item.item_type_id=item_type.item_type_id
				AND item.status_id=status.status_id
                AND item.item_id=<%=request.getParameter("selected")%>
</sql:query>

<sql:query var="itemProgram" dataSource="${dataSource}">
               	SELECT *
				FROM program, item, program_has_item
				WHERE program.program_id = program_has_item.program_id
				AND program_has_item.item_id = item.item_id
				AND item.item_id=<%=request.getParameter("selected")%>
</sql:query>


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Edit Workshop</title>
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
<%-- <%
		//allow access only if session exists
		String user = null;
		if (session.getAttribute("name") == null || session.getAttribute("role") != ("admin")) {
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
	%> --%>
	
</head>


<script src="js/fileinput.js"></script>

<script src="ckeditor/ckeditor.js"></script>
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

					<h1>Workshop</h1>

					<ul class="breadcrumb">
						<li><a href="adminIndex.jsp">Home</a></li>
						<li><a href="workshopAdmin.jsp">Manage Workshop</a></li>
						<li><a href="editWorkshop.jsp">Edit Workshop</a></li>
					</ul>
				</div>
			</div>
			<div class="container-fluid">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-pencil"></i> Edit Workshop
						</h3>
					</div>
					<c:forEach var="ws" items="${workshop.rows}">

						<div class="panel-body">

							<form action="EditWorkshop" method="get"
								enctype="multipart/form-data" id="form-category"
								class="form-horizontal">
								<input type="hidden" name="itemID"
									value="<c:out value="${ws.item_id}" />" />
								<div class="form-group required">
									<label class="col-sm-2 control-label" for="course_name">Workshop
										Name:</label>
									<div class="col-sm-10">
										<input type="text" name="course_name"
											value="<c:out value="${ws.item_name}" />" placeholder=""
											id="workshop_name" class="form-control" />
									</div>
								</div>

								<div class="form-group required">
									<label class="col-sm-2 control-label" ></label> 
									<div class="col-sm-10">
										<!-- whether it is edit/selected depends on sql query already -->
										<div class="panel panel-default">
											<!-- Default panel contents -->
											<div class="panel-heading">
												<label>Related Programs</label>
											</div>
											<table class="table table-striped">
												<c:forEach var="program" items="${itemProgram.rows}">
													<tr>
														<td><c:out value="${program.program_name}"></c:out></td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div>
								<!-- IMAGE
								<div class="form-group required">
									<label class="col-sm-2 control-label" for="input-name1">Image:</label>
									<div class="col-sm-10">
										<input id="input-image-1" name="input-image" type="file"
											class="file-loading" accept="image/*">

										an example modal dialog to display confirmation of the resized image
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
								</div> 
								-->

								<div class="form-group required"></div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-description1">Description:</label>
									<div class="col-sm-10">
										<textarea name="course_description" placeholder="Description"
											id="input-description1" class="form-control">
														<c:out value="${ws.item_desc}" />	  
									</textarea>
										<script>
											// Replace the <textarea id="editor1"> with a CKEditor
											// instance, using default configuration.
											CKEDITOR
													.replace('course_description');
										</script>
									</div>
								</div>
								<div class="form-group required">
									<label class="col-sm-2 control-label" for="duration">Duration:</label>
									<div class="col-sm-10">
										<input type="text" name="duration"
											value="<c:out value="${ws.item_duration}" />" placeholder=""
											id="duration" class="form-control" />
									</div>

								</div>


								<div class="form-group required">


									<label class="col-sm-2 control-label" for="course_cost">Cost:</label>
									<div class="col-sm-10">
										<input type="text" name="course_cost"
											value="<c:out value="${ws.unit_cost}" />" placeholder=""
											id="course_cost" class="form-control" />
									</div>
								</div>

								<!-- this part do the checkbox-->
								<div class="form-group required">
									<label class="col-sm-2 control-label" for="category">Category:</label>
									<div class="col-sm-10">

										<sql:query var="categories" dataSource="${dataSource}">
												SELECT * FROM category where category_id !=<c:out
												value="${ws.category_id}" />
										</sql:query>

										<select class="form-control" id="category"  name="category">
											<option value="<c:out value="${ws.category_id}"/>"><c:out
													value="${ws.category_name}" /></option>
											<c:forEach var="categories" items="${categories.rows}">
												<option value="<c:out value="${categories.category_id}" />"><c:out
														value="${categories.category_name}" /></option>
											</c:forEach>

											<!-- 
											<option>Family Counseling</option>
											<option>Individual Counselling</option>
											<option>Child and Youth Counselling</option>
											<option>Adjustment/Transition Change Counselling</option>
											<option>Grief Counselling</option> 
											-->
										</select>
									</div>
								</div>

								<div class="form-group required">
									<label class="col-sm-2 control-label" for="status">Status:</label>
									<div class="col-sm-10">
										<sql:query var="status" dataSource="${dataSource}">
												SELECT * FROM status where status_id !=<c:out
												value="${ws.status_id}" />
										</sql:query>
										<select class="form-control" id="status" name="status">
											<option value="<c:out value="${ws.status_id}"/>"><c:out
													value="${ws.status_name}" /></option>
											<c:forEach var="status" items="${status.rows}">
												<option value="<c:out value="${status.status_id}" />"><c:out
														value="${status.status_name}" /></option>
											</c:forEach>
										</select>
									</div>
								</div>


								<div class="form-group required">
									<label class="col-sm-2 control-label" for="status">Type
										Of Course:</label>
									<div class="col-sm-10">
										<sql:query var="itemType" dataSource="${dataSource}">
												SELECT * FROM item_type where item_type_id != <c:out
												value="${ws.item_type_id}" />
										</sql:query>
										<select class="form-control" id="status"  name="item_type">
											<option value="<c:out value="${ws.item_type_id}"/>"><c:out
													value="${ws.item_type_name}" /></option>
											<c:forEach var="itemType" items="${itemType.rows}">
												<option value="<c:out value="${itemType.item_type_id}" />"><c:out
														value="${itemType.item_type_name}" /></option>
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
					</c:forEach>

				</div>
			</div>
		</div>

	</div>
	<!-- <End> -->

	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->


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