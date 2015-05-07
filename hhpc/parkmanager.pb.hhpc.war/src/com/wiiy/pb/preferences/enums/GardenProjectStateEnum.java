package com.wiiy.pb.preferences.enums;

/**
 * 
 * @author aswan
 * 苗圃项目状态
 */
public enum GardenProjectStateEnum {
	APPLYING("申请"),SEEDLING("育苗"),EMERGENCE("出苗"),TERMINATE("终止");
	
	private String title;

	GardenProjectStateEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
