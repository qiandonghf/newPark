package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;
import com.wiiy.crm.entity.CustomerService;

/**
 * <br/>class-description 客服服务轨迹
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerServiceTrack extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 客服联系单
	 */
	@FieldDescription("客服联系单")
	private CustomerService service;
	/**
	 * 处理人
	 */
	@FieldDescription("处理人")
	private User user;
	/**
	 * 客服联系单ID
	 */
	@FieldDescription("客服联系单ID")
	private Long serviceId;
	/**
	 * 处理人ID
	 */
	@FieldDescription("处理人ID")
	private Long userId;
	/**
	 * 受理开始日期
	 */
	@FieldDescription("受理开始日期")
	private Date handleTime;
	/**
	 * 内容
	 */
	@FieldDescription("内容")
	private String content;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 客服联系单
	 */
	public CustomerService getService(){
		return service;
	}
	public void setService(CustomerService service){
		this.service = service;
	}
	/**
	 * 处理人
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	/**
	 * 客服联系单ID
	 */
	public Long getServiceId(){
		return serviceId;
	}
	public void setServiceId(Long serviceId){
		this.serviceId = serviceId;
	}
	/**
	 * 处理人ID
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 受理开始日期
	 */
	public Date getHandleTime(){
		return handleTime;
	}
	public void setHandleTime(Date handleTime){
		this.handleTime = handleTime;
	}
	/**
	 * 内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}