<!DOCTYPE html>
<html lang="en">
<jsp:include page="main/publicNavigations.jsp"></jsp:include>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<jsp:include page="main/publicNavigations.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/mydb" scope="session" user="root"
	password="" />

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Register Password</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- for filter bar -->
<link rel="stylesheet" type="text/css" href="css/flaticon.css">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/jquery-ui.min.css" rel="stylesheet">
<script src="http://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="http://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css"
	rel="stylesheet"></link>
<link rel="stylesheet" type="text/css" href="css/home.css" />

<%-- <sql:query var="programname" dataSource="${dataSource}">
               	select * from program,category_has_program,category,status
				where program.program_id=category_has_program.program_id
				AND category_has_program.category_id=category.category_id  
				AND program.status_id=status.status_id
				AND program.program_id=<%=request.getParameter("program_id")%>
</sql:query> --%>

<body>

	<form action="registerpassword.jsp" method="get" name="myForm"
		id="login_form" class="form-horizontal" data-toggle="validator"
		role="form" onsubmit="return formValidation()">
		<div class="container">
			<div class="container-fluid">
				<div class="registrationpanel">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">Registration Page</h3>
						</div>

						<%-- 
						<c:forEach var="program" items="${programname.rows}">
							<p>
								<b>Program Registered:</b> <input type="text"
									placeholder="programname" id="sname_input" name="programname"
									value="${program.program_name}" required>
							</p>
						</c:forEach>
 --%>
						<!-- class="form-control" -->
						<fieldset style="padding-left: 10px">
							<h3>Personal Details Of Parent</h3>
							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Salutation:</label>
									<div class="col-xs-3">
										<select class="form-control" id="salutation_input"
											name="salutation">
											<option value="Mr">Mr</option>
											<option value="Mrs">Mrs</option>
											<option value="Ms">Ms</option>
											<option value="Mdm">Mdm</option>
										</select>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Full Name:</label>
									<div class="col-xs-2">
										<input type="text" class="form-control" placeholder="Surname"
											id="sname_input" name="sname" value="" required>
									</div>
									<div class="col-xs-3">
										<input type="text" class="form-control" id="gname_input"
											name="gname" placeholder="Given Name" value="" required>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Gender:</label>
									<div class="col-xs-2">
										<select class="form-control" id="gender_input" name="gender">
											<option>Male</option>
											<option>Female</option>

										</select>
									</div>
								</div>
							</div>

							<hr />

							<h3>Contact Information Of Parent</h3>
							<div class="row">
								<i>Please provide the contact details we should use in the
									event for the latest updates of IM' Counselling.</i>
							</div>

							<br />

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Contact Number:</label>
									<!-- 									<div class="col-xs-2">
										<input type="text" class="form-control" id="country_code"
											name="country" placeholder="+65" required>
									</div> -->
									<div class="col-xs-2">
										<input type="text" class="form-control" id="number_input"
											name="contact_number" placeholder="Contact Number" required>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-sm-2" for="category">Address:</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="address_input"
											name="address" placeholder="Address" required>
									</div>
								</div>
							</div>


							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-sm-2" for="category">Postal Code:</label>
									<div class="col-sm-2">
										<input type="text" class="form-control" id="pc_input"
											name="postal_code" placeholder="Postal Code" required>
									</div>
								</div>
							</div>

							<hr />

							<h3>Personal Details Of Child</h3>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Salutation:</label>
									<div class="col-xs-3">
										<select class="form-control" id="salutation_input"
											name="salutation1">
											<option value="Mr">Mr</option>
											<option value="Mrs">Mrs</option>
											<option value="Ms">Ms</option>
											<option value="Mdm">Mdm</option>
										</select>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Full Name:</label>
									<div class="col-xs-2">
										<input type="text" class="form-control" placeholder="Surname"
											id="sname_input" name="sname1" required>
									</div>
									<div class="col-xs-3">
										<input type="text" class="form-control" id="gname_input"
											name="gname1" placeholder="Given Name" required>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Gender:</label>
									<div class="col-xs-2">
										<select class="form-control" id="gender_input" name="gender1">
											<option value="Male">Male</option>
											<option value="Female">Female</option>
										</select>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Date of Birth:</label>
									<div class="col-sm-4">
										<input type="date" class="form-control" id="dateofbirth"
											name="dob" required>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Relationship to
										child:</label>
									<div class="col-sm-4">
										<select class="form-control" id="rtochild" name="relationship">
											<option value="Mother">Mother</option>
											<option value="Father">Father</option>
											<option value="Guardian">Guardian</option>
											<option value="Others">Others</option>
										</select>
									</div>
								</div>
							</div>

							<hr />

							<h3>Contact Information Of Child</h3>
							<div class="row">
								<i>Please provide the contact details we should use in the
									event for the latest updates of IM' POSSIBLE.</i>
							</div>

							<br />

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-xs-2" for="category">Contact:</label>
									<!-- 
									<div class="col-xs-2">
										<input type="text" class="form-control" id="country_code"
											name="country1" placeholder="+65" required>
									</div> -->
									<div class="col-xs-2">
										<input type="text" class="form-control" id="number_input"
											name="contact_number1" placeholder="Contact Number" required>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-sm-2" for="category">Address:</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="address_input"
											name="address1" placeholder="Address" required>
									</div>
								</div>
							</div>



							<div class="row">
								<div class="form-group form-group-md">
									<label class="col-sm-2" for="category">Postal Code:</label>
									<div class="col-sm-2">
										<input type="text" class="form-control" id="pc_input"
											name="postal_code1" placeholder="Postal Code" required>
									</div>
								</div>
							</div>
						</fieldset>

						<div class="form-actions">
							<button type="submit" class="btn btn-primary"
								onclick=formValidation()>Next</button>
							<a href="viewProgramsNcourses.jsp"><button type="button"
									class="btn btn-danger">Cancel</button></a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</form>



	<script>

