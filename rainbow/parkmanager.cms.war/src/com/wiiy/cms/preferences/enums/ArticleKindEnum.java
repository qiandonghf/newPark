package com.wiiy.cms.preferences.enums;
/**
 * 
 * @author Aswan
 *文章栏目类型枚举
 */
public enum ArticleKindEnum {
	
	SINGLE("单页文章"),LIST("列表文章"),TOPIC("专题"),CUSTOM("自定义");
	private String title;

	ArticleKindEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
