package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 外出登记
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class OutRegister extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
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
	 * 外出事由
	 */
	@FieldDescription("外出事由")
	private String reason;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	 * 外出事由
	 */
	public String getReason(){
		return reason;
	}
	public void setReason(String reason){
		this.reason = reason;
	}
}