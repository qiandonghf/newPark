package com.wiiy.cms.dto;

import java.util.List;

public class WebInfoDto {
	private String link;
	private String title;
	private Long id;
	private List<WebContentDto> webContentDtoList;
	private Boolean isCheck;
	
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public List<WebContentDto> getWebContentDtoList() {
		return webContentDtoList;
	}
	public void setWebContentDtoList(List<WebContentDto> webContentDtoList) {
		this.webContentDtoList = webContentDtoList;
	}
	public Boolean getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(Boolean isCheck) {
		this.isCheck = isCheck;
	}
	
}
