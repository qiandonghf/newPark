package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 薪资标准
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SalaryDefine extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 标准编号
	 */
	@FieldDescription("标准编号")
	private String serialNo;
	/**
	 * 标准名称
	 */
	@FieldDescription("标准名称")
	private String name;
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
	 * 标准编号
	 */
	public String getSerialNo(){
		return serialNo;
	}
	public void setSerialNo(String serialNo){
		this.serialNo = serialNo;
	}
	/**
	 * 标准名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
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