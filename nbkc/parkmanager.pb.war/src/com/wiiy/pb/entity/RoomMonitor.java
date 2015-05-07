package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.pb.entity.Room;

/**
 * <br/>class-description 房间跟进
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class RoomMonitor extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 房间
	 */
	@FieldDescription("房间")
	private Room room;
	/**
	 * 房间外键
	 */
	@FieldDescription("房间外键")
	private Long roomId;
	/**
	 * 跟进标题
	 */
	@FieldDescription("跟进标题")
	private String title;
	/**
	 * 提醒时间
	 */
	@FieldDescription("提醒时间")
	private Date promotTime;
	private Long defaultEmailId;
	/**
	 * 默认邮件(内部)
	 */
	@FieldDescription("默认邮件(内部)")
	private BooleanEnum defaultEmail;
	private Long emailId;
	/**
	 * 外部邮件
	 */
	@FieldDescription("外部邮件")
	private BooleanEnum email;
	private Long smsId;
	/**
	 * 短信
	 */
	@FieldDescription("短信")
	private BooleanEnum sms;
	/**
	 * 跟进内容
	 */
	@FieldDescription("跟进内容")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 房间
	 */
	public Room getRoom(){
		return room;
	}
	public void setRoom(Room room){
		this.room = room;
	}
	/**
	 * 房间外键
	 */
	public Long getRoomId(){
		return roomId;
	}
	public void setRoomId(Long roomId){
		this.roomId = roomId;
	}
	/**
	 * 跟进标题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * 提醒时间
	 */
	public Date getPromotTime(){
		return promotTime;
	}
	public void setPromotTime(Date promotTime){
		this.promotTime = promotTime;
	}
	public Long getDefaultEmailId(){
		return defaultEmailId;
	}
	public void setDefaultEmailId(Long defaultEmailId){
		this.defaultEmailId = defaultEmailId;
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
	public Long getEmailId(){
		return emailId;
	}
	public void setEmailId(Long emailId){
		this.emailId = emailId;
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
	public Long getSmsId(){
		return smsId;
	}
	public void setSmsId(Long smsId){
		this.smsId = smsId;
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
	/**
	 * 跟进内容
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}