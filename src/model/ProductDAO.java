package model;

import java.sql.*;

import org.apache.catalina.filters.CsrfPreventionFilter;
import org.json.simple.*;

public class ProductDAO {
	//상품정보 삭제
	public void delete(String prod_id) {
		try {
			String sql = "delete from product where prod_id=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, prod_id);
			ps.execute();			
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}
	}
	//상품정보 수정
	public void update(ProductVO vo) {
		try {
			String sql="update product set prod_name=?,company=?,prod_item=?,mall_id=?,price1=?,price2=?,prod_del=?,detail=?,image=? where prod_id=?";
			PreparedStatement ps = DB.con.prepareStatement(sql);
			ps.setString(10, vo.getProd_id());
			ps.setString(1, vo.getProd_name());
			ps.setString(3, vo.getProd_item());
			ps.setString(4, vo.getMall_id());
			ps.setString(2, vo.getCompany());
			ps.setInt(5, vo.getPrice1());
			ps.setInt(6, vo.getPrice2());
			ps.setString(8, vo.getDetail());
			ps.setString(9, vo.getImage());
			ps.setString(7, vo.getProd_del());
			ps.execute();
		}catch(Exception e) {
			System.out.println("오류:"+ e.toString());
		}
	}
	//상품정보
	public ProductVO read(String prod_id) {
		ProductVO vo = new ProductVO();
		try {
			String sql="select * from productMall where prod_id=?";
			PreparedStatement ps = DB.con.prepareStatement(sql);
			ps.setString(1, prod_id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setProd_id(rs.getString("prod_id"));
				vo.setProd_name(rs.getString("prod_name"));
				vo.setProd_item(rs.getString("prod_item"));
				vo.setMall_id(rs.getString("mall_id"));
				vo.setProd_del(rs.getString("prod_del"));
				vo.setMall_name(rs.getString("mall_name"));
				vo.setPrice1(rs.getInt("price1"));
				vo.setPrice2(rs.getInt("price2"));
				vo.setCompany(rs.getString("company"));
				vo.setDetail(rs.getString("detail"));
				vo.setImage(rs.getString("image"));				
			}
		}catch(Exception e) {
			System.out.println("오류:"+ e.toString());
		}return vo;
	}
	//상품코드
	public String getCode() {
		String prod_id="P001";
		try {
			String sql = "select max(prod_id) from product";
			PreparedStatement ps = DB.con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				String lastId=rs.getString("max(prod_id)");
				prod_id="P"+(Integer.parseInt(lastId.substring(1))+1);
			}
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}
		return prod_id;
	}
	//상품등록
	public void insert(ProductVO vo) {
		try {
			String sql="insert into product(prod_id,prod_name,prod_item,mall_id,company,price1,price2,detail,image,prod_del) values (?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = DB.con.prepareStatement(sql);
			ps.setString(1, vo.getProd_id());
			ps.setString(2, vo.getProd_name());
			ps.setString(3, vo.getProd_item());
			ps.setString(4, vo.getMall_id());
			ps.setString(5, vo.getCompany());
			ps.setInt(6, vo.getPrice1());
			ps.setInt(7, vo.getPrice2());
			ps.setString(8, vo.getDetail());
			ps.setString(9, vo.getImage());
			ps.setString(10, "0");
			ps.execute();			
		}catch(Exception e) {
			System.out.println("오류:"+ e.toString());
		}
	}
	//상픔목록
	public JSONObject list(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		System.out.println(vo.toString());
		try {
			String sql= "{call list(?,?,?,?,?,?,?,?,?)}";
			CallableStatement cs=DB.con.prepareCall(sql);
			cs.setString(1, "product");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setInt(4, vo.getPage());
			cs.setInt(5, vo.getPerpage());
			cs.setString(6, vo.getOrder());
			cs.setString(7, vo.getDesc());
			cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
			cs.registerOutParameter(9, oracle.jdbc.OracleTypes.INTEGER);		
			cs.execute();			
			ResultSet rs=(ResultSet)cs.getObject(8);
			JSONArray array=new JSONArray();
			while(rs.next()) {
				JSONObject obj= new JSONObject();
				obj.put("prod_id", rs.getString("prod_id"));				
				obj.put("prod_name", rs.getString("prod_name"));
				obj.put("prod_item", rs.getString("prod_item"));
				obj.put("mall_id", rs.getString("mall_id"));
				obj.put("company", rs.getString("company"));
				obj.put("price1", rs.getInt("price1"));
				obj.put("price2", rs.getInt("price2"));	
				obj.put("detail", rs.getString("detail"));
				obj.put("image", rs.getString("image"));
				obj.put("prod_del", rs.getString("prod_del"));
				array.add(obj);
			}
			jObject.put("productList", array);
			int count= cs.getInt(9);
			jObject.put("count", count);
					
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}return jObject;
	}
}
