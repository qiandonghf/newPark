package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.preferences.enums.ProjectApplyStatusEnum;

/**
 * <br/>class-description 项目申报
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ProjectApply extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 申报类型
	 */
	@FieldDescription("申报类型")
	private DataDict applyType;
	/**
	 * 产品
	 */
	@FieldDescription("产品")
	private Product product;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 申报类型外键
	 */
	@FieldDescription("申报类型外键")
	private String applyTypeId;
	/**
	 * 产品外键
	 */
	@FieldDescription("产品外键")
	private Long productId;
	/**
	 * 项目名称
	 */
	@FieldDescription("项目名称")
	private String name;
	/**
	 * 申报年度
	 */
	@FieldDescription("申报年度")
	private Integer applyYear;
	/**
	 * 申报状态
	 */
	@FieldDescription("申报状态")
	private ProjectApplyStatusEnum applyState;
	/**
	 * 验收时间
	 */
	@FieldDescription("验收时间")
	private Date checkTime;
	/**
	 * 申报金额
	 */
	@FieldDescription("申报金额")
	private Double amount;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 是否验收
	 */
	@FieldDescription("是否验收")
	private BooleanEnum checked;
	/**
	 * 是否发布到网站
	 */
	@FieldDescription("是否发布到网站")
	private BooleanEnum pub;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 企业
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	/**
	 * 申报类型
	 */
	public DataDict getApplyType(){
		return applyType;
	}
	public void setApplyType(DataDict applyType){
		this.applyType = applyType;
	}
	/**
	 * 产品
	 */
	public Product getProduct(){
		return product;
	}
	public void setProduct(Product product){
		this.product = product;
	}
	/**
	 * 企业外键
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 申报类型外键
	 */
	public String getApplyTypeId(){
		return applyTypeId;
	}
	public void setApplyTypeId(String applyTypeId){
		this.applyTypeId = applyTypeId;
	}
	/**
	 * 产品外键
	 */
	public Long getProductId(){
		return productId;
	}
	public void setProductId(Long productId){
		this.productId = productId;
	}
	/**
	 * 项目名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 申报年度
	 */
	public Integer getApplyYear(){
		return applyYear;
	}
	public void setApplyYear(Integer applyYear){
		this.applyYear = applyYear;
	}
	/**
	 * 申报状态
	 */
	public ProjectApplyStatusEnum getApplyState(){
		return applyState;
	}
	public void setApplyState(ProjectApplyStatusEnum applyState){
		this.applyState = applyState;
	}
	/**
	 * 验收时间
	 */
	public Date getCheckTime(){
		return checkTime;
	}
	public void setCheckTime(Date checkTime){
		this.checkTime = checkTime;
	}
	/**
	 * 申报金额
	 */
	public Double getAmount(){
		return amount;
	}
	public void setAmount(Double amount){
		this.amount = amount;
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
	/**
	 * 是否验收
	 */
	public BooleanEnum getChecked(){
		return checked;
	}
	public void setChecked(BooleanEnum checked){
		this.checked = checked;
	}
	/**
	 * 是否发布到网站
	 */
	public BooleanEnum getPub(){
		return pub;
	}
	public void setPub(BooleanEnum pub){
		this.pub = pub;
	}
}