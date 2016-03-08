

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * Servlet implementation class editCoachUser
 */
@WebServlet("/editCoachUser")
public class editCoachUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editCoachUser() {
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

		try{



			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection conn = database.Get_Connection();
			String id =null;
			String saluation =null;
			String 	sname=null;
			String	gname =null;
			String	email =null;

			String	pw =null;
			String	mobile =null;
			String	address =null;
			String	uStatus =null;
			String	role =null;
			String	hr =null;
			String	profile =null;
			String currentTime =null;
			id= request.getParameter("Coachid");
			uStatus= request.getParameter("userStatus");
			role= request.getParameter("role");
			saluation= request.getParameter("salutation");
			sname= request.getParameter("csName");
			gname= request.getParameter("cgName");
			email= request.getParameter("cEmail");
			pw= request.getParameter("cPassword");
			mobile= request.getParameter("cMobile");
			address= request.getParameter("cAddress");
			hr= request.getParameter("cHR");
			profile= request.getParameter("cProfile");
			currentTime= request.getParameter("rdate");
			out.println(id); 
			out.println(saluation);
			out.println(sname);
			out.println(gname);
			out.println(email);

			out.println(pw);
			out.println(mobile);
			out.println(address);
			out.println(uStatus);
			out.println(role);
			out.println(hr);
			out.println(profile);
			
			// Execute SQL query

			// Execute SQL query
			Statement stmt = null;
			Statement ustmt = null;
			stmt = conn.createStatement();
			ustmt = conn.createStatement();
			// create the java mysql update preparedstatement

			int i= stmt.executeUpdate("UPDATE `user` SET`email`='"+email+"',`password`='"+pw+"',`surname`='"+sname+"',`given_name`='"+gname+"',`mobile`='"+mobile+"',`role`='"+role+"',`create_update_datetime`='"+currentTime+"',`salutation`='"+saluation+"',`address`='"+address+"',`userStatus_id`='"+uStatus+"' WHERE coach_id='"+id+"'");




			int c = ustmt.executeUpdate("UPDATE `coach` SET`coach_hourly_rate`='"+hr+"',`coach_profile`='"+profile+"' WHERE coach_id='"+id+"'");




			conn.close();

			if(i==1 && c==1){
				response.sendRedirect("manageCoachUser.jsp");

			}else{
				out.println("There is an error");

			}
		}

		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println("Error: " + e.getMessage());
		}
		finally
		{
			out.close();
		}


	}

}
