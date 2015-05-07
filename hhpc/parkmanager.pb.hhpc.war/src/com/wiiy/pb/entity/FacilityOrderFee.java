package com.wiiy.pb.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.pb.entity.Facility;
import com.wiiy.pb.entity.FacilityOrder;

/**
 * <br/>class-description 公共设施使用费用
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class FacilityOrderFee extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 公共设施实体
	 */
	@FieldDescription("公共设施实体")
	private Facility facility;
	/**
	 * 设施预约实体
	 */
	@FieldDescription("设施预约实体")
	private FacilityOrder order;
	/**
	 * 公共设施外键
	 */
	@FieldDescription("公共设施外键")
	private Long facilityId;
	/**
	 * 设施预约外键
	 */
	@FieldDescription("设施预约外键")
	private Long orderId;
	/**
	 * 金额
	 */
	@FieldDescription("金额")
	private BigDecimal amount;
	/**
	 * 计划付费时间
	 */
	@FieldDescription("计划付费时间")
	private Date planPayTime;
	/**
	 * 出账时间
	 */
	@FieldDescription("出账时间")
	private Date checkoutTime;
	/**
	 * 是否已出账
	 */
	@FieldDescription("是否已出账")
	private BooleanEnum bcheckout;
	/**
	 * 是否自动出账
	 */
	@FieldDescription("是否自动出账")
	private BooleanEnum bauto;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	 * 设施预约实体
	 */
	public FacilityOrder getOrder(){
		return order;
	}
	public void setOrder(FacilityOrder order){
		this.order = order;
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
	 * 设施预约外键
	 */
	public Long getOrderId(){
		return orderId;
	}
	public void setOrderId(Long orderId){
		this.orderId = orderId;
	}
	/**
	 * 金额
	 */
	public BigDecimal getAmount(){
		return amount;
	}
	public void setAmount(BigDecimal amount){
		this.amount = amount;
	}
	/**
	 * 计划付费时间
	 */
	public Date getPlanPayTime(){
		return planPayTime;
	}
	public void setPlanPayTime(Date planPayTime){
		this.planPayTime = planPayTime;
	}
	/**
	 * 出账时间
	 */
	public Date getCheckoutTime(){
		return checkoutTime;
	}
	public void setCheckoutTime(Date checkoutTime){
		this.checkoutTime = checkoutTime;
	}
	/**
	 * 是否已出账
	 */
	public BooleanEnum getBcheckout(){
		return bcheckout;
	}
	public void setBcheckout(BooleanEnum bcheckout){
		this.bcheckout = bcheckout;
	}
	/**
	 * 是否自动出账
	 */
	public BooleanEnum getBauto(){
		return bauto;
	}
	public void setBauto(BooleanEnum bauto){
		this.bauto = bauto;
	}
}