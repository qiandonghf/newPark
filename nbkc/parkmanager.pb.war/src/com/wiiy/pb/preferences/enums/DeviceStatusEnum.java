package com.wiiy.pb.preferences.enums;

public enum DeviceStatusEnum {
	
	RUNNING("运行"), HANGUP("停止"),UNSTART("维护");
	
	 private String title;
	 DeviceStatusEnum(String title) {
		this.title = title;
	 }

	 public String getTitle() {
		return title;
	 }

}
