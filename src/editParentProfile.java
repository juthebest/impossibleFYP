
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
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			// Register JDBC driver
			// JDBC driver name and database URL
			// Database credentials

			Database database = new Database();

			// Open a connection
			Connection conn = database.Get_Connection();
			
			String givenname = null;
			String sname = null;
			String email = null;
			String mobile = null;
			String address = null;
			String id = null;
			
			givenname = request.getParameter("parentname");
			sname = request.getParameter("parentsurname");
			email = request.getParameter("parentemail");
			mobile = request.getParameter("parentmobile");
			address = request.getParameter("parentaddress");
			id = request.getParameter("parentid");


			// Execute SQL query
			Statement stmt = null;

			stmt = conn.createStatement();
			// create the java mysql update preparedstatement

			int i = stmt.executeUpdate("UPDATE `user` SET`given_name`='"
					+ givenname + "',`surname`='" + sname + "',`email`='" + email + "',`mobile`='"
					+ mobile + "',`address`='" + address + "' WHERE parent_id='" + id + "'");

			
			if (i == 1) {
				response.sendRedirect("parenthomepage.jsp");

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
