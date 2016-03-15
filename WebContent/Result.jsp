
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <jsp:include page="main/publicNavigations.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<!-- these are useful for getting your site noticed in search engines-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- support IE 9 or IE 8-->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- responsive web-->
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>I'MPOSSIBLE - Home</title>

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/home.css">
<title>Forgot Password </title>
</head>
<body>
    <center>
        <h3><%=request.getAttribute("Message")%></h3>
        
        <%
							if (request.getAttribute("link") != null) {
						%>
						<p style="color: red">

						Please click <a href="passwordForgot.jsp">here</a>. to enter the correct email again. </p>
						<%
							}
						%>
						
						
						   <%
							if (request.getAttribute("successlink") != null) {
						%>
						<p style="color: red">

						Please click <a href="login.jsp">here</a>. to login with your new password sent to your email.</p>
						<%
							}
						%>
    </center>
    
    
    
</body>
</html>
