package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;
import com.wiiy.oa.entity.WorkClass;
import com.wiiy.oa.preferences.enums.SignStatusEnum;
import com.wiiy.oa.preferences.enums.SignTypeEnum;

/**
 * <br/>class-description 用户签到
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class UserSign extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 用户
	 */
	@FieldDescription("用户")
	private User user;
	/**
	 * 班次
	 */
	@FieldDescription("班次")
	private WorkClass workClass;
	/**
	 * 用户外键
	 */
	@FieldDescription("用户外键")
	private Long userId;
	/**
	 * 班次外键
	 */
	@FieldDescription("班次外键")
	private Long workClassId;
	/**
	 * 考勤时间
	 */
	@FieldDescription("考勤时间")
	private Date signTime;
	/**
	 * 考勤类型
	 */
	@FieldDescription("考勤类型")
	private SignTypeEnum signType;
	/**
	 * 考勤状态
	 */
	@FieldDescription("考勤状态")
	private SignStatusEnum signStatus;
	/**
	 * 迟到或早退分钟
	 */
	@FieldDescription("迟到或早退分钟")
	private Long minute;
	/**
	 * 迟到或早退原因
	 */
	@FieldDescription("迟到或早退原因")
	private String reason;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 用户
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	/**
	 * 班次
	 */
	public WorkClass getWorkClass(){
		return workClass;
	}
	public void setWorkClass(WorkClass workClass){
		this.workClass = workClass;
	}
	/**
	 * 用户外键
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 班次外键
	 */
	public Long getWorkClassId(){
		return workClassId;
	}
	public void setWorkClassId(Long workClassId){
		this.workClassId = workClassId;
	}
	/**
	 * 考勤时间
	 */
	public Date getSignTime(){
		return signTime;
	}
	public void setSignTime(Date signTime){
		this.signTime = signTime;
	}
	/**
	 * 考勤类型
	 */
	public SignTypeEnum getSignType(){
		return signType;
	}
	public void setSignType(SignTypeEnum signType){
		this.signType = signType;
	}
	/**
	 * 考勤状态
	 */
	public SignStatusEnum getSignStatus(){
		return signStatus;
	}
	public void setSignStatus(SignStatusEnum signStatus){
		this.signStatus = signStatus;
	}
	/**
	 * 迟到或早退分钟
	 */
	public Long getMinute(){
		return minute;
	}
	public void setMinute(Long minute){
		this.minute = minute;
	}
	/**
	 * 迟到或早退原因
	 */
	public String getReason(){
		return reason;
	}
	public void setReason(String reason){
		this.reason = reason;
	}
}