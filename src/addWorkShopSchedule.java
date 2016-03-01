

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
 * Servlet implementation class addWorkShopSchedule
 */
@WebServlet("/addWorkShopSchedule")
public class addWorkShopSchedule extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addWorkShopSchedule() {
		super();
		// TODO Auto-generated constructor stub
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try
		{
			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection connection = database.Get_Connection();


			String wsname =null;


			String sdt=null;
			String edt=null;

			String coach=null;
			String venue=null;
			String status=null;
			wsname=request.getParameter("wsname");
			sdt=request.getParameter("sdt");
			edt=request.getParameter("edt");
			

			coach=	request.getParameter("coachInCharge");

			status=	request.getParameter("status");
			venue=	request.getParameter("venue");



			// Execute SQL query
			Statement stmt = null;

		
			stmt = connection.createStatement();


			int i= stmt.executeUpdate("INSERT INTO `itemrun`(`item_id`, `status_id`, `coach_id`, `itemrun_start_datetime`, `item_end_datetime`, `itemrun_venue`) VALUES ('"+wsname+"','"+status+"','"+coach+"','"+sdt+"','"+edt+"','"+venue+"')"); 
			if(i==1){


				response.sendRedirect("manageWorkShopSchedule.jsp");


			}
			else{
				out.print("failed");
				response.sendRedirect("manageWorkShopSchedule.jsp");
			}
	


		} catch (Exception e) {
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


