

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
 * Servlet implementation class deleteCoach
 */
@WebServlet("/deleteCoach")
public class deleteCoach extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteCoach() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
			String[] cID= request.getParameterValues("coachID");

			String query;
			String query1;
			String query2;
			String query3;
			String query4;
			String query5;
			int rs =0;

			for(String id: cID){
				query1="DELETE FROM `client_journal` WHERE `coach_id`IN ('"+id+"')";

				stmt.executeUpdate(query1);

				query2=	"DELETE FROM `client` WHERE `coach_id`IN ('"+id+"')";
				stmt.executeUpdate(query2);

				query3=	"DELETE FROM `coach_note` WHERE `coach_id`IN ('"+id+"')";
				stmt.executeUpdate(query3);








				query4=	"DELETE FROM `itemrun` WHERE `coach_id`IN ('"+id+"')";
				stmt.executeUpdate(query4);

				query5 = "DELETE FROM `user` WHERE  `coach_id` IN ('"+id+"')";
				stmt.executeUpdate(query5);

		
				query="DELETE FROM `coach` WHERE `coach_id`IN ('"+id+"')";

				stmt.executeUpdate(query4);

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
