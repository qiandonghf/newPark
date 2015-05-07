package com.wiiy.pb.preferences.enums;

/**
 * 
 * @author aswan
 * 苗圃项目来源
 */
public enum GardenProjectSourceEnum {
	TEACHER("导师课题"),STUDENT("学生自行拟定"),OTHER("其它");
	
	private String title;

	GardenProjectSourceEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
