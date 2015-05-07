package com.wiiy.pb.preferences.enums;

public enum RoomStatusEnum {
	IDLE("空闲"),BOOK("预定"),FITMENT("装修"),USING("占用");
	
	private String title;

	RoomStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
