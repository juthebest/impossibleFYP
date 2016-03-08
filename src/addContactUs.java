

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * Servlet implementation class addContactUs
 */
@WebServlet("/addContactUs")
public class addContactUs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addContactUs() {
        super();
        // TODO Auto-generated constructor stub
    }



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
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


			String address =null;

			String pc =null;
			String country_code =null;


			String email =null;
			String direction=null;

	

			address=request.getParameter("address");
			pc=request.getParameter("pn");
			country_code=request.getParameter("country_code");


			email=	request.getParameter("email");


			direction=request.getParameter("direction");


		

	
	

			// Execute SQL query
			Statement stmt = null;

			stmt = connection.createStatement();



			int rs =	 stmt.executeUpdate("INSERT INTO `control`( `office_address`, `office_tel_number`, `country_code`, `office_email`, `office_directions`) VALUES ('"+address+"','"+pc+"','"+country_code+"','"+email+"','"+direction+"')"); 
		
				//validate login to remember the row

				if(rs == 1){


					out.println("success");
					response.sendRedirect("manageContactUs.jsp");
				}
				else{
					out.println("failed");
					response.sendRedirect("manageContactUs.jsp");

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
