package ino.web.freeBoard.common.util;

public class Pagination {

	private int page = 1;
	private int endPage;
	//페이지당 글 개수
	private int pageSize = 5;
	//페이지네이션 번호개수
	private int blockSize = 5;
	private String url;
	
	public Pagination() {}
	
	public Pagination(int page, int totalCount, String url) {
		this.setPage(page);
		this.setEndPage(totalCount);
		this.setUrl(url);
	}
	// 결과가 없을 시 페이지 1로 끝냄
	public void setPage(int page) {
		this.page = page > 0 ? page : 1;
	}
	
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	
	public void setEndPage(int totalCount) {
		// 페이지 끝번호 계산
		this.endPage = (int) Math.ceil((double) totalCount / this.pageSize);
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	//첫번째 페이지
	private int makeStart(int target, int size) {
		return (target - 1) * size + 1;
	}
	//마지막 페이지
	private int makeEnd(int target, int size) {
		return target * size;
	}
	// 페이지 블럭 생성
	public String getPagination() {
		StringBuffer buffer = this.makeCss(new StringBuffer());
		
		buffer.append("<div class=\"paging\">");
		if(this.getBlockStart() > 1) {
			buffer.append("<span><a href=\"" + this.url + "?page=" + this.getBlockPrev() + "\"><</a></span>");
		}
		
		for(int i = this.getBlockStart(); i <= this.getBlockEnd(); i++) {
			if(page == i)
				buffer.append("<span>" + i + "</span>");
			else
				buffer.append("<span><a href=\"" + this.url + "?page=" + i + "\">" + i + "</a></span>");
		}
		
		if(this.getBlockEnd() < endPage) {
			buffer.append("<span><a href=\"" + this.url + "?page=" + this.getBlockNext() + "\">></a></span>");
		}
		
		buffer.append("</div>");
		return buffer.toString();
	}
	
	private StringBuffer makeCss(StringBuffer buffer) {
		buffer.append("<style>")
				.append(".paging {")
				.append("	display: block;")
				.append("	width: 100%;")
				.append("	text-align: center;")
				.append("}")
				.append(".paging > span:not(:last-child) {")
				.append("	margin-right: 5px;")
				.append("}")
				.append(".paging > span {")
				.append("	display: inline-block;")
				.append("	width: 25px;")
				.append("	height: 25px;")
				.append("	border-radius: 2px;")
				.append("	background-color: #03A9F4;")
				.append("	color : #fff;")
				.append("	font-size: 13px;")
				.append("	line-height: 24px;")
				.append("}")
				.append(".paging > span:hover > a {")
				.append("	border-radius: 2px;")
				.append("	background-color: #03A9F4;")
				.append("	color: #fff;")
				.append("}")
				.append(".paging > span > a {")
				.append("	display : inline-block;")
				.append("	width : 100%;")
				.append("	height : 100%;")
				.append("	border-radius: 2px;")
				.append("	cursor : pointer;")
				.append("	text-decoration : none;")
				.append("	background-color: #fff;")
				.append("	color : #8e8e8e;")
				.append("}")
				.append("</style>");
		return buffer;
	}
	// 첫번째 페이지 
	public int getStart() {
		return this.makeStart(this.page, this.pageSize);
	}
	// 마지막 페이지
	public int getEnd() {
		return this.makeEnd(this.page, this.pageSize);
	}
	
	private int getBlockGroup() {
		return (int) Math.ceil((double) this.page / this.blockSize);
	}
	
	private int getBlockStart() {
		return this.makeStart(this.getBlockGroup(), this.blockSize);
	}
	
	private int getBlockEnd() {
		int blockEnd = this.makeEnd(this.getBlockGroup(), this.blockSize);
		return blockEnd > this.endPage ? this.endPage : blockEnd;
	}
	//이전페이지(페이지네이션)
	private int getBlockPrev() {
		return this.getBlockStart() - 1;
	}
	//다음페이지(페이지네이션)
	private int getBlockNext() {
		return this.getBlockEnd() + 1;
	}
}
