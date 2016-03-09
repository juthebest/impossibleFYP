// check if it is tied to item/program

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
 * Servlet implementation class deleteItemStatus
 */
@WebServlet("/deleteItemStatus")
public class deleteItemStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteItemStatus() {
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


			Database database= new Database();

			Connection connection = database.Get_Connection();
			Statement stmt = null;
			stmt = connection.createStatement();
			Statement stmt1 = null;
			stmt1 = connection.createStatement();
			Statement stmt2 = null;
			stmt2 = connection.createStatement();
			Statement stmt3 = null;
			stmt3 = connection.createStatement();
			String[] iStatus= request.getParameterValues("itemStatusID");


			String query;
			String query1;
			String query2;
			String query3;
			String query4;
			String query5;
			String query6;
			int rs =0;
			ResultSet sqlCheck;
			ResultSet sqlCheck1;
			ResultSet sqlCheck2;
			for(String id: iStatus){


				query4="SELECT * FROM item, STATUS WHERE status.status_id IN ('"+id+"') AND item.status_id = status.status_id";
				sqlCheck = stmt1.executeQuery(query4);

				query5="SELECT * FROM STATUS , program WHERE  status.status_id IN ('"+id+"') AND status.status_id = program.status_id";
				sqlCheck1 = stmt2.executeQuery(query5);
				query6="SELECT * FROM STATUS , itemrun WHERE status.status_id IN ('"+id+"') AND status.status_id = itemrun.status_id";
				sqlCheck2 = stmt3.executeQuery(query6);
				
				if(sqlCheck.next()){
					request.setAttribute("Error","Error occured: Cannot delete , status is tied to item!");

				} else if(sqlCheck1.next()){
					request.setAttribute("Error","Error occured: Cannot delete , status is tied to program!");
				}else if(sqlCheck2.next()){
					request.setAttribute("Error","Error occured: Cannot delete , status is tied to itemrun!");
				}else {
					query1= "DELETE FROM `itemrun`   WHERE `status_id` IN ('"+id+"')";
					stmt.executeUpdate(query1);
					query2 = "DELETE FROM `item`  WHERE  `status_id` IN ('"+id+"')";
					stmt.executeUpdate(query2);
					query3 = "DELETE FROM `program` WHERE   `status_id` IN ('"+id+"')";
					stmt.executeUpdate(query3);
					query = "DELETE FROM `status`  WHERE `status_id` IN ('"+id+"')";


					rs =  stmt.executeUpdate(query);	
					request.setAttribute("Error","Successfully Deleted");
				}



				if(rs==1){
					 request.getRequestDispatcher("/manageItemStatus.jsp").forward(request, response);

				}else{
					 request.getRequestDispatcher("/manageItemStatus.jsp").forward(request, response);


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
