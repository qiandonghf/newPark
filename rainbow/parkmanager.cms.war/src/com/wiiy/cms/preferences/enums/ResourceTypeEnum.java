package com.wiiy.cms.preferences.enums;
/**
 * 
 * @author zhf
 *文章栏目类型枚举
 */
public enum ResourceTypeEnum {
	
	FLASH("flash"),IMAGE("图片"),WORDS("文字"),JS("js代码");
	private String title;

	ResourceTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
