package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;

/**
 * <br/>class-description 工作汇报报送人配置
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class WorkReportConfig extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 报送人
	 */
	@FieldDescription("报送人")
	private User reporter;
	/**
	 * 接收人
	 */
	@FieldDescription("接收人")
	private User receiver;
	/**
	 * 报送人Id
	 */
	@FieldDescription("报送人Id")
	private Long reporterId;
	/**
	 * 接收人Id
	 */
	@FieldDescription("接收人Id")
	private Long receiverId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 报送人
	 */
	public User getReporter(){
		return reporter;
	}
	public void setReporter(User reporter){
		this.reporter = reporter;
	}
	/**
	 * 接收人
	 */
	public User getReceiver(){
		return receiver;
	}
	public void setReceiver(User receiver){
		this.receiver = receiver;
	}
	/**
	 * 报送人Id
	 */
	public Long getReporterId(){
		return reporterId;
	}
	public void setReporterId(Long reporterId){
		this.reporterId = reporterId;
	}
	/**
	 * 接收人Id
	 */
	public Long getReceiverId(){
		return receiverId;
	}
	public void setReceiverId(Long receiverId){
		this.receiverId = receiverId;
	}
}