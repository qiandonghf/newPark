package com.wiiy.core.dto;

import com.wiiy.commons.entity.TreeEntity;

public class WebInfoDto extends TreeEntity {
	private Long id;
	private String webInfoName;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getWebInfoName() {
		return webInfoName;
	}

	public void setWebInfoName(String webInfoName) {
		this.webInfoName = webInfoName;
	}
}
