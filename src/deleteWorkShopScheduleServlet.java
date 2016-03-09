

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
 * Servlet implementation class deleteWorkShopScheduleServlet
 */
@WebServlet("/deleteWorkShopScheduleServlet")
public class deleteWorkShopScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteWorkShopScheduleServlet() {
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

			Database database= new Database();

			Connection connection = database.Get_Connection();
			Statement stmt = null;
			stmt = connection.createStatement();


			Statement stmt1 = null;
			stmt1 = connection.createStatement();
			String[] wseID= request.getParameterValues("wseID");


			String query;
			String query1;
			String query2;
			int rs =0;









			ResultSet resultSet;








			for(String id: wseID){
				query2="SELECT itemrun_has_client_id, enrollment_status.enrollment_status_id, client.client_id, itemrun.itemrun_id, program_has_client.program_has_client_id, itemrun_has_client.date_registered, quantity, unit_cost FROM itemrun_has_client, enrollment_status, client, program_has_client, itemrun WHERE  itemrun.itemrun_id IN ('"+id+"') AND enrollment_status.enrollment_status_id = itemrun_has_client.enrollment_status_id AND client.client_id = itemrun_has_client.client_id AND itemrun.itemrun_id = itemrun_has_client.itemrun_id AND program_has_client.program_has_client_id = itemrun_has_client.program_has_client_id";


				resultSet= stmt1.executeQuery(query2);



				if (resultSet.next()) {
					System.out.println("Cannot delete , Itemrun have client registered for it");


					request.setAttribute("Error","Error occured: Cannot delete, have client registered for this run!");



				}else{
					query1 = " DELETE FROM `itemrun_has_client` WHERE  `itemrun_id` IN ('"+id+"')";
					stmt.executeUpdate(query1);
					query = "	 DELETE FROM `itemrun` WHERE   `itemrun_id` IN ('"+id+"')";



					rs =  stmt.executeUpdate(query);
				}

			}

			if(rs==1){
				response.sendRedirect("manageWorkShopSchedule.jsp");

			}else{
				request.getRequestDispatcher("/manageWorkShopSchedule.jsp").forward(request, response);



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
