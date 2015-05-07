package com.wiiy.crm.preferences.enums;

public enum PayTypeEnum {
	
	NETWORK("网络"); 

	
	private String title;

	PayTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

}
