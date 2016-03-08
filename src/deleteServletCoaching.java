

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
 * Servlet implementation class deleteServlet
 */
@WebServlet("/deleteServlet")
public class deleteServletCoaching extends HttpServlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// JDBC driver name and database URL

	

		
		// Set response content type
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();

		try{
			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection conn = database.Get_Connection();


			String[] itemID = request.getParameterValues("itemID");



			// Execute SQL query
			final  Statement stmt = conn.createStatement();
			String sql;
			String sql2;
			String sql3;
			String sqlCheck;
			ResultSet sqlCheckResults;
			int rs = 0;
			/*sqlCheck = "SELECT * FROM category_has_item,program_has_item,item"+ 
					"WHERE item.item_id = category_has_item.item_id" 
					+"AND program_has_item.item_id = item.item_id";*/
			
			
			for(String id:itemID)
			{
				sql2 = "delete from category_has_item where item_id='"+id+"'";
				sql3 = "delete from program_has_item where item_id='"+id+"'";
				sql = "delete from item where item_id='"+id+"' ";
				
				sqlCheck = "SELECT * FROM itemrun,itemrun_has_client,item "
						+ "WHERE '"+id+"' = itemrun.item_id "
						+ "AND itemrun_has_client.itemrun_id = itemrun.itemrun_id";
				sqlCheckResults = stmt.executeQuery(sqlCheck);
				
				if(sqlCheckResults.next()){
					request.setAttribute("Error","Error occured: Cannot delete , client is tied to item!");
				} else {
					request.setAttribute("Error","Successfully Deleted");

					stmt.execute(sql2);
					stmt.execute(sql3);
					rs = stmt.executeUpdate(sql);

				}
				
			}


			if(rs == 1){
				response.sendRedirect("coachingAdmin.jsp");

			} else {
				response.sendRedirect("coachingAdmin.jsp");
			}


			stmt.close();
			conn.close();

		}catch(SQLException se){
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			//Handle errors for Class.forName
			e.printStackTrace();
		}
	}
}