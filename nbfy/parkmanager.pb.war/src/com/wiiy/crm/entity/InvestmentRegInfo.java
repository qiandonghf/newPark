package com.wiiy.crm.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Investment;

/**
 * <br/>class-description 招商项目注册信息
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class InvestmentRegInfo extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 注册类型实体
	 */
	@FieldDescription("注册类型实体")
	private DataDict regType;
	/**
	 * 币种实体
	 */
	@FieldDescription("币种实体")
	private DataDict currencyType;
	/**
	 * 证件类型实体
	 */
	@FieldDescription("证件类型实体")
	private DataDict documentType;
	/**
	 * 招商项目
	 */
	@FieldDescription("招商项目")
	private Investment investment;
	/**
	 * 注册时间
	 */
	@FieldDescription("注册时间")
	private Date regTime;
	/**
	 * 注册类型外键
	 */
	@FieldDescription("注册类型外键")
	private String regTypeId;
	/**
	 * 注册资本
	 */
	@FieldDescription("注册资本")
	private BigDecimal regCapital;
	/**
	 * 币种外键
	 */
	@FieldDescription("币种外键")
	private String currencyTypeId;
	/**
	 * 组织机构代码
	 */
	@FieldDescription("组织机构代码")
	private String organizationNumber;
	/**
	 * 工商注册号
	 */
	@FieldDescription("工商注册号")
	private String businessNumber;
	/**
	 * 税务登记证
	 */
	@FieldDescription("税务登记证")
	private String taxNumber;
	/**
	 * 法定代表人
	 */
	@FieldDescription("法定代表人")
	private String legalPerson;
	/**
	 * 证件类型外键
	 */
	@FieldDescription("证件类型外键")
	private String documentTypeId;
	/**
	 * 证件号
	 */
	@FieldDescription("证件号")
	private String documentNumber;
	/**
	 * 注册EMAIL
	 */
	@FieldDescription("注册EMAIL")
	private String regMail;
	/**
	 * 移动电话
	 */
	@FieldDescription("移动电话")
	private String cellphone;
	/**
	 * 注册地址
	 */
	@FieldDescription("注册地址")
	private String regAddress;
	/**
	 * 经营范围
	 */
	@FieldDescription("经营范围")
	private String businessScope;
	/**
	 * 营业截至日期
	 */
	@FieldDescription("营业截至日期")
	private Date businessExpireDate;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 注册类型实体
	 */
	public DataDict getRegType(){
		return regType;
	}
	public void setRegType(DataDict regType){
		this.regType = regType;
	}
	/**
	 * 币种实体
	 */
	public DataDict getCurrencyType(){
		return currencyType;
	}
	public void setCurrencyType(DataDict currencyType){
		this.currencyType = currencyType;
	}
	/**
	 * 证件类型实体
	 */
	public DataDict getDocumentType(){
		return documentType;
	}
	public void setDocumentType(DataDict documentType){
		this.documentType = documentType;
	}
	/**
	 * 招商项目
	 */
	public Investment getInvestment(){
		return investment;
	}
	public void setInvestment(Investment investment){
		this.investment = investment;
	}
	/**
	 * 注册时间
	 */
	public Date getRegTime(){
		return regTime;
	}
	public void setRegTime(Date regTime){
		this.regTime = regTime;
	}
	/**
	 * 注册类型外键
	 */
	public String getRegTypeId(){
		return regTypeId;
	}
	public void setRegTypeId(String regTypeId){
		this.regTypeId = regTypeId;
	}
	/**
	 * 注册资本
	 */
	public BigDecimal getRegCapital(){
		return regCapital;
	}
	public void setRegCapital(BigDecimal regCapital){
		this.regCapital = regCapital;
	}
	/**
	 * 币种外键
	 */
	public String getCurrencyTypeId(){
		return currencyTypeId;
	}
	public void setCurrencyTypeId(String currencyTypeId){
		this.currencyTypeId = currencyTypeId;
	}
	/**
	 * 组织机构代码
	 */
	public String getOrganizationNumber(){
		return organizationNumber;
	}
	public void setOrganizationNumber(String organizationNumber){
		this.organizationNumber = organizationNumber;
	}
	/**
	 * 工商注册号
	 */
	public String getBusinessNumber(){
		return businessNumber;
	}
	public void setBusinessNumber(String businessNumber){
		this.businessNumber = businessNumber;
	}
	/**
	 * 税务登记证
	 */
	public String getTaxNumber(){
		return taxNumber;
	}
	public void setTaxNumber(String taxNumber){
		this.taxNumber = taxNumber;
	}
	/**
	 * 法定代表人
	 */
	public String getLegalPerson(){
		return legalPerson;
	}
	public void setLegalPerson(String legalPerson){
		this.legalPerson = legalPerson;
	}
	/**
	 * 证件类型外键
	 */
	public String getDocumentTypeId(){
		return documentTypeId;
	}
	public void setDocumentTypeId(String documentTypeId){
		this.documentTypeId = documentTypeId;
	}
	/**
	 * 证件号
	 */
	public String getDocumentNumber(){
		return documentNumber;
	}
	public void setDocumentNumber(String documentNumber){
		this.documentNumber = documentNumber;
	}
	/**
	 * 注册EMAIL
	 */
	public String getRegMail(){
		return regMail;
	}
	public void setRegMail(String regMail){
		this.regMail = regMail;
	}
	/**
	 * 移动电话
	 */
	public String getCellphone(){
		return cellphone;
	}
	public void setCellphone(String cellphone){
		this.cellphone = cellphone;
	}
	/**
	 * 注册地址
	 */
	public String getRegAddress(){
		return regAddress;
	}
	public void setRegAddress(String regAddress){
		this.regAddress = regAddress;
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
	 * 营业截至日期
	 */
	public Date getBusinessExpireDate(){
		return businessExpireDate;
	}
	public void setBusinessExpireDate(Date businessExpireDate){
		this.businessExpireDate = businessExpireDate;
	}
}