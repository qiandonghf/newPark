package com.wiiy.web.enums;

public enum Gender {
	MAN("男"),WOMAN("女");
	
	private String title;
	
	Gender(String title){
		this.title = title;
	}

	public final String getTitle() {
		return title;
	}
	
}
