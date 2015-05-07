package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Investment;

/**
 * <br/>class-description 项目创业类型
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class InvestmentVentureType extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 招商项目实体
	 */
	@FieldDescription("招商项目实体")
	private Investment investment;
	/**
	 * 创业类型
	 */
	@FieldDescription("创业类型")
	private DataDict ventureType;
	/**
	 * 招商项目外键
	 */
	@FieldDescription("招商项目外键")
	private Long investmentId;
	/**
	 * 创业类型外键
	 */
	@FieldDescription("创业类型外键")
	private String ventureTypeId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 招商项目实体
	 */
	public Investment getInvestment(){
		return investment;
	}
	public void setInvestment(Investment investment){
		this.investment = investment;
	}
	/**
	 * 创业类型
	 */
	public DataDict getVentureType(){
		return ventureType;
	}
	public void setVentureType(DataDict ventureType){
		this.ventureType = ventureType;
	}
	/**
	 * 招商项目外键
	 */
	public Long getInvestmentId(){
		return investmentId;
	}
	public void setInvestmentId(Long investmentId){
		this.investmentId = investmentId;
	}
	/**
	 * 创业类型外键
	 */
	public String getVentureTypeId(){
		return ventureTypeId;
	}
	public void setVentureTypeId(String ventureTypeId){
		this.ventureTypeId = ventureTypeId;
	}
}