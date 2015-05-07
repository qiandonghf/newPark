package com.wiiy.pb.preferences.enums;

/**
 * 
 * @author aswan
 * 苗圃申请状态
 */
public enum GardenApplyStateEnum {
	EVAL("评审中"),AGREE("评审同意"),REJECT("评审拒绝");
	
	private String title;

	GardenApplyStateEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
