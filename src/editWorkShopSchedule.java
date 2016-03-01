

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
 * Servlet implementation class editWorkShopSchedule
 */
@WebServlet("/editWorkShopSchedule")
public class editWorkShopSchedule extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editWorkShopSchedule() {
		super();
		// TODO Auto-generated constructor stub
	}



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	

		// Set response content type
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();

		String id =null;
		String ws =null;
		String 	sdt=null;
		String	edt =null;
		String	cIc =null;

		String	venue =null;
		String	status =null;

		id= request.getParameter("id");
		ws= request.getParameter("wsname");
		sdt= request.getParameter("sdt");
		edt= request.getParameter("edt");
		cIc= request.getParameter("coachInCharge");
		venue= request.getParameter("venue");
		status= request.getParameter("status");
		
		
		
		
		out.println(id);
	out.println(ws); 
	out.println(sdt);
	out.println(edt);
	out.println(cIc);

	out.println(venue);
	out.println(status);

		try{



			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection conn = database.Get_Connection();
			Statement stmt = null;
			stmt = conn.createStatement();

			// create the java mysql update preparedstatement
			int i= stmt.executeUpdate("UPDATE `itemrun` SET `item_id`='"+ws+"',`status_id`='"+status+"',`coach_id`='"+cIc+"',`itemrun_start_datetime`='"+sdt+"',`item_end_datetime`='"+edt+"',`itemrun_venue`='"+venue+"' WHERE `itemrun_id`='"+id+"'");			



			conn.close();

			if(i==1){
				response.sendRedirect("manageWorkShopSchedule.jsp");

			}else{
				out.println("There is an error");

			}

		}

		catch (Exception e)
		{
			System.err.println("Got an exception! ");
			System.err.println(e.getMessage());
		}
	}

}
