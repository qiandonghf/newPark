package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.SubjectNetwork;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.pb.entity.Facility;
import com.wiiy.pb.entity.FacilityOrder;

/**
 * <br/>class-description 公共设施资金计划
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class BillPlanFacility extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 合同
	 */
	@FieldDescription("合同")
	private Contract contract;
	/**
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 公共设施
	 */
	@FieldDescription("公共设施")
	private Facility facility;
	/**
	 * 标的
	 */
	@FieldDescription("标的")
	private SubjectNetwork subject;
	/**
	 * 公共设施使用申请
	 */
	@FieldDescription("公共设施使用申请")
	private FacilityOrder facilityOrder;
	/**
	 * 合同外键
	 */
	@FieldDescription("合同外键")
	private Long contractId;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 公共设施外键
	 */
	@FieldDescription("公共设施外键")
	private Long facilityId;
	/**
	 * 标的外键
	 */
	@FieldDescription("标的外键")
	private Long subjectId;
	/**
	 * 公共设施使用申请外键
	 */
	@FieldDescription("公共设施使用申请外键")
	private Long facilityOrderId;
	/**
	 * 单价
	 */
	@FieldDescription("单价")
	private String price;
	/**
	 * 数量
	 */
	@FieldDescription("数量")
	private Double amount;
	/**
	 * 计划金额
	 */
	@FieldDescription("计划金额")
	private Double planFee;
	/**
	 * 实际金额
	 */
	@FieldDescription("实际金额")
	private Double realFee;
	/**
	 * 已付金额
	 */
	@FieldDescription("已付金额")
	private Double paidFee;
	/**
	 * 滞纳金
	 */
	@FieldDescription("滞纳金")
	private Double overdueFee;
	/**
	 * 计费开始时间
	 */
	@FieldDescription("计费开始时间")
	private Date startDate;
	/**
	 * 计费结束时间
	 */
	@FieldDescription("计费结束时间")
	private Date endDate;
	/**
	 * 最后付费时间
	 */
	@FieldDescription("最后付费时间")
	private Date lastPayDate;
	/**
	 * 计划付费时间
	 */
	@FieldDescription("计划付费时间")
	private Date planPayDate;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private BillPlanStatusEnum status;
	/**
	 * 是否自动出账
	 */
	@FieldDescription("是否自动出账")
	private BooleanEnum autoCheck;
	/**
	 * 出账时间
	 */
	@FieldDescription("出账时间")
	private Date intoAccountDate;
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
	 * 合同
	 */
	public Contract getContract(){
		return contract;
	}
	public void setContract(Contract contract){
		this.contract = contract;
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
	 * 公共设施
	 */
	public Facility getFacility(){
		return facility;
	}
	public void setFacility(Facility facility){
		this.facility = facility;
	}
	/**
	 * 标的
	 */
	public SubjectNetwork getSubject(){
		return subject;
	}
	public void setSubject(SubjectNetwork subject){
		this.subject = subject;
	}
	/**
	 * 公共设施使用申请
	 */
	public FacilityOrder getFacilityOrder(){
		return facilityOrder;
	}
	public void setFacilityOrder(FacilityOrder facilityOrder){
		this.facilityOrder = facilityOrder;
	}
	/**
	 * 合同外键
	 */
	public Long getContractId(){
		return contractId;
	}
	public void setContractId(Long contractId){
		this.contractId = contractId;
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
	 * 公共设施外键
	 */
	public Long getFacilityId(){
		return facilityId;
	}
	public void setFacilityId(Long facilityId){
		this.facilityId = facilityId;
	}
	/**
	 * 标的外键
	 */
	public Long getSubjectId(){
		return subjectId;
	}
	public void setSubjectId(Long subjectId){
		this.subjectId = subjectId;
	}
	/**
	 * 公共设施使用申请外键
	 */
	public Long getFacilityOrderId(){
		return facilityOrderId;
	}
	public void setFacilityOrderId(Long facilityOrderId){
		this.facilityOrderId = facilityOrderId;
	}
	/**
	 * 单价
	 */
	public String getPrice(){
		return price;
	}
	public void setPrice(String price){
		this.price = price;
	}
	/**
	 * 数量
	 */
	public Double getAmount(){
		return amount;
	}
	public void setAmount(Double amount){
		this.amount = amount;
	}
	/**
	 * 计划金额
	 */
	public Double getPlanFee(){
		return planFee;
	}
	public void setPlanFee(Double planFee){
		this.planFee = planFee;
	}
	/**
	 * 实际金额
	 */
	public Double getRealFee(){
		return realFee;
	}
	public void setRealFee(Double realFee){
		this.realFee = realFee;
	}
	/**
	 * 已付金额
	 */
	public Double getPaidFee(){
		return paidFee;
	}
	public void setPaidFee(Double paidFee){
		this.paidFee = paidFee;
	}
	/**
	 * 滞纳金
	 */
	public Double getOverdueFee(){
		return overdueFee;
	}
	public void setOverdueFee(Double overdueFee){
		this.overdueFee = overdueFee;
	}
	/**
	 * 计费开始时间
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 计费结束时间
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 最后付费时间
	 */
	public Date getLastPayDate(){
		return lastPayDate;
	}
	public void setLastPayDate(Date lastPayDate){
		this.lastPayDate = lastPayDate;
	}
	/**
	 * 计划付费时间
	 */
	public Date getPlanPayDate(){
		return planPayDate;
	}
	public void setPlanPayDate(Date planPayDate){
		this.planPayDate = planPayDate;
	}
	/**
	 * 状态
	 */
	public BillPlanStatusEnum getStatus(){
		return status;
	}
	public void setStatus(BillPlanStatusEnum status){
		this.status = status;
	}
	/**
	 * 是否自动出账
	 */
	public BooleanEnum getAutoCheck(){
		return autoCheck;
	}
	public void setAutoCheck(BooleanEnum autoCheck){
		this.autoCheck = autoCheck;
	}
	/**
	 * 出账时间
	 */
	public Date getIntoAccountDate(){
		return intoAccountDate;
	}
	public void setIntoAccountDate(Date intoAccountDate){
		this.intoAccountDate = intoAccountDate;
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