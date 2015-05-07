package com.wiiy.oa.dto;

public class UserNoticeDto{
	private Long id;//公告ID
	private String name;// 公告标题
	private String content;//公告内容
	private String issuer;//发布者
	private String state;//发布状态
	private String issueTime;//发布日期
	private String userView;//是否看过
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIssuer() {
		return issuer;
	}
	public void setIssuer(String issuer) {
		this.issuer = issuer;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getIssueTime() {
		return issueTime;
	}
	public void setIssueTime(String issueTime) {
		this.issueTime = issueTime;
	}
	public String getUserView() {
		return userView;
	}
	public void setUserView(String userView) {
		this.userView = userView;
	}
}
