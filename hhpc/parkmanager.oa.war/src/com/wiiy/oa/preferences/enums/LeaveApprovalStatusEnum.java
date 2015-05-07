package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 *请假审批状态枚举
 */
public enum LeaveApprovalStatusEnum {
	PENDING("待审批"),AGREE("同意"),DISAGREE("不同意");
	private String title;

	LeaveApprovalStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
