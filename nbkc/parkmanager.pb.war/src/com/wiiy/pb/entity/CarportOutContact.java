package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.ContactEntity;
import com.wiiy.core.entity.User;

/**
 * <br/>class-description 浙江大学国家大学科技园(一期) 车位退租确认单
 * <br/>extends com.wiiy.core.entity.ContactEntity
 */
public class CarportOutContact extends ContactEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 经办人
	 */
	@FieldDescription("经办人")
	private User responsible;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 退租单位
	 */
	@FieldDescription("退租单位")
	private String customer;
	/**
	 * 退租原因
	 */
	@FieldDescription("退租原因")
	private String reason;
	/**
	 * 经办人ID
	 */
	@FieldDescription("经办人ID")
	private Long responsibleId;
	/**
	 * 原租赁车 位号
	 */
	@FieldDescription("原租赁车 位号")
	private String carport;
	/**
	 * 车 位个数
	 */
	@FieldDescription("车 位个数")
	private String number;
	/**
	 * 租赁开始时间
	 */
	@FieldDescription("租赁开始时间")
	private Date rentStart;
	/**
	 * 租赁结束时间
	 */
	@FieldDescription("租赁结束时间")
	private Date rentEnd;
	/**
	 * 退赁开始时间
	 */
	@FieldDescription("退赁开始时间")
	private Date rentOutStart;
	/**
	 * 退赁结束时间
	 */
	@FieldDescription("退赁结束时间")
	private Date rentOutEnd;
	/**
	 * 退赁金额
	 */
	@FieldDescription("退赁金额")
	private String money;
	/**
	 * 创业服务中心核实意见
	 */
	@FieldDescription("创业服务中心核实意见")
	private String opinion1;
	/**
	 * 创业服务中心核实意见ID
	 */
	@FieldDescription("创业服务中心核实意见ID")
	private Long opinion1Id;
	/**
	 * 科技园发展有限公财务部审核
	 */
	@FieldDescription("科技园发展有限公财务部审核")
	private String opinion2;
	/**
	 * 科技园发展有限公司财务部审核ID
	 */
	@FieldDescription("科技园发展有限公司财务部审核ID")
	private Long opinion2Id;
	/**
	 * 南都物业物管中心财务审核
	 */
	@FieldDescription("南都物业物管中心财务审核")
	private String opinion3;
	/**
	 * 南都物业物管中心财务审核ID
	 */
	@FieldDescription("南都物业物管中心财务审核ID")
	private Long opinion3Id;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 经办人
	 */
	public User getResponsible(){
		return responsible;
	}
	public void setResponsible(User responsible){
		this.responsible = responsible;
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
	 * 退租单位
	 */
	public String getCustomer(){
		return customer;
	}
	public void setCustomer(String customer){
		this.customer = customer;
	}
	/**
	 * 退租原因
	 */
	public String getReason(){
		return reason;
	}
	public void setReason(String reason){
		this.reason = reason;
	}
	/**
	 * 经办人ID
	 */
	public Long getResponsibleId(){
		return responsibleId;
	}
	public void setResponsibleId(Long responsibleId){
		this.responsibleId = responsibleId;
	}
	/**
	 * 原租赁车 位号
	 */
	public String getCarport(){
		return carport;
	}
	public void setCarport(String carport){
		this.carport = carport;
	}
	/**
	 * 车 位个数
	 */
	public String getNumber(){
		return number;
	}
	public void setNumber(String number){
		this.number = number;
	}
	/**
	 * 租赁开始时间
	 */
	public Date getRentStart(){
		return rentStart;
	}
	public void setRentStart(Date rentStart){
		this.rentStart = rentStart;
	}
	/**
	 * 租赁结束时间
	 */
	public Date getRentEnd(){
		return rentEnd;
	}
	public void setRentEnd(Date rentEnd){
		this.rentEnd = rentEnd;
	}
	/**
	 * 退赁开始时间
	 */
	public Date getRentOutStart(){
		return rentOutStart;
	}
	public void setRentOutStart(Date rentOutStart){
		this.rentOutStart = rentOutStart;
	}
	/**
	 * 退赁结束时间
	 */
	public Date getRentOutEnd(){
		return rentOutEnd;
	}
	public void setRentOutEnd(Date rentOutEnd){
		this.rentOutEnd = rentOutEnd;
	}
	/**
	 * 退赁金额
	 */
	public String getMoney(){
		return money;
	}
	public void setMoney(String money){
		this.money = money;
	}
	/**
	 * 创业服务中心核实意见
	 */
	public String getOpinion1(){
		return opinion1;
	}
	public void setOpinion1(String opinion1){
		this.opinion1 = opinion1;
	}
	/**
	 * 创业服务中心核实意见ID
	 */
	public Long getOpinion1Id(){
		return opinion1Id;
	}
	public void setOpinion1Id(Long opinion1Id){
		this.opinion1Id = opinion1Id;
	}
	/**
	 * 科技园发展有限公财务部审核
	 */
	public String getOpinion2(){
		return opinion2;
	}
	public void setOpinion2(String opinion2){
		this.opinion2 = opinion2;
	}
	/**
	 * 科技园发展有限公司财务部审核ID
	 */
	public Long getOpinion2Id(){
		return opinion2Id;
	}
	public void setOpinion2Id(Long opinion2Id){
		this.opinion2Id = opinion2Id;
	}
	/**
	 * 南都物业物管中心财务审核
	 */
	public String getOpinion3(){
		return opinion3;
	}
	public void setOpinion3(String opinion3){
		this.opinion3 = opinion3;
	}
	/**
	 * 南都物业物管中心财务审核ID
	 */
	public Long getOpinion3Id(){
		return opinion3Id;
	}
	public void setOpinion3Id(Long opinion3Id){
		this.opinion3Id = opinion3Id;
	}
}