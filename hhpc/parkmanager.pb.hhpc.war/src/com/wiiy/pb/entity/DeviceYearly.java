package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.DeviceManagement;

/**
 * <br/>class-description 设备年检
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DeviceYearly extends BaseEntity implements Serializable {
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
	 * 年检日期
	 */
	@FieldDescription("年检日期")
	private Date operationDate;
	/**
	 * 年检单位
	 */
	@FieldDescription("年检单位")
	private String unitName;
	/**
	 * 操作人员
	 */
	@FieldDescription("操作人员")
	private String operator;
	/**
	 * 年检结果
	 */
	@FieldDescription("年检结果")
	private String yearlyResults;
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
	 * 年检日期
	 */
	public Date getOperationDate(){
		return operationDate;
	}
	public void setOperationDate(Date operationDate){
		this.operationDate = operationDate;
	}
	/**
	 * 年检单位
	 */
	public String getUnitName(){
		return unitName;
	}
	public void setUnitName(String unitName){
		this.unitName = unitName;
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
	 * 年检结果
	 */
	public String getYearlyResults(){
		return yearlyResults;
	}
	public void setYearlyResults(String yearlyResults){
		this.yearlyResults = yearlyResults;
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