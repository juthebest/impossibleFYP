
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * Servlet implementation class AddCourseForUser
 */
@WebServlet("/AddCourseForUser")
public class AddCourseForUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCourseForUser() {
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

		String action = request.getParameter("action");

		if ("Submitprogram".equals(action)) {
			// Set response content type
			response.setContentType("text/html");
			int rs = 0;
			PrintWriter out = response.getWriter();

			try {

				Database database = new Database();

				// Open a connection
				Connection conn = database.Get_Connection();

				String programid = null;
				String clientid = null;

				programid = request.getParameter("programidis");
				clientid = request.getParameter("clientidis");

				// Date format (USER table - parent)
				java.util.Date dt = new java.util.Date();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentTime = sdf.format(dt);

				final Statement stmt = conn.createStatement();

				final Statement statement = conn.createStatement();
				ResultSet resultset = statement.executeQuery("SELECT * FROM `program_has_client` WHERE `program_id` ='"
						+ programid + "' AND `client_id` ='" + clientid + "'");

				int ct = 0;
				
				while (resultset.next()) {
					ct++;
				}
				if (ct > 0) {
					request.setAttribute("Error", "Error occured: Duplicate info! Category Name: " + programid);
					request.getRequestDispatcher("/StudentPrograms&Courses.jsp").forward(request, response);

				} else {

					// Execute SQL query
					String sql;

					sql = "INSERT INTO `program_has_client`(`program_id`, `client_id`, `date_registered`, `enrollment_status_id`) VALUES ('"
							+ programid + "','" + clientid + "','" + currentTime + "','2') ";

					rs = stmt.executeUpdate(sql);
					// validate login to remember the row

				}

				if (rs == 1) {
					out.println("success");

					request.getRequestDispatcher("/myCourseNPrograms.jsp").forward(request, response);
				} else {
					out.println("failed");
					
					request.getRequestDispatcher("/StudentPrograms&Courses.jsp").forward(request, response);
				}

			} catch (SQLException se) {
				// Handle errors for JDBC
				se.printStackTrace();
			} catch (Exception e) {
				// Handle errors for Class.forName
				e.printStackTrace();
			}

			/* doGet(request, response); */

		} else if ("Submitcourse".equals(action)) {
			// Set response content type
			response.setContentType("text/html");

			PrintWriter out = response.getWriter();
			int rs = 0;

			try {

				Database database = new Database();

				// Open a connection
				Connection conn = database.Get_Connection();

				String clientid = null;
				String itemrunid = null;
				String programhasclient = null;

				clientid = request.getParameter("clientidis");
				itemrunid = request.getParameter("itemrunidgetid");
				programhasclient = request.getParameter("programhasclientis");

				// Date format (USER table - parent)
				java.util.Date dt = new java.util.Date();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentTime = sdf.format(dt);

				final Statement stmt = conn.createStatement();

				final Statement statement = conn.createStatement();

				ResultSet resultset = statement.executeQuery("SELECT * FROM `itemrun_has_client` WHERE `itemrun_id` ='"
						+ itemrunid + "' AND `client_id` ='" + clientid + "'");

				int ct = 0;
				while (resultset.next()) {
					ct++;
				}
				if (ct > 0) {
					request.setAttribute("Error", "Error occured: Duplicate info! Category Name: " + itemrunid);
					request.getRequestDispatcher("/StudentPrograms&Courses.jsp").forward(request, response);

				} else {

					// Execute SQL query
					String sql;

					sql = "INSERT INTO `itemrun_has_client`(`enrollment_status_id`, `client_id`, `itemrun_id`, `program_has_client_id`, `date_registered`, `quantity`, `unit_cost`) VALUES ('2','"
							+ clientid + "','" + itemrunid + "','" + programhasclient + "','" + currentTime
							+ "','1','20') ";

					rs = stmt.executeUpdate(sql);
					// validate login to remember the row

				}

				if (rs == 1) {
					out.println("success");
			
					request.getRequestDispatcher("/myCourseNPrograms.jsp").forward(request, response);
					
				} else {
					out.println("failed");

					request.getRequestDispatcher("/StudentPrograms&Courses.jsp").forward(request, response);
				}

			} catch (SQLException se) {
				// Handle errors for JDBC
				se.printStackTrace();
			} catch (Exception e) {
				// Handle errors for Class.forName
				e.printStackTrace();
			}

			/* doGet(request, response); */

		} else if ("Submitworkshop".equals(action)) {
			// Set response content type
			response.setContentType("text/html");
			int rs = 0;

			PrintWriter out = response.getWriter();

			try {

				Database database = new Database();

				// Open a connection
				Connection conn = database.Get_Connection();

				String clientidws = null;
				String itemrunidws = null;
				String programhasclientcoachws = null;

				clientidws = request.getParameter("clientidis");
				itemrunidws = request.getParameter("itemcoachrunidis");
				programhasclientcoachws = request.getParameter("programhasclientidis");

				// Date format (USER table - parent)
				java.util.Date dt = new java.util.Date();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentTime = sdf.format(dt);

				final Statement stmt = conn.createStatement();

				final Statement statement = conn.createStatement();

				ResultSet resultset = statement.executeQuery("SELECT * FROM `itemrun_has_client` WHERE `itemrun_id` ='"
						+ itemrunidws + "' AND `client_id` ='" + clientidws + "'");

				int ct = 0;
				while (resultset.next()) {
					ct++;
				}
				if (ct > 0) {
					request.setAttribute("Error", "Error occured: Duplicate info! Category Name: " + itemrunidws);
					request.getRequestDispatcher("/StudentPrograms&Courses.jsp").forward(request, response);

				} else {
					String sql;

					sql = "INSERT INTO `itemrun_has_client`(`enrollment_status_id`, `client_id`, `itemrun_id`, `program_has_client_id`, `date_registered`, `quantity`, `unit_cost`) VALUES ('2','"
							+ clientidws + "','" + itemrunidws + "','" + programhasclientcoachws + "','" + currentTime
							+ "','1','20') ";

					rs = stmt.executeUpdate(sql);
				}

				if (rs == 1) {
					out.println("success");
					response.sendRedirect("myCourseNPrograms.jsp");
				} else {
					out.println("failed");
					response.sendRedirect("StudentPrograms&Courses.jsp");
				}

			} catch (SQLException se) {
				// Handle errors for JDBC
				se.printStackTrace();
			} catch (Exception e) {
				// Handle errors for Class.forName
				e.printStackTrace();
			}

			/* doGet(request, response); */

		}
	}

}
