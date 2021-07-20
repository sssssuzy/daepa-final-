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

import model.CommunityDAO;
import model.CommunityVO;
import model.SqlVO;
import model.UserVO;


@WebServlet(value={"/community/list","/community/insert","/community/list.json"})
public class Community extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CommunityDAO dao = new CommunityDAO();
       
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		response.setContentType("text/html;charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	String path=request.getServletPath();
    	RequestDispatcher dis=null;
    	
    	switch(path) {
    	case "/community/insert":
    		request.setAttribute("noid", dao.getCode());
    		request.setAttribute("pageName","/community/insert.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/community/list.json":
    		SqlVO svo = new SqlVO();
    		svo.setKey(request.getParameter("key"));
        	svo.setWord(request.getParameter("word"));
        	svo.setPage(Integer.parseInt(request.getParameter("page")));
        	svo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
        	svo.setOrder(request.getParameter("order"));
        	svo.setDesc(request.getParameter("desc"));
        	//로그인한 사람의 주문목록만 보기
	   		HttpSession session=request.getSession();
	   		UserVO userVO=(UserVO)session.getAttribute("user");
	   		String userid=userVO.getUserid()==null ? "" : userVO.getUserid();
	   		out.println(dao.list(svo,userid));
    		break; 
    	case "/community/list":
    		request.setAttribute("pageName","/community/list.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	}
   	}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
			String path=request.getServletPath();
			CommunityVO vo = new CommunityVO();
			vo.setNoid(Integer.parseInt(request.getParameter("noid")));
			vo.setCategory(request.getParameter("category"));
			vo.setUserid(request.getParameter("userid"));
			vo.setSubtitle(request.getParameter("subtitle"));
			vo.setContent(request.getParameter("content"));
			switch(path) {
			case "/community/insert":
				dao.insert(vo);
				break;
			}
			response.sendRedirect("/community/list");
			
		}

}
