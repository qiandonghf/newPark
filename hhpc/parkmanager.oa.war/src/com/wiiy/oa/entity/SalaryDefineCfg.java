package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.SalaryDefine;
import com.wiiy.oa.entity.SalaryItem;

/**
 * <br/>class-description 薪资项设置
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SalaryDefineCfg extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 薪资标准
	 */
	@FieldDescription("薪资标准")
	private SalaryDefine salaryDefine;
	/**
	 * 薪资项
	 */
	@FieldDescription("薪资项")
	private SalaryItem salaryItem;
	/**
	 * 薪资标准外键
	 */
	@FieldDescription("薪资标准外键")
	private Long salaryDefineId;
	/**
	 * 薪资项外键
	 */
	@FieldDescription("薪资项外键")
	private Long salaryItemId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 薪资标准
	 */
	public SalaryDefine getSalaryDefine(){
		return salaryDefine;
	}
	public void setSalaryDefine(SalaryDefine salaryDefine){
		this.salaryDefine = salaryDefine;
	}
	/**
	 * 薪资项
	 */
	public SalaryItem getSalaryItem(){
		return salaryItem;
	}
	public void setSalaryItem(SalaryItem salaryItem){
		this.salaryItem = salaryItem;
	}
	/**
	 * 薪资标准外键
	 */
	public Long getSalaryDefineId(){
		return salaryDefineId;
	}
	public void setSalaryDefineId(Long salaryDefineId){
		this.salaryDefineId = salaryDefineId;
	}
	/**
	 * 薪资项外键
	 */
	public Long getSalaryItemId(){
		return salaryItemId;
	}
	public void setSalaryItemId(Long salaryItemId){
		this.salaryItemId = salaryItemId;
	}
}