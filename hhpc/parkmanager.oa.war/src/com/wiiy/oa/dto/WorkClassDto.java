package com.wiiy.oa.dto;

import com.wiiy.oa.preferences.enums.SignTypeEnum;


public class WorkClassDto {
	private Long id;
	private String name;
	private Boolean isSign;
	private SignTypeEnum type;
	public Boolean getIsSign() {
		return isSign;
	}
	public void setIsSign(Boolean isSign) {
		this.isSign = isSign;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public SignTypeEnum getType() {
		return type;
	}
	public void setType(SignTypeEnum type) {
		this.type = type;
	}
	
	
}
