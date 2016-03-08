
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import java.sql.PreparedStatement;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * Servlet implementation class editAdminUser
 */
@WebServlet("/editAdminUser")
public class editAdminUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editAdminUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// Set response content type
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();

		String id =null;
		String saluation =null;
		String 	sname=null;
		String	gname =null;
		String	email =null;

		String	pw =null;
		String	mobile =null;
		String	address =null;
		String	uStatus =null;
		String	currentTime =null;
		id= request.getParameter("adminid");
		uStatus= request.getParameter("userStatus");
		saluation= request.getParameter("salutation");
		sname= request.getParameter("sName");
		gname= request.getParameter("gName");
		email= request.getParameter("aEmail");
		pw= request.getParameter("aPassword");
		mobile= request.getParameter("aMobile");
		address= request.getParameter("aAddress");
		currentTime= request.getParameter("rdate");

		try{
			out.println(currentTime);

			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection conn = database.Get_Connection();
		

	
			// create the java mysql update preparedstatement
			String query = "UPDATE `user` SET `email`=?,`password`=?,`surname`=?,`given_name`=?,`mobile`=?,`role`=?,`create_update_datetime`=?,`salutation`=?,`address`=?,`userStatus_id`=? WHERE user_id=?";
			PreparedStatement preparedStmt = conn.prepareStatement(query);
			preparedStmt.setString  (1,email);
			preparedStmt.setString(2,pw);
			preparedStmt.setString(3,sname);
			preparedStmt.setString(4,gname);
			preparedStmt.setString(5,mobile);
			preparedStmt.setString(6,"admin");
			preparedStmt.setString(7,currentTime);
			preparedStmt.setString(8,saluation);
			preparedStmt.setString(9,address);
			preparedStmt.setString(10,uStatus);
			preparedStmt.setString(11, id);

			// execute the java preparedstatement
			int i = preparedStmt.executeUpdate();

			conn.close();
			if(i==1){
				response.sendRedirect("manageAdminUser.jsp");
			}else{
				out.println("There is an error");
				response.sendRedirect("manageAdminUser.jsp");
				
			}


		}

		catch (Exception e)
		{
			System.err.println("Got an exception! ");
			System.err.println(e.getMessage());
		}
	}



}
