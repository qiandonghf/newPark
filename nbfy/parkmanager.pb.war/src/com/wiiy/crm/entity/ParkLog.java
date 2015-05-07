package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;

/**
 * <br/>class-description 项目创业类型
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ParkLog extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 招商项目外键
	 */
	@FieldDescription("招商项目外键")
	private String content;
	/**
	 * 日志类型
	 */
	@FieldDescription("日志类型")
	private ParkLogTypeEnums parkLogType;
	/**
	 * 执行人员
	 */
	@FieldDescription("执行人员")
	private String handlePersonnel;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 招商项目外键
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 日志类型
	 */
	public ParkLogTypeEnums getParkLogType(){
		return parkLogType;
	}
	public void setParkLogType(ParkLogTypeEnums parkLogType){
		this.parkLogType = parkLogType;
	}
	/**
	 * 执行人员
	 */
	public String getHandlePersonnel(){
		return handlePersonnel;
	}
	public void setHandlePersonnel(String handlePersonnel){
		this.handlePersonnel = handlePersonnel;
	}
}