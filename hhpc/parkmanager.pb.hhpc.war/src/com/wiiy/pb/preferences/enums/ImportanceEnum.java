package com.wiiy.pb.preferences.enums;

public enum ImportanceEnum {
	
	EMERGENCY("紧急"), IMPORTANT("重要"),GENERAL("一般");
		
	 private String title;
	 ImportanceEnum(String title) {
		this.title = title;
	 }

	 public String getTitle() {
		return title;
	 }	
		
}
