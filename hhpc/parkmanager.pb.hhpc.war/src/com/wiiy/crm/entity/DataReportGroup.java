package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 报表分组
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DataReportGroup extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 分组名称
	 */
	@FieldDescription("分组名称")
	private String name;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 分组名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
}