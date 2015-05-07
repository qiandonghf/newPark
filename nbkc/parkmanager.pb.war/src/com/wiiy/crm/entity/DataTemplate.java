package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.crm.preferences.enums.DataTemplateFormatEnum;

/**
 * <br/>class-description 数据上报模板
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DataTemplate extends BaseEntity implements Serializable {
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
	 * 报表格式
	 */
	@FieldDescription("报表格式")
	private DataTemplateFormatEnum format;
	/**
	 * 是否系统预设,系统预设的只有管理员可以删除修改
	 */
	@FieldDescription("是否系统预设,系统预设的只有管理员可以删除修改")
	private BooleanEnum fixed;

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
	 * 报表格式
	 */
	public DataTemplateFormatEnum getFormat(){
		return format;
	}
	public void setFormat(DataTemplateFormatEnum format){
		this.format = format;
	}
	/**
	 * 是否系统预设,系统预设的只有管理员可以删除修改
	 */
	public BooleanEnum getFixed(){
		return fixed;
	}
	public void setFixed(BooleanEnum fixed){
		this.fixed = fixed;
	}
}