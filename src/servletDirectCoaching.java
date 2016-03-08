

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/servletDirect")
public class servletDirectCoaching extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String direct = request.getParameter("direct");
		String id = request.getParameter("selected");

		if(direct != null) {
			if(direct.equals("Delete")) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("deleteServletCoaching");
				dispatcher.forward(request, response);
			}
			else if(direct.equals("Edit")) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("editCoaching.jsp");
				dispatcher.forward(request, response);
			}
		}
	}
}