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
 * Servlet implementation class addCatServlet
 */
@WebServlet("/registerservlet")
public class registerservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public registerservlet() {
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
		// TODO Auto-generated method stub
		// JDBC driver name and database URL

		// Set response content type
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();

		try {
			Database database = new Database();

			// Open a connection
			Connection conn = database.Get_Connection();

			// parent values
			String salutation = request.getParameter("salutation");
			String sname = request.getParameter("sname");
			String gname = request.getParameter("gname");
			String contact_number = request.getParameter("contact_number");
			String address = request.getParameter("address");
			String email = request.getParameter("email");
			String password = request.getParameter("passwordparent");

			// child values
			String dob = request.getParameter("dob");
			String relationship = request.getParameter("relationship");
			String salutation1 = request.getParameter("salutation1");
			String sname1 = request.getParameter("sname1");
			String gname1 = request.getParameter("gname1");
			String contact_number1 = request.getParameter("contact_number1");
			String address1 = request.getParameter("address1");
			String email1 = request.getParameter("email1");
			String password1 = request.getParameter("passwordchild");

			// Execute SQL query
			final Statement stmtparenttable = conn.createStatement();
			final Statement stmtparentusertable = conn.createStatement();
			final Statement stmtclienttable = conn.createStatement();
			final Statement stmtclientusertable = conn.createStatement();

			// Date format (USER table - parent)
			java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);

			// String for the different tables
			String sqlparenttable;
			String sqlparentusertable;
			String sqlclienttable;
			String sqlclientusertable;

			/*
			 * MessageDigest md = null; MessageDigest cmd = null; try { md =
			 * MessageDigest.getInstance("SHA-256"); cmd =
			 * MessageDigest.getInstance("SHA-256"); } catch
			 * (NoSuchAlgorithmException e1) { // TODO Auto-generated catch
			 * block e1.printStackTrace(); } md.update(password.getBytes());
			 * cmd.update(password1.getBytes());
			 * 
			 * byte byteData[] = md.digest();
			 * 
			 * //convert the byte to hex format method 1 StringBuffer sb = new
			 * StringBuffer(); for (int i = 0; i < byteData.length; i++) {
			 * sb.append(Integer.toString((byteData[i] & 0xff) + 0x100,
			 * 16).substring(1)); }
			 * 
			 * password = sb.toString(); password1 = sb.toString();
			 * System.out.println(password); System.out.println(password1);
			 */

			// query for PARENT table
			sqlparenttable = "INSERT INTO `parent`() VALUES ()";
			// execute user table for PARENT
			int rs1 = stmtparenttable.executeUpdate(sqlparenttable, Statement.RETURN_GENERATED_KEYS);

			// generate key for parent and user relationship
			ResultSet parentid = null;
			parentid = stmtparenttable.getGeneratedKeys();

			while (parentid.next()) {
				int key = parentid.getInt(1);

				sqlparentusertable = "INSERT INTO `user`(`parent_id`,`email`, `password`, `surname`, `given_name`, `mobile`, `role`, `create_update_datetime`,`salutation`, `address`, `userStatus_id`) VALUES ('"
						+ key + "','" + email + "','" + password + "','" + sname + "','" + gname + "','"
						+ contact_number + "','parent','" + currentTime + "','" + salutation + "','" + address
						+ "','2') ";

				sqlclienttable = "INSERT INTO `client`(`parent_id`, `client_dob`, `relationship_to_child`) VALUES ('"
						+ key + "','" + dob + "','" + relationship + "')";

				int i = stmtparentusertable.executeUpdate(sqlparentusertable);

				int sqlclient = stmtclienttable.executeUpdate(sqlclienttable, Statement.RETURN_GENERATED_KEYS);

				ResultSet clientid = null;
				clientid = stmtclienttable.getGeneratedKeys();

				while (clientid.next()) {
					int keyforclient = clientid.getInt(1);

					sqlclientusertable = "INSERT INTO `user`(`client_id`,`email`, `password`, `surname`, `given_name`, `mobile`, `role`, `create_update_datetime`,`salutation`, `address`, `userStatus_id`) VALUES ('"
							+ keyforclient + "','" + email1 + "','" + password1 + "','" + sname1 + "','" + gname1
							+ "','" + contact_number1 + "','child','" + currentTime + "','" + salutation1 + "','"
							+ address1 + "','2') ";

					int usertable = stmtclientusertable.executeUpdate(sqlclientusertable);

					// validate login to remember the row
					if (i == 1) {
						response.sendRedirect("login.jsp");
					} else {
						// out.println("failed");
						response.sendRedirect("register.jsp");
					}
				} // end of while loop
				clientid.close();
			}

			parentid.close();

		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		} catch (Exception e) {
			// Handle errors for Class.forName
			e.printStackTrace();
		}
	}
}
