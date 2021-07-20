package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.ProductDAO;
import model.ProductVO;
import model.SqlVO;


@WebServlet(value={"/product/best","/product/outer","/product/top","/product/bottom","/product/insert","/product/read","/product/delete","/product/update","/product/list","/product/list.json"})
public class Product extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ProductDAO dao = new ProductDAO();
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	String path=request.getServletPath();
    	RequestDispatcher dis=null;
    	
    	switch(path) {    	
    	case "/product/delete":
    		ProductVO oldVO = dao.read(request.getParameter("prod_id"));
    		dao.delete(request.getParameter("prod_id"));
    		if(oldVO.getImage()!=null) {
    			File file = new File("c:/image/"+oldVO.getImage());
    			file.delete();
    		}
    		response.sendRedirect("/product/list");
    		break;
    	case "/product/list.json":
    		SqlVO svo = new SqlVO();
    		svo.setKey(request.getParameter("key"));
        	svo.setWord(request.getParameter("word"));
        	svo.setPage(Integer.parseInt(request.getParameter("page")));        	
        	svo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
        	svo.setOrder(request.getParameter("order"));
        	svo.setDesc(request.getParameter("desc"));
        	out.println(dao.list(svo));
    		break;    
    	case "/product/read" :
    		request.setAttribute("vo",dao.read(request.getParameter("prod_id")));
    		request.setAttribute("pageName","/product/read.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/product/top" :
    		request.setAttribute("pageName","/product/top.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/product/bottom" :
    		request.setAttribute("pageName","/product/bottom.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/product/outer" :
    		request.setAttribute("pageName","/product/outer.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/product/best" :
    		request.setAttribute("pageName","/product/best.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/product/list" :
    		request.setAttribute("pageName","/product/list.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	case "/product/insert" :
    		request.setAttribute("prod_id", dao.getCode());
    		request.setAttribute("pageName","/product/insert.jsp");
    		dis = request.getRequestDispatcher("/home.jsp");
    		dis.forward(request, response);
    		break;
    	} 	    	
    	
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String path=request.getServletPath();
    	
    	MultipartRequest multi= new MultipartRequest(request,
    			"c:/image",1024*1024*10,"UTF-8",new DefaultFileRenamePolicy());
    	//System.out.println(multi.getFilesystemName("image"));
    	ProductVO vo = new ProductVO();
    	vo.setProd_id(multi.getParameter("prod_id"));
    	vo.setProd_name(multi.getParameter("prod_name"));
    	vo.setProd_item(multi.getParameter("prod_item"));
    	vo.setCompany(multi.getParameter("company"));
    	vo.setMall_id(multi.getParameter("mall_id"));
    	vo.setPrice1(Integer.parseInt(multi.getParameter("price1")));   
    	vo.setPrice2(Integer.parseInt(multi.getParameter("price2"))); 
    	vo.setImage(multi.getFilesystemName("image"));
    	vo.setDetail(multi.getParameter("detail"));
    	String prod_del=multi.getParameter("prod_del")==null?"0":"1";    	
    	vo.setProd_del(prod_del);
    	System.out.println(vo.toString());
    	switch(path) {
    	case "/product/update":
    		ProductVO oldVO = dao.read(vo.getProd_id());
    		if(multi.getFilesystemName("image")==null) {
    			vo.setImage(oldVO.getImage());
    		}else {
    			if(oldVO.getImage() != null) {
    				File file = new File("c:/image/"+oldVO.getImage());
    				file.delete();
    			}
    		}
    		dao.update(vo);
    		break;
    	case "/product/insert":
    		dao.insert(vo);
    		break;
    	}
    	response.sendRedirect("/product/list");
    }

}
