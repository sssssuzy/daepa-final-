package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	//로그인
	public UserVO read(String userid){
		UserVO vo = new UserVO();
		try {
			String sql = "select * from users where userid=?";
			PreparedStatement ps= DB.con.prepareStatement(sql);
			ps.setString(1, userid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setUserid(rs.getString("userid"));
				vo.setUserpass(rs.getString("userpass"));
				vo.setUsername(rs.getString("username"));
				vo.setUseraddress(rs.getString("useraddress"));
				vo.setUsertel(rs.getString("usertel"));
				vo.setUseremail(rs.getString("useremail"));
			}
		}catch(Exception e) {
			System.out.println("오류:"+e.toString());
		}return vo;
	}
}
