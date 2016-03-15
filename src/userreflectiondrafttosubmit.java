

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class userreflectiondrafttosubmit
 */
@WebServlet("/userreflectiondrafttosubmit")
public class userreflectiondrafttosubmit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userreflectiondrafttosubmit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");

		if ("Save".equals(action)) {
			// Invoke FirstServlet's job here.
			final String DB_URL = "jdbc:mysql://localhost:3306/mydb";

			// Database credentials
			final String USER = "root";
			final String PASS = "";

			// Set response content type
			response.setContentType("text/html");

			PrintWriter out = response.getWriter();

			try {
				// Register JDBC driver
				Class.forName("com.mysql.jdbc.Driver");

				// Open a connection
				Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

				// get from js
				String editor = request.getParameter("editor1");
				String privacy = request.getParameter("privacyin");
				String emotionrating = request.getParameter("emotionrating");
				String journalid = request.getParameter("clientjournalid");

				// Date format (USER table - parent)
				java.util.Date dt = new java.util.Date();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentTime = sdf.format(dt);

				out.println("Your Text = " + editor + "<br>");

				// Execute SQL query
				final Statement stmt = conn.createStatement();
				String sql;
				sql = "UPDATE `client_journal` SET `journal_reflection`='" + editor + "', `privacy_indicator`='" + privacy + "',"
						+ "`emotion_rating`='" + emotionrating + "', `create_update_datetime`='" + currentTime + "' WHERE client_journal_id ='" + journalid + "'";


				int rs = stmt.executeUpdate(sql);
				// validate login to remember the row

				if (rs == 1) {
					out.println("success");
					response.sendRedirect("user.jsp");
				} else {
					out.println("failed");
					response.sendRedirect("ReflectionJournal.jsp");
				}

			} catch (SQLException se) {
				// Handle errors for JDBC
				se.printStackTrace();
			} catch (Exception e) {
				// Handle errors for Class.forName
				e.printStackTrace();
			}

		} else if ("Submit".equals(action)) {
			// Invoke SecondServlet's job here.
			final String DB_URL = "jdbc:mysql://localhost:3306/mydb";

			// Database credentials
			final String USER = "root";
			final String PASS = "";

			// Set response content type
			response.setContentType("text/html");

			PrintWriter out = response.getWriter();

			try {
				// Register JDBC driver
				Class.forName("com.mysql.jdbc.Driver");

				// Open a connection
				Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

				// get from js
				String editor = request.getParameter("editor1");
				String privacy = request.getParameter("privacyin");
				String emotionrating = request.getParameter("emotionrating");
				String journalid = request.getParameter("clientjournalid");

				// Date format (USER table - parent)
				java.util.Date dt = new java.util.Date();
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentTime = sdf.format(dt);

				out.println("Your Text = " + editor + "<br>");

				// Execute SQL query
				final Statement stmt = conn.createStatement();
				String sql;

				sql = "UPDATE `client_journal` SET `journal_reflection`='" + editor + "', `privacy_indicator`='" + privacy + "',"
						+ "`emotion_rating`='" + emotionrating + "', `create_update_datetime`='" + currentTime + "', `journalstatus_id`= '1' WHERE client_journal_id ='" + journalid + "'";
				int rs = stmt.executeUpdate(sql);
				// validate login to remember the row

				if (rs == 1) {
					out.println("success");
					response.sendRedirect("user.jsp");
				} else {
					out.println("failed");
					response.sendRedirect("ReflectionJournal.jsp");
				}

			} catch (SQLException se) {
				// Handle errors for JDBC
				se.printStackTrace();
			} catch (Exception e) {
				// Handle errors for Class.forName
				e.printStackTrace();
			}
		}
	}

}
