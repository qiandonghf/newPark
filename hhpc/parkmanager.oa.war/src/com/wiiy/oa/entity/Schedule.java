package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.oa.preferences.enums.PromotEnum;
import com.wiiy.oa.preferences.enums.RepeatEnum;

/**
 * <br/>class-description 日程
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Schedule extends BaseEntity implements Serializable {
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
	 * 是否全天
	 */
	@FieldDescription("是否全天")
	private BooleanEnum wholeDay;
	/**
	 * 是否设置结束时间
	 */
	@FieldDescription("是否设置结束时间")
	private BooleanEnum setEndTime;
	/**
	 * 重复
	 */
	@FieldDescription("重复")
	private RepeatEnum repeatType;
	/**
	 * 提醒方式
	 */
	@FieldDescription("提醒方式")
	private PromotEnum promot;
	/**
	 * 提醒详情
	 */
	@FieldDescription("提醒详情")
	private String promotDetail;
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
	 * 是否仅删除当天
	 */
	@FieldDescription("是否仅删除当天")
	private BooleanEnum deleted;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 拥有者ID
	 */
	@FieldDescription("拥有者ID")
	private Long ownerId;
	/**
	 * 父日程ID
	 */
	@FieldDescription("父日程ID")
	private Long parentId;

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
	 * 是否全天
	 */
	public BooleanEnum getWholeDay(){
		return wholeDay;
	}
	public void setWholeDay(BooleanEnum wholeDay){
		this.wholeDay = wholeDay;
	}
	/**
	 * 是否设置结束时间
	 */
	public BooleanEnum getSetEndTime(){
		return setEndTime;
	}
	public void setSetEndTime(BooleanEnum setEndTime){
		this.setEndTime = setEndTime;
	}
	/**
	 * 重复
	 */
	public RepeatEnum getRepeatType(){
		return repeatType;
	}
	public void setRepeatType(RepeatEnum repeatType){
		this.repeatType = repeatType;
	}
	/**
	 * 提醒方式
	 */
	public PromotEnum getPromot(){
		return promot;
	}
	public void setPromot(PromotEnum promot){
		this.promot = promot;
	}
	/**
	 * 提醒详情
	 */
	public String getPromotDetail(){
		return promotDetail;
	}
	public void setPromotDetail(String promotDetail){
		this.promotDetail = promotDetail;
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
	 * 是否仅删除当天
	 */
	public BooleanEnum getDeleted(){
		return deleted;
	}
	public void setDeleted(BooleanEnum deleted){
		this.deleted = deleted;
	}
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
	/**
	 * 拥有者ID
	 */
	public Long getOwnerId(){
		return ownerId;
	}
	public void setOwnerId(Long ownerId){
		this.ownerId = ownerId;
	}
	/**
	 * 父日程ID
	 */
	public Long getParentId(){
		return parentId;
	}
	public void setParentId(Long parentId){
		this.parentId = parentId;
	}
}