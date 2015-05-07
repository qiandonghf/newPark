package com.wiiy.pb.preferences.enums;

public enum GardenApplyAttTypeEnum {
	BUSINESSPLAN("商业计划书"),OTHER("其它附件");
	
	private String title;

	GardenApplyAttTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
