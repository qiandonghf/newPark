package com.wiiy.pb.preferences.enums;

/**
 * 
 * @author aswan
 * 苗圃项目评审结果
 */
public enum GardenProjectEvalEnum {
	EXCELLENT("优秀"),GOOD("良好"),NORMAL("一般"),BAD("较差");
	
	private String title;

	GardenProjectEvalEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
