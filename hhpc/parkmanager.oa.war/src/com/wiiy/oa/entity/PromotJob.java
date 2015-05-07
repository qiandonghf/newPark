package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;

/**
 * <br/>class-description 提醒后台进程
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class PromotJob extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 主题
	 */
	@FieldDescription("主题")
	private String title;
	/**
	 * 提醒发送时间
	 */
	@FieldDescription("提醒发送时间")
	private Date jobTime;
	/**
	 * 提醒接收者ID
	 */
	@FieldDescription("提醒接收者ID")
	private Long receiveId;
	/**
	 * 默认邮件(内部)
	 */
	@FieldDescription("默认邮件(内部)")
	private BooleanEnum defaultEmail;
	/**
	 * 外部邮件
	 */
	@FieldDescription("外部邮件")
	private BooleanEnum email;
	/**
	 * 短信
	 */
	@FieldDescription("短信")
	private BooleanEnum sms;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 主题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * 提醒发送时间
	 */
	public Date getJobTime(){
		return jobTime;
	}
	public void setJobTime(Date jobTime){
		this.jobTime = jobTime;
	}
	/**
	 * 提醒接收者ID
	 */
	public Long getReceiveId(){
		return receiveId;
	}
	public void setReceiveId(Long receiveId){
		this.receiveId = receiveId;
	}
	/**
	 * 默认邮件(内部)
	 */
	public BooleanEnum getDefaultEmail(){
		return defaultEmail;
	}
	public void setDefaultEmail(BooleanEnum defaultEmail){
		this.defaultEmail = defaultEmail;
	}
	/**
	 * 外部邮件
	 */
	public BooleanEnum getEmail(){
		return email;
	}
	public void setEmail(BooleanEnum email){
		this.email = email;
	}
	/**
	 * 短信
	 */
	public BooleanEnum getSms(){
		return sms;
	}
	public void setSms(BooleanEnum sms){
		this.sms = sms;
	}
}