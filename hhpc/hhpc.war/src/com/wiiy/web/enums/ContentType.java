package com.wiiy.web.enums;

public enum ContentType {
	
	LABORATORY("实验室");
	
	private String title;
	
	ContentType(String title){
		this.title = title;
	}

	public final String getTitle() {
		return title;
	}
	
}
