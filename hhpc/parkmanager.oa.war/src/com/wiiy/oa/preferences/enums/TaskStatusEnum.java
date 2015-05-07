package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 任务状态
 *
 */
public enum TaskStatusEnum{
	PENDING("未开始"),RUNNING("进行中"),FINISHED("已完成"),WAITING("等待他人"),DELAY("已推迟"),ABORTED("已中止");
	private String title;

	TaskStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
