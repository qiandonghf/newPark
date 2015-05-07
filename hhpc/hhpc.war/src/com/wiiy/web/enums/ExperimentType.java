package com.wiiy.web.enums;

public enum ExperimentType {
	
	TABLE("实验台"),LABORATORY("实验室"),KEYTABLE("重点实验室"),MEETINGROOM("会议室");
	
	private String title;
	
	ExperimentType(String title){
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
