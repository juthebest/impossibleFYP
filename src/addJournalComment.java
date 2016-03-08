
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
 * Servlet implementation class addJournalComment
 */
@WebServlet("/addJournalComment")
public class addJournalComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addJournalComment() {
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

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			// Register JDBC driver
			// JDBC driver name and database URL
			// Database credentials

			Database database = new Database();

			// Open a connection
			Connection conn = database.Get_Connection();

			String coachcomment = null;
			String journalid = null;
			
			coachcomment = request.getParameter("coachcomment");
			journalid = request.getParameter("id");

			java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);

			// Execute SQL query
			Statement stmt = null;

			stmt = conn.createStatement();
			// create the java mysql update preparedstatement

			int i = stmt.executeUpdate("UPDATE `client_journal` SET`coach_comment`='" + coachcomment
					+ "',`coach_comment_datetime`='" + currentTime + "' WHERE client_journal_id='" + journalid + "'");

			if (i == 1) {
				response.sendRedirect("counsellor.jsp");

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
