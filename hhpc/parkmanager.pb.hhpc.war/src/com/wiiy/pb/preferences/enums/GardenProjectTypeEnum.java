package com.wiiy.pb.preferences.enums;
/**
 * 
 * @author aswan
 * 苗圃项目类型
 *
 */
public enum GardenProjectTypeEnum {
	PRODUCT("产品"),SERVICE("服务"),OTHER("其它");
	
	private String title;

	GardenProjectTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
