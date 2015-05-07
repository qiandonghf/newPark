package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.preferences.enums.ContactTypeEnum;

/**
 * <br/>class-description 联系单轨迹
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContactLog extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 联系单外键
	 */
	@FieldDescription("联系单外键")
	private Long contactId;
	/**
	 * 联系单类型
	 */
	@FieldDescription("联系单类型")
	private ContactTypeEnum contactType;
	/**
	 * 内容
	 */
	@FieldDescription("内容")
	private String content;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 联系单外键
	 */
	public Long getContactId(){
		return contactId;
	}
	public void setContactId(Long contactId){
		this.contactId = contactId;
	}
	/**
	 * 联系单类型
	 */
	public ContactTypeEnum getContactType(){
		return contactType;
	}
	public void setContactType(ContactTypeEnum contactType){
		this.contactType = contactType;
	}
	/**
	 * 内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}