package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.ContactEntity;

/**
 * <br/>class-description 招商项目审批联系单
 * <br/>extends com.wiiy.core.entity.ContactEntity
 */
public class InvestmentContact extends ContactEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 项目外键
	 */
	@FieldDescription("项目外键")
	private Long investmentId;
	/**
	 * 项目名称
	 */
	@FieldDescription("项目名称")
	private String investmentName;
	/**
	 * 经营范围
	 */
	@FieldDescription("经营范围")
	private String businessScope;
	/**
	 * 注册资本
	 */
	@FieldDescription("注册资本")
	private Double regCapital;
	/**
	 * 企业人数
	 */
	@FieldDescription("企业人数")
	private Integer staff;
	/**
	 * 用房面积
	 */
	@FieldDescription("用房面积")
	private Double officeArea;
	/**
	 * 计划总投资
	 */
	@FieldDescription("计划总投资")
	private Double investCapital;
	/**
	 * 预计年产值
	 */
	@FieldDescription("预计年产值")
	private Double outputValue;
	/**
	 * 经办人员意见
	 */
	@FieldDescription("经办人员意见")
	private String handleOpinion;
	/**
	 * 经办人员意见ID
	 */
	@FieldDescription("经办人员意见ID")
	private Long handleOpinionId;
	/**
	 * 招商人员意见
	 */
	@FieldDescription("招商人员意见")
	private String attractOpinion;
	/**
	 * 招商人员意见ID
	 */
	@FieldDescription("招商人员意见ID")
	private Long attractOpinionId;
	/**
	 * 投资促进部意见
	 */
	@FieldDescription("投资促进部意见")
	private String departmentOpinion;
	/**
	 * 投资促进部ID
	 */
	@FieldDescription("投资促进部ID")
	private Long departmentOpinionId;
	/**
	 * 主任会议室意见
	 */
	@FieldDescription("主任会议室意见")
	private String headOpinion;
	/**
	 * 主任会议室ID
	 */
	@FieldDescription("主任会议室ID")
	private Long headOpinionId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 项目外键
	 */
	public Long getInvestmentId(){
		return investmentId;
	}
	public void setInvestmentId(Long investmentId){
		this.investmentId = investmentId;
	}
	/**
	 * 项目名称
	 */
	public String getInvestmentName(){
		return investmentName;
	}
	public void setInvestmentName(String investmentName){
		this.investmentName = investmentName;
	}
	/**
	 * 经营范围
	 */
	public String getBusinessScope(){
		return businessScope;
	}
	public void setBusinessScope(String businessScope){
		this.businessScope = businessScope;
	}
	/**
	 * 注册资本
	 */
	public Double getRegCapital(){
		return regCapital;
	}
	public void setRegCapital(Double regCapital){
		this.regCapital = regCapital;
	}
	/**
	 * 企业人数
	 */
	public Integer getStaff(){
		return staff;
	}
	public void setStaff(Integer staff){
		this.staff = staff;
	}
	/**
	 * 用房面积
	 */
	public Double getOfficeArea(){
		return officeArea;
	}
	public void setOfficeArea(Double officeArea){
		this.officeArea = officeArea;
	}
	/**
	 * 计划总投资
	 */
	public Double getInvestCapital(){
		return investCapital;
	}
	public void setInvestCapital(Double investCapital){
		this.investCapital = investCapital;
	}
	/**
	 * 预计年产值
	 */
	public Double getOutputValue(){
		return outputValue;
	}
	public void setOutputValue(Double outputValue){
		this.outputValue = outputValue;
	}
	/**
	 * 经办人员意见
	 */
	public String getHandleOpinion(){
		return handleOpinion;
	}
	public void setHandleOpinion(String handleOpinion){
		this.handleOpinion = handleOpinion;
	}
	/**
	 * 经办人员意见ID
	 */
	public Long getHandleOpinionId(){
		return handleOpinionId;
	}
	public void setHandleOpinionId(Long handleOpinionId){
		this.handleOpinionId = handleOpinionId;
	}
	/**
	 * 招商人员意见
	 */
	public String getAttractOpinion(){
		return attractOpinion;
	}
	public void setAttractOpinion(String attractOpinion){
		this.attractOpinion = attractOpinion;
	}
	/**
	 * 招商人员意见ID
	 */
	public Long getAttractOpinionId(){
		return attractOpinionId;
	}
	public void setAttractOpinionId(Long attractOpinionId){
		this.attractOpinionId = attractOpinionId;
	}
	/**
	 * 投资促进部意见
	 */
	public String getDepartmentOpinion(){
		return departmentOpinion;
	}
	public void setDepartmentOpinion(String departmentOpinion){
		this.departmentOpinion = departmentOpinion;
	}
	/**
	 * 投资促进部ID
	 */
	public Long getDepartmentOpinionId(){
		return departmentOpinionId;
	}
	public void setDepartmentOpinionId(Long departmentOpinionId){
		this.departmentOpinionId = departmentOpinionId;
	}
	/**
	 * 主任会议室意见
	 */
	public String getHeadOpinion(){
		return headOpinion;
	}
	public void setHeadOpinion(String headOpinion){
		this.headOpinion = headOpinion;
	}
	/**
	 * 主任会议室ID
	 */
	public Long getHeadOpinionId(){
		return headOpinionId;
	}
	public void setHeadOpinionId(Long headOpinionId){
		this.headOpinionId = headOpinionId;
	}
}