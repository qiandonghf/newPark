package com.wiiy.pb.preferences.enums;

public enum RoomAttTypeEnum {
	ATTACHMENT("附件"),PHOTO("图片");
	
	private String title;

	RoomAttTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
	
}
