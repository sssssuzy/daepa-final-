package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class PurchaseDAO {
	//구매상품 입력
	public void insert_product(OrderVO vo) {
		try {
			String sql="insert into orders(order_id,prod_id,price,quantity) values (?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, vo.getOrder_id());
			ps.setString(2, vo.getProd_id());
			ps.setInt(3, vo.getPrice());
			ps.setInt(4, vo.getQuantity());
			ps.execute();
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}
	}
	//구매정보 입력
	public String insert(PurchaseVO vo) {
		String order_id ="";
		try {
			String sql="select max(order_id) from purchase";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				String id=rs.getString("max(order_id)");
				int lastId=(Integer.parseInt(id.substring(1))+1);
				order_id="R"+lastId;
			}
			sql="insert into purchase (order_id,name,tel,address,email,pdate,paytype,status) values (?,?,?,?,?,sysdate,?,'0')";
			ps=DB.con.prepareStatement(sql);
			ps.setString(1, order_id);
			ps.setString(2, vo.getName());
			ps.setString(3, vo.getTel());
			ps.setString(4, vo.getAddress());
			ps.setString(5, vo.getEmail());
			ps.setString(6, vo.getPaytype());
			ps.execute();
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}return order_id;
	}
	//주문한 상품목록 삭제
	public void delete(String order_id) {
		try {
			
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}
	}
	//주문한 상품목록
	public JSONArray productList(String order_id) {
		JSONArray array = new JSONArray();
		try {
			String sql = "select * from productlist where order_id=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, order_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("prod_id", rs.getString("prod_id"));
				obj.put("prod_name", rs.getString("prod_name"));
				obj.put("price", rs.getInt("price"));
				obj.put("quantity", rs.getInt("quantity"));
				obj.put("sum", rs.getInt("price")*rs.getInt("quantity"));
				array.add(obj);
			}
			
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}return array;
	}
	//주문목록
	public JSONObject list(SqlVO vo,String userid) {
		JSONObject jObject = new JSONObject();
		try {
			String sql= "{call plist(?,?,?,?,?,?,?,?,?,?)}";
			CallableStatement cs=DB.con.prepareCall(sql);
			cs.setString(1, "purchase");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setInt(4, vo.getPage());
			cs.setInt(5, vo.getPerpage());
			cs.setString(6, vo.getOrder());
			cs.setString(7, vo.getDesc());
			cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
			cs.registerOutParameter(9, oracle.jdbc.OracleTypes.INTEGER);
			cs.setString(10,userid);
			cs.execute();
			
			ResultSet rs=(ResultSet)cs.getObject(8);
			JSONArray array=new JSONArray();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			while(rs.next()) {
				JSONObject obj= new JSONObject();
				obj.put("order_id", rs.getString("order_id"));				
				obj.put("name", rs.getString("name"));
				obj.put("tel", rs.getString("tel"));
				obj.put("address", rs.getString("address"));
				obj.put("email", rs.getString("email"));
				obj.put("pdate", sdf.format(rs.getDate("pdate")));
				obj.put("paytype", rs.getString("paytype"));
				obj.put("status", rs.getString("status"));
				array.add(obj);
			}
			jObject.put("purchaseList", array);
			int count= cs.getInt(9);
			jObject.put("count", count);
					
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}return jObject;
	}
}
