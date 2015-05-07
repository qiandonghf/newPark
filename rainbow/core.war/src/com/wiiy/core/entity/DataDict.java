package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;

/**
 * <br/>class-description 数据字典
 */
public class DataDict implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private String id;
	/**
	 * 模块名称
	 */
	@FieldDescription("模块名称")
	private String moduleName;
	/**
	 * 父ID
	 */
	@FieldDescription("父ID")
	private String parentId;
	/**
	 * 数据名称
	 */
	@FieldDescription("数据名称")
	private String dataName;
	/**
	 * 数据值
	 */
	@FieldDescription("数据值")
	private String dataValue;
	/**
	 * 数据类型 0单一值 1列表值
	 */
	@FieldDescription("数据类型 0单一值 1列表值")
	private Integer type;
	/**
	 * 是否固定不允许删除编辑
	 */
	@FieldDescription("是否固定不允许删除编辑")
	private Integer fixed;
	/**
	 * 显示顺序(数字小的在前面)
	 */
	@FieldDescription("显示顺序(数字小的在前面)")
	private Integer displayOrder;

	public String getId(){
		return id;
	}
	public void setId(String id){
		this.id = id;
	}
	/**
	 * 模块名称
	 */
	public String getModuleName(){
		return moduleName;
	}
	public void setModuleName(String moduleName){
		this.moduleName = moduleName;
	}
	/**
	 * 父ID
	 */
	public String getParentId(){
		return parentId;
	}
	public void setParentId(String parentId){
		this.parentId = parentId;
	}
	/**
	 * 数据名称
	 */
	public String getDataName(){
		return dataName;
	}
	public void setDataName(String dataName){
		this.dataName = dataName;
	}
	/**
	 * 数据值
	 */
	public String getDataValue(){
		return dataValue;
	}
	public void setDataValue(String dataValue){
		this.dataValue = dataValue;
	}
	/**
	 * 数据类型 0单一值 1列表值
	 */
	public Integer getType(){
		return type;
	}
	public void setType(Integer type){
		this.type = type;
	}
	/**
	 * 是否固定不允许删除编辑
	 */
	public Integer getFixed(){
		return fixed;
	}
	public void setFixed(Integer fixed){
		this.fixed = fixed;
	}
	public boolean isCanWrite() {
		return fixed == null || fixed != 1;
	}
	/**
	 * 显示顺序(数字小的在前面)
	 */
	public Integer getDisplayOrder(){
		return displayOrder;
	}
	public void setDisplayOrder(Integer displayOrder){
		this.displayOrder = displayOrder;
	}
}