

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * Servlet implementation class editStudentProfile
 */
@WebServlet("/editStudentProfile")
public class editStudentProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editStudentProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try
		{
			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection connection = database.Get_Connection();

			String id =null;
			String studentname =null;


			studentname =request.getParameter("studentgivenname");


			id=request.getParameter("userid");

			out.println(id);

			out.println(studentname);


			// create the java mysql update preparedstatement
			String query = "UPDATE `user` SET `given_name`= ? WHERE `control_id`=?";

			PreparedStatement preparedStmt = connection.prepareStatement(query);
			preparedStmt.setString  (1, studentname);

			preparedStmt.setString(2, id);
			// execute the java preparedstatement
			int i = preparedStmt.executeUpdate();

			connection.close();
			if(i==1){
				response.sendRedirect("user.jsp");
			}else{
				out.println("There is an error");
	
			}



		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println("Error: " + e.getMessage());
		}
		finally
		{
			out.close();
		}
		
	}

}
