package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Administrator
 *公告发布状态枚举
 */
public enum NoticeStatusEnum {
	UNISSUED("未发布"),ISSUED("发布");
	private String title;

	NoticeStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
