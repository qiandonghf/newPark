package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 孵化过程
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class IncubationRoute extends BaseEntity implements Serializable {
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
	 * 孵化过程
	 */
	@FieldDescription("孵化过程")
	private DataDict route;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 孵化过程外键
	 */
	@FieldDescription("孵化过程外键")
	private String routeId;
	/**
	 * 对应时间
	 */
	@FieldDescription("对应时间")
	private Date time;

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
	 * 孵化过程
	 */
	public DataDict getRoute(){
		return route;
	}
	public void setRoute(DataDict route){
		this.route = route;
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
	 * 孵化过程外键
	 */
	public String getRouteId(){
		return routeId;
	}
	public void setRouteId(String routeId){
		this.routeId = routeId;
	}
	/**
	 * 对应时间
	 */
	public Date getTime(){
		return time;
	}
	public void setTime(Date time){
		this.time = time;
	}
}