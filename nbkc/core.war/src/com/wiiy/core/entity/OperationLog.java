package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.LogTypeEnum;

/**
 * <br/>class-description 操作日志
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class OperationLog extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 模块名称
	 */
	@FieldDescription("模块名称")
	private String bundleName;
	/**
	 * 日志内容
	 */
	@FieldDescription("日志内容")
	private String msg;
	/**
	 * 日志类型
	 */
	@FieldDescription("日志类型")
	private LogTypeEnum logType;
	/**
	 * 部门ID
	 */
	@FieldDescription("部门ID")
	private Long orgId;
	/**
	 * 部门名称
	 */
	@FieldDescription("部门名称")
	private String orgName;
	/**
	 * IP地址
	 */
	@FieldDescription("IP地址")
	private String ip;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 模块名称
	 */
	public String getBundleName(){
		return bundleName;
	}
	public void setBundleName(String bundleName){
		this.bundleName = bundleName;
	}
	/**
	 * 日志内容
	 */
	public String getMsg(){
		return msg;
	}
	public void setMsg(String msg){
		this.msg = msg;
	}
	/**
	 * 日志类型
	 */
	public LogTypeEnum getLogType(){
		return logType;
	}
	public void setLogType(LogTypeEnum logType){
		this.logType = logType;
	}
	/**
	 * 部门ID
	 */
	public Long getOrgId(){
		return orgId;
	}
	public void setOrgId(Long orgId){
		this.orgId = orgId;
	}
	/**
	 * 部门名称
	 */
	public String getOrgName(){
		return orgName;
	}
	public void setOrgName(String orgName){
		this.orgName = orgName;
	}
	/**
	 * IP地址
	 */
	public String getIp(){
		return ip;
	}
	public void setIp(String ip){
		this.ip = ip;
	}
}