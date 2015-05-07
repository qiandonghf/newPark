package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.preferences.enums.CheckStatusEnum;
import com.wiiy.crm.preferences.enums.CheckTypeEnum;

/**
 * <br/>class-description 自检Log
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DataCheckLog extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * Log名称
	 */
	@FieldDescription("Log名称")
	private String name;
	/**
	 * 父级ID
	 */
	@FieldDescription("父级ID")
	private Long parentId;
	/**
	 * 自检日期
	 */
	@FieldDescription("自检日期")
	private Date date;
	/**
	 * 开始时间
	 */
	@FieldDescription("开始时间")
	private Date startTime;
	/**
	 * 结束时间
	 */
	@FieldDescription("结束时间")
	private Date endTime;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private CheckStatusEnum status;
	/**
	 * 自检类型
	 */
	@FieldDescription("自检类型")
	private CheckTypeEnum type;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * Log名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 父级ID
	 */
	public Long getParentId(){
		return parentId;
	}
	public void setParentId(Long parentId){
		this.parentId = parentId;
	}
	/**
	 * 自检日期
	 */
	public Date getDate(){
		return date;
	}
	public void setDate(Date date){
		this.date = date;
	}
	/**
	 * 开始时间
	 */
	public Date getStartTime(){
		return startTime;
	}
	public void setStartTime(Date startTime){
		this.startTime = startTime;
	}
	/**
	 * 结束时间
	 */
	public Date getEndTime(){
		return endTime;
	}
	public void setEndTime(Date endTime){
		this.endTime = endTime;
	}
	/**
	 * 状态
	 */
	public CheckStatusEnum getStatus(){
		return status;
	}
	public void setStatus(CheckStatusEnum status){
		this.status = status;
	}
	/**
	 * 自检类型
	 */
	public CheckTypeEnum getType(){
		return type;
	}
	public void setType(CheckTypeEnum type){
		this.type = type;
	}
}