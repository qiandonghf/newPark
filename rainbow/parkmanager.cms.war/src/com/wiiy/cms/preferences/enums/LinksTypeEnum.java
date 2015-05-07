package com.wiiy.cms.preferences.enums;
/**
 * 
 * @author zhf
 * 新闻类别枚举
 */
public enum LinksTypeEnum {
	
	WORDS("文字链接"),PHOTO("图片链接");
	private String title;

	LinksTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
