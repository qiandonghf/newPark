package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 薪资项
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SalaryItem extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 缺省值
	 */
	@FieldDescription("缺省值")
	private Double defaultVal;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 缺省值
	 */
	public Double getDefaultVal(){
		return defaultVal;
	}
	public void setDefaultVal(Double defaultVal){
		this.defaultVal = defaultVal;
	}
}