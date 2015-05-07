package com.wiiy.web.enums;

public enum EquipmentState {
	
	NORMAL("正常"),USED("借用"),SERVICING("维修中"),BAD("毁坏不能用"),SCRAP("待报废");
	
	private String title;
	
	EquipmentState(String title){
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

}
