<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>

<%@ page import="java.sql.* " %>

<%@ page import="java.io.*"%>



<% Blob image = null;
Connection con = null;
byte[ ] imgData = null ;
Statement stmt = null;
ResultSet rs = null;

try {
Class.forName("com.mysql.jdbc.Driver");

con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb");
final String DB_URL = "jdbc:mysql://localhost:3306/mydb";

// Database credentials
final String USER = "root";
final String PASS = "";
Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

stmt = conn.createStatement();
rs = stmt.executeQuery("SELECT `banner_image_id`, `banner_image` FROM `banner_image` WHERE banner_image_id='2' ");
if (rs.next()) {
image = rs.getBlob(1);

imgData = image.getBytes(1,(int)image.length());

} else {
out.println("Display Blob Example");
out.println("image not found for given id>");
return;
}

// display the image
response.setContentType("image/gif");

OutputStream o = response.getOutputStream();
o.write(imgData);
o.flush();
o.close();
} catch (Exception e) {
out.println("Unable To Display image");
out.println("Image Display Error=" + e.getMessage());
return;
} finally {


}
%>