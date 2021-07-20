package model;

public class SqlVO {
	private String table;
	private String key;
	private String word;
	private int page;
	private int perpage;
	private String order;
	private String desc;
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerpage() {
		return perpage;
	}
	public void setPerpage(int perpage) {
		this.perpage = perpage;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	@Override
	public String toString() {
		return "SqlVO [table=" + table + ", key=" + key + ", word=" + word + ", page=" + page + ", perpage=" + perpage
				+ ", order=" + order + ", desc=" + desc + "]";
	}
	
	
	
	
	
}
