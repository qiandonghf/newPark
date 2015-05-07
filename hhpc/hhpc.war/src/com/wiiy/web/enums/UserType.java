package com.wiiy.web.enums;

public enum UserType {
	ADMIN("管理员"),
	TEACHER("老师"),
	STUDENT("学生"),
	COMPANY("企业"),
	OTHER("其他"),
	MOBILITY("流动人员"),
	DIMISSION("离职人员");
	private String title;
	
	UserType(String title){
		this.title = title;
	}

	public final String getTitle() {
		return title;
	}
	
}
