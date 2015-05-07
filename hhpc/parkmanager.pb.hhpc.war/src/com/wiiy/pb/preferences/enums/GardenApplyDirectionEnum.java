package com.wiiy.pb.preferences.enums;

/**
 * 
 * @author aswan
 * 苗圃申请状态
 */
public enum GardenApplyDirectionEnum {
	INCENTER("科创中心"),NOTINCENTER("区内"),OTHER("区外");
	
	private String title;

	GardenApplyDirectionEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
