package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.oa.entity.Sms;

/**
 * <br/>class-description 短信收件人
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SmsReceiver extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 短信
	 */
	@FieldDescription("短信")
	private Sms sms;
	/**
	 * 短信外键
	 */
	@FieldDescription("短信外键")
	private Long smsId;
	/**
	 * 是否已发送
	 */
	@FieldDescription("是否已发送")
	private BooleanEnum sended;
	/**
	 * 收件人名称
	 */
	@FieldDescription("收件人名称")
	private String receiverName;
	/**
	 * 收件人号码
	 */
	@FieldDescription("收件人号码")
	private String phone;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 短信
	 */
	public Sms getSms(){
		return sms;
	}
	public void setSms(Sms sms){
		this.sms = sms;
	}
	/**
	 * 短信外键
	 */
	public Long getSmsId(){
		return smsId;
	}
	public void setSmsId(Long smsId){
		this.smsId = smsId;
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
	/**
	 * 收件人名称
	 */
	public String getReceiverName(){
		return receiverName;
	}
	public void setReceiverName(String receiverName){
		this.receiverName = receiverName;
	}
	/**
	 * 收件人号码
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
}