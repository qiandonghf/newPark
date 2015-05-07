package com.wiiy.cms.preferences.enums;
/**
 * 
 * @author zhf
 * 新闻类别枚举
 */
public enum NewsTypeEnum {
	
	WORDS("文字新闻"),PHOTO("图片新闻"),VIDEO("视频新闻");
	private String title;

	NewsTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