function formValidation()  
{  
/* 	parent
 */	var sname = document.myForm.sname;  
	var gname = document.myForm.gname;  
	var contact_number = document.myForm.contact_number;  
	var address = document.myForm.address;  
	var postal_code = document.myForm.postal_code;
	
/* child	
 */var sname1 = document.myForm.sname1;  
var gname1 = document.myForm.gname1;  
var contact_number1 = document.myForm.contact_number1;  
var address1 = document.myForm.address1;
var postal_code1 = document.myForm.postal_code1;


if(allLetter(uname))  
{  
if(alphanumeric(uadd))  
{   
if(countryselect(ucountry))  
{  
	
/* postalcode */
if(allnumeric(postal_code))  
{  
if(ValidateEmail(uemail))  
{  
if(validsex(umsex,ufsex))  
{  
}  
 
}   
}  
}  
}  
}  
return false;  
  
} function sname_validation(sname)  
{  
var sname_len = sname.value.length;  
if (sname_len == 0)  
{  
alert("User Id should not be empty");  
uid.focus();  
return false;  
}  
return true;  
}  
function passid_validation(passid,mx,my)  
{  
var passid_len = passid.value.length;  
if (passid_len == 0 ||passid_len >= my || passid_len < mx)  
{  
alert("Password should not be empty / length be between "+mx+" to "+my);  
passid.focus();  
return false;  
}  
return true;  
}  
function allLetter(uname)  
{   
var letters = /^[A-Za-z]+$/;  
if(uname.value.match(letters))  
{  
return true;  
}  
else  
{  
alert('Username must have alphabet characters only');  
uname.focus();  
return false;  
}  
}  
function alphanumeric(uadd)  
{   
var letters = /^[0-9a-zA-Z]+$/;  
if(uadd.value.match(letters))  
{  
return true;  
}  
else  
{  
alert('User address must have alphanumeric characters only');  
uadd.focus();  
return false;  
}  
}  
function countryselect(ucountry)  
{  
if(ucountry.value == "Default")  
{  
alert('Select your country from the list');  
ucountry.focus();  
return false;  
}  
else  
{  
return true;  
}  
}  
function allnumeric(postal_code)  
{   
var numbers = /^[0-9]+$/;  
if(postal_code.value.match(numbers))  
{  
return true;  
}  
else  
{  
alert('ZIP code must have numeric characters only');  
postal_code.focus();  
return false;  
}  
}  
function ValidateEmail(uemail)  
{  
var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  
if(uemail.value.match(mailformat))  
{  
return true;  
}  
else  
{  
alert("You have entered an invalid email address!");  
uemail.focus();  
return false;  
}  
} function validsex(umsex,ufsex)  
{  
x=0;  
  
if(umsex.checked)   
{  
x++;  
} if(ufsex.checked)  
{  
x++;   
}  
if(x==0)  
{  
alert('Select Male/Female');  
umsex.focus();  
return false;  
}  
else  
{  
alert('Form Succesfully Submitted');  
window.location.reload()  
return true;  
}  
} 

</script>


	<!-- Start of <Fixed footer> -->
	<footer id="footerMenu"></footer>
	<!-- End of <Fixed footer> -->

	<script src="js/validationregister.js"></script>
	<script src="js/footer.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>

</body>
</html>