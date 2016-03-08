

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class deleteUser
 */
@WebServlet("/deleteUser")
public class deleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out =  response.getWriter();
		try
		{
			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection connection = database.Get_Connection();
			Statement stmt = null;
			stmt = connection.createStatement();
			String[] uID= request.getParameterValues("userID");

	
			String query;
			String query1;
		
			int rs =0;
		
			for(String id: uID){
	
				 query1 = "DELETE FROM `user_has_role` WHERE `user_id` IN ('"+id+"')";
				 stmt.executeUpdate(query1);
			
				 
				 query = "DELETE FROM `user` WHERE `user_id` IN ('"+id+"')";
	
			
		
				 rs =  stmt.executeUpdate(query);
			}



			if(rs==1){
				response.sendRedirect("manageUser.jsp");

			}else{
			out.println("There is an error");
			response.sendRedirect("manageUser.jsp");


		}
			stmt.close();
			connection.close();

		}catch(SQLException se){
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			//Handle errors for Class.forName
			e.printStackTrace();
		}
	
	}


}
