package com.wiiy.oa.dto;

public class ApprovalDto{
	
	private Long id;
	private String username;
	private String status;
	
	public ApprovalDto(Long id, String username, String status) {
		super();
		this.id = id;
		this.username = username;
		this.status = status;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
