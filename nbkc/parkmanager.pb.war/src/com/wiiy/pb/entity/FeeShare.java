package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;

/**
 * <br/>class-description 公摊费用
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class FeeShare extends BaseEntity implements Serializable {
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
	 * 类型
	 */
	@FieldDescription("类型")
	private MeterTypeEnum type;

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
	 * 类型
	 */
	public MeterTypeEnum getType(){
		return type;
	}
	public void setType(MeterTypeEnum type){
		this.type = type;
	}
}