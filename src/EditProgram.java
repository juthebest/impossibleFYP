import java.io.IOException;


import java.sql.Connection;

import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * Servlet implementation class InsertCoaching
 */
@WebServlet("/EditProgram")
public class EditProgram extends HttpServlet {
	private static final long serialVersionUID = 1L;


	static final String DB_URL = "jdbc:mysql://localhost:3306/mydb";
	static final String USER = "root";
	static final String PASS = "";


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
		// Set response content type
		response.setContentType("text/html");



		try{

			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection conn = database.Get_Connection();
			String[] itemID = request.getParameterValues("itemsSelected");

			String programName= null;
			String programDesc = null;
			int programStatus;
			String programCost = null;
			String programCat = null;
			int programDuration;
			String programID = null;
			programName = request.getParameter("program_name");
			programDesc = request.getParameter("program_description");
			programCat = request.getParameter("category");
			programStatus = Integer.parseInt(request.getParameter("status"));
			programCost = request.getParameter("program_cost");
			programDuration = Integer.parseInt(request.getParameter("duration"));
			programID = request.getParameter("programID");

			// Execute SQL query
			final  Statement stmt = conn.createStatement();

			String sql;
			sql = "UPDATE `program` "
					+ "SET `program_name`='"+programName+"', `program_desc`='"+programDesc+"', `program_price`='"+programCost+"', `status_id`='"+programStatus+"',  `program_duration`='"+programDuration+"' "
					+ "WHERE program_id='"+programID+"'";
			int rs = stmt.executeUpdate(sql);
			String sql2;
			sql2 = "UPDATE `category_has_program` "
					+ "SET `category_id`='"+programCat+"' "
					+ "WHERE program_id='"+programID+"'" ;
			stmt.executeUpdate(sql2);
			String sql3;
			String sql4;
			String sql5;
			if(itemID==null){
				sql4 = "DELETE from program_has_item where program_id='"+programID+"'";
				stmt.execute(sql4);
			} else {
				for(String id:itemID)
				{
				sql5 = "DELETE from `program_has_item` where `item_id`!='"+id+"'";
				stmt.execute(sql5);
				}
				for(String id:itemID)
				{
					
					sql3 = "INSERT INTO `program_has_item` (`item_id`, `program_id`) "
							+ "VALUES ('"+id+"', '"+programID+"') "
							+ "ON DUPLICATE KEY "
							+ "UPDATE `item_id`='"+id+"'";


					stmt.executeUpdate(sql3);
				}
			}
			if(rs == 1){



				response.sendRedirect("programAdmin.jsp");

			}
			else{
				//out.println("failed");
				response.sendRedirect("editProgram.jsp");

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
