package com.wiiy.web.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.cms.entity.Param;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.web.enums.EmailDataType;

/**
 * <br/>class-description 邮件相关数据
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class EmailData extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站外键
	 */
	@FieldDescription("网站外键")
	private Long paramId;
	/**
	 * 数据类型
	 */
	@FieldDescription("数据类型")
	private EmailDataType type;
	/**
	 * 上次时间
	 */
	@FieldDescription("上次时间")
	private Date lastTime;
	/**
	 * 发送内容
	 */
	@FieldDescription("发送内容")
	private String content;
	/**
	 * 电子邮件
	 */
	@FieldDescription("电子邮件")
	private String email;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 网站外键
	 */
	public Long getParamId(){
		return paramId;
	}
	public void setParamId(Long paramId){
		this.paramId = paramId;
	}
	/**
	 * 数据类型
	 */
	public EmailDataType getType(){
		return type;
	}
	public void setType(EmailDataType type){
		this.type = type;
	}
	/**
	 * 上次时间
	 */
	public Date getLastTime(){
		return lastTime;
	}
	public void setLastTime(Date lastTime){
		this.lastTime = lastTime;
	}
	/**
	 * 发送内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 电子邮件
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
}