import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dao.Database;


/**
 * Servlet implementation class InsertCoaching
 */
@WebServlet("/EditWorkshop")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
/// indicates this servlet will handle multipart request. We restrict maximum size of the upload file up to 16 MB.
public class EditWorkshop extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	@Override
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		 InputStream inputStream = null; // input stream of the upload file
	        String type = null;
	        // obtains the upload file part in this multipart request
	        Part filePart = request.getPart("photo");
	        if (filePart != null) {
	            // prints out some information for debugging
	            System.out.println(filePart.getName());
	            System.out.println(filePart.getSize());
	            System.out.println(filePart.getContentType());
	      type=  filePart.getContentType();
	            // obtains input stream of the upload file
	            inputStream = filePart.getInputStream();
	        }
	         
	        Connection conn = null; // connection to the database
	

		try{

			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
		 conn = database.Get_Connection();
			
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

 			java.util.Date dt = new java.util.Date();
 			java.text.SimpleDateFormat sdf = 
 					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			String currentTime = sdf.format(dt);
			// Execute SQL query
			final  Statement stmt = conn.createStatement();

			String sql;
		
			
			sql = "UPDATE item SET item_name = ?, status_id = ?, item_type_id = ?, item_desc = ?, unit_cost = ?, images = ?, date_last_updated = ?, item_duration = ?, image_type = ? WHERE item_id = ?";
			
			  PreparedStatement statement = conn.prepareStatement(sql);
			     statement.setInt(2, courseStatus);
		          
			     statement.setString(1, courseName);
		          
			     statement.setString(3, courseType);
		          
		
		          
			     statement.setString(4, courseDesc);
		          
			     statement.setString(5, courseCost);
			     statement.setString(7, currentTime);
			     statement.setInt(8, courseDuration);
			     statement.setString(9, type);
			     statement.setString(10, itemID);
			     if (inputStream != null) {
		                // fetches input stream of the upload file for the blob column
		                statement.setBlob(6, inputStream);
		            }
			int rs = statement.executeUpdate();
			String sql2;
			sql2 = "UPDATE `category_has_item` "
					+ "SET `category_id`='"+courseCat+"' "
							+ "WHERE item_id='"+itemID+"'" ;
			stmt.executeUpdate(sql2);
			
			
			if(rs == 1){


				
				response.sendRedirect("workshopAdmin.jsp");

			}
			else{
				//out.println("failed");
				response.sendRedirect("addWorkshop.jsp");

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
