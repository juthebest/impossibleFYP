

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
 * Servlet implementation class deleteServlet
 */
@WebServlet("/deleteServlet")
public class deleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;



	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// JDBC driver name and database URL


		// Set response content type
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();

		try{
			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection conn = database.Get_Connection();


			String[] itemID = request.getParameterValues("selected");



			// Execute SQL query
			final  Statement stmt = conn.createStatement();
			String sql;
			String sql2;
			String sql3;
			int rs = 0;

			for(String id:itemID)
			{
				sql2 = "delete from category_has_item where item_id='"+id+"'";
				stmt.execute(sql2);
				sql3 = "delete from program_has_item where item_id='"+id+"'";
				stmt.execute(sql3);
				sql = "delete from item where item_id='"+id+"' ";
				rs = stmt.executeUpdate(sql);
			}


			if(rs == 1){


				/*out.println("success");servletDirect.java
				out.print(courseName);
				out.print(courseDesc);
				out.print(courseIMG);
				out.print(courseStatus);*/
				response.sendRedirect("workshopAdmin.jsp");

			}
			else{
				out.println("failed");
				response.sendRedirect("workshopAdmin.jsp");

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