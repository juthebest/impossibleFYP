

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

			/*		for(int i=0;i<catID.length;i++){
			if(i==0) {
				catString = catString + "'" +(String)catID[i] + "'"; 
			}else{ 
					catString = catString + ",'" + (String)catID[i] + "'"; 
				} 
		}
		out.println(catString);

			 */
			String query;
			String queryCheck;

			int b=0;
			int bCheck =0;


			for(String id: catID){

				queryCheck = "SELECT * FROM category,category_has_item,item"
						+ "WHERE item.item_id = category_has_item.item_id "
						+ "AND category_has_item.category_id = '"+id+"' ";
				bCheck = stmt.executeUpdate(queryCheck);
				
				if(bCheck == 0 ){
					query = "DELETE FROM `category` WHERE  category_id  IN ('"+id+"')";
					b =  stmt.executeUpdate(query);
				} else {
					request.setAttribute("error", " Invalid");
					request.getRequestDispatcher("login.jsp").forward(request,response);
				}
				// execute the preparedstatement
			}



			if(b==1){
				response.sendRedirect("manageCategory.jsp");

			}
			out.println("There is an error");


		}

		catch (Exception e)
		{
			System.err.println("Got an exception! ");
			System.err.println(e.getMessage());
		}

	}

}

