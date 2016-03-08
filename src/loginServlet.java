import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.Database;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public loginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/*	LoginServlet is used to authenticate the request from client for login.*/
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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

			final String email = request.getParameter("inputEmail");
			String password = request.getParameter("inputPassword");
			out.print("email:" + email);
			out.print("password:" +  password);

			/*	MessageDigest md = null;

			try {
				md = MessageDigest.getInstance("SHA-256");

			} catch (NoSuchAlgorithmException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			md.update(password.getBytes());


			byte byteData[] = md.digest();

			//convert the byte to hex format method 1
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			password = sb.toString();

			System.out.println(password);

			 */


			// Execute SQL query
			final Statement stmt = conn.createStatement();
			String sql;
			sql = "Select user_id,given_name, role,email,password FROM user WHERE email = '" + email
					+ "' and password = '" + password + "' ";
			ResultSet rs = stmt.executeQuery(sql);
			// validate login to remember the row
			/*
			 * boolean row = rs.isBeforeFirst();
			 * 
			 * if(row){
			 */
			// Extract data from result set

			String x = "";

			while (rs.next()) {
				String dbemail = rs.getString("email");
				String dbpwd = rs.getString("password");
				String role = rs.getString("role");
				String name = rs.getString("given_name");
				String id = rs.getString("user_id");
				if (email.equals(dbemail) && password.equals(dbpwd)) {

					// create a new session request
					HttpSession session = request.getSession();

					Date created = new Date(session.getCreationTime());
					Date accessed = new Date(session.getLastAccessedTime());
					out.println("ID " + session.getId());
					out.println("Created: " + created);
					out.println("Last Accessed: " + accessed);
					session.setAttribute("name", name);
					session.setAttribute("uid", id);
					// setting session to expiry in 30 mins
					session.setMaxInactiveInterval(60*60*24*365);

					// If the cookies are disabled at client side and we are
					// using URL rewriting then this method uses the jsessionid
					// value from the request URL to find the corresponding
					// session.
					// JSESSIONID cookie is used for session tracking, so we
					// should not use it for our application purposes to avoid
					// any session related issues.
					Cookie userName = new Cookie("name", name);
					Cookie userrole = new Cookie("role", role);
					Cookie userID = new Cookie("id", id);
					userName.setMaxAge(30 * 60);

					// add cookie to response object
					response.addCookie(userName);
					response.addCookie(userrole);
					response.addCookie(userID);
					// Get the encoded URL string



					if( role.equalsIgnoreCase("coach")){
						session.setAttribute("role", "coach");
				
						request.getRequestDispatcher("counsellor.jsp").forward(request,response);
					}
					else if(role.equalsIgnoreCase("admin")){
						session.setAttribute("role", "admin");

			
						request.getRequestDispatcher("adminIndex.jsp").forward(request,response);
					}

					else if(role.equalsIgnoreCase("child")){
						session.setAttribute("role", "child");
					

						request.getRequestDispatcher("user.jsp").forward(request,response);
						
					}
					else if(role.equalsIgnoreCase("parent")){
						session.setAttribute("role", "parent");
						
						request.getRequestDispatcher("parenthomepage.jsp").forward(request,response);
						
					}
				


					x=role;
					System.out.println(x);

				}
				else{
					request.setAttribute("error", "Account's Invalid");
					request.getRequestDispatcher("login.jsp").forward(request,response);
				}
			}
			
			/*response.sendRedirect("login.jsp" + "?IsSuccess=" + rs.next());*/
		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		} catch (Exception e) {
			// Handle errors for Class.forName
			e.printStackTrace();
		}

	}

}
