package com.wiiy.cms.dto;

import java.util.List;

public class CatalogDto {
	private String paramName;
	private Long paramId;
	private String catalogName;
	private Integer level;
	private Long id;
	private Long parentId;
	private Integer displayOrder;
	private List<CatalogDto> catalogDtoList;
	
	
	public String getParamName() {
		return paramName;
	}
	public void setParamName(String paramName) {
		this.paramName = paramName;
	}
	public Long getParamId() {
		return paramId;
	}
	public void setParamId(Long paramId) {
		this.paramId = paramId;
	}
	public String getCatalogName() {
		return catalogName;
	}
	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getParentId() {
		return parentId;
	}
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	public Integer getDisplayOrder() {
		return displayOrder;
	}
	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}
	public List<CatalogDto> getCatalogDtoList() {
		return catalogDtoList;
	}
	public void setCatalogDtoList(List<CatalogDto> catalogDtoList) {
		this.catalogDtoList = catalogDtoList;
	}
	
	
	
}
