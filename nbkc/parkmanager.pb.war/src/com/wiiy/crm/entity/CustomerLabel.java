package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.preferences.enums.OwnerEnum;

/**
 * <br/>class-description 企业标签
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerLabel extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 分类
	 */
	@FieldDescription("分类")
	private CustomerCategory category;
	/**
	 * 标签名称
	 */
	@FieldDescription("标签名称")
	private String name;
	/**
	 * 分类外键
	 */
	@FieldDescription("分类外键")
	private Long categoryId;
	/**
	 * 标签拥有者ID
	 */
	@FieldDescription("标签拥有者ID")
	private Long ownerId;
	/**
	 * 拥有类型
	 */
	@FieldDescription("拥有类型")
	private OwnerEnum ownerEnum;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 分类
	 */
	public CustomerCategory getCategory(){
		return category;
	}
	public void setCategory(CustomerCategory category){
		this.category = category;
	}
	/**
	 * 标签名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 分类外键
	 */
	public Long getCategoryId(){
		return categoryId;
	}
	public void setCategoryId(Long categoryId){
		this.categoryId = categoryId;
	}
	/**
	 * 标签拥有者ID
	 */
	public Long getOwnerId(){
		return ownerId;
	}
	public void setOwnerId(Long ownerId){
		this.ownerId = ownerId;
	}
	/**
	 * 拥有类型
	 */
	public OwnerEnum getOwnerEnum(){
		return ownerEnum;
	}
	public void setOwnerEnum(OwnerEnum ownerEnum){
		this.ownerEnum = ownerEnum;
	}
}