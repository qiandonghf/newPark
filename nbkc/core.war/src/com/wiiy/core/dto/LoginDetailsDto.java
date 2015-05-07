package com.wiiy.core.dto;

import java.util.Date;


public class LoginDetailsDto extends LoginStatisticalDto {
	private String content;
	private String ip;
	private String time;
	
	public LoginDetailsDto(Long userId) {
		super(userId);
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
}
