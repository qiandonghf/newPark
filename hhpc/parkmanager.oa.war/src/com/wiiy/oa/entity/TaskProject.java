package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.preferences.enums.TaskProjectStatusEnum;

/**
 * <br/>class-description 任务项目
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class TaskProject extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 项目名称
	 */
	@FieldDescription("项目名称")
	private String name;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private TaskProjectStatusEnum status;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	public TaskProjectStatusEnum getStatus(){
		return status;
	}
	public void setStatus(TaskProjectStatusEnum status){
		this.status = status;
	}
}