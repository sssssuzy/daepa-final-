package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class MallDAO {
	//업체정보 삭제
	public void delete(String mall_id) {
		try {
			String sql="delete from mall where mall_id=?";
			PreparedStatement ps = DB.con.prepareStatement(sql);
			ps.setString(1, mall_id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}
	}
	//업체정보 수정
	public void update(MallVO vo) {
		try {
			String sql="update mall set mall_name=?,manager=?,address=?,tel=?,email=?,detail=? where mall_id=?";
			PreparedStatement ps = DB.con.prepareStatement(sql);
			ps.setString(7, vo.getMall_id());
			ps.setString(1, vo.getMall_name());
			ps.setString(2, vo.getManager());
			ps.setString(3, vo.getAddress());
			ps.setString(4, vo.getTel());
			ps.setString(5, vo.getEmail());
			ps.setString(6, vo.getDetail());
			ps.execute();					
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}
	}
	//업체정보 읽기
	public MallVO read(String mall_id) {
		MallVO vo = new MallVO();
		try {
			String sql = "select * from mall where mall_id=?";
			PreparedStatement ps = DB.con.prepareStatement(sql);
			ps.setString(1, mall_id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setMall_id(rs.getString("mall_id"));
				vo.setMall_name(rs.getString("mall_name"));
				vo.setManager(rs.getString("manager"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setTel(rs.getString("tel"));
				vo.setDetail(rs.getString("detail"));
			}			
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}
		return vo;
	}	
	//업체코드 
	public String getCode() {
		String mall_id="M101";
		try {
			String sql = "select max(mall_id) from mall";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				String lastId=rs.getString("max(mall_id)");
				mall_id = "M"+(Integer.parseInt(lastId.substring(1))+1);
			}
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}		
		return mall_id;
	}
	//업체등록
	public void insert(MallVO vo) {
		try {
			String sql="insert into mall(mall_id,mall_name,manager,address,tel,email,detail) values (?,?,?,?,?,?,?)";
			PreparedStatement ps = DB.con.prepareStatement(sql);
			ps.setString(1, vo.getMall_id());
			ps.setString(2, vo.getMall_name());
			ps.setString(3, vo.getManager());
			ps.setString(4, vo.getAddress());
			ps.setString(5, vo.getTel());
			ps.setString(6, vo.getEmail());
			ps.setString(7, vo.getDetail());
			ps.execute();					
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}
	}
	//업체목록
	public JSONObject list(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql= "{call list(?,?,?,?,?,?,?,?,?)}";
			CallableStatement cs=DB.con.prepareCall(sql);
			cs.setString(1, "mall");
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
				obj.put("mall_id", rs.getString("mall_id"));
				obj.put("mall_name", rs.getString("mall_name"));				
				obj.put("address", rs.getString("address"));				
				obj.put("tel", rs.getString("tel"));
				obj.put("email", rs.getString("email"));
				array.add(obj);
			}
			jObject.put("mallList", array);
			int count= cs.getInt(9);
			jObject.put("count", count);
					
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}return jObject;
	}
}
