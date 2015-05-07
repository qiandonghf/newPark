package com.wiiy.core.dto;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class ResourceDto {
	private String moduleId;
	private String idSpace;
	private String name;
	private String icon;
	private String uri;
	private String uris;
	private String order;
	private String type;
	private String parentId;
	private boolean display = true;
	private List<ResourceDto> children = new ArrayList<ResourceDto>();
	
	private Set<ResourceDto> resChildren;
	
	public Set<ResourceDto> getResChildren() {
		return resChildren;
	}
	public void setResChildren(Set<ResourceDto> resChildren) {
		this.resChildren = resChildren;
	}
	public String getModuleId() {
		return moduleId;
	}
	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public List<ResourceDto> getChildren() {
		return children;
	}
	public void setChildren(List<ResourceDto> children) {
		this.children = children;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getIdSpace() {
		return idSpace;
	}
	public void setIdSpace(String idSpace) {
		this.idSpace = idSpace;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getUris() {
		return uris;
	}
	public void setUris(String uris) {
		this.uris = uris;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public boolean isDisplay() {
		return display;
	}
	public void setDisplay(boolean display) {
		this.display = display;
	}
}
