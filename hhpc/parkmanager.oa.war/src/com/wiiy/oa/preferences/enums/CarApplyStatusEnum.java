package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 车辆申请状态
 *
 */
public enum CarApplyStatusEnum{
	PENDING("未审批"),AGREE("审批同意"),REFUSE("审批拒绝");
	private String title;

	CarApplyStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
