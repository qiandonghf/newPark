package com.wiiy.crm.preferences.enums;
/**
 * 自检状态
 * @author Aswan
 *
 */
public enum CheckStatusEnum {
	UNFINISHED("未完成"),PART("部分"),FAILURE("失败"),SUCCESS("成功");
	
	private String title;

	CheckStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
