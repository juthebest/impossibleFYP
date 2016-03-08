
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
 * Servlet implementation class editCoachNote
 */
@WebServlet("/editCoachNote")
public class editCoachNote extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editCoachNote() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		// Set response content type
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();

		try {

			// Register JDBC driver
			// JDBC driver name and database URL
			// Database credentials

			Database database = new Database();

			// Open a connection
			Connection conn = database.Get_Connection();
			String id = null;
			String counsellornote = null;
			
			
			id = request.getParameter("id");
			counsellornote = request.getParameter("message");
			
			java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);
			
			/*
			 * out.println(id); out.println(email);
			 * 
			 * out.println(mobile); out.println(address); out.println(uStatus);
			 * out.println(role); out.println(profile);
			 */

			// Execute SQL query
			Statement stmt = null;
			stmt = conn.createStatement();
			

			int c = stmt.executeUpdate("UPDATE `coach_note` SET `note_details`='" + counsellornote + "',`create_update_datetime`='"
					+ currentTime + "' WHERE coach_note_id='" + id + "'");

			conn.close();

			if (c == 1) {
				response.sendRedirect("counsellornotes.jsp");

			} else {
				response.sendRedirect("editCoachNote.jsp");

			}
		}

		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println("Error: " + e.getMessage());
		} finally {
			out.close();
		}
	}

}
