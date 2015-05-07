package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 工作项目状态
 *
 */
public enum TaskProjectStatusEnum {
	NORMAL("正常"),CLOSED("已关闭");
	private String title;

	TaskProjectStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
