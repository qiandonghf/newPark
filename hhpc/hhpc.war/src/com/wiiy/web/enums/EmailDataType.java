package com.wiiy.web.enums;

public enum EmailDataType {
	
	INIT("初始化"),CHECK("检查"), RELOAD("重新加载"),SEND("发送"),RESEND("重新发送");
	
	private String title;
	
	EmailDataType(String title){
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

}
