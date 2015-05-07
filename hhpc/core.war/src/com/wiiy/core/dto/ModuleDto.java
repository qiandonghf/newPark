package com.wiiy.core.dto;

public class ModuleDto {
	//模块名称
	private String name;
	//版本号
	private String version;
	//模块ID
	private String id;
	//供应商
	private String provider;
	//状态
	private String state;
	//发布时间
	private String publishTime;
	//模块安装时间
	private String loadTime;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProvider() {
		return provider;
	}
	public void setProvider(String provider) {
		this.provider = provider;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}
	public String getLoadTime() {
		return loadTime;
	}
	public void setLoadTime(String loadTime) {
		this.loadTime = loadTime;
	}
}
