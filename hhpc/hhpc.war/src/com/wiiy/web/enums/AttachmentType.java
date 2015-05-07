package com.wiiy.web.enums;

public enum AttachmentType {
	
	IMAGE("图片"),FILE("附件"),VIDEO("视频");
	
	private String title;
	
	AttachmentType(String title){
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
