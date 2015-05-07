package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 短信模板
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SmsTemplate extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 模板名称
	 */
	@FieldDescription("模板名称")
	private String name;
	/**
	 * 模板内容
	 */
	@FieldDescription("模板内容")
	private String content;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 模板名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 模板内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}