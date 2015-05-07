package com.wiiy.web.enums;

public enum LinkType {
	
	LINK("友情链接"),RESOURCE("网站资源");
	
	private String title;
	
	LinkType(String title){
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
