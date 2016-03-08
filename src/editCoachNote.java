
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
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
			String saluation = null;
			String sname = null;
			String gname = null;
			String email = null;

			id = request.getParameter("Coachid");
			saluation = request.getParameter("salutation");
			sname = request.getParameter("csName");
			gname = request.getParameter("cgName");
			email = request.getParameter("cEmail");

			/*
			 * out.println(id); out.println(email);
			 * 
			 * out.println(mobile); out.println(address); out.println(uStatus);
			 * out.println(role); out.println(profile);
			 */

			// Execute SQL query

			// Execute SQL query
			Statement stmt = null;
			Statement ustmt = null;
			stmt = conn.createStatement();
			ustmt = conn.createStatement();
			// create the java mysql update preparedstatement

			int c = ustmt.executeUpdate("UPDATE `coach` SET`coach_hourly_rate`='" + saluation + "',`coach_profile`='" + profile
					+ "' WHERE coach_id='" + id + "'");

			conn.close();

			if (c == 1) {
				response.sendRedirect("manageCoachUser.jsp");

			} else {
				out.println("There is an error");

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
