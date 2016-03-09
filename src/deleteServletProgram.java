

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
public class deleteServletProgram extends HttpServlet {
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


			String[] programID = request.getParameterValues("programID");



			// Execute SQL query
			final  Statement stmt = conn.createStatement();
			String sql;
			String sql2;
			String sql3;
			int rs = 0;
			String sqlCheck;
			ResultSet sqlCheckResults;
			for(String id:programID)
			{
				sql2 = "delete from category_has_program where program_id='"+id+"'";
				sql3 = "delete from program_has_item where program_id='"+id+"'";
				sql = "delete from program where program_id='"+id+"' ";
				
				sqlCheck="SELECT * FROM program,program_has_client "
						+ "WHERE program.program_id = program_has_client.program_id "
						+ "AND program.program_id = '"+id+"'";
				
				sqlCheckResults = stmt.executeQuery(sqlCheck);
				if(sqlCheckResults.next()){
					request.setAttribute("Error","Error occured: Cannot delete , client is tied to program!");
				} else {
					request.setAttribute("Error","Successfully Deleted");

					stmt.execute(sql2);
					stmt.execute(sql3);
					rs = stmt.executeUpdate(sql);

				}
			}


			if(rs == 1){
				 request.getRequestDispatcher("/programAdmin.jsp").forward(request, response);
			} else {
				 request.getRequestDispatcher("/programAdmin.jsp").forward(request, response);
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