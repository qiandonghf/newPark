package com.wiiy.pb.preferences.enums;

public enum PatrolIntervalEnum {
	Year("年"), Month("月"),Day("天");
	
	 private String title;
	 PatrolIntervalEnum(String title) {
		this.title = title;
	 }

	 public String getTitle() {
		return title;
	 }
}
