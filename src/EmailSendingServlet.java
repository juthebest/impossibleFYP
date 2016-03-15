import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * A servlet that takes message details from user and send it as a new e-mail
 * through an SMTP server.
 * 
 * @author www.codejava.net
 * 
 */
@WebServlet("/EmailSendingServlet")
public class EmailSendingServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String host;
	private String port;
	private String user;
	private String pass;

	public void init() {
		// reads SMTP server setting from web.xml file
		ServletContext context = getServletContext();
		host = context.getInitParameter("host");
		port = context.getInitParameter("port");
		user = context.getInitParameter("user");
		pass = context.getInitParameter("pass");
	}
	static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	static SecureRandom rnd = new SecureRandom();

	static String randomString( int len ){
		StringBuilder sb = new StringBuilder( len );
		for( int i = 0; i < len; i++ ) 
			sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
		return sb.toString();
	}

	String random =randomString(15);

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// reads form fields
		String recipient = request.getParameter("recipient");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		int i;
		String resultMessage = "";



		subject = "Reset Your Password";
		content="Hi, We've received a request to reset your password. If you didnt make the request, just ignore this email. Otherwise, you can reset your password using this link. Thanks The I'MPOSSIBLE TEAM" + random;


		try {
		

			// Register JDBC driver
			// JDBC driver name and database URL
			//  Database credentials

			Database database= new Database();

			// Open a connection
			Connection conn = database.Get_Connection();
			
			
			final  Statement statement = conn.createStatement();
			ResultSet resultset =  statement.executeQuery("SELECT * FROM `user` WHERE `email` ='"+recipient+"'") ;


		if(resultset.next())
			{
				// create the java mysql update preparedstatement
				String query = "UPDATE `user` SET `password`= ? WHERE email = ?";
				PreparedStatement preparedStmt = conn.prepareStatement(query);
				preparedStmt.setString  (1, random);
				preparedStmt.setString(2, recipient);

				// execute the java preparedstatement
				i = preparedStmt.executeUpdate();
				EmailUtility.sendEmail(host, port, user, pass, recipient, subject,
						content);
				resultMessage = "The e-mail was sent successfully, Please log in with your new password";
				request.setAttribute("successlink", "login.jsp");


			conn.close();

			}else{
				resultMessage = "Error occured: Email:"+ " " + recipient + " " +"dont exist in our database";
				request.setAttribute("link", "passwordForgot.jsp");
			
			}
	
} catch (Exception ex) {
		ex.printStackTrace();
		resultMessage = "There were an error: " + ex.getMessage();
	} finally {
		request.setAttribute("Message", resultMessage);
		getServletContext().getRequestDispatcher("/Result.jsp").forward(
				request, response);
	}

}
}
