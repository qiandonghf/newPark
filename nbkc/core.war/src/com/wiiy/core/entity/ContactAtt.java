package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.preferences.enums.ContactTypeEnum;

/**
 * <br/>class-description 联系单附件
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContactAtt extends BaseEntity implements Serializable {
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
	 * 附件名称
	 */
	@FieldDescription("附件名称")
	private String name;
	/**
	 * 重命名名称
	 */
	@FieldDescription("重命名名称")
	private String newName;
	/**
	 * 附件大小
	 */
	@FieldDescription("附件大小")
	private Long size;

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
	 * 附件名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 重命名名称
	 */
	public String getNewName(){
		return newName;
	}
	public void setNewName(String newName){
		this.newName = newName;
	}
	/**
	 * 附件大小
	 */
	public Long getSize(){
		return size;
	}
	public void setSize(Long size){
		this.size = size;
	}
}