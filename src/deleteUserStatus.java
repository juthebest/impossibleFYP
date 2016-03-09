

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
 * Servlet implementation class deleteUserStatus
 */
@WebServlet("/deleteUserStatus")
public class deleteUserStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteUserStatus() {
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
			Statement stmt2 = null;
			stmt2 = connection.createStatement();
			String[] uStatus= request.getParameterValues("userStatusID");

			String query;
			String query1;
			String query2;
			int rs =0;
		ResultSet sqlCheck;
			for(String id: uStatus){
				
				query2="SELECT * FROM  `userstatus` , user WHERE  userstatus.userStatus_id IN ('"+id+"') AND user.`userStatus_id` = userstatus.`userStatus_id` ";
				
				sqlCheck=stmt2.executeQuery(query2);
				
				if(sqlCheck.next()){
					request.setAttribute("Error","Error occured: Cannot delete , status is tied to users!");

				} else {
				 query1 = "DELETE FROM `user` WHERE  `userStatus_id` IN ('"+id+"')";
				 stmt.executeUpdate(query1);
				 query = "DELETE FROM `userstatus` WHERE  `userStatus_id` IN ('"+id+"')";
				// execute the preparedstatement
			
		
				 rs =  stmt.executeUpdate(query);
					request.setAttribute("Error","Successfully Deleted");
			}



			if(rs==1){
				request.getRequestDispatcher("/manageUserStatus.jsp").forward(request, response);

			}else{
				request.getRequestDispatcher("/manageUserStatus.jsp").forward(request, response);

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
