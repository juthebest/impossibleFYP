

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
 * Servlet implementation class deleteCategoryServlet
 */
@WebServlet("/deleteCategoryServlet")
public class deleteCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteCategoryServlet() {
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
			String[] catID= request.getParameterValues("catID");
			String query1;
			String query2;
			String query;

			int rs =0;

			for(String id: catID){
				query1="DELETE FROM `category_has_item` WHERE `category_id` IN ('"+id+"')";
				stmt.executeUpdate(query1);
				
				query2="DELETE FROM `category_has_program` WHERE  `category_id` IN ('"+id+"')";
				stmt.executeUpdate(query2);
				query="DELETE FROM `category` WHERE `category_id` IN ('"+id+"')";



		
				rs =  stmt.executeUpdate(query);
			}
			
			
			if(rs==1){
				response.sendRedirect("manageCategory.jsp");

			}else{
				out.println("There is an error");
				response.sendRedirect("manageCategory.jsp");


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




