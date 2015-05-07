package com.wiiy.core.dto;

import java.util.ArrayList;
import java.util.List;

public class LoginStatisticalDto {
	
	private Long userId;
	private String username;
	private String depart;
	private Integer loginCount;
	private Integer ipCount;
	private List<String> ips;
	public LoginStatisticalDto(Long userId) {
		super();
		this.userId = userId;
		this.loginCount = 0;
		this.ipCount = 0;
		this.ips = new ArrayList<String>();
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public Integer getLoginCount() {
		return loginCount;
	}
	public void setLoginCount(Integer loginCount) {
		this.loginCount = loginCount;
	}
	public Integer getIpCount() {
		return ipCount;
	}
	public void setIpCount(Integer ipCount) {
		this.ipCount = ipCount;
	}
	public List<String> getIps() {
		return ips;
	}
	public void setIps(List<String> ips) {
		this.ips = ips;
	}
}
