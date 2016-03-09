
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
 * Servlet implementation class deleteEnrollmentStatus
 */
@WebServlet("/deleteEnrollmentStatus")
public class deleteEnrollmentStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteEnrollmentStatus() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

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

			Statement stmt2 = null;
			stmt2 = connection.createStatement();
			String[] eStatus= request.getParameterValues("eStatusID");


			String query;
			String query1;
			String query2;
			String query3;
			String query4;

			ResultSet sqlCheck;
			ResultSet sqlCheck1;

			int rs =0;

			for(String id: eStatus){

				query3="SELECT * FROM program_has_client, enrollment_status WHERE  enrollment_status.enrollment_status_id  IN ('"+id+"') AND program_has_client.enrollment_status_id = enrollment_status.enrollment_status_id";
				sqlCheck= stmt1.executeQuery(query3);
				query4="SELECT * FROM enrollment_status, itemrun_has_client WHERE enrollment_status.enrollment_status_id  IN ('"+id+"') AND enrollment_status.enrollment_status_id = itemrun_has_client.enrollment_status_id";

				sqlCheck1= stmt2.executeQuery(query4);


				if(sqlCheck.next()){
					request.setAttribute("Error","Error occured: Cannot delete , status is tied to  Program which have client!");

				} else if(sqlCheck1.next()){
					request.setAttribute("Error","Error occured: Cannot delete , status is tied to Itemrun which have client!");
				}else {




					query1= "DELETE FROM `itemrun_has_client` WHERE `enrollment_status_id`  IN ('"+id+"')";
					stmt.executeUpdate(query1);
					query2 = "DELETE FROM `program_has_client` WHERE  `enrollment_status_id` IN ('"+id+"')";
					stmt.executeUpdate(query2);
					query = "DELETE FROM `enrollment_status` WHERE  `enrollment_status_id` IN ('"+id+"')";
			

					rs =  stmt.executeUpdate(query);
				}



				if(rs==1){
					response.sendRedirect("manageEnrollmentStatus.jsp");

				}else{
					request.getRequestDispatcher("/manageEnrollmentStatus.jsp").forward(request, response);



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
