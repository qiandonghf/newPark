package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataTemplate;

/**
 * <br/>class-description 数据模板-数据项配置
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DataTemplatePropertyConfig extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 数据模板
	 */
	@FieldDescription("数据模板")
	private DataTemplate template;
	/**
	 * 数据项
	 */
	@FieldDescription("数据项")
	private DataProperty property;
	/**
	 * 数据分组配置外键
	 */
	@FieldDescription("数据分组配置外键")
	private Long templateId;
	/**
	 * 数据项外键
	 */
	@FieldDescription("数据项外键")
	private Long propertyId;
	/**
	 * 显示顺序
	 */
	@FieldDescription("显示顺序")
	private Integer displayOrder;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 数据模板
	 */
	public DataTemplate getTemplate(){
		return template;
	}
	public void setTemplate(DataTemplate template){
		this.template = template;
	}
	/**
	 * 数据项
	 */
	public DataProperty getProperty(){
		return property;
	}
	public void setProperty(DataProperty property){
		this.property = property;
	}
	/**
	 * 数据分组配置外键
	 */
	public Long getTemplateId(){
		return templateId;
	}
	public void setTemplateId(Long templateId){
		this.templateId = templateId;
	}
	/**
	 * 数据项外键
	 */
	public Long getPropertyId(){
		return propertyId;
	}
	public void setPropertyId(Long propertyId){
		this.propertyId = propertyId;
	}
	/**
	 * 显示顺序
	 */
	public Integer getDisplayOrder(){
		return displayOrder;
	}
	public void setDisplayOrder(Integer displayOrder){
		this.displayOrder = displayOrder;
	}
}