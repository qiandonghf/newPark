package com.wiiy.web.enums;

public enum OrderState {
	
	NEW("新建"),APPLY("申请中"),DIRECTORAGREE("实验室主任审批通过"),AGREE("终审通过"),DISAGREE("未通过"),READY("待签收"),SIGNFOR("已全部领用");
	
	private String title;
	
	OrderState(String title){
		this.title = title;
	}
 
	public String getTitle() {
		return title;
	}

}
