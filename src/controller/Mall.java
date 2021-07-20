package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MallDAO;
import model.MallVO;
import model.SqlVO;


@WebServlet(value={"/mall/list","/mall/delete","/mall/update","/mall/read","/mall/insert","/mall/list.json"})
public class Mall extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MallDAO dao = new MallDAO();
       
  	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  		response.setContentType("text/html;charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	String path=request.getServletPath();
    	RequestDispatcher dis=null;
    	
    	switch(path) {
    	case "/mall/delete" :
    		dao.delete(request.getParameter("mall_id"));
    		response.sendRedirect("/mall/list");
    		break;
    	case "/mall/read":
    		request.setAttribute("vo", dao.read(request.getParameter("mall_id")));
    		request.setAttribute("pageName","/mall/read.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/mall/insert":
    		request.setAttribute("mall_id", dao.getCode());
    		request.setAttribute("pageName","/mall/insert.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/mall/list.json":
    		SqlVO svo = new SqlVO();
    		svo.setKey(request.getParameter("key"));
        	svo.setWord(request.getParameter("word"));
        	svo.setPage(Integer.parseInt(request.getParameter("page")));
        	svo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
        	svo.setOrder(request.getParameter("order"));
        	svo.setDesc(request.getParameter("desc"));
        	out.println(dao.list(svo));
    		break;    		
    	case "/mall/list" :
    		request.setAttribute("pageName","/mall/list.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	} 	    	
  	}
  	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String path=request.getServletPath();
		MallVO vo = new MallVO();
		vo.setMall_id(request.getParameter("mall_id"));
		vo.setMall_name(request.getParameter("mall_name"));
		vo.setManager(request.getParameter("manager"));
		vo.setAddress(request.getParameter("address"));
		vo.setEmail(request.getParameter("email"));
		vo.setTel(request.getParameter("tel"));
		vo.setDetail(request.getParameter("detail"));
		System.out.println(vo.toString());
		switch(path) {
		case "/mall/update":
			dao.update(vo);
			break;
		case "/mall/insert":
			dao.insert(vo);
			break;
		}
		response.sendRedirect("/mall/list");
	}

}
