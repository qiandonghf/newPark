package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.SendTimeTypeEnum;

/**
 * <br/>class-description 短信
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Sms extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 短信内容
	 */
	@FieldDescription("短信内容")
	private String content;
	/**
	 * 定时发送
	 */
	@FieldDescription("定时发送")
	private SendTimeTypeEnum timeType;
	/**
	 * 指定发送时间
	 */
	@FieldDescription("指定发送时间")
	private Date sendTime;
	/**
	 * 是否已发送
	 */
	@FieldDescription("是否已发送")
	private BooleanEnum sended;
	
	private String receivers;
	public String getReceivers() {
		return receivers;
	}
	public void setReceivers(String receivers) {
		this.receivers = receivers;
	}
	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 短信内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 定时发送
	 */
	public SendTimeTypeEnum getTimeType(){
		return timeType;
	}
	public void setTimeType(SendTimeTypeEnum timeType){
		this.timeType = timeType;
	}
	/**
	 * 指定发送时间
	 */
	public Date getSendTime(){
		return sendTime;
	}
	public void setSendTime(Date sendTime){
		this.sendTime = sendTime;
	}
	/**
	 * 是否已发送
	 */
	public BooleanEnum getSended(){
		return sended;
	}
	public void setSended(BooleanEnum sended){
		this.sended = sended;
	}
}