package com.wiiy.crm.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.User;
import com.wiiy.crm.preferences.enums.ContractItemEnum;
import com.wiiy.crm.preferences.enums.ContractRentStatusEnum;
import com.wiiy.crm.preferences.enums.ContractStatusEnum;
import com.wiiy.crm.preferences.enums.ContractTypeEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanEnum;

/**
 * <br/>class-description 合同
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Contract extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	
	public Contract() {
		super();
	}
	public Contract(Long id, Customer customer,String shortName,String name, ContractItemEnum item,
			Date endDate) {
		super();
		this.id = id;
		this.customer = customer;
		this.customer.setShortName(shortName);
		this.customer.setName(name);
		this.item = item;
		this.endDate = endDate;
	}

	public Contract(Long id,Date endDate) {
		super();
		this.id = id;
		this.endDate = endDate;
	}
	public Contract(Long id) {
		super();
		this.customerId = id;
	}
	private Long id;
	/**
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 负责人
	 */
	@FieldDescription("负责人")
	private User manager;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 租赁用途
	 */
	@FieldDescription("租赁用途")
	private String purpose;
	/**
	 * 优惠政策
	 */
	@FieldDescription("优惠政策")
	private String policy;
	/**
	 * 企业名称
	 */
	@FieldDescription("企业名称")
	private String customerName;
	/**
	 * 负责人外键
	 */
	@FieldDescription("负责人外键")
	private Long managerId;
	/**
	 * 合同名称
	 */
	@FieldDescription("合同名称")
	private String name;
	/**
	 * 合同编号
	 */
	@FieldDescription("合同编号")
	private String contractNo;
	/**
	 * 合同名目
	 */
	@FieldDescription("合同名目")
	private ContractItemEnum item;
	/**
	 * 合同类型
	 */
	@FieldDescription("合同类型")
	private ContractTypeEnum type;
	/**
	 * 合同签订日期
	 */
	@FieldDescription("合同签订日期")
	private Date signDate;
	/**
	 * 交付日期
	 */
	@FieldDescription("交付日期")
	private Date receiveDate;
	/**
	 * 合同有效期开始日期
	 */
	@FieldDescription("合同有效期开始日期")
	private Date startDate;
	/**
	 * 合同有效期结束日期
	 */
	@FieldDescription("合同有效期结束日期")
	private Date endDate;
	/**
	 * 装修开始日期
	 */
	@FieldDescription("装修开始日期")
	private Date decorateStartDate;
	/**
	 * 装修结束日期
	 */
	@FieldDescription("装修结束日期")
	private Date decorateEndDate;
	/**
	 * 合同状态
	 */
	@FieldDescription("合同状态")
	private ContractStatusEnum state;
	/**
	 * 租赁状态
	 */
	@FieldDescription("租赁状态")
	private ContractRentStatusEnum rentState;
	/**
	 * 合同总额
	 */
	@FieldDescription("合同总额")
	private Double totalAmount;
	
	/**
	 * 本物业名称
	 */
	@FieldDescription("本物业名称")
	private String propertyName;
	/**
	 * 座落位置
	 */
	@FieldDescription("座落位置")
	private String address;
	/**
	 * 乙方所租房屋产权证号
	 */
	@FieldDescription("乙方所租房屋产权证号")
	private String propertyNo;
	/**
	 * 房间类型
	 */
	@FieldDescription("房间类型")
	private DataDict roomType;
	/**
	 * 房间类型外键
	 */
	@FieldDescription("房间类型外键")
	private String roomTypeId;
	/**
	 * 单价
	 */
	@FieldDescription("单价")
	private BigDecimal propertyUnit;
	/**
	 * 总建筑面积
	 */
	@FieldDescription("总建筑面积")
	private BigDecimal overallFloorage;
	/**
	 * 租金支付方式
	 */
	@FieldDescription("租金支付方式")
	private RentBillPlanEnum payType;
	/**
	 * 租金额度
	 */
	@FieldDescription("租金额度")
	private String rentAmount;
	
	/**
	 * 合同甲方
	 */
	@FieldDescription("合同甲方")
	private DataDict contractParty;
	
	/**
	 * 合同甲方外键
	 */
	@FieldDescription("合同甲方外键")
	private String contractPartyId;
	
	/**
	 * 合同甲方
	 */
	public DataDict getContractParty() {
		return contractParty;
	}
	public void setContractParty(DataDict contractParty) {
		this.contractParty = contractParty;
	}
	/**
	 * 合同甲方外键
	 */
	public String getContractPartyId() {
		return contractPartyId;
	}
	public void setContractPartyId(String contractPartyId) {
		this.contractPartyId = contractPartyId;
	}
	/**
	 * 租金额度
	 */
	public String getRentAmount() {
		return rentAmount;
	}
	public void setRentAmount(String rentAmount) {
		this.rentAmount = rentAmount;
	}
	/**
	 * 本物业名称
	 */
	public String getPropertyName() {
		return propertyName;
	}
	/**
	 * 本物业名称
	 */
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
	/**
	 * 座落位置
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * 座落位置
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * 乙方所租房屋产权证号
	 */
	public String getPropertyNo() {
		return propertyNo;
	}
	/**
	 * 乙方所租房屋产权证号
	 */
	public void setPropertyNo(String propertyNo) {
		this.propertyNo = propertyNo;
	}
	/**
	 * 房间类型
	 */
	public DataDict getRoomType() {
		return roomType;
	}
	/**
	 * 房间类型
	 */
	public void setRoomType(DataDict roomType) {
		this.roomType = roomType;
	}
	/**
	 * 房间类型外键
	 */
	public String getRoomTypeId() {
		return roomTypeId;
	}
	/**
	 * v
	 */
	public void setRoomTypeId(String roomTypeId) {
		this.roomTypeId = roomTypeId;
	}
	/**
	 * 单价
	 */
	public BigDecimal getPropertyUnit() {
		return propertyUnit;
	}
	/**
	 * 单价
	 */
	public void setPropertyUnit(BigDecimal propertyUnit) {
		this.propertyUnit = propertyUnit;
	}
	/**
	 * 总建筑面积
	 */
	public BigDecimal getOverallFloorage() {
		return overallFloorage;
	}
	/**
	 * 总建筑面积
	 */
	public void setOverallFloorage(BigDecimal overallFloorage) {
		this.overallFloorage = overallFloorage;
	}
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
	 * 负责人
	 */
	public User getManager(){
		return manager;
	}
	public void setManager(User manager){
		this.manager = manager;
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
	 * 租赁用途
	 */
	public String getPurpose(){
		return purpose;
	}
	public void setPurpose(String purpose){
		this.purpose = purpose;
	}
	/**
	 * 优惠政策
	 */
	public String getPolicy(){
		return policy;
	}
	public void setPolicy(String policy){
		this.policy = policy;
	}
	/**
	 * 企业名称
	 */
	public String getCustomerName(){
		return customerName;
	}
	public void setCustomerName(String customerName){
		this.customerName = customerName;
	}
	/**
	 * 负责人外键
	 */
	public Long getManagerId(){
		return managerId;
	}
	public void setManagerId(Long managerId){
		this.managerId = managerId;
	}
	/**
	 * 合同名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 合同编号
	 */
	public String getContractNo(){
		return contractNo;
	}
	public void setContractNo(String contractNo){
		this.contractNo = contractNo;
	}
	/**
	 * 合同名目
	 */
	public ContractItemEnum getItem(){
		return item;
	}
	public void setItem(ContractItemEnum item){
		this.item = item;
	}
	/**
	 * 合同类型
	 */
	public ContractTypeEnum getType(){
		return type;
	}
	public void setType(ContractTypeEnum type){
		this.type = type;
	}
	/**
	 * 合同签订日期
	 */
	public Date getSignDate(){
		return signDate;
	}
	public void setSignDate(Date signDate){
		this.signDate = signDate;
	}
	/**
	 * 交付日期
	 */
	public Date getReceiveDate(){
		return receiveDate;
	}
	public void setReceiveDate(Date receiveDate){
		this.receiveDate = receiveDate;
	}
	/**
	 * 合同有效期开始日期
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 合同有效期结束日期
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 装修开始日期
	 */
	public Date getDecorateStartDate() {
		return decorateStartDate;
	}
	public void setDecorateStartDate(Date decorateStartDate) {
		this.decorateStartDate = decorateStartDate;
	}
	/**
	 * 装修结束日期
	 */
	public Date getDecorateEndDate() {
		return decorateEndDate;
	}
	public void setDecorateEndDate(Date decorateEndDate) {
		this.decorateEndDate = decorateEndDate;
	}
	/**
	 * 合同状态
	 */
	public ContractStatusEnum getState(){
		return state;
	}
	public void setState(ContractStatusEnum state){
		this.state = state;
	}
	/**
	 * 租赁状态
	 */
	public ContractRentStatusEnum getRentState(){
		return rentState;
	}
	public void setRentState(ContractRentStatusEnum rentState){
		this.rentState = rentState;
	}
	/**
	 * 合同总额
	 */
	public Double getTotalAmount(){
		return totalAmount;
	}
	public void setTotalAmount(Double totalAmount){
		this.totalAmount = totalAmount;
	}
	/**
	 * 租金支付方式
	 */
	public RentBillPlanEnum getPayType() {
		return payType;
	}
	public void setPayType(RentBillPlanEnum payType) {
		this.payType = payType;
	}
}