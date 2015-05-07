package com.wiiy.pb.preferences.enums;

public enum PropertyFixStatusEnum {
	
	FINISHED("完成"), HANGUP("挂起"),UNSTART("未处理"),HANGIN("递交");
		
	 private String title;
	 PropertyFixStatusEnum(String title) {
		this.title = title;
	 }

	 public String getTitle() {
		return title;
	 }	
		
}
