package com.wiiy.pb.preferences.enums;

public enum ComplaintAcceptStatusEnum {
	
	FINISHED("已解决"), HANGUP("待进一步跟进"),UNSTART("未受理");
		
	 private String title;
	 ComplaintAcceptStatusEnum(String title) {
		this.title = title;
	 }

	 public String getTitle() {
		return title;
	 }	
		
}
