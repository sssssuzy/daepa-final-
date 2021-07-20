package model;

public class CommunityVO {
	private int noid;
	private String category;
	private String subtitle;
	private String content;
	private String qnadate;
	private String userid;
	public int getNoid() {
		return noid;
	}
	public void setNoid(int noid) {
		this.noid = noid;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getQnadate() {
		return qnadate;
	}
	public void setQnadate(String qnadate) {
		this.qnadate = qnadate;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	@Override
	public String toString() {
		return "CommunityVO [noid=" + noid + ", category=" + category + ", subtitle=" + subtitle + ", content="
				+ content + ", qnadate=" + qnadate + ", userid=" + userid + "]";
	}
	
	
	
}
