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

import model.OrderVO;
import model.PurchaseDAO;
import model.PurchaseVO;
import model.SqlVO;
import model.UserVO;

@WebServlet(value={"/purchase/list","/purchase/insert_product","/purchase/insert","/purchase/productList.json","/purchase/list.json"})
public class Purchase extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PurchaseDAO dao = new PurchaseDAO();

   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		response.setContentType("text/html;charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	String path=request.getServletPath();
    	RequestDispatcher dis=null;
    	
    	switch(path) {
    	case "/purchase/productList.json":
    		out.println(dao.productList(request.getParameter("order_id")));
    		break;
    	case "/purchase/list.json":
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
    	case "/purchase/list":
    		request.setAttribute("pageName","/purchase/list.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	}
    	
   	}
   	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		request.setCharacterEncoding("UTF-8");
   		String path=request.getServletPath();
   		switch(path) {
   		case "/purchase/insert_product" :
   			OrderVO ordervo= new OrderVO();
   			ordervo.setOrder_id(request.getParameter("order_id"));
   			ordervo.setProd_id(request.getParameter("prod_id"));
   			ordervo.setPrice(Integer.parseInt(request.getParameter("price")));
   			ordervo.setQuantity(Integer.parseInt(request.getParameter("quantity")));
   			dao.insert_product(ordervo);
   			break;
   		case "/purchase/insert":
   			PurchaseVO vo = new PurchaseVO();
   			vo.setName(request.getParameter("name"));
   			vo.setAddress(request.getParameter("address"));
   			vo.setTel(request.getParameter("tel"));
   			vo.setPaytype(request.getParameter("paytype"));
   			vo.setEmail(request.getParameter("email"));
   			String order_id=dao.insert(vo);
   			PrintWriter out = response.getWriter(); //브라우저에 출력
   			out.print(order_id);
   			//장바구니 비우기
   			HttpSession session = request.getSession();
   			session.setAttribute("cartList", null);
   			break;
   		}
	}
}
