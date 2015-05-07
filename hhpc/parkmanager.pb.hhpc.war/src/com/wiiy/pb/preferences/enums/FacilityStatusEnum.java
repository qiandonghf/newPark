package com.wiiy.pb.preferences.enums;

/**
 * 设施状态枚举
 */
public enum FacilityStatusEnum {
    ENABLE("启用"),MAINTAIN("维护"),DISABLE("停用");
    private String title;

    FacilityStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
