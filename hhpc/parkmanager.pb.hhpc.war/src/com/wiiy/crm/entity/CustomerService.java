package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.User;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.preferences.enums.CustomerServiceResultEnum;
import com.wiiy.crm.preferences.enums.CustomerServiceStatusEnum;
import com.wiiy.crm.preferences.enums.PriorityEnum;

/**
 * <br/>class-description 客服联系单
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerService extends BaseEntity implements Serializable {
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
	 * 企业名称
	 */
	@FieldDescription("企业名称")
	private String customerName;
	/**
	 * 受理部门
	 */
	@FieldDescription("受理部门")
	private Org org;
	/**
	 * 受理人
	 */
	@FieldDescription("受理人")
	private User user;
	/**
	 * 服务类型
	 */
	@FieldDescription("服务类型")
	private DataDict type;
	/**
	 * 企业ID
	 */
	@FieldDescription("企业ID")
	private Long customerId;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private String contect;
	/**
	 * 受理部门ID
	 */
	@FieldDescription("受理部门ID")
	private Long orgId;
	/**
	 * 受理人ID
	 */
	@FieldDescription("受理人ID")
	private Long userId;
	/**
	 * 服务类型ID
	 */
	@FieldDescription("服务类型ID")
	private String typeId;
	/**
	 * 受理开始日期
	 */
	@FieldDescription("受理开始日期")
	private Date startDate;
	/**
	 * 受理结束日期
	 */
	@FieldDescription("受理结束日期")
	private Date endDate;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private CustomerServiceStatusEnum status;
	/**
	 * 重要性
	 */
	@FieldDescription("重要性")
	private PriorityEnum priority;
	/**
	 * 服务结果
	 */
	@FieldDescription("服务结果")
	private CustomerServiceResultEnum result;
	/**
	 * 情况说明
	 */
	@FieldDescription("情况说明")
	private String description;
	/**
	 * 客服意见及建议
	 */
	@FieldDescription("客服意见及建议")
	private String suggest;

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
	 * 受理部门
	 */
	public Org getOrg(){
		return org;
	}
	public void setOrg(Org org){
		this.org = org;
	}
	/**
	 * 受理人
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	/**
	 * 服务类型
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
	}
	/**
	 * 企业ID
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 联系人
	 */
	public String getContect(){
		return contect;
	}
	public void setContect(String contect){
		this.contect = contect;
	}
	/**
	 * 受理部门ID
	 */
	public Long getOrgId(){
		return orgId;
	}
	public void setOrgId(Long orgId){
		this.orgId = orgId;
	}
	/**
	 * 受理人ID
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 服务类型ID
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 受理开始日期
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 受理结束日期
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 联系电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 状态
	 */
	public CustomerServiceStatusEnum getStatus(){
		return status;
	}
	public void setStatus(CustomerServiceStatusEnum status){
		this.status = status;
	}
	/**
	 * 重要性
	 */
	public PriorityEnum getPriority() {
		return priority;
	}
	public void setPriority(PriorityEnum priority) {
		this.priority = priority;
	}
	/**
	 * 服务结果
	 */
	public CustomerServiceResultEnum getResult(){
		return result;
	}
	public void setResult(CustomerServiceResultEnum result){
		this.result = result;
	}
	/**
	 * 情况说明
	 */
	public String getDescription(){
		return description;
	}
	public void setDescription(String description){
		this.description = description;
	}
	/**
	 * 客服意见及建议
	 */
	public String getSuggest(){
		return suggest;
	}
	public void setSuggest(String suggest){
		this.suggest = suggest;
	}
	/**
	 * 企业名称
	 */
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
}