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
 * Servlet implementation class a
 */
@WebServlet("/a")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
/// indicates this servlet will handle multipart request. We restrict maximum size of the upload file up to 16 MB.
public class a extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public a() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#do(HttpServletRequest request, HttpServletResponse response)
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
	        String message = null;  // message will be sent back to clie
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
			 courseName = request.getParameter("course_name");
          courseDesc = request.getParameter("course_description");
          courseCat = request.getParameter("category");
          courseStatus = Integer.parseInt(request.getParameter("status"));
          courseCost = request.getParameter("course_cost");
          courseDuration = Integer.parseInt(request.getParameter("duration"));
          
      	java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf = 
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			String currentTime = sdf.format(dt);
          
			// Execute SQL query
			final  Statement stmt = conn.createStatement();

			String sql = "INSERT INTO `item` ( `item_name`, `item_desc`, `unit_cost`, `images`,`status_id`, `item_type_id`, `date_last_updated`, `item_duration`,image_type )VALUES (?,?,?,?,?,?,?,?,?)" ;
			
			  PreparedStatement statement = conn.prepareStatement(sql);
			     statement.setString(1, courseName);
		          
			     statement.setString(2, courseDesc);
		          
			     statement.setString(3, courseCost);
		          
		
		          
			     statement.setInt(5, courseStatus);
		          
			     statement.setInt(6, 2);
			     statement.setString(7, currentTime);
			     statement.setInt(8, courseDuration);
			     statement.setString(9, type);
			     if (inputStream != null) {
		                // fetches input stream of the upload file for the blob column
		                statement.setBlob(4, inputStream);
		            }
			int rs = statement.executeUpdate();
			String sql2;
			sql2 = "INSERT INTO `category_has_item` ( `category_id`, `item_id` )VALUES ('"+courseCat+"',LAST_INSERT_ID())" ;
			stmt.executeUpdate(sql2);
			
			if(rs == 1){


				
				response.sendRedirect("workshopAdmin.jsp");
				message = "File uploaded and saved into database";
			}
			else{
				//out.println("failed");
				response.sendRedirect("addWorkshop.jsp");

			}



			  // sets the message in request scope
         request.setAttribute("Message", message);
          
         // forwards to the message page
         getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
			stmt.close();
			conn.close();

		}catch(SQLException se){
			//Handle errors for JDBC
			se.printStackTrace();
			 message = "ERROR: " + se.getMessage();
	     
		}catch(Exception e){
			//Handle errors for Class.forName
			e.printStackTrace();
		}



	}
	}


