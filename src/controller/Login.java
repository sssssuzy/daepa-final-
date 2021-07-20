package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserDAO;
import model.UserVO;

@WebServlet(value={"/user/login","/user/logout"})
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	String path=request.getServletPath();
    	RequestDispatcher dis=null;
    switch(path) {	
    	case "/user/logout":
    		HttpSession session = request.getSession();
    		session.setAttribute("user", null);
    		response.sendRedirect("/product/best");
    		break;
		case "/user/login" :
			request.setAttribute("pageName","/user/login.jsp");
			dis = request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
    	}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		UserVO vo = dao.read(request.getParameter("userid"));
		int result=0;
		if(vo.getUserid()!=null) {
			if(vo.getUserpass().equals(request.getParameter("userpass"))) {
				result=1;
				HttpSession session=request.getSession();
				session.setAttribute("user", vo);
			}else {
				result=2;
			}
		}
		PrintWriter out = response.getWriter();	
		out.print(result);
	}

}
