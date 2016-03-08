package filter;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class RequestLoggingFilter
 */
@WebFilter("/RequestLoggingFilter")
public class RequestLoggingFilter implements Filter {

    /**
     * Default constructor. 
     */
    public RequestLoggingFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}
	 private ServletContext context;
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		  HttpServletRequest req = (HttpServletRequest) request;
	        Enumeration<String> params = req.getParameterNames();
	        while(params.hasMoreElements()){
	            String name = params.nextElement();
	            String value = request.getParameter(name);
	            this.context.log(req.getRemoteAddr() + "::Request Params::{"+name+"="+value+"}");
	        }
	         
	        Cookie[] cookies = req.getCookies();
	        if(cookies != null){
	            for(Cookie cookie : cookies){
	                this.context.log(req.getRemoteAddr() + "::Cookie::{"+cookie.getName()+","+cookie.getValue()+"}");
	            }
	        }
	        // pass the request along the filter chain
	        chain.doFilter(request, response);
	    }


	/**
	 * @see Filter#init(FilterConfig)
	 */
	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		 this.context = fConfig.getServletContext();
	        this.context.log("RequestLoggingFilter initialized");

	}

}
