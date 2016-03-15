
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
 * Servlet implementation class deleteCategoryServlet
 */
@WebServlet("/deleteCategoryServlet")
public class deleteCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteCategoryServlet() {
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
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			// Register JDBC driver
			// JDBC driver name and database URL
			// Database credentials

			Database database = new Database();

			// Open a connection
			Connection connection = database.Get_Connection();
			Statement stmt = null;
			Statement stmt1 = null;
			Statement stmt2 = null;
			stmt = connection.createStatement();
			stmt1 = connection.createStatement();
			stmt2 = connection.createStatement();
			String[] catID = request.getParameterValues("catID");
			String query1;
			String query2;
			String query4;
			String query5;
			String query;

			int rs = 0;

			ResultSet resultSet;

			for (String id : catID) {
				query4 = "SELECT category.category_id,  `category_has_item_id` , item.item_id FROM  `category_has_item` , item, category WHERE category.category_id IN ('"
						+ id
						+ "') AND category_has_item.item_id = item.item_id AND category_has_item.category_id = category.category_id";

				query5 = "SELECT category.category_id, program.program_id,category_has_program_id  FROM  `category_has_program` , category, program  WHERE category.category_id IN ('"
						+ id
						+ "')  AND program.program_id = category_has_program.category_has_program_id  AND category.category_id = category_has_program.category_id";

				query1 = "DELETE FROM `category_has_item` WHERE `category_id` IN ('" + id + "')";
				query2 = "DELETE FROM `category_has_program` WHERE  `category_id` IN ('" + id + "')";
				query = "DELETE FROM `category` WHERE `category_id` IN ('" + id + "')";

				resultSet = stmt.executeQuery(query4);

				ResultSet j = stmt1.executeQuery(query5);
				if (resultSet.next()) {
					System.out.println("Cannot delete , Category is tied to item");

					request.setAttribute("Error", "Error occured: Cannot delete , Category is tied to item!");

				} else if (j.next()) {
					System.out.println("Cannot delete , Category is tied to program!");

					request.setAttribute("Error", "Error occured: Cannot delete , Category is tied to program");

				} else {
					System.out.println("nodata");

					request.setAttribute("Error", "Successfully Deleted");
					stmt.executeUpdate(query1);

					stmt1.executeUpdate(query2);

					rs = stmt2.executeUpdate(query);

				}

			}

			if (rs == 1) {

				request.getRequestDispatcher("/manageCategory.jsp").forward(request, response);

			} else {

				request.getRequestDispatcher("/manageCategory.jsp").forward(request, response);

			}

			stmt.close();
			connection.close();

		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		} catch (Exception e) {
			// Handle errors for Class.forName
			e.printStackTrace();
		}

	}
}
