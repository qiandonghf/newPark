package com.wiiy.crm.preferences.enums;

/**
 * 项目申报状态
 * @author Administrator
 *
 */
public enum ProjectApplyStatusEnum {
	SUCCESS("申请成功"),FAILED("申请失败"),APPLYING("申请中");
	
	private String title;

	ProjectApplyStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
