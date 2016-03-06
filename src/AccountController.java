

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.Database;
import dto.Account;
import dto.CategoryObjects;
import model.AccountModel;
import model.ProjectCategory;

/**
 * Servlet implementation class AccountController
 */
@WebServlet("/AccountController")
public class AccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AccountController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
		// TODO Auto-generated method stub
		String action =request.getParameter("action");
		HttpSession session=request.getSession();
		if(action ==null){
			Account account = checkCookie(request);
			if(account == null){
				request.getRequestDispatcher("login.jsp").forward(request,response);
			}else{
				AccountModel accModel = new AccountModel();
				if(accModel.login(account.getUsername(),account.getPassword())){
					session.setAttribute("username", account.getUsername());
					request.getRequestDispatcher("welcome.jsp").forward(request,response);
				}else{
					request.setAttribute("error", "Account's Invalid");
					request.getRequestDispatcher("login.jsp").forward(request,response);
				}





			}
		}else{ //log out
			if(action.equalsIgnoreCase("logout")){
				//remove session
				session.removeAttribute("username");
				//remove cookie
				Cookie[] cookies = request.getCookies();
				for(Cookie ck :cookies){
					if(ck.getName().equalsIgnoreCase("username")){
						ck.setMaxAge(0);
						response.addCookie(ck);
					}
					if(ck.getName().equalsIgnoreCase("password")){
						ck.setMaxAge(0);
						response.addCookie(ck);
					}
				}	
				request.getRequestDispatcher("login.jsp").forward(request,response);
			}

		}
	}
	private Account checkCookie(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		Account account =null;
		if(cookies == null)
			return null;
		else{
			String username ="", password ="", role ="";
			for(Cookie ck:cookies){
				if(ck.getName().equalsIgnoreCase("username"))
					username =ck.getValue();
				if(ck.getName().equalsIgnoreCase("password"))
					password=ck.getValue();
				if(ck.getName().equalsIgnoreCase("role"))
					role=ck.getValue();
			}
			if(!username.isEmpty() && !password.isEmpty())
				account = new Account(username,password, role);
		}
		return account;
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action =request.getParameter("action");
		HttpSession session=request.getSession();
		AccountModel accModel = new AccountModel();
		if(action ==null){
			String username =request.getParameter("inputEmail").trim();
			String password =request.getParameter("inputPassword").trim();
			boolean remember = request.getParameter("remember") != null;
			if(accModel.login(username,password)){
				session.setAttribute("username", username);
				if(remember){
					Cookie ckUsername = new Cookie("username",username);
					ckUsername.setMaxAge(3600);
					response.addCookie(ckUsername);
					Cookie ckPassword = new Cookie("password",password);
					ckPassword.setMaxAge(3600);
					response.addCookie(ckPassword);
				}
				request.getRequestDispatcher("welcome.jsp").forward(request,response);

			}else{
				request.setAttribute("error", "Account's Invalid");
				request.getRequestDispatcher("login.jsp").forward(request,response);
			}
		}else{

		}
	}

}
