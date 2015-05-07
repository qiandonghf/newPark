package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 招商政策
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Policy extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 类型
	 */
	@FieldDescription("类型")
	private DataDict type;
	/**
	 * 发布年度
	 */
	@FieldDescription("发布年度")
	private Integer year;
	/**
	 * 类型外键
	 */
	@FieldDescription("类型外键")
	private String typeId;
	/**
	 * 启用
	 */
	@FieldDescription("启用")
	private BooleanEnum usable;
	/**
	 * 内容
	 */
	@FieldDescription("内容")
	private String content;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 类型
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
	}
	/**
	 * 发布年度
	 */
	public Integer getYear(){
		return year;
	}
	public void setYear(Integer year){
		this.year = year;
	}
	/**
	 * 类型外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 启用
	 */
	public BooleanEnum getUsable(){
		return usable;
	}
	public void setUsable(BooleanEnum usable){
		this.usable = usable;
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
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}