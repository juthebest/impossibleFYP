//check if coach is in any of the runs and client

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
			
			Statement stmt1 = null;
			stmt1 =connection.createStatement();
			Statement stmt2 = null;
			stmt2 =connection.createStatement();
			
			Statement stmt3 = null;
			stmt3 =connection.createStatement();
			String[] cID= request.getParameterValues("coachID");

			String query;
			String query1;
			String query2;
			String query3;
			String query4;
			String query5;
			
			String querycheck1;
			ResultSet check;
			
			
			String querycheck2;
			ResultSet check2;
			
			
			String querycheck3;
			ResultSet check3;
			int rs =0;

			for(String id: cID){
				
				querycheck1="SELECT * FROM coach, client, coach_note WHERE coach.coach_id IN ('"+id+"') AND coach.coach_id = client.coach_id AND coach_note.coach_id = client.coach_id AND coach_note.coach_id = coach.coach_id";
				check=stmt1.executeQuery(querycheck1);
				
				
				querycheck2="SELECT * FROM coach, itemrun WHERE coach.coach_id IN ('"+id+"') AND itemrun.coach_id = coach.coach_id";
				check2=stmt2.executeQuery(querycheck2);
				
				querycheck3="SELECT * FROM client_journal, client, coach WHERE coach.coach_id IN ('"+id+"') AND coach.coach_id = client_journal.coach_id AND coach.coach_id = client.coach_id";
				check3=stmt3.executeQuery(querycheck3);
				
				
	
				if(check.next()){
					request.setAttribute("Error","Error occured: Cannot delete , coach is assigned to client!");
				}else if(check2.next()){
					request.setAttribute("Error","Error occured: Cannot delete , coach is assigned to scheduled workshop !");
				}
				else if(check3.next()){
					request.setAttribute("Error","Error occured: Cannot delete , coach is assigned to client journal !");
				}else{
				query1="DELETE FROM `client_journal` WHERE `coach_id`IN ('"+id+"')";

				stmt.executeUpdate(query1);

				query2=	"DELETE FROM `client` WHERE `coach_id`IN ('"+id+"')";
				stmt.executeUpdate(query2);

				query3=	"DELETE FROM `coach_note` WHERE `coach_id`IN ('"+id+"')";
				stmt.executeUpdate(query3);
				request.setAttribute("Error","Successfully Deleted");







				query4=	"DELETE FROM `itemrun` WHERE `coach_id`IN ('"+id+"')";
				stmt.executeUpdate(query4);

				query5 = "DELETE FROM `user` WHERE  `coach_id` IN ('"+id+"')";
				stmt.executeUpdate(query5);

		
				query="DELETE FROM `coach` WHERE `coach_id`IN ('"+id+"')";

				stmt.executeUpdate(query4);

				rs =  stmt.executeUpdate(query);
			}



			if(rs==1){
				response.sendRedirect("manageCoachUser.jsp");

			}else{
			
				 request.getRequestDispatcher("/manageCoachUser.jsp").forward(request, response);


			}
			stmt.close();
			connection.close();

			}}catch(SQLException se){
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			//Handle errors for Class.forName
			e.printStackTrace();
		}

	}



}
