package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.DeviceManagement;

/**
 * <br/>class-description 设备巡检
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DevicePatrol extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 设备
	 */
	@FieldDescription("设备")
	private DeviceManagement deviceManagement;
	/**
	 * 设备外键
	 */
	@FieldDescription("设备外键")
	private Long deviceId;
	/**
	 * 操作人员
	 */
	@FieldDescription("操作人员")
	private String operator;
	/**
	 * 巡检日期
	 */
	@FieldDescription("巡检日期")
	private Date operationDate;
	/**
	 * 巡检时间
	 */
	@FieldDescription("巡检时间")
	private String operationTime;
	/**
	 * 检查人
	 */
	@FieldDescription("检查人")
	private String inspector;
	/**
	 * 检查结果
	 */
	@FieldDescription("检查结果")
	private String patrolResults;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 设备
	 */
	public DeviceManagement getDeviceManagement(){
		return deviceManagement;
	}
	public void setDeviceManagement(DeviceManagement deviceManagement){
		this.deviceManagement = deviceManagement;
	}
	/**
	 * 设备外键
	 */
	public Long getDeviceId(){
		return deviceId;
	}
	public void setDeviceId(Long deviceId){
		this.deviceId = deviceId;
	}
	/**
	 * 操作人员
	 */
	public String getOperator(){
		return operator;
	}
	public void setOperator(String operator){
		this.operator = operator;
	}
	/**
	 * 巡检日期
	 */
	public Date getOperationDate(){
		return operationDate;
	}
	public void setOperationDate(Date operationDate){
		this.operationDate = operationDate;
	}
	/**
	 * 巡检时间
	 */
	public String getOperationTime(){
		return operationTime;
	}
	public void setOperationTime(String operationTime){
		this.operationTime = operationTime;
	}
	/**
	 * 检查人
	 */
	public String getInspector(){
		return inspector;
	}
	public void setInspector(String inspector){
		this.inspector = inspector;
	}
	/**
	 * 检查结果
	 */
	public String getPatrolResults() {
		return patrolResults;
	}
	public void setPatrolResults(String patrolResults) {
		this.patrolResults = patrolResults;
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
}