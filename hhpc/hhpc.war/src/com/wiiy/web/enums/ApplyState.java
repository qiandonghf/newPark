package com.wiiy.web.enums;

public enum ApplyState {
	
	PENDDING("等待老师确认"),APPLY("申请中"), MANAGERAGREE("管理员确认"), DIRECTORAGREE("实验室主任审批通过"), AGREE("终审通过"), DISAGREE("未通过"), CANCEL("取消");
	
	private String title;
	
	ApplyState(String title){
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

}
