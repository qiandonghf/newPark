package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 子任务状态
 *
 */
public enum SubTaskStatusEnum {
	PENDING("未签收"),SIGNED("已签收"),REFUSED("已拒绝"),FINISHED("已完成"),ABORTED("已中止");
	private String title;

	SubTaskStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
