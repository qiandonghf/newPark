package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.Customer;
import com.wiiy.pb.preferences.enums.FacilityOrderStatusEnum;

/**
 * <br/>class-description 公共设施使用申请
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class FacilityOrder extends BaseEntity implements Serializable {
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
	 * 公共设施实体
	 */
	@FieldDescription("公共设施实体")
	private Facility facility;
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
	 * 使用开始时间
	 */
	@FieldDescription("使用开始时间")
	private Date startTime;
	/**
	 * 使用结束时间
	 */
	@FieldDescription("使用结束时间")
	private Date endTime;
	/**
	 * 合同
	 */
	@FieldDescription("合同")
	private String contractPath;
	/**
	 * 合同ID
	 */
	@FieldDescription("合同ID")
	private Long contractId;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private FacilityOrderStatusEnum status;

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
	 * 公共设施实体
	 */
	public Facility getFacility(){
		return facility;
	}
	public void setFacility(Facility facility){
		this.facility = facility;
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
	 * 使用开始时间
	 */
	public Date getStartTime(){
		return startTime;
	}
	public void setStartTime(Date startTime){
		this.startTime = startTime;
	}
	/**
	 * 使用结束时间
	 */
	public Date getEndTime(){
		return endTime;
	}
	public void setEndTime(Date endTime){
		this.endTime = endTime;
	}
	/**
	 * 合同
	 */
	public String getContractPath(){
		return contractPath;
	}
	public void setContractPath(String contractPath){
		this.contractPath = contractPath;
	}
	/**
	 * 合同ID
	 */
	public Long getContractId(){
		return contractId;
	}
	public void setContractId(Long contractId){
		this.contractId = contractId;
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
	 * 状态
	 */
	public FacilityOrderStatusEnum getStatus(){
		return status;
	}
	public void setStatus(FacilityOrderStatusEnum status){
		this.status = status;
	}
}