package com.wiiy.web.enums;

public enum UserState {
	
	UNACTIVATED("未激活"),NORMAL("正常"),LOCKED("冻结");
	
	private String title;
	
	UserState(String title){
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

}
