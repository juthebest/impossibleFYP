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
@WebServlet("/EditProgram")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
/// indicates this servlet will handle multipart request. We restrict maximum size of the upload file up to 16 MB.
public class EditProgram extends HttpServlet {
	private static final long serialVersionUID = 1L;


	static final String DB_URL = "jdbc:mysql://localhost:3306/mydb";
	static final String USER = "root";
	static final String PASS = "";

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

 			java.util.Date dt = new java.util.Date();
 			java.text.SimpleDateFormat sdf = 
 					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			String currentTime = sdf.format(dt);
			// Execute SQL query
			final  Statement stmt = conn.createStatement();

			String sql;
			sql = "UPDATE `program` SET `status_id`= ?, `program_name`=?,`program_desc`=?,`program_price`=?,`program_duration`=?,`images`=?,`date_last_updated`=?,`image_type`=? WHERE `program_id`=?";
			
			
			  PreparedStatement statement = conn.prepareStatement(sql);
			  statement.setInt(1, programStatus);
	          
			     statement.setString(2, programName);
		          
			     statement.setString(3, programDesc);
		          
		
		          
			     statement.setString(4, programCost);
		          
			     statement.setInt(5, programDuration);
			     statement.setString(7, currentTime);
			     statement.setString(8, type);
			     statement.setString(9, programID);
			    
			     if (inputStream != null) {
		                // fetches input stream of the upload file for the blob column
		                statement.setBlob(6, inputStream);
		            }
			int rs = statement.executeUpdate();
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
