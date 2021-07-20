package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class CommunityDAO {	
	//글읽기
			public CommunityVO read(int noid) {
				CommunityVO vo = new CommunityVO();
				try {
					String sql="select * from community where noid=?";
					PreparedStatement ps=DB.con.prepareStatement(sql);
					ps.setInt(1, noid);
					ResultSet rs = ps.executeQuery();
					if(rs.next()) {
						vo.setNoid(rs.getInt("noid"));
						vo.setCategory(rs.getString("category"));
						vo.setQnadate(rs.getString("qnadate"));
						vo.setSubtitle(rs.getString("subtitle"));
						vo.setContent(rs.getString("content"));
						vo.setUserid(rs.getString("userid"));
					}
				}catch(Exception e) {
					System.out.println("오류:"+ e.toString());
				}return vo;		
			}
	//글등록
		public void insert(CommunityVO vo) {
			try {
				String sql="insert into community(noid,category,subtitle,content,qnadate,userid) values(?,?,?,?,sysdate,?)";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ps.setInt(1, vo.getNoid());
				ps.setString(2, vo.getCategory());
				ps.setString(3, vo.getSubtitle());
				ps.setString(4, vo.getContent());
				ps.setString(5, vo.getUserid());
				ps.execute();
			}catch(Exception e) {
				System.out.println("오류:"+ e.toString());
			}			
		}
	//글번호 
		public int getCode() {
			int noid=1;
			try {
				String sql="select max(noid) from community";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {
					noid = rs.getInt("max(noid)")+1;
				}
			}catch(Exception e) {
				System.out.println("오류:"+ e.toString());
			}return noid;
		}
	//QnA목록
		public JSONObject list(SqlVO vo,String userid) {
			JSONObject jObject = new JSONObject();
			try {
				String sql= "{call plist(?,?,?,?,?,?,?,?,?,?)}";
				CallableStatement cs=DB.con.prepareCall(sql);
				cs.setString(1, "community");
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
					obj.put("noid", rs.getString("noid"));				
					obj.put("category", rs.getString("category"));
					obj.put("subtitle", rs.getString("subtitle"));
					obj.put("content", rs.getString("content"));
					obj.put("qnadate", sdf.format(rs.getDate("qnadate")));
					obj.put("userid", rs.getString("userid"));
					array.add(obj);
				}
				jObject.put("qnaList", array);
				int count= cs.getInt(9);
				jObject.put("count", count);
						
			}catch(Exception e) {
				System.out.println("오류:"+e.toString());
			}return jObject;
		}

}
