

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Database;

/**
 * Servlet implementation class readImageProgram
 */
@WebServlet("/readImageProgram")
public class readImageProgram extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public readImageProgram() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				// TODO Auto-generated method stub

				ServletOutputStream out = response.getOutputStream();
				try {
					Database database= new Database();

					// Open a connection
					Connection conn = database.Get_Connection();
					Blob photo = null;
					String type =null;
					Statement stmt = null;
					ResultSet rs = null;
					String id;

					id=request.getParameter("id");
					System.out.println(id);

					String query = "SELECT  `images` ,  `image_type`  FROM program where program_id  = '"+id+"'";

					stmt = conn.createStatement();
					rs = stmt.executeQuery(query);
					if (rs.next()) {
						type=rs.getString("image_type");
						photo = rs.getBlob(1);
		System.out.println(type);


					} else {
						response.setContentType("text/html");
						out.println("<html><head><title>Person Photo</title></head>");
						out.println("<body><h1>No photo found  </h1></body></html>");
						return;
					}

					response.setContentType(type);
					InputStream in = photo.getBinaryStream();
					int length = (int) photo.length();

					int bufferSize = 1024;
					byte[] buffer = new byte[bufferSize];

					while ((length = in.read(buffer)) != -1) {
						//System.out.println("writing " + length + " bytes");
						out.write(buffer, 0, length);
					}

					in.close();
					out.flush();

				}catch(SQLException se){
					//Handle errors for JDBC
					se.printStackTrace();
					response.setContentType("text/html");
					out.println("<html><head><title>Error: Person Photo</title></head>");

				}catch(Exception e){
					//Handle errors for Class.forName
					out.println("<body><h1>Error=" + e.getMessage() + "</h1></body></html>");
					e.printStackTrace();
				}
			}
			}
