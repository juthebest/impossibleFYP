
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
 * Servlet implementation class editStudentProfile
 */
@WebServlet("/editStudentProfile")
public class editStudentProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editStudentProfile() {
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

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			// Register JDBC driver
			// JDBC driver name and database URL
			// Database credentials

			Database database = new Database();

			// Open a connection
			Connection conn = database.Get_Connection();

			String id = null;
			String gname = null;
			String sname = null;
			String semail = null;
			String smobile = null;
			String sadd = null;
			String uStatus = null;
			String role = null;
			String saluation = null;
			String pw = null;

			gname = request.getParameter("gname");
			sname = request.getParameter("studentsname");
			semail = request.getParameter("semail");
			smobile = request.getParameter("smobile");
			sadd = request.getParameter("saddress");
			id = request.getParameter("userid");
			uStatus = request.getParameter("userStatus");
			role = request.getParameter("role");
			saluation = request.getParameter("salutation");
			pw = request.getParameter("uPassword");

			// Execute SQL query
			Statement stmt = null;

			stmt = conn.createStatement();
			// create the java mysql update preparedstatement

			int i = stmt.executeUpdate("UPDATE `user` SET`email`='" + semail + "',`password`='" + pw + "',`surname`='"
					+ sname + "',`given_name`='" + gname + "',`mobile`='" + smobile + "',`role`='" + role
					+ "',`salutation`='" + saluation + "',`address`='" + sadd + "',`userStatus_id`='" + uStatus
					+ "' WHERE user_id='" + id + "'");

			if (i == 1) {
				response.sendRedirect("user.jsp");

			} else {
				out.println("There is an error");

			}
			conn.close();
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
