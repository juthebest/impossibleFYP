
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * Servlet implementation class editParentProfile
 */
@WebServlet("/editParentProfile")
public class editParentProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editParentProfile() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		final String DB_URL = "jdbc:mysql://localhost:3306/mydb";

		// Database credentials
		final String USER = "root";
		final String PASS = "";

		// Set response content type
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();
		// Open a connection

		String id = null;
		String givenname = null;
		String surname = null;
		String email = null;
		String mobile = null;
		String address = null;

		id = request.getParameter("parentid");
		givenname = request.getParameter("parentgivenname");
		surname = request.getParameter("parentsurname");
		email = request.getParameter("parentemail");
		mobile = request.getParameter("parentmobile");
		address = request.getParameter("parentaddress");

		try {

			// Register JDBC driver
			// JDBC driver name and database URL
			// Database credentials

			Database database = new Database();

			// Open a connection
			Connection conn = database.Get_Connection();
			Statement stmt = null;
			stmt = conn.createStatement();

			// create the java mysql update preparedstatement
			int i = stmt.executeUpdate(
					"UPDATE `user` SET `given_name`='" + givenname + "',`surname`='" + surname + "',`surname`='" + email
							+ "',`mobile`='" + mobile + "',`mobile`='" + address + "' WHERE parent_id='" + id + "'");

			conn.close();

			if (i == 1) {
				response.sendRedirect("ParentProfile.jsp");

			} else {
				out.println("There is an error");
				response.sendRedirect("editParentProfile.jsp");

			}

		}

		catch (Exception e)
		{
			System.err.println("Got an exception!");
			System.err.println(e.getMessage());
		}
	}

}
