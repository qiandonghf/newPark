package com.wiiy.core.dto;

import java.util.Date;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;

public class AppDto {
	
	public static final String CORE_APP_ID = "core.war";
		
	public static final String APP_SUFFIX = ".war";

	private Long bundleId;
	
	private String appId;
	
	private String simpleName;

	private String name;
	
	private String version;
	
	private EntityStatus status;
	
	private Date lastChangeStatus;
	
	private String msg;

	public Long getBundleId() {
		return bundleId;
	}

	public void setBundleId(Long bundleId) {
		this.bundleId = bundleId;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getName() {
		return name;
	}

	public String getSimpleName() {
		return simpleName;
	}

	public void setSimpleName(String simpleName) {
		this.simpleName = simpleName;
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

	public EntityStatus getStatus() {
		return status;
	}

	public void setStatus(EntityStatus status) {
		this.status = status;
	}

	public Date getLastChangeStatus() {
		return lastChangeStatus;
	}

	public void setLastChangeStatus(Date lastChangeStatus) {
		this.lastChangeStatus = lastChangeStatus;
	}

	public String getMsg() {
		return msg == null ? "" : msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public BooleanEnum getIsPlugin() {
		return CORE_APP_ID.equals(appId) ? BooleanEnum.NO : BooleanEnum.YES;
	}
}
