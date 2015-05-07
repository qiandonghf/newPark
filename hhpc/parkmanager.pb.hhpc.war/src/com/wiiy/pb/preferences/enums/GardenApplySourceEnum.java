package com.wiiy.pb.preferences.enums;

/**
 * 
 * @author aswan
 * 苗圃申请信息来源
 */
public enum GardenApplySourceEnum {
	WINDOW("窗口"),WEB("网站"),CENTER("后台");
	
	private String title;

	GardenApplySourceEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
