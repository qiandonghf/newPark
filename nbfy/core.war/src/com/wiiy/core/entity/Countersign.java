package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.preferences.enums.CountersignDoneEnum;
import com.wiiy.core.preferences.enums.CountersignOpenEnum;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;

/**
 * <br/>class-description 会签单
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Countersign extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 会签单名称
	 */
	@FieldDescription("会签单名称")
	private String name;
	/**
	 * 会签类型
	 */
	@FieldDescription("会签类型")
	private CountersignTypeEnum countersignType;
	/**
	 * 会签办理状态
	 */
	@FieldDescription("会签办理状态")
	private CountersignDoneEnum countersignDone;
	/**
	 * 会签开启状态
	 */
	@FieldDescription("会签开启状态")
	private CountersignOpenEnum countersignOpen;
	/**
	 * 外键ID
	 */
	@FieldDescription("外键ID")
	private Long countersignId;
	/**
	 * 审批人ID
	 */
	@FieldDescription("审批人ID")
	private Long userId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 会签单名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 会签类型
	 */
	public CountersignTypeEnum getCountersignType(){
		return countersignType;
	}
	public void setCountersignType(CountersignTypeEnum countersignType){
		this.countersignType = countersignType;
	}
	/**
	 * 会签办理状态
	 */
	public CountersignDoneEnum getCountersignDone(){
		return countersignDone;
	}
	public void setCountersignDone(CountersignDoneEnum countersignDone){
		this.countersignDone = countersignDone;
	}
	/**
	 * 会签开启状态
	 */
	public CountersignOpenEnum getCountersignOpen(){
		return countersignOpen;
	}
	public void setCountersignOpen(CountersignOpenEnum countersignOpen){
		this.countersignOpen = countersignOpen;
	}
	/**
	 * 外键ID
	 */
	public Long getCountersignId(){
		return countersignId;
	}
	public void setCountersignId(Long countersignId){
		this.countersignId = countersignId;
	}
	/**
	 * 审批人ID
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
}