package com.wiiy.pb.preferences.enums;

/**
 * 设施类型枚举
 */
public enum FacilityTypeEnum {
    NETWORK("网络"),LIFT("电梯"),PARK("车位"),AD("广告位"),MEETINGROOM("会议室");
    private String title;

    FacilityTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
