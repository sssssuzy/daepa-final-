package model;

public class UserVO {
	private String userid;
	private String userpass;
	private String username;
	private String useraddress;
	private String usertel;
	private String useremail;
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpass() {
		return userpass;
	}
	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUseraddress() {
		return useraddress;
	}
	public void setUseraddress(String useraddress) {
		this.useraddress = useraddress;
	}
	public String getUsertel() {
		return usertel;
	}
	public void setUsertel(String usertel) {
		this.usertel = usertel;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	@Override
	public String toString() {
		return "UserVO [userid=" + userid + ", userpass=" + userpass + ", username=" + username + ", useraddress="
				+ useraddress + ", usertel=" + usertel + ", useremail=" + useremail + "]";
	}
	
}
