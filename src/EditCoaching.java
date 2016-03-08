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
@WebServlet("/EditCoaching")
public class EditCoaching extends HttpServlet {
	private static final long serialVersionUID = 1L;


	
	
	@Override
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
			
			 String courseName= null;
			 String courseDesc = null;
			 int courseStatus;
			 String courseCost = null;
			 String courseCat = null;
             int courseDuration;
             String courseType = null;
             String itemID = null;
			 courseName = request.getParameter("course_name");
             courseDesc = request.getParameter("course_description");
             courseCat = request.getParameter("category");
             courseStatus = Integer.parseInt(request.getParameter("status"));
             courseCost = request.getParameter("course_cost");
             courseDuration = Integer.parseInt(request.getParameter("duration"));
             courseType = request.getParameter("item_type");
             itemID = request.getParameter("itemID");
             
			// Execute SQL query
			final  Statement stmt = conn.createStatement();

			String sql;
			sql = "UPDATE `item` "
					+ "SET `item_name`='"+courseName+"', `item_desc`='"+courseDesc+"', `unit_cost`='"+courseCost+"', `status_id`='"+courseStatus+"', `item_type_id`='"+courseType+"', `item_duration`='"+courseDuration+"' "
							+ "WHERE item_id='"+itemID+"'";
			int rs = stmt.executeUpdate(sql);
			String sql2;
			sql2 = "UPDATE `category_has_item` "
					+ "SET `category_id`='"+courseCat+"' "
							+ "WHERE item_id='"+itemID+"'" ;
			stmt.executeUpdate(sql2);
			
			
			if(rs == 1){


				
				response.sendRedirect("coachingAdmin.jsp");

			}
			else{
				//out.println("failed");
				response.sendRedirect("addCoaching.jsp");

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
