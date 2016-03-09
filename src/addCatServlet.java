

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
 * Servlet implementation class addCatServlet
 */
@WebServlet("/addCatServlet")
public class addCatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addCatServlet() {
		super();
		// TODO Auto-generated constructor stub
	}



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		// Set response content type
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();
		int rs =0;


		try{
			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection conn = database.Get_Connection();

			String textarea =null;
			String textarea1=null;
			textarea= request.getParameter("name");
			textarea1= request.getParameter("desc");
			out.println("Your Text = "+textarea+"<br>");
			out.println("Your Text = "+textarea1+"<br>");

			// Execute SQL query
			final  Statement stmt = conn.createStatement();

			final  Statement statement = conn.createStatement();
			ResultSet resultset =  statement.executeQuery("SELECT * FROM `category` WHERE `category_name` ='"+textarea+"'") ;

			int ct = 0;
			while(resultset.next())
			{
				ct++;	
			}
			if (ct > 0)
			{

				request.setAttribute("Error","Error occured: Duplicate info! Category Name: " + textarea);
				request.getRequestDispatcher("/addCat.jsp").forward(request, response);

			}
			else
			{



				String sql;
				sql = "INSERT INTO `category`(`category_desc`, `category_name`) VALUES ('"+textarea1+"','"+textarea+"') " ;
				rs = stmt.executeUpdate(sql);
				//validate login to remember the row




			} 


			if(rs == 1){


				out.println("success");
				response.sendRedirect("manageCategory.jsp");
			}
			else{
				out.println("failed");

				request.getRequestDispatcher("/addCat.jsp").forward(request, response);
			}




		}catch(SQLException se){
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			//Handle errors for Class.forName
			e.printStackTrace();
		}
	}
}


